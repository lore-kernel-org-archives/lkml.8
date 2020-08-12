Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC1820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247831;
	bh=Gpq5ix4ezroTt36b6Z1RuaTnByqc8WPwI1MtpDCopoQ=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=IGVhQWUqU2wSTZTUGz1eglKs78wYfpjOg8Sh0v7+G8aaReA9tDlZdaflvWRBKt4if
	 2ycezRyPrMJyGgVn0haaeawnH6aPv9KGsa0f2J4ZKsnIUzpZFOjQ9wJcJ+fufEUCpH
	 5MznUOQLk0bbXw98NFspgrJwyKGQPiO66JlBsY8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHLP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4922322D04;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=Gpq5ix4ezroTt36b6Z1RuaTnByqc8WPwI1MtpDCopoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecVF+S00hrK+LBZLxx3QnnwVH38ERNtt8aS/rX4YLc8RunTl0o0WHK3SLFkDRXF2A
         hSw0e9HIAlhJo2xqrsrWtZDqXI41h/tMpaVc5rq5zM5StlJITXZmQ4lSvrxg6K0UmB
         TY39DkVUGrQsGz/b5gzml+kyWoNr5qV+OsZPOmT8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6T-CZ; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH 20/44] staging: mfd: hi6421-spmi-pmic: fix some coding style issues
Date:   Wed, 12 Aug 2020 17:56:30 +0200
Message-Id: <867108ee50302f933fade56f8c25ef775ade36b3.1597247164.git.mchehab+huawei@kernel.org>
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

Checkpatch complains about some minor issues inside this
driver that were not addressed by the previous patch.

Address them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 ++--
 include/linux/mfd/hi6421-spmi-pmic.h        | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index d12ad7484018..aeff96c4a37e 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -38,7 +38,8 @@ struct hi6421_spmi_pmic {
 	unsigned int				*irqs;
 	int					irqnum;
 	int					irqarray;
-	struct hi6421_spmi_irq_mask_info 	irq_mask_addr;
+
+	struct hi6421_spmi_irq_mask_info	irq_mask_addr;
 	struct hi6421_spmi_irq_info		irq_addr;
 };
 
-- 
2.26.2

