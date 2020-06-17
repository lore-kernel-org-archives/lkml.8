Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A371E20786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOhAfGG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:29:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFQH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592378980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AdmT7b3BPc2aqD/olMArTuC26rpkA9g8KwOs1HIshag=;
        b=NOhAfGG0KwIBoAHdo5BFcyoFoHOs6ecYmV8IKLMM2tUK3c7AjhhtnM8NbqKo4dxqJRl5Xx
        tNrFDWXmbnfi6aGQLRrAOrlN5FqUNj95oJm5Q0Qvt1o90omWo/son/O87Puw7VQ1UR38dT
        166ls5S9++NmmfRTrxPKGwn1CbyQHr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-d3oeC4xkPu2QUEUTlFrMUA-1; Wed, 17 Jun 2020 03:29:38 -0400
X-MC-Unique: d3oeC4xkPu2QUEUTlFrMUA-1
Received: by mail-wr1-f70.google.com with SMTP id i6so597020wrr.23
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdmT7b3BPc2aqD/olMArTuC26rpkA9g8KwOs1HIshag=;
        b=GumgpZYwmCrthAo7dn0pBoI/s0hEtWFpVcV61g5wapMqk4yX+FDTTL/7O0Ry+cCg8q
         264i2rw+TySMwmDGFioUHyx3OxRte0Y48h2ZV2+oV3TYS00kFtu5Jj8Izvj85j2tuSvm
         7rFd20Zwyci2z12bAySVVcNnyVUs+X4LKZEUZjaa4fY/+QEmJn/wJEmcKGf/snIirZxO
         F9WW3EdFFuZukX6Zc7B9/p4KAVL9nZAUyqLUJLbqOCL8JRrsLUeBzyLr8rJRHj8RK8I3
         pc3zar/4G1b+bdVEOccRWKDIxBCjUMkzqJOWLIcH44+qN9L2cD0kShn1Tvl8T2Np0T2A
         PYtg==
X-Gm-Message-State: AOAM533Q+xTa3j2m0Ys6UgZdtbiWxRUzxLlMAfQ5G/sOdQ7An8MZESwA
        z7JTH4OpSTT1DyhUU2eus13sxOZxWJmr0U3RLoJcQGPAWnPYBVRZDNJhNkiuY9bxoJQDC2nGJWq
        n4TBM0G2fhYasRCKtk0mzYUoX
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr7041564wmb.123.1592378975907;
        Wed, 17 Jun 2020 00:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc+1RGVWjbqpFMqHqMiabr2trMaCcP1mbPJyMdmZq9uNo9i3bt5oqkHtObnT4q45dID2QNqA==
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr7041542wmb.123.1592378975662;
        Wed, 17 Jun 2020 00:29:35 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id k17sm33035633wrl.54.2020.06.17.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:29:34 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, dwagner@suse.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>,
        syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Subject: [PATCH] sched/deadline: Initialize dl_boosted
Date:   Wed, 17 Jun 2020 09:29:19 +0200
Message-Id: <20200617072919.818409-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported the following warning:

  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 setup_new_dl_entity /kernel/sched/deadline.c:594 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_dl_entity /kernel/sched/deadline.c:1370 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_task_dl+0x1c17/0x2ba0 /kernel/sched/deadline.c:1441
  Kernel panic - not syncing: panic_on_warn set ...

  CPU: 0 PID: 6973 Comm: syz-executor366 Not tainted 4.14.133 #28
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack /lib/dump_stack.c:17 [inline]
   dump_stack+0x138/0x19c /lib/dump_stack.c:53
   panic+0x1f2/0x426 /kernel/panic.c:182
   __warn.cold+0x2f/0x36 /kernel/panic.c:546
   report_bug+0x216/0x254 /lib/bug.c:186
   fixup_bug /arch/x86/kernel/traps.c:177 [inline]
   fixup_bug /arch/x86/kernel/traps.c:172 [inline]
   do_error_trap+0x1bb/0x310 /arch/x86/kernel/traps.c:295
   do_invalid_op+0x1b/0x20 /arch/x86/kernel/traps.c:314
   invalid_op+0x1b/0x40 /arch/x86/entry/entry_64.S:960
  RIP: 0010:setup_new_dl_entity /kernel/sched/deadline.c:593 [inline]
  RIP: 0010:enqueue_dl_entity /kernel/sched/deadline.c:1370 [inline]
  RIP: 0010:enqueue_task_dl+0x1c17/0x2ba0 /kernel/sched/deadline.c:1441
  RSP: 0018:ffff888098a3fcd8 EFLAGS: 00010002
  RAX: 0000000000000000 RBX: ffffffff87ab2780 RCX: 1ffff1101041413a
  RDX: 0000000ad48fb497 RSI: ffff8880aee2c518 RDI: ffff8880820a09d0
  RBP: ffff888098a3fd48 R08: ffff8880820a09cc R09: ffff8880820a09c0
  R10: ffff8880820a073c R11: 0000000000000001 R12: ffff8880820a0700
  R13: ffff8880aee2c500 R14: ffff8880820a0978 R15: ffff8880aee2c500
   enqueue_task /kernel/sched/core.c:762 [inline]
   __sched_setscheduler+0xd17/0x2510 /kernel/sched/core.c:4227
   sched_setattr /kernel/sched/core.c:4285 [inline]
   SYSC_sched_setattr /kernel/sched/core.c:4456 [inline]
   SyS_sched_setattr+0x1f8/0x300 /kernel/sched/core.c:4435
   do_syscall_64+0x1e8/0x640 /arch/x86/entry/common.c:292
   entry_SYSCALL_64_after_hwframe+0x42/0xb7
  RIP: 0033:0x446749
  RSP: 002b:00007ff022092db8 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
  RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446749
  RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
  RBP: 00000000006dbc30 R08: 00007ff022093700 R09: 0000000000000000
  R10: 00007ff022093700 R11: 0000000000000246 R12: 00000000006dbc3c
  R13: 00007ffdbf86bf7f R14: 00007ff0220939c0 R15: 0000000000000000

This happens because dl_boosted flag is currently not initialized by
__dl_clear_params() (unlike the other flags) and setup_new_dl_entity()
finds complains about it.

Initialize dl_boosted to 0.

Reported-by: syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..f63f337c7147 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2692,6 +2692,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->dl_boosted		= 0;
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
-- 
2.26.2

