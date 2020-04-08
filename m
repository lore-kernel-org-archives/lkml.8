Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6126C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EF32051A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgDHUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:08:38 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:08:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHG4W-1jZSGb2XFQ-00DGKB; Wed, 08 Apr 2020 22:08:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] phy: tegra: fix USB dependencies
Date:   Wed,  8 Apr 2020 22:08:14 +0200
Message-Id: <20200408200828.124139-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kUzwfLYLaHsZpKlTy4n+0vussKWl3Ftu9RnLUf4mhmFXohPzTmH
 wi9J5Xrz92VvWWaVhGoy4eGOh9nxRsmb6gyzpE34ECy4I55coV+LxZDoMlDNUmbjHnLmpiu
 prJXQXOwAs167fMBF2YRxpTD0kaEOpCFPsRgHEFiBTKqj0SS+fg2IO24nqY+s2zntmn+Ih0
 QKehqgKLZNjWr4PAcJQ2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AM4pn0KeM6w=:vZLclcrBBMaxMpySOwMon4
 BbSK3XIk3rVKOCuv2itMAAc2THQ0BZBLsqsHemLM8C2larnYUkvud2BHzb6nauxhEdkny95hh
 11CyINZE1K5TowecRzwdHw8SlHyUFytQtxA1wPG0o+rDd2i4PYEnxAOmAV7MvnEv9Uh9ffl4y
 QxhI5S1OP99m6b3z74r6ed1/kZ/V6rs7/UKS4ebTqqQXJ0jkPWBoPhpSuQ2Jl6O6Ttf1fKwhG
 ZAiLbvVYroWdsFhIo95lipufu6dCWJhxYYGx0F5GLWXGTqXzUDtpWk8XiMwEdQWMNeYaZc+a3
 rtKIG4O5bnqqx8BzVgbylLRmICe5zRisjk2Y0mJDV8OHkzWSM/r5bK4P9IXbXV3ln0guLhBgx
 dhnUKSVl/YYFHvIP1iKklUYVhsKAPNYf4OzWP6PHTWTz1V+mKaQH+AgpeFKpFjQtvqw6wALzw
 UP5MI03Izh2cdIiBkrV1zGyj8x3iFmArET/LpxM1i83OW3mfYS/1vNt7XkzJ7osf+wzBU/Es6
 TFpOeq5LGUp77io8X2zARp0hTzFN72TVG6mIzKnSJDKjnAwsLOgU0dyQKvm/prxn1ZqKtKZKe
 avBUNfL4qEaOuBdsUGLoXOCupuFBuCEe0ekSfUEjndW89NaTE35i40LREWifLwx0lo3HcYNbp
 j/oBcu9vwoqSeRfHVbOI1zs8Vzf6lsV4NrndXxSi5ED2/tg8XfzGK4aNcNa8Ud7hKLdhuThwe
 QGosSl/Y4ihAmMNavDGzgC40D7Tbt01eISUNNpPDjhhpNzZI+9fqSKJMyVuzadt7OmbA4f+cL
 WRJmBlSoV/nssCfM5lks5XCuoSCA0IYw3IBaFHdb0Hq9Hm+Ql8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_USB_SUPPORT, we can get a couple of warnings for
missing dependencies:

WARNING: unmet direct dependencies detected for USB_PHY
  Depends on [n]: USB_SUPPORT [=n]
  Selected by [m]:
  - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]

WARNING: unmet direct dependencies detected for USB_CONN_GPIO
  Depends on [n]: USB_SUPPORT [=n] && GPIOLIB [=y]
  Selected by [m]:
  - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]

Fixes: 6835bdc99580 ("phy: tegra: Select USB_PHY")
Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/tegra/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index a208aca4ba7b..4f8c61863411 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA && USB_SUPPORT
 	select USB_CONN_GPIO
 	select USB_PHY
 	help
-- 
2.26.0

