Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF820409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Edj5iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgC3OKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:10:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3OKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:10:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so6759866plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zEWrJ+S/cpn22b9RrUPtUgGvmx174MpZLt5rxEvwuts=;
        b=l4Edj5iwMkoHEC5DIJmIH93bYmo+EWfpjA5WBbbPGCxs6SKP89bs1dGc1DSY15vvVq
         X1tNNu1pZYPbobXpTXORQaAtGeQcqdwLGRhhgyP+7oS4wU86oM6K6fJbCm8OViw/XhKF
         zrR3KhRZ8UAJ+t8LhzoghgX6QvtV5KbhCMPjvHjbPn5TEppJ7hpu0a7oIJ08GOL7uVRi
         1KJvj6IfH3aaBd9Ru1j/cbPw2VsAw8DlJczt04Ffmyy698wBoB6idqlMDC06zibyZ8mQ
         dgtPS5YPRQV3kUMPosbaudSMQ8ayGKSBpKf97sQl0buP/lLcWUMW3YfgIyjZuHUXn1co
         D8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zEWrJ+S/cpn22b9RrUPtUgGvmx174MpZLt5rxEvwuts=;
        b=A/c4pqzEr5R9yd6cnUZ0diJ4lSrdKxJUsmw/gwFa5FbUmn2N3D37CHB499OLxvFZHS
         LBbaw88FMp9/+arHWsU1dCS2a3l9leNBsSWEdSEmrujjqOe41Mf05S0ta+OvsI1+82iZ
         A2geSQ+SeF4j6U9pHqk01aRbpEkVb6FwZibcc+H7CVXTCFspx2hI1GcCvZIxmjeo5kuE
         J5y0h/Ic/SB9rVz+y0MYivQ8tyaKFdbmHXFMqFVVXlY842hfcjf1KTeovFDrxLjJoHGh
         5Zf9vlJ67K0IHMcUM11WaS35LMlLe7fLtPEl4uSrAi4m9yx5IMjA4DQpxu7gB94GmTpI
         7ODA==
X-Gm-Message-State: ANhLgQ3R6UBSMjpIbKii0pT+Qavs+dADYhrgsn3/xM53ldk/zLxmGj6Q
        6P6qxEgYLW+xnBpPU1EoCtM=
X-Google-Smtp-Source: ADFU+vsnDqAAIA47wGZ5Cj4Jv582EBSHe488ht2lQIzZ0lFO9vFuD78okV6J0CneK7OUo7sv2+H16w==
X-Received: by 2002:a17:90a:3acc:: with SMTP id b70mr15802936pjc.179.1585577407532;
        Mon, 30 Mar 2020 07:10:07 -0700 (PDT)
Received: from localhost.net ([131.107.160.147])
        by smtp.googlemail.com with ESMTPSA id x4sm10257480pfi.202.2020.03.30.07.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:10:06 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH] x86/Hyper-V: Initialize Syn timer clock even when it's not available
Date:   Mon, 30 Mar 2020 07:09:50 -0700
Message-Id: <20200330140950.12714-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Current code initializes clock event data structure for syn timer
even when it's available or not. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 632d25674e7f..2e893768fc76 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -212,13 +212,16 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
-					  GFP_KERNEL);
-		if (hv_cpu->clk_evt == NULL) {
-			pr_err("Unable to allocate clock event device\n");
-			goto err;
+		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+			hv_cpu->clk_evt =
+				kzalloc(sizeof(struct clock_event_device),
+						  GFP_KERNEL);
+			if (hv_cpu->clk_evt == NULL) {
+				pr_err("Unable to allocate clock event device\n");
+				goto err;
+			}
+			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 		}
-		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 
 		hv_cpu->synic_message_page =
 			(void *)get_zeroed_page(GFP_ATOMIC);
-- 
2.14.5

