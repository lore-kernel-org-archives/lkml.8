Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936932076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160622;
	bh=EMMFXuWN+gwpqfoPWAsVY8betx/gJ+xa5jzIbRyS8wY=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=pkWFZ/wiainLp/mmqvoAzxuV8LqQyXPHQNM7a+BvOQsgheSC2OlU+LodZU/g09KOk
	 MzRQpTLkOIkdDmwj8QviFKnXLjmB7gfJ48cuC1ph/IqDWaxmmsfTkCIJFe4R5QMOss
	 D3BYDMPZkriDXtEp46nd9+NyiElBr4/ggn3CEU3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgHKPnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgHKPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B573022CF7;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=EMMFXuWN+gwpqfoPWAsVY8betx/gJ+xa5jzIbRyS8wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwgbheYQM0BazLtcTgs5m7S5ntyULcMphiHMUJ0E6VWX9tQ39mctqyNIfPU5EuqJ+
         JvoihY1w5Ic/tgyVXVgF6GJyTb1eBQzVtkhb/uYSSPdxaL6kFmhHIO/FNcmi4+L07E
         ZJfsnEwzeVP5JV0Aw8X8R9rKiCYx+5Z3B+d+1Ehs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bn5-TG; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/33] spmi: hi6421-spmi-pmic: cleanup OF properties
Date:   Tue, 11 Aug 2020 17:41:45 +0200
Message-Id: <1e2d0723f6bef27b6ab6a3647c3925a14f6ccbed.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the names of the DT properties and do some cleanups,
in order to better document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hi6421-spmi-pmic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
index f523b2d844b9..aed2d3ec2227 100644
--- a/drivers/mfd/hi6421-spmi-pmic.c
+++ b/drivers/mfd/hi6421-spmi-pmic.c
@@ -209,37 +209,37 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 	int ret = 0;
 
 	/*get pmic irq num*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-num",
+	ret = of_property_read_u32_array(np, "irq-num",
 					 &pmic->irqnum, 1);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-num property set\n");
+		pr_err("no irq-num property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*get pmic irq array number*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-array",
+	ret = of_property_read_u32_array(np, "irq-array",
 					 &pmic->irqarray, 1);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-array property set\n");
+		pr_err("no irq-array property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-mask-addr",
+	ret = of_property_read_u32_array(np, "irq-mask-addr",
 					 (int *)&pmic->irq_mask_addr, 2);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-mask-addr property set\n");
+		pr_err("no irq-mask-addr property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*SOC_PMIC_IRQ0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-addr",
+	ret = of_property_read_u32_array(np, "irq-addr",
 					 (int *)&pmic->irq_addr, 2);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-addr property set\n");
+		pr_err("no irq-addr property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
-- 
2.26.2

