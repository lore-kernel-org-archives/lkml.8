Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93675C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5AB208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgE0NiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:38:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0NiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:38:02 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MA7b8-1jjwmq2jEY-00BbQ7; Wed, 27 May 2020 15:37:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>, Bin Liu <b-liu@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: fix build failure without I2C
Date:   Wed, 27 May 2020 15:37:34 +0200
Message-Id: <20200527133746.643895-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SLs7EPo0CHZ35dzILzlg3ynC9V36VweHDMcvML7eK6dlMa+8x+D
 78lfpGqShx4bwcPgQzRY4BRaUxMgsnkzdIhbmn/fDMo1RTidXOUkCG14pmNmDaEe4fIBpGJ
 0GJ8YUM4ZQRm2syGd9w5JZ1pq5HZvYj90TMEZZ7NMvp7up0nALLBO8aEaW373HbK2adJgaD
 VwY7gw3Ujyn51ZWneRDLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSqZnahNGa0=:dOXn6UfLrNQ1/OX9KcCM6R
 mLYgB6k3/DBOAoJ3/kb8sNeadHjCWkSphjfPEc/gYpNVF+ynX6vlQnettRFJURxSAbUfr2XKB
 42PyLO8PKojzEJdopGAq0Yk7v2kvjgX8FkOrBaWqQVkmiU4/GWh83b4G7vzjK/EG5anKT9Fu6
 O0CxiOEDnlkVDkvzS15SyEiVFO72qL8AtcmWT6m9vX6mn4Rms2DQQPGGgDU7GWQLDktr5CpM3
 gyNqLA/a0dJSxDMAk0NVEnudS+4CFof4WpvYl9Ld2zRnvWXLON9hkuqbaBpj8C8lBijtdzmgx
 Q10B94mHS2p3lvFNOWDMU65j+HQGo1uaXjAH3szxrRjMao/doegjLsrlFT7KnZdYRFmK86FZr
 yrt+Ljo2q1fO6spmd3yfN29wUz/IFQSY80oRRay6dv6KUyrgqrpvIyID39Tn47Gr9A1a+NpQw
 wDuNAN2muxnSRNp3xHEW0UHCHuGzXMwZqV2o9EUEpL2HflLwo1M8P2klrFEVpm5ff8fFJvl7l
 OKUh174Hcw7ldzB05LsYouOvCBwKQlJk+IqDUh1xQEiahBXboMJTmXo87F8VgHPp+Yv/rJx2n
 4AWvG79F9iPUFFcSVToqMOxlXoW/dtapa7H0c7Q6VLQUZtnSNvoRixzJ8VxeOelQ++IsO1lgl
 Sf14Ruj8XNvKlnNkoE+KJYzDl/UnidsG0EzLLIdABfWYin7dSfNvySogAB+w/ax1ay9x0GDBm
 Tax/9VwUkzdRfdN7R9rIvaPiiQFRFGom/u5coB65uGc8F9aPRqJ8TrN+EAvewk9nFubSfq/xf
 vwI/VuvgdkFB8GMSigXXOE0D3DDD5yVd+1YtEpsDrFsiY5lbeY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two supplies are referenced outside of #ifdef CONFIG_I2C but
defined inside, which breaks the build if that is not built-in:

mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifier 'fixed_supplies_1_8v'
                                     ARRAY_SIZE(fixed_supplies_1_8v), 1800000);
                                                ^
mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifier 'fixed_supplies_1_8v'
mach-davinci/board-dm644x-evm.c:861:21: error: use of undeclared identifier 'fixed_supplies_1_8v'
mach-davinci/board-dm644x-evm.c:860:49: error: use of undeclared identifier 'fixed_supplies_1_8v'
        regulator_register_always_on(0, "fixed-dummy", fixed_supplies_1_8v,

I don't know if the regulators are used anywhere without I2C, but
always registering them seems to be the safe choice here.

On a related note, it might be best to also deal with CONFIG_I2C=m
across the file, unless this is going to be moved to DT and removed
really soon anyway.

Fixes: 5e06d19694a4 ("ARM: davinci: dm644x-evm: Add Fixed regulators needed for tlv320aic33")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 3461d12bbfc0..a5d3708fedf6 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -655,19 +655,6 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 };
 
-/* Fixed regulator support */
-static struct regulator_consumer_supply fixed_supplies_3_3v[] = {
-	/* Baseboard 3.3V: 5V -> TPS54310PWP -> 3.3V */
-	REGULATOR_SUPPLY("AVDD", "1-001b"),
-	REGULATOR_SUPPLY("DRVDD", "1-001b"),
-};
-
-static struct regulator_consumer_supply fixed_supplies_1_8v[] = {
-	/* Baseboard 1.8V: 5V -> TPS54310PWP -> 1.8V */
-	REGULATOR_SUPPLY("IOVDD", "1-001b"),
-	REGULATOR_SUPPLY("DVDD", "1-001b"),
-};
-
 #define DM644X_I2C_SDA_PIN	GPIO_TO_PIN(2, 12)
 #define DM644X_I2C_SCL_PIN	GPIO_TO_PIN(2, 11)
 
@@ -700,6 +687,19 @@ static void __init evm_init_i2c(void)
 }
 #endif
 
+/* Fixed regulator support */
+static struct regulator_consumer_supply fixed_supplies_3_3v[] = {
+	/* Baseboard 3.3V: 5V -> TPS54310PWP -> 3.3V */
+	REGULATOR_SUPPLY("AVDD", "1-001b"),
+	REGULATOR_SUPPLY("DRVDD", "1-001b"),
+};
+
+static struct regulator_consumer_supply fixed_supplies_1_8v[] = {
+	/* Baseboard 1.8V: 5V -> TPS54310PWP -> 1.8V */
+	REGULATOR_SUPPLY("IOVDD", "1-001b"),
+	REGULATOR_SUPPLY("DVDD", "1-001b"),
+};
+
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /* venc standard timings */
-- 
2.26.2

