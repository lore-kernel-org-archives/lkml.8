Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF89C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C820578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272504;
	bh=BN8+ZaNbGgmLxYVRgR35u0FGVKgnwKnoUJxz89LB8gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMILxKrmy6Iq9DVvUUUEMztKeqmY5W/vyeRYAiU9k5c0kTe+MA+r6c/9y8RNjPoXo
	 bqUvLIM1PhypIE61+VGeywakdvOMOi9je2HXdpQVhSP/1cBs07OGTHrp8RK32MHWiD
	 818UBYI/lMUL111r0FpN+wQl6CZBXO5brfbBPoI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgBUIIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730873AbgBUIIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:08:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5DD20578;
        Fri, 21 Feb 2020 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272499;
        bh=BN8+ZaNbGgmLxYVRgR35u0FGVKgnwKnoUJxz89LB8gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0m3dXveKIjlfvEqoHWYgfuw374PMIVkPPzEZUPkjLfTXFLzaU3w2A/BKNHIKjg8Z
         7LpprX3cV8Gr0cV1ffzpFtOvpGviE4L1oKY5w0rJThOADk3mprBf9WDrFEIU/+ILx+
         +PlRCq8oKqXwJR/vakgNaTopdKpWrXmCnvQUX7fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 166/344] PM / devfreq: rk3399_dmc: Add COMPILE_TEST and HAVE_ARM_SMCCC dependency
Date:   Fri, 21 Feb 2020 08:39:25 +0100
Message-Id: <20200221072403.940387891@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index af4a3ccb96b34..1433f2ba9d3b1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -118,7 +118,8 @@ config ARM_TEGRA20_DEVFREQ
 
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
-	depends on ARCH_ROCKCHIP
+	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
+		(COMPILE_TEST && HAVE_ARM_SMCCC)
 	select DEVFREQ_EVENT_ROCKCHIP_DFI
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index cef2cf5347ca7..a53e0a6ffdfeb 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -34,7 +34,7 @@ config DEVFREQ_EVENT_EXYNOS_PPMU
 
 config DEVFREQ_EVENT_ROCKCHIP_DFI
 	tristate "ROCKCHIP DFI DEVFREQ event Driver"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This add the devfreq-event driver for Rockchip SoC. It provides DFI
 	  (DDR Monitor Module) driver to count ddr load.
-- 
2.20.1



