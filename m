Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6FD207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247875;
	bh=0Ge6VswlmR80j30p2evfkj0Ci5lu2tDRSHfnYoCsjZI=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=UHWdHkWiHbP82EfHzL/V/N1/MXjk/naMQI5Nt6YNgwWyLQJckW7NSyPCE4FBBNDpZ
	 VXrdP+J7Yv0aio1ohhbEeULP+6+8/FxheCGv8jmCa4ZlcwMGTAlyI5R0fA8KCAUxXv
	 Q1AiHDngeoHzjKDvNYTXQHPPSII1T218Dwhqwvrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHLP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2997323103;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=0Ge6VswlmR80j30p2evfkj0Ci5lu2tDRSHfnYoCsjZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnHY8lkrUOoV9efHBIJmvk88xey5fb8VvSUqa14JbSI1/7FNbB4tuhOHORgR3m9o+
         xOGZ/47lELYLmf0VNMqGdU6QK1TB5KbMDsGPnhl5sJYFVx3wkH1kyXNsDbNAofdxSX
         KQmsJtDmul/FgKDgYc+C8Ue5Nn8bBaG8hFjP11RA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7O-BL; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 39/44] staging: regulator: hi6421v600-regulator: add it to the building system
Date:   Wed, 12 Aug 2020 17:56:49 +0200
Message-Id: <e760a3d286354424e98ed6425dd12892b5363915.1597247164.git.mchehab+huawei@kernel.org>
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

Change the binding logic to ensure that the PMIC SPMI
driver will run before the regulator code and add it to the
building system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/Kconfig  | 10 +++++++++-
 drivers/staging/hikey9xx/Makefile |  5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 7ca083b7e94d..76267b9be562 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -15,7 +15,6 @@ config MFD_HI6421_SPMI
 	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
 	depends on OF
 	select MFD_CORE
-	select REGMAP_MMIO
 	help
 	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
 	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
@@ -25,3 +24,12 @@ config MFD_HI6421_SPMI
 	  individual components like voltage regulators under corresponding
 	  menus in order to enable them.
 	  We communicate with the Hi6421v600 via a SPMI bus.
+
+# to be placed at drivers/regulator
+config REGULATOR_HI6421V600
+	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
+	depends on MFD_HI6421_PMIC && OF
+	help
+	  This driver provides support for the voltage regulators on
+	  HiSilicon Hi6421v600 PMU / Codec IC.
+	  This is used on Kirin 3670 boards, like HiKey 970.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 79de37da7a8f..9371dcc3d35b 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
-obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
+obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
+obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
+obj-$(CONFIG_REGULATOR_HI6421V600)	+= hi6421v600-regulator.o
-- 
2.26.2

