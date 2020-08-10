Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59D320729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqRn0qMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgHJLHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:07:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgHJLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597057633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHCoGFv/slftUZpEERreHjBoBcennu4blqAk1fcTw/k=;
        b=OqRn0qMiOPHW1hKC4xyZ5T7SSgP121SvvMMxLh8IjEMriwR7WVC5ah/IXGpaNFq2Dk6Y66
        zhNk6HL4ijIcuVhSiPYFnmFq9Ml3Cyqib3qALbN4EtPbtcMsEBbDyyfeDe6Tka6XaWdA2a
        cMENZlE9sbZGUYVSy4bMM/kE3zwKmXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-LP0f2cGjM8KguZ-X50y43Q-1; Mon, 10 Aug 2020 07:07:11 -0400
X-MC-Unique: LP0f2cGjM8KguZ-X50y43Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865531DE0;
        Mon, 10 Aug 2020 11:07:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.177])
        by smtp.corp.redhat.com (Postfix) with SMTP id 00A8710013C2;
        Mon, 10 Aug 2020 11:06:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Aug 2020 13:07:10 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:06:48 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kernel: update callers of task_work_add() to use
 TWA_RESUME
Message-ID: <20200810110646.GB17018@redhat.com>
References: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08, Jens Axboe wrote:
>
> Any pre-existing caller of this function uses 'true' to signal to use
> notifications or not, but we now also have signaled notifications.
> Update existing callers that specify 'true' for notify to use the
> updated TWA_RESUME instead.

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>

