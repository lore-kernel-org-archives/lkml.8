Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051B520857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayxkDSI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgDUJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:28:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgDUJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587461333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oysdPbShO57/vKq4TlPjj7UTPsawLCj1VnG1ltbyIf8=;
        b=ayxkDSI+1GdtLTJTfeoH2ujD5krKq6RUMGaOKT8HUlDzF5rDl9Rv66VOXSNVOkAd7um0ri
        4vI1qe/hfQR7UiaV34kydr/vy3WciFl7AcVwZA3ZpqhxHj12HwIzUE3RQrQCoUhyoM3mDv
        uzSU5/VCWsfl2Sy/IJVtTU/wbdLjRxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-ukKVoaLKMJSn34-FQs_Gig-1; Tue, 21 Apr 2020 05:28:51 -0400
X-MC-Unique: ukKVoaLKMJSn34-FQs_Gig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4843018FF662;
        Tue, 21 Apr 2020 09:28:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id B54A01001B30;
        Tue, 21 Apr 2020 09:28:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 21 Apr 2020 11:28:49 +0200 (CEST)
Date:   Tue, 21 Apr 2020 11:28:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421092846.GB6787@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421083031.5wapruzncjkagvhf@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Christian Brauner wrote:
>
> > -		__group_send_sig_info(sig, &info, tsk->parent);
> > +		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
>
> So below you switch to __send_signal() but set the "force" argument to
> to "false".

it must be false, the signal is generated from the parent's namespace or
its descendant

> Before that, if the signal was generated from another pid
> namespace and we fixed up si_pid and si_uid the "force" argument was set
> to "true",

before that the "force" argument could be falsely true by the same reason,
task_pid_nr_ns(tsk, tsk->parent) can return 0 because "tsk" no longer have
pids after __unhash_process().

Oleg.

