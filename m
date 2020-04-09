Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA2C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38D420784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586414665;
	bh=2N0GMdLYc2FyQxaMRo7QOJwiClWsmWmQoTEOT+XZN4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L9MjwccPPNODxs9WGBScCu2okiF7tVXMaw5KfCUqyJxDQITGjbqvO2yGrDrU9NXtR
	 Kzwoxcs+7Dfg1Z9DDO77+tNh7EGaSJcCPXPO42NSBW5Sbx//PYPPE6qRP/36IM6NeY
	 9Mv28mSxNFDezuOZCyDt4mZVfsqIA3Zj+iFXRhiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDIGoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgDIGoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:44:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C03A20BED;
        Thu,  9 Apr 2020 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586414660;
        bh=2N0GMdLYc2FyQxaMRo7QOJwiClWsmWmQoTEOT+XZN4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hs5rRolwq+W+EUuMWw+q/+Mbdv3EjLUqPL7ByM1DnrZNmfsdc54YSgQaJSSubvY5L
         NQ7kNSzAj9MquxJ+TVcbmYbUTlXlEHwSy3J1Ph0f1z+5hdbsoLZdq9BYLqCIZduJnZ
         fDSUrXV2BUKPEi+5sEGNMfF98N+dwITkpyfuw64w=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 06/10] mmc: meson-mx-sdio: Depend on OF_ADDRESS and not just OF
Date:   Wed,  8 Apr 2020 23:44:12 -0700
Message-Id: <20200409064416.83340-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making COMMON_CLK a visible option causes the sparc allyesconfig to fail
to build like so:

   sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `meson_mx_mmc_remove':
   meson-mx-sdio.c:(.text+0x70): undefined reference to `of_platform_device_destroy'
   sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `meson_mx_mmc_probe':
   meson-mx-sdio.c:(.text+0x9e4): undefined reference to `of_platform_device_create'
   sparc64-linux-ld: meson-mx-sdio.c:(.text+0xdd4): undefined reference to `of_platform_device_destroy'

This is because the implementation of of_platform_device_destroy() is
inside an #ifdef CONFIG_OF_ADDRESS section of drivers/of/platform.c.
This driver already depends on OF being enabled, so let's tighten that
constrain a little more so that it depends on OF_ADDRESS instead. This
way we won't try to build this driver on platforms that don't have this
function.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 3a5089f0332c..31b2a8826b30 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -409,7 +409,7 @@ config MMC_MESON_MX_SDIO
 	tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
 	depends on ARCH_MESON || COMPILE_TEST
 	depends on COMMON_CLK
-	depends on OF
+	depends on OF_ADDRESS
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Amlogic Meson6, Meson8 and Meson8b SoCs.
-- 
Sent by a computer, using git, on the internet

