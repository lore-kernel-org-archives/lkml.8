Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B56C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAADA2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650638;
	bh=HOfDmj8UoHuRegR0krfn2T5Wtujk1Lcw6hMZ/GcOEPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cy6kJmCCEBDVCnPSphUgztlAbFttHz2wh/qHLC9PNUNubVOQCtdjEKmiMuDvOY6/F
	 gx3GwjzWOoXzFnvcrv2WtWYidwfvlCsB0lQAX3ZcxEulTWn4b2SYtxmgADMH47Fm55
	 +2Z5PQb1ymeDGPQa9zgVi9+PEMfWTusR5p62MJ+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHQHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgHQHuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:23 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325BE22B45;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=HOfDmj8UoHuRegR0krfn2T5Wtujk1Lcw6hMZ/GcOEPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qy0J2xtwUnQFW5bq9l/SJPpRL+5JU+CWUnGl2nZKC8HBBbPrfo8UXyza96eHNVgIS
         9TbhMB3Pkc2d26NONKp3nTuuco5tjGLxdnrbDns++1mpLiWdfzLyZ1/Mm/Fm19qyRP
         XEqeSOQATa6Hf/0tHlmZkqt7OEd265WJLitVg+5Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcL-B1; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 11/16] iommu: add Hisilicon Kirin970 iommu at the building system
Date:   Mon, 17 Aug 2020 09:50:10 +0200
Message-Id: <5a6910720a629bdc39d013d8b45bd97a72c9ceb0.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the iommu driver is ready, add it to the building
system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/Kconfig  | 9 +++++++++
 drivers/staging/hikey9xx/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 76267b9be562..6487278a4144 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -33,3 +33,12 @@ config REGULATOR_HI6421V600
 	  This driver provides support for the voltage regulators on
 	  HiSilicon Hi6421v600 PMU / Codec IC.
 	  This is used on Kirin 3670 boards, like HiKey 970.
+
+# to be placed at drivers/iommu
+config HISI_IOMMU_LPAE
+	bool "Hisilicon IOMMU LPAE Support"
+	select IOMMU_API
+	select IODOMAIN_API
+	help
+	  This driver provides support for the IOMMU found on Kirin 970.
+	  This is used on Kirin 3670 boards, like HiKey 970.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 9371dcc3d35b..c6e4998c02dd 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
 obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
 obj-$(CONFIG_REGULATOR_HI6421V600)	+= hi6421v600-regulator.o
+obj-$(CONFIG_HISI_IOMMU_LPAE)		+= hisi_smmu_lpae.o
-- 
2.26.2

