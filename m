Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFEC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87CF2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDWQE6oY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRRmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35639 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgCRRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10919721wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dcxJNCvC++SuuvRsSGVbNsf6w51bi547QQ/OjMqmLQ=;
        b=PDWQE6oY5WBarlJlgolHRHNcVadn+BJ5bNq1FobZqtoFTih5bWfATo41yfXUWURFyE
         0Bu7OarTd2fMRbnNzMpMTTkswSEGbTFMcPsi2EmfIv+8Hks/7IVVcAAz7nRwFM3Hn8sy
         BqHBW75GK2nzpEec1X0MTMB8/Bhi3m5ERxQpBs2wkn0dmSD6YrlR4dTXi/1PtYvo8f6S
         jSA0YhgCT3K/oV9A3bRRpGJIW0PLVdSKizPB5S+E+vI4A25Tp+7dGfVZzd4gs9LQtt9E
         qhkfm1PR3n3gn9tX5jiQHdGusg0oa/1wO4wCL5C9NmyRb74MHMevApUwyn5Ibn9BgueQ
         VPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dcxJNCvC++SuuvRsSGVbNsf6w51bi547QQ/OjMqmLQ=;
        b=aPoDio8M4PGwabeqmlNKAaYUD40gODp/qYJWFCP9wk4gnGqIauQ3it7DsaFlP6rPx+
         AvpKXUaI2EdQUI5fMlrd7ukzAKUI3T/BxPAIEYKwygLJb7CAV6sVMdiPl9JTd8GAUaUL
         76VYNEsFdQzYCYoX3GBgPypogT+NQZp08/o2FBvWXlHHt3hPDpO4j+WFpkjJ62PLuT1z
         b/6vrKh+sX2YWg3RbsGCTJlxUmI4DHltG1Crjg2J9FTyW9kayNQ15iuDFHBF/KgzCXsz
         SAaXutS3NrhYOYVJrCQ6gae1hv6vle2iAmnxdJhkLFjEnLHzrKi37B+jcwoAH+fWX+uP
         t2fw==
X-Gm-Message-State: ANhLgQ27P7sTS6toGI5o/5HIv+erst7IURZ0pFCe8EfqMTT20vsyAW0J
        3RD3IqhFa9GOSUnQiaMAfAiwQg==
X-Google-Smtp-Source: ADFU+vvKyobOYlzcrnmmuxlddBFzyFgGMZdf/uTrpa+0uA75psnEe+wPZRx5MNPaCV1SNn1xB2ZedQ==
X-Received: by 2002:adf:f749:: with SMTP id z9mr6501875wrp.332.1584553347612;
        Wed, 18 Mar 2020 10:42:27 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI
        ARCHITECTURE)
Subject: [PATCH 05/21] clocksource/drivers/owl: Improve owl_timer_init fail messages
Date:   Wed, 18 Mar 2020 18:41:15 +0100
Message-Id: <20200318174131.20582-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br>

Check the return from clocksource_mmio_init, add messages in case of
an error and in case of not having a defined clock property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200219004810.411190-1-matheus@castello.eng.br
---
 drivers/clocksource/timer-owl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index 900fe736145d..ac97420bfa7c 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -135,8 +135,11 @@ static int __init owl_timer_init(struct device_node *node)
 	}
 
 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("Failed to get clock for clocksource (%d)\n", ret);
+		return ret;
+	}
 
 	rate = clk_get_rate(clk);
 
@@ -144,8 +147,12 @@ static int __init owl_timer_init(struct device_node *node)
 	owl_timer_set_enabled(owl_clksrc_base, true);
 
 	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
+	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+				    rate, 200, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("Failed to register clocksource (%d)\n", ret);
+		return ret;
+	}
 
 	owl_timer_reset(owl_clkevt_base);
 
-- 
2.17.1

