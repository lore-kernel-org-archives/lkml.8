Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22909C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72332074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD1LiPjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2Lan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2Lan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:30:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24122C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:30:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so14088739pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=f8WSDQJ1BMFeePb0L/BbIVNSSbVdawZX1MtFDgOVN90=;
        b=UD1LiPjUprO9x0biTukgBu4L89Xtt8vucwleufAjo3eAK8BqgUAxrSdWGDxdRqJ3xy
         2rjWIpI0q5PNAWBBYafaIzuItmCHzLmSKKFgSCzqz67qXKasP0sTbKD+IgRBD+tY/B6T
         /FxIcwZ+smecLpLUdWitl/bI2V0wSwWV2DzBZLO1UvE/6niARbeOEwrrZlFtJKwg7g9V
         k8tSqjyIRktetsSEjLlu2Bfmg1f1e+aM0UpPsbxYNleGvnxcnAI9+p1EoPiHFlQUTAdE
         oMK2GDVJwdkPdrULYDIyiq5TaNLdifwmirI7HKp3N3zhmj5jSKzxl6a+NwHPxSKBN60z
         L98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=f8WSDQJ1BMFeePb0L/BbIVNSSbVdawZX1MtFDgOVN90=;
        b=Sy/SitopAzMF0L+Dxv9O1fZJXld4MGdJuIhJbETJWHYbolXMXRKIyHbeCVeJnDi+Va
         MjfYptZJwGC74EMv3T58M/Sbhhtd1Hp5JGsZPaoglxxyxzSInrfTPZ8tlfNgcSwNoK6C
         WZe2yfbBbbpDRKw2ccolnnMfFGtninU5qz9E7roLlwJ5jF0kYWqTNA/yncDVKTgjSsqL
         otURh8UueweOwjnKECkPbpjaetJUzp/8HcqfkkRexN/yjceDdBa26v71DvZu2FUN2kLc
         nWM1lySw62hWKOkMZhhrS7O9Mwu+P+EPYJa2TuUYZJ/6gpDDoVL39MAcHG2wTdJlSI4b
         Ia4A==
X-Gm-Message-State: AOAM532WpsD3NZPryqoK5KNHcEvNIXvUBlfGb000+MqhrQa1z4nM/KvM
        rcKFJN7qxAq0RWY/4A4eXl8F1LaTd6Q=
X-Google-Smtp-Source: ABdhPJw8cyGblmxnIej+bzuHmE4HaMNlmnpVyZFWAmTOGTWxugumWrL+e6/hTvLo+eljwIDkGS7DfQ==
X-Received: by 2002:a63:a1f:: with SMTP id 31mr28236844pgk.328.1596022242617;
        Wed, 29 Jul 2020 04:30:42 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n24sm1968487pfa.125.2020.07.29.04.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 04:30:42 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] trace : use kvmalloc instead of kmalloc
Date:   Wed, 29 Jul 2020 19:30:32 +0800
Message-Id: <1596022232-14076-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High order memory stuff within trace could introduce OOM, use kvmalloc instead.

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
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee65..d4eb7ea 100644
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
-- 
1.9.1

