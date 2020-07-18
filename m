Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C40C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8361920691
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaB2T02E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgGRAGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGRAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:06:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F5C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a25so7985339pfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DKGRFKWlyGqgvFuZLsoVKcLXRUmmTtOYHyvcndsSP+U=;
        b=eaB2T02EB8g0y1xZXeHPi2mGLg8poIqpVgJ7BZUCLc/EEq3S9kRsfSNNVOCKuDD0Tp
         x74rVZSROfJKsOJm9ugF+T1Hp/iX0XD+d22Er6E2Ibg96Ah5e8rAy3JrWpf9H2Z7OG+d
         YfBGYGnHBr3s3ccaS/U13rr/1gTn2YsvYde1+xHImpDp53KqpLwJSlZ2wApaMUKIJsf3
         crIVaak6JWU7DHb9Yi5DC8e+5EFRBpqVcvzTXx4P24HIAMBgrJPX7czTcaMGSWVzUDhV
         MEo1D+Pw+zcwU39+Qrp+uVsSPuLqyQXoE6/DNJ8WbV/EYVgi81q5pq3cK0C/DF/L+LlF
         vZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DKGRFKWlyGqgvFuZLsoVKcLXRUmmTtOYHyvcndsSP+U=;
        b=PUQoaStQWOI/OBFnGW0U2Zpp9v+0SVDQTebEuIRU0eVAi15oJ369mdMd7iNyOt84bo
         mQjnnpZgmySvR14wn16x/S7AR5/UiAcPbVRKCt+M9nE05wa8WsmyLI48oX60NCZvm2oY
         IShiEFwtGqJTci31qKD5LUSLfdwcmoJWSAWZibofL9+EfQfXuDcjc/Gp8t0qTW8AuemE
         DpK5z1JQiZm6alWCYUtjHqH8DdBBI+4XwpAqMgZE+kc2Kcu6X+SAqnoFhb2BU0q9UHAD
         R0OL+ooqtKRnQ/yhRVvZI5TPj5sEHHsRRaUzbniLh1o/O5F3XGDUi6SmUJi70YUihlyP
         GvGA==
X-Gm-Message-State: AOAM530T44ptCceXjAXgP74x7nd4thvrbfQn1o5nkAt0zOYk7K7HwK4h
        7XVle31lChkSjEJkw53jBcTFHfjLPajDM0A=
X-Google-Smtp-Source: ABdhPJw0Oq4D37hE7WRVSZZsPHqDRMN/reFgLscACQLoMocTAkUGaDa91/twwV300uYzLONkac+Q5pfdV9Natf0=
X-Received: by 2002:a17:90a:32cb:: with SMTP id l69mr11006149pjb.205.1595030805133;
 Fri, 17 Jul 2020 17:06:45 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:06:35 -0700
In-Reply-To: <20200718000637.3632841-1-saravanak@google.com>
Message-Id: <20200718000637.3632841-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER
 helper macros
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the driver to use the helper macros. In addition to reducing the
number of lines, this also adds module unload protection (if the driver
is compiled as a module) by switching from module_platform_driver to
builtin_platform_driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/qcom-pdc.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 5b624e3295e4..c1c5dfad57cc 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -432,28 +432,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-static int qcom_pdc_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *parent = of_irq_find_parent(np);
-
-	return qcom_pdc_init(np, parent);
-}
-
-static const struct of_device_id qcom_pdc_match_table[] = {
-	{ .compatible = "qcom,pdc" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
-
-static struct platform_driver qcom_pdc_driver = {
-	.probe = qcom_pdc_probe,
-	.driver = {
-		.name = "qcom-pdc",
-		.of_match_table = qcom_pdc_match_table,
-		.suppress_bind_attrs = true,
-	},
-};
-module_platform_driver(qcom_pdc_driver);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
 MODULE_LICENSE("GPL v2");
-- 
2.28.0.rc0.105.gf9edc3c819-goog

