Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF66C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43AE20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWM3eM4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404357AbgDCPfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:35:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55406 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404257AbgDCPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:35:03 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so3119176pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OBTqvoJaPRzJzFYbgduwTTs1J5D9wflAy+OmVHZv2bE=;
        b=VWM3eM4TgcEp3bwAqSNkP36LzS6eQ3DJCQar0MaDV+IbULRSznAHfkGGrZfUUgFeHx
         WA83xCYji6p2nU4Gj1nZ1dPXRhOwyL59Gnb6BqQytUW9YYIb6nH9lfgEn9Z+WVF8/u2R
         xXou7NYPy+Ynfc2/bQEQuyTHukyR19omZN7JKr0hJz5GBtMgCLWBB7jDvyixlcIWnMgv
         d1XHRQHf29iCOCDybn8vN6BIt2emLUG0ctr65dJkvX+nITffnvDgUxP8B1DwlNguezJa
         l0vIoMv7hnIvJlD0KJzIskQ/DIeIkPRyFLqvHwQp6hG0SBwHz1VgJ5KdUxT/dgU2551w
         VH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OBTqvoJaPRzJzFYbgduwTTs1J5D9wflAy+OmVHZv2bE=;
        b=NM0Rxid+juySJbuEIchTt2gPGMDLve54O/0GYiBNgOPTu31E3GC9Ru7ikUrE8CczXl
         Ej/Yn5K/31ngbqdpYi/X7O9D8OLM4T7Cvig+q4y0Ja/UfIurjqSFwNCy8R4V+pPpxT+O
         ydhSuqhzW1psNQbdUiiGEIEwZWW82QyaLFjrRRaPqJ3fghH4AFY6L1JsWl8wawFgFL4b
         4h2YPSGkBafpTKatK21Nrq9SgtxBGOKWnOBcTYp490ec7AmOVAb9vtmpXq2smggM/gNn
         so2fPSRPTr8tAzs9jAjbw8NAHv/cgvKNKf9tpMViduSLuzNgyNi1Qq8O/dG8WEgLX1O0
         Qiqw==
X-Gm-Message-State: AGi0PuY0Dwq6Z4bdNrs64SqiZAD1UzCrrrT1C3h8jRO3okt4+aBT5tmo
        8xz/VrBhtDV+8zsZ735VVD0y4T5z
X-Google-Smtp-Source: APiQypJJiNXI4c4eCEzEuJotLFPpEG3qfziqFlxS1yRA5Y7XU1zlhh/l5Ii/b2Lugm0W5VX8iuUmPQ==
X-Received: by 2002:a17:902:ee93:: with SMTP id a19mr8563263pld.258.1585928102358;
        Fri, 03 Apr 2020 08:35:02 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id d7sm6043761pfa.106.2020.04.03.08.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:35:01 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] trace: Fix a typo in comment "bascially" -> "basically"
Date:   Fri,  3 Apr 2020 23:34:57 +0800
Message-Id: <1585928097-28123-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a typo in comment. Fix it.
s/bascially/basically

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 2e9a474..4d61af0 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -155,7 +155,7 @@ static int benchmark_event_kthread(void *arg)
 
 		/*
 		 * We don't go to sleep, but let others run as well.
-		 * This is bascially a "yield()" to let any task that
+		 * This is basically a "yield()" to let any task that
 		 * wants to run, schedule in, but if the CPU is idle,
 		 * we'll keep burning cycles.
 		 *
-- 
1.8.3.1

