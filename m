Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0FC55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3B92064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8HXr44D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgDUMRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:17:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34103 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587471448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqZ5qaUI7lAD/CtTgYgPwx5mo1DofqJj/P+jVLEwSPE=;
        b=O8HXr44DtWbgh9fkcVt5cbeTib2kO8n9uQCWcTVH968tRiB7XN+8XX5XJf3W/MezOrz4p1
        NBOlngiWIBztweL7+7UEFxYyY/GDfPJcVn7EQ9cJK0JyoSdf2o7M90n0axRMtbssTbVY5t
        qBs5tNNWzfzUBIh1SxE6Np7kYlMNr+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-vOfEtwf0Nw-xffzHvGPR3w-1; Tue, 21 Apr 2020 08:17:26 -0400
X-MC-Unique: vOfEtwf0Nw-xffzHvGPR3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B0741922965;
        Tue, 21 Apr 2020 12:17:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD7B79DD8A;
        Tue, 21 Apr 2020 12:17:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Apr 2020 14:17:25 +0200 (CEST)
Date:   Tue, 21 Apr 2020 14:17:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421121722.GE6787@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <20200421092846.GB6787@redhat.com>
 <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
 <20200421111139.GC6787@redhat.com>
 <20200421112606.ay4cck2dphguqazb@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421112606.ay4cck2dphguqazb@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Christian Brauner wrote:
>
> process B setnses into
> <pidnsC> which is a sibling pid namespace,

please see pidns_install(), it verifies that

	* Only allow entering the current active pid namespace
	* or a child of the current active pid namespace.

Oleg.

