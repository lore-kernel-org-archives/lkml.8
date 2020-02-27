Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF34C3F35F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A702469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811261;
	bh=fsw8bX3AiW/+z9HUZPwx9bSyI1oArS/BAj87FAOnCEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FV98z5tNusSKPXZPq7kkS8Zx7IydKrrPXhAbInbR2TEgocBjfCujwbD7zDy/NeGGD
	 5DwToCnCiph86rp8kTpkJb3qHrieXBifILvRqxrGgZnj2Esz5gzzE8NBt4VG/e9zj6
	 PSp2+7K+NtvQUaHqWCCPEE5ZlbXh78y7DeslRuFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgB0Nrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgB0Nri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679B22469F;
        Thu, 27 Feb 2020 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811257;
        bh=fsw8bX3AiW/+z9HUZPwx9bSyI1oArS/BAj87FAOnCEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYgsUoT7KhyA+ni1CML3kYAAbTbd3vbSxtXye6F7rDiXre6VvvwOlAd/3Wk/UMb6g
         0DURSkbyhh6lHsZirOnP1UriCUvJG0x1KZj+AjuOQ5APshUqm5vl38Q9SHX/UYpGFy
         YQxHSSbLG504zlcMxHTU703Rx5dN6IKN+HjqO7mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 063/165] PM / devfreq: rk3399_dmc: Add COMPILE_TEST and HAVE_ARM_SMCCC dependency
Date:   Thu, 27 Feb 2020 14:35:37 +0100
Message-Id: <20200227132240.678764794@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

[ Upstream commit eff5d31f7407fa9d31fb840106f1593399457298 ]

To build test, add COMPILE_TEST depedency to both ARM_RK3399_DMC_DEVFREQ
and DEVFREQ_EVENT_ROCKCHIP_DFI configuration. And ARM_RK3399_DMC_DEVFREQ
used the SMCCC interface so that add HAVE_ARM_SMCCC dependency to prevent
the build break.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/Kconfig       | 3 ++-
 drivers/devfreq/event/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 41254e702f1e9..2ce7cc94d78b1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -102,7 +102,8 @@ config ARM_TEGRA_DEVFREQ
 
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
-	depends on ARCH_ROCKCHIP
+	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
+		(COMPILE_TEST && HAVE_ARM_SMCCC)
 	select DEVFREQ_EVENT_ROCKCHIP_DFI
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index cd949800eed96..8851bc4e8e3e1 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -33,7 +33,7 @@ config DEVFREQ_EVENT_EXYNOS_PPMU
 
 config DEVFREQ_EVENT_ROCKCHIP_DFI
 	tristate "ROCKCHIP DFI DEVFREQ event Driver"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This add the devfreq-event driver for Rockchip SoC. It provides DFI
 	  (DDR Monitor Module) driver to count ddr load.
-- 
2.20.1



