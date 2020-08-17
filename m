Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F20C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDF52078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648348;
	bh=gEvx9Kx8KGAqN/e6R9fLDivnSIHXhkH+qz6V51q6op8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B8Ryh7anuhRAy46F1e+AllmU9Vfm0+CaYfVBX2HBX1c+UpNY9hOLbPKgW2Xb7P4Ue
	 8NdeaRfZPkiDigJkfnzhgj0fIMXIu9ajjteFdKlg9EqjG/9iGKUF5bQSQpj9GWAKxa
	 bnCtZS0fZojlpbzavnlBJPl04Uynkrl+xF0nSLus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHQHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgHQHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB7022CA1;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=gEvx9Kx8KGAqN/e6R9fLDivnSIHXhkH+qz6V51q6op8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXy2yY6f7J6QjpJOLJTEw85JDeViVkfKuh4VcQTS2KUkTGHvBl+y1mvfI9jzbFxts
         ML2Y0J/cXfcCOXTHB/SkY7XMBG4Ndl2LuDg0H6Wp5aI5Fxl3Dy5pt9ytNEsP/dEAzg
         iS3b7WXLCPT8/WBUrW9c1ZFLgfq1Bs7f6+G9JTQU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdk9-NJ; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 20/44] staging: mfd: hi6421-spmi-pmic: fix some coding style issues
Date:   Mon, 17 Aug 2020 09:10:39 +0200
Message-Id: <84b53d20632c84cc60b8dadfe937f3c54b355cef.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch complains about some minor issues inside this
driver that were not addressed by the previous patch.

Address them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 ++--
 include/linux/mfd/hi6421-spmi-pmic.h        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 09cedfa1e4bb..d8b84d64041e 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -189,7 +189,7 @@ static struct irq_chip hi6421_spmi_pmu_irqchip = {
 };
 
 static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
-			irq_hw_number_t hw)
+			       irq_hw_number_t hw)
 {
 	struct hi6421_spmi_pmic *pmic = d->host_data;
 
@@ -350,7 +350,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	 * The logic below will rely that the pmic is already stored at
 	 * drvdata.
 	 */
-	dev_dbg(&pdev->dev, "SPMI-PMIC: adding childs for %pOF\n",
+	dev_dbg(&pdev->dev, "SPMI-PMIC: adding children for %pOF\n",
 		pdev->dev.of_node);
 	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
 				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index d12ad7484018..403fd8bb45fa 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -38,7 +38,7 @@ struct hi6421_spmi_pmic {
 	unsigned int				*irqs;
 	int					irqnum;
 	int					irqarray;
-	struct hi6421_spmi_irq_mask_info 	irq_mask_addr;
+	struct hi6421_spmi_irq_mask_info	irq_mask_addr;
 	struct hi6421_spmi_irq_info		irq_addr;
 };
 
-- 
2.26.2

