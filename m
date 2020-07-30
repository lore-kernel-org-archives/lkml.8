Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688482082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT2vw6A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgG3LEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgG3LEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:04:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC89C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:04:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so13753691pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcSB3wfh7zdX0Tp7q0+rt6lDZlbsPbuW0nAVyFfINqs=;
        b=aT2vw6A+D1q+WUbw+nNYlQh4AEKquMrk7jxVTZXLTXtRYHas8Ar44rqNas5eBuYROT
         yCnQu6SoALDHR+HvHal6PDw7fYb5W8y+UZxy8s5GosFusYpsIM5KEO+Lw8F5PQwwHYES
         IyoaDaCLZ5K/yTby/1XHpQG9vvmTMOx8Bhs0ddwydDAtBDAwJU27b6xVIB/hnSsfgBuu
         IMx8QLvxZGFyLalERBpiO+ztD7qfRJt4ME/OKGY/JCMyIX04Ut0bt1RTirl07LnNEaY9
         o/Ix0t5GJK5b3LuWVaiChwCt+BuVAxQQtJaFUJQ3OucbCokQh0Bk1FKTRHhqEAtFCy+b
         vZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UcSB3wfh7zdX0Tp7q0+rt6lDZlbsPbuW0nAVyFfINqs=;
        b=Z06UE7N5KOJhKOUEJNq1QtCoCaodLt3KhFSZ58FkuE8tScU7IZCqxQdc+lrzrtFELx
         13Rw1mx+OHyIApHBRqzVkuZYPHPj/neJc9hgzoDuBpnsCqntklPdM1sXpJrXkf2ygzkW
         8ZsakH4MUVHDqQhwYJ5XAI1cnM6gcbNc5sK6pq+lTcr3/FC34QPveGD7/m1/wnx5HXhV
         HV9dCrM3qjcn0zi/w91jye37OYmaUKTVbuDEVOuMvXGQarKMZFuUxQ8rrnXE26RJkjFP
         /q5ND8OW6y7CNZ9l9Z2R4TaLN78VgK59yl9Urc74kaSqjtzJFI8tFxUBqdRKyeX4LSr/
         n54A==
X-Gm-Message-State: AOAM530ZmrHALOSudLbLOGV9IsP9BIDW8mw5G15JvEFcdWAfQrOPOKk9
        OPILn0GsixZ+YwE7CnhujG8=
X-Google-Smtp-Source: ABdhPJwtf9fENR8h3p79mW3cH2apypEIUJZgpJvUMh2BuUFT1yP8gTzZh2Vru/1v7G20oJL+ViBeyQ==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr15309060pjz.176.1596107059866;
        Thu, 30 Jul 2020 04:04:19 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j5sm5499305pfa.5.2020.07.30.04.04.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 04:04:19 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] trace : use kvmalloc instead of kmalloc
Date:   Thu, 30 Jul 2020 19:04:12 +0800
Message-Id: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High order memory stuff within trace could introduce OOM, use kvmalloc instead.

Please find the bellowing for the call stack we run across in an android system. The scenario happens when traced_probes is woken up to get a large quantity of trace even if free memory is even higher than watermark_low. 

traced_probes invoked oom-killer: gfp_mask=0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),  order=2, oom_score_adj=-1

traced_probes cpuset=system-background mems_allowed=0
CPU: 3 PID: 588 Comm: traced_probes Tainted: G        W  O    4.14.181 #1
Hardware name: Generic DT based system
(unwind_backtrace) from [<c010d824>] (show_stack+0x20/0x24)
(show_stack) from [<c0b2e174>] (dump_stack+0xa8/0xec)
(dump_stack) from [<c027d584>] (dump_header+0x9c/0x220)
(dump_header) from [<c027cfe4>] (oom_kill_process+0xc0/0x5c4)
(oom_kill_process) from [<c027cb94>] (out_of_memory+0x220/0x310)
(out_of_memory) from [<c02816bc>] (__alloc_pages_nodemask+0xff8/0x13a4)
(__alloc_pages_nodemask) from [<c02a6a1c>] (kmalloc_order+0x30/0x48)
(kmalloc_order) from [<c02a6a64>] (kmalloc_order_trace+0x30/0x118)
(kmalloc_order_trace) from [<c0223d7c>] (tracing_buffers_open+0x50/0xfc)
(tracing_buffers_open) from [<c02e6f58>] (do_dentry_open+0x278/0x34c)
(do_dentry_open) from [<c02e70d0>] (vfs_open+0x50/0x70)
(vfs_open) from [<c02f7c24>] (path_openat+0x5fc/0x169c)
(path_openat) from [<c02f75c4>] (do_filp_open+0x94/0xf8)
(do_filp_open) from [<c02e7650>] (do_sys_open+0x168/0x26c)
(do_sys_open) from [<c02e77bc>] (SyS_openat+0x34/0x38)
(SyS_openat) from [<c0108bc0>] (ret_fast_syscall+0x0/0x28)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
changes since v1: change kfree to kvfree
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee65..8d70c79 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6891,7 +6891,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = kvmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		trace_array_put(tr);
 		return -ENOMEM;
@@ -7017,7 +7017,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 	if (info->spare)
 		ring_buffer_free_read_page(iter->trace_buffer->buffer,
 					   info->spare_cpu, info->spare);
-	kfree(info);
+	kvfree(info);
 
 	mutex_unlock(&trace_types_lock);
 
-- 
1.9.1

