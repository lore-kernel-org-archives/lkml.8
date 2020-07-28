Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D4C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B299420829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595933115;
	bh=8yMg9fJQRjOOXsxqO6TAUCfO3nYZZssnCt0NXo42FWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3gW+Ou3PvalvpypC5yaUmvisKkzEHz19Bq/J5x/yF3fPvtm5IlgHHG6zIOf/9U39
	 F1Aef/oQZtSWzD7h56IQvZdBSSiG3p0NJKC7TKuJuy8wIbQs5xXQ++Rx6EYtDCsG+J
	 vWUCuUo56Y4gGgsTDQ4lqM5fXhzoUDSkQkzfzZ/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgG1KpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgG1KpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:45:12 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB710207E8;
        Tue, 28 Jul 2020 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595933112;
        bh=8yMg9fJQRjOOXsxqO6TAUCfO3nYZZssnCt0NXo42FWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDghIWQc/P63HUUqZ8YTt3YwY4KoLo+JFMa+116li7oKFkNrFzlg+0Bl3YIEhDCm3
         8UIEmLPyuf2+4JOIcsRC9/M6PRtCt6mPI9MgA+6GS/GhHOBA6XiMR1JBKNEGifIVJF
         GG0/N0vYs+vDoa36c7WoNhElNkYYR5LlFjlsBENc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/2] MIPS: ingenic: Enable JZ4780_NEMC manually
Date:   Tue, 28 Jul 2020 12:45:03 +0200
Message-Id: <20200728104503.23655-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728104503.23655-1-krzk@kernel.org>
References: <20200728104503.23655-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_JZ4780_NEMC was previously a default on MIPS but now it has
to be enabled manually.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 arch/mips/configs/ci20_defconfig    | 1 +
 arch/mips/configs/qi_lb60_defconfig | 1 +
 arch/mips/configs/rs90_defconfig    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index e511fe0243a5..0a46199fdc3f 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -128,6 +128,7 @@ CONFIG_DMA_JZ4780=y
 CONFIG_INGENIC_OST=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
+CONFIG_JZ4780_NEMC=y
 CONFIG_PWM=y
 CONFIG_PWM_JZ4740=m
 CONFIG_EXT4_FS=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 97c9a69d1528..81bfbee72b0c 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -108,6 +108,7 @@ CONFIG_RTC_DRV_JZ4740=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_JZ4780=y
 CONFIG_MEMORY=y
+CONFIG_JZ4780_NEMC=y
 CONFIG_IIO=y
 CONFIG_INGENIC_ADC=y
 CONFIG_PWM=y
diff --git a/arch/mips/configs/rs90_defconfig b/arch/mips/configs/rs90_defconfig
index 433ac5c0266a..de6752051ecc 100644
--- a/arch/mips/configs/rs90_defconfig
+++ b/arch/mips/configs/rs90_defconfig
@@ -145,6 +145,7 @@ CONFIG_DMA_JZ4780=y
 CONFIG_INGENIC_OST=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
+CONFIG_JZ4780_NEMC=y
 CONFIG_IIO=y
 CONFIG_INGENIC_ADC=y
 CONFIG_IIO_RESCALE=y
-- 
2.17.1

