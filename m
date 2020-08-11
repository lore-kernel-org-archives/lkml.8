Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87259C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C8C2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160651;
	bh=qEWaiZ3m/Gf0hSnFw93IzfHoukanTss06kl7BdRnAbA=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=bvZaRhVM3FpcBxM0WQiXBlF9BFg5+xpl6nrKstx2B4SbGlhDMuOcjEl38eXKKLSB2
	 CWyUEfcbX1MB/ODr4ZIwGj9l+1K9uLq3Z/7is90TBfH+ZS2Qj4uDfpatLaTG5Iwrnm
	 aM/vsFlEKtqNxiehFf46g+O5koztS70Qn3zw+LH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgHKPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgHKPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96ED622B49;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=qEWaiZ3m/Gf0hSnFw93IzfHoukanTss06kl7BdRnAbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsgS9KKdMztB0hOc2XcCIvW8pABdPmJeZSJF3Lkiw71RsTtJxpH7VnXDHq306074r
         vdEugxrwqeYCv2U9WJM0/ys/4ez/lF1g8pQe6lcdcA6GHwTpPq4H7XYHy+lNmiGKhv
         1VdDricrUOASUbV69GiuhPPk/DgLX+empy0/Odw4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmq-O4; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/33] spmi: add hisi-spmi-controller to the building system
Date:   Tue, 11 Aug 2020 17:41:40 +0200
Message-Id: <7026c57ed74b9e187b5342efd76161e33839b0ff.1597160086.git.mchehab+huawei@kernel.org>
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

Now that the driver was ported to upstream, add it as a
SPMI controller.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spmi/Kconfig  | 9 +++++++++
 drivers/spmi/Makefile | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index a53bad541f1a..b44e2ab6bf81 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -25,4 +25,13 @@ config SPMI_MSM_PMIC_ARB
 	  This is required for communicating with Qualcomm PMICs and
 	  other devices that have the SPMI interface.
 
+config SPMI_HISI3670
+	tristate "Hisilicon 3670 SPMI Controller"
+	select IRQ_DOMAIN_HIERARCHY
+	depends on HAS_IOMEM
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
+	  processors.
+
 endif
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 55a94cadeffe..694853e391cb 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -5,3 +5,5 @@
 obj-$(CONFIG_SPMI)	+= spmi.o
 
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
+
+obj-$(CONFIG_SPMI_HISI3670) += hisi-spmi-controller.o
-- 
2.26.2

