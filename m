Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F301DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1D12080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJGHl6OP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH0PUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728649AbgH0LdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598527981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tK2E5OHaYdIMnHynVyzOX85+jSQpnlWbWxI1ka3rMpQ=;
        b=iJGHl6OPlX/bSFOwWs6Tl5Z5Fd+juMSODETyFwMqsD6H0OtAMMBztX6PTiI/tM+0FSGL6H
        cWodOzu+cBJhPRhANWsb0Nu/pBdtpgR/+P7oby2wJvrWPv5ylQFyGW3dv66DvRLQ+V7mM+
        4ossNlXy9iHK2P5ycyQ5Ixu0T4eTOvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-GHCIpvapPlWFtEXqEva68w-1; Thu, 27 Aug 2020 07:24:30 -0400
X-MC-Unique: GHCIpvapPlWFtEXqEva68w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 455E080EFBE;
        Thu, 27 Aug 2020 11:24:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC68F5D9E8;
        Thu, 27 Aug 2020 11:24:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 27 Aug 2020 13:24:28 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:24:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     syzbot <syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in get_signal
Message-ID: <20200827112426.GE28468@redhat.com>
References: <00000000000068340d05add74c29@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000068340d05add74c29@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27, syzbot wrote:
>
>  __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
>  debug_check_no_obj_freed+0x301/0x41c lib/debugobjects.c:998
>  kmem_cache_free.part.0+0x16d/0x1f0 mm/slab.c:3692
>  task_work_run+0xdd/0x190 kernel/task_work.c:141

I don't understand this trace, work->func(work) can call kmem_cache_free()
but task_work_run() doesn't do this.

In theory the patch below makes sense anyway, but I have no idea if it can
explain the problem.

Oleg.

--- x/kernel/task_work.c
+++ x/kernel/task_work.c
@@ -137,7 +137,7 @@ void task_work_run(void)
 		raw_spin_unlock_irq(&task->pi_lock);
 
 		do {
-			next = work->next;
+			next = READ_ONCE(work->next);
 			work->func(work);
 			work = next;
 			cond_resched();

