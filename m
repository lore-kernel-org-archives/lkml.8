Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F80F207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762764;
	bh=DqlApqnoeh62N6nMDBl0bR6nhDhQK2yfyHxOyzgzSmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGhALWMvYoYEj/gNcN4pSjxP6St7hcGsQYWILfPZGqcixtApzmTkfXiEioqOrXVGd
	 yIgcQjPUGp68ytNk+r2ngO41XEBTikna7BVBIJOMCK/gKk+Em4vCOz6YMcw0IAQEGj
	 Qe3OFQjI9Lgoads8OfRbs3vou2Q1fm6vopN6JU/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHRO7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgHRO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:05 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7556207DE;
        Tue, 18 Aug 2020 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=DqlApqnoeh62N6nMDBl0bR6nhDhQK2yfyHxOyzgzSmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAFhwzV/KxZlFNRENnfytqfkdaOUy0xG5MGIuqy+NkveP6ggo/QGtME9+koNEJZ+8
         NPK+JXwYv7jrqrZsgg0amd6oBf7eiNNuXZB2U3Wc0Sct62WAiep7eX97afGAVXosxu
         0/NJPR1P4BHnXqHo+kcQTGdQO/ukP+mU4ZvZwQR8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAc-11; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: hikey9xx: fix Kconfig dependency chain
Date:   Tue, 18 Aug 2020 16:58:53 +0200
Message-Id: <1b7e23500e7449593393115cc0954af441b0c730.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597762400.git.mchehab+huawei@kernel.org>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the SPMI controller and the SPMI PMIC driver
depends on the SPMI bus support.

The dependency for the regulator is also wrong:
it should depends on the SPMI version of the HiSilicon 6421,
and not on the normal one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 76267b9be562..a004839e8fa9 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -5,6 +5,7 @@ config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
 	select IRQ_DOMAIN_HIERARCHY
 	depends on HAS_IOMEM
+	depends on SPMI
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
@@ -14,6 +15,7 @@ config SPMI_HISI3670
 config MFD_HI6421_SPMI
 	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
 	depends on OF
+	depends on SPMI
 	select MFD_CORE
 	help
 	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
@@ -28,7 +30,7 @@ config MFD_HI6421_SPMI
 # to be placed at drivers/regulator
 config REGULATOR_HI6421V600
 	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
-	depends on MFD_HI6421_PMIC && OF
+	depends on MFD_HI6421_SPMI && OF
 	help
 	  This driver provides support for the voltage regulators on
 	  HiSilicon Hi6421v600 PMU / Codec IC.
-- 
2.26.2

