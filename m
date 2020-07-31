Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413AF20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYiRmWCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgGaA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbgGaA1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:27:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A66C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:27:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so4141911pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/x33MxEGssqW5/BKpRXT03KlDE/YqWV5krAcZe2pDIk=;
        b=eYiRmWCH4wBcatIzXXCsoF769A8liQQ6C0gLJXIM46ANq1pkOYfyyPuqaXAs0sByRD
         a1NPxY7k56q22aQuh2U9z4XMge9i32A2IKaO/63WbxT3n8Sj5snqZcxiqNy/oBnFWCRo
         h3uTpidM1B2HVoJq83QGNPNzTD9RfH83SVWdalJqjrrVmpjV+K3TRHH6Vr59mhIgNC2D
         YMeUGsdxJhAYwUhkpg6Qu5TJDHz/uI46L6CApgpCtUYFdDEXFALkvulkl9O7eCKtHCtc
         JXQhbBTu5AplCWlUnjU538VkGxZS8LRC3FEpr9PQJfnUAMnTomxdD4NoEmf732xycoLQ
         TP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/x33MxEGssqW5/BKpRXT03KlDE/YqWV5krAcZe2pDIk=;
        b=tA3DQm6hntqpZUfcJhCigIH1AMrztxW5DUEns+8fptptfx/2LBCdE1M3Vp4Y6c0GeQ
         40Ox1Z1SVfa+F7AyNrAFS44OsHqNsqYkNg6faiFBuu4/VhOBJIk/OrL5d3ReQIewF5XV
         x5FycMYfZE8IbNHIlewlVBucfBqpLYAAuG48bSujbxpxg3UquklKYiQnsoIgqkWcC8Lf
         MF0e8zdJjirtsw2UzhQtka6sD9j6mvCOnMQG06LyQSi6VC7hrp1e51B2Ius0U6r8jeGI
         DBFVI2YXUgB7cOJCEZ88bzCgNPEKiBcD8ib/nQnM9t4lPs4oxdD88mYCFM9sm09NbsuE
         +M/w==
X-Gm-Message-State: AOAM533/ZrdiL+8qtPp6fSmLbex1fzdc0J557xOjsawmvmAz325jjiXC
        Lx/K/6kMZdLlYcHqRWmpuKsbWLUOfK4=
X-Google-Smtp-Source: ABdhPJzu60l479KqwVygWaTuAhVWeBTepYNLGQr7RyBP6p6Q92JxnGKBwYWopOixVGCZRsNS2rPLiw==
X-Received: by 2002:a65:4484:: with SMTP id l4mr1305372pgq.96.1596155273235;
        Thu, 30 Jul 2020 17:27:53 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 196sm7981911pgd.16.2020.07.30.17.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 17:27:52 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] trace : use kvzalloc instead of kzalloc
Date:   Fri, 31 Jul 2020 08:27:45 +0800
Message-Id: <1596155265-32365-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High order memory stuff within trace could introduce OOM, use kvzalloc instead.

Please find the bellowing for the call stack we run across in an android system.
The scenario happens when traced_probes is woken up to get a large quantity of
trace even if free memory is even higher than watermark_low. 

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
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee65..1a038a2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6891,7 +6891,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = kvzalloc(sizeof(*info), GFP_KERNEL);
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

