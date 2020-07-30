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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170B120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgaIwncX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgG3I2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3I2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:28:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE681C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:28:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t15so3802207pjq.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcCsLLurihXDG2ArxLxOQzE6h/YxXGnUypoiUIrMUPs=;
        b=vgaIwncXLH76c2vsjopH6VnpXCFwwvIE7id91VfeltlytUTvkT6D8F19YWHHMP7xwr
         /VeViC12OhIl3n1xQKb6sQDJ/I+mR4iffOgoi8TbCG/SK8pI/8udYIj11dNQ6xXS6oKB
         QrKDEweLqv/Dba2wvepV6O9G6hv2c6hoaOd2d0WJ11hjyAZyz5adZywiHvFdeCbdhOX1
         Yqc1m/hG7M7WVYGEPRUfKHsbSYwRj+DxwDUHeNJnA3wXbw/9QzZ+9miPWuvByLjGnKfV
         /gSe+TwEovFkQAOWSzSOCGCVBF5o74xWWtGpgWpyhThUyHcwYaK8gAdciEnWXncy8AEM
         7+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcCsLLurihXDG2ArxLxOQzE6h/YxXGnUypoiUIrMUPs=;
        b=d50klt50h3m1+ayECjfC19PLkBIUvmM1akjYOZK9bXdsILToOId//IkoP85kk93Dq1
         Q9LuP49a7KnD8xaFo2QxYtSPWSq+R/jsy6A7qRnnBjLHKJhDXrHpcgi11vb594n3o03M
         8Rzd6aiwyRVkmyqJeuNtkwMS+cmi/22qnCi+tID8BAzsddXC2kKncOlkpreqkTCzkv5q
         jwSoGTcOMqGfZzhM3Je+tehBwWRwfAo7v/Y0pZ1qjfZxCWJpQveqiT8WAnkdLQ2xgfp7
         B4incLyXJLMWnMdjwrLRYxeHiJA1DL0uqBZ7i6YvQRhGwllCbAXeZ6wufdcCg/EKnw1R
         GesA==
X-Gm-Message-State: AOAM532pj5FduYq5G6eybvZ/9lCdyd3ox+aMyvb+WDC7CEOEaQDs+F8+
        IRtguZEqo7ziGK/xOgajR38=
X-Google-Smtp-Source: ABdhPJyn9R58zagQgVL2qh2n3BuTu8xw4rtcySVK0Yvdhwt9gbPpCSe/bklWxOYeoyn3yIekr5Qd/Q==
X-Received: by 2002:a17:90a:fe0c:: with SMTP id ck12mr2226712pjb.102.1596097732436;
        Thu, 30 Jul 2020 01:28:52 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id d29sm5150685pgb.54.2020.07.30.01.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 01:28:52 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing/hwlat: Honor the tracing_cpumask
Date:   Thu, 30 Jul 2020 16:23:18 +0800
Message-Id: <20200730082318.42584-2-haokexin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730082318.42584-1-haokexin@gmail.com>
References: <20200730082318.42584-1-haokexin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In calculation of the cpu mask for the hwlat kernel thread, the wrong
cpu mask is used instead of the tracing_cpumask, this causes the
tracing/tracing_cpumask useless for hwlat tracer. Fixes it.

Fixes: 0330f7aa8ee6 ("tracing: Have hwlat trace migrate across tracing_cpumask CPUs")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/trace/trace_hwlat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index ddb528a6cd51..17873e5d0353 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -283,6 +283,7 @@ static bool disable_migrate;
 static void move_to_next_cpu(void)
 {
 	struct cpumask *current_mask = &save_cpumask;
+	struct trace_array *tr = hwlat_trace;
 	int next_cpu;
 
 	if (disable_migrate)
@@ -296,7 +297,7 @@ static void move_to_next_cpu(void)
 		goto disable;
 
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	next_cpu = cpumask_next(smp_processor_id(), current_mask);
 	put_online_cpus();
 
@@ -372,7 +373,7 @@ static int start_kthread(struct trace_array *tr)
 
 	/* Just pick the first CPU on first iteration */
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	put_online_cpus();
 	next_cpu = cpumask_first(current_mask);
 
-- 
2.26.2

