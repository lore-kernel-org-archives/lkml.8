Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CBE2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247958;
	bh=F4/0N358UMInRTChm1W025kSLWvagEEmCODOlEavrPA=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=2mjoPso965mkkQodk12ZDdQCN2WXzhK70ykoH39cjM/vM2I55DiXsbkgguTjZXXtu
	 HBLiXDqhiOmTVx+i+Cp9oP8jjrrY4wbzaB3UD7jZrc7Cu/qifCCNze7CPtS7EeGIFx
	 n06l/qYX0lK/XoCsPXbPUDo23MC/cb6COdqcufNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHLP7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3728922B49;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=F4/0N358UMInRTChm1W025kSLWvagEEmCODOlEavrPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Owpp0QA19AC4Hs0o7VUlHXmV0MZOhFhBA6a7EJpbjzEEB0OuGT0scQ+QtjzoYkbp6
         Mc8vtK35EgOjCFtd0vd1cLkRSreu4Gll4ZQlkDn3hHDeO2T0AqP1Ni7P07Sw97Dwy0
         Qc93PbwQv87Ixzq1es0BC6HP1MpUR2lVmbdBMpgE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6N-9b; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 18/44] staging: mfd: hi6421-spmi-pmic: cleanup OF properties
Date:   Wed, 12 Aug 2020 17:56:28 +0200
Message-Id: <64e7e7d39b4fd738a9202d970b42b01b7bf49069.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
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
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index f523b2d844b9..aed2d3ec2227 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
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

