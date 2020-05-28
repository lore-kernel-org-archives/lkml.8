Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DA62075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbgE1L3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:29:44 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4394 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbgE1L3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:29:43 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25ecfa089b11-1547a; Thu, 28 May 2020 19:29:13 +0800 (CST)
X-RM-TRANSID: 2ee25ecfa089b11-1547a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45ecfa086616-732fc;
        Thu, 28 May 2020 19:29:13 +0800 (CST)
X-RM-TRANSID: 2ee45ecfa086616-732fc
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        balbi@kernel.org, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: phy: tegra: Remove unnecessary spaces and tables
Date:   Thu, 28 May 2020 19:28:59 +0800
Message-Id: <20200528112859.6160-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros in phy-tegra-usb.c have inconsistent sapces between
the macro name and the value. Thus sets all the macros to have
a signal space between the name and value.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 214 ++++++++++++++++----------------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 6153cc35a..c294dc617 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -30,124 +30,124 @@
 #include <linux/usb/tegra_usb_phy.h>
 #include <linux/usb/ulpi.h>
 
-#define ULPI_VIEWPORT				0x170
+#define ULPI_VIEWPORT	0x170
 
 /* PORTSC PTS/PHCD bits, Tegra20 only */
-#define TEGRA_USB_PORTSC1			0x184
-#define TEGRA_USB_PORTSC1_PTS(x)		(((x) & 0x3) << 30)
-#define TEGRA_USB_PORTSC1_PHCD			BIT(23)
+#define TEGRA_USB_PORTSC1	0x184
+#define TEGRA_USB_PORTSC1_PTS(x)	(((x) & 0x3) << 30)
+#define TEGRA_USB_PORTSC1_PHCD	BIT(23)
 
 /* HOSTPC1 PTS/PHCD bits, Tegra30 and above */
-#define TEGRA_USB_HOSTPC1_DEVLC			0x1b4
-#define TEGRA_USB_HOSTPC1_DEVLC_PTS(x)		(((x) & 0x7) << 29)
-#define TEGRA_USB_HOSTPC1_DEVLC_PHCD		BIT(22)
+#define TEGRA_USB_HOSTPC1_DEVLC	0x1b4
+#define TEGRA_USB_HOSTPC1_DEVLC_PTS(x)	(((x) & 0x7) << 29)
+#define TEGRA_USB_HOSTPC1_DEVLC_PHCD	BIT(22)
 
 /* Bits of PORTSC1, which will get cleared by writing 1 into them */
 #define TEGRA_PORTSC1_RWC_BITS	(PORT_CSC | PORT_PEC | PORT_OCC)
 
-#define USB_SUSP_CTRL				0x400
-#define   USB_WAKE_ON_CNNT_EN_DEV		BIT(3)
-#define   USB_WAKE_ON_DISCON_EN_DEV		BIT(4)
-#define   USB_SUSP_CLR				BIT(5)
-#define   USB_PHY_CLK_VALID			BIT(7)
-#define   UTMIP_RESET				BIT(11)
-#define   UHSIC_RESET				BIT(11)
-#define   UTMIP_PHY_ENABLE			BIT(12)
-#define   ULPI_PHY_ENABLE			BIT(13)
-#define   USB_SUSP_SET				BIT(14)
-#define   USB_WAKEUP_DEBOUNCE_COUNT(x)		(((x) & 0x7) << 16)
-
-#define USB1_LEGACY_CTRL			0x410
-#define   USB1_NO_LEGACY_MODE			BIT(0)
-#define   USB1_VBUS_SENSE_CTL_MASK		(3 << 1)
-#define   USB1_VBUS_SENSE_CTL_VBUS_WAKEUP	(0 << 1)
-#define   USB1_VBUS_SENSE_CTL_AB_SESS_VLD_OR_VBUS_WAKEUP \
+#define USB_SUSP_CTRL	0x400
+#define USB_WAKE_ON_CNNT_EN_DEV	BIT(3)
+#define USB_WAKE_ON_DISCON_EN_DEV	BIT(4)
+#define USB_SUSP_CLR	BIT(5)
+#define USB_PHY_CLK_VALID	BIT(7)
+#define UTMIP_RESET	BIT(11)
+#define UHSIC_RESET	BIT(11)
+#define UTMIP_PHY_ENABLE	BIT(12)
+#define ULPI_PHY_ENABLE	BIT(13)
+#define USB_SUSP_SET	BIT(14)
+#define USB_WAKEUP_DEBOUNCE_COUNT(x)	(((x) & 0x7) << 16)
+
+#define USB1_LEGACY_CTRL	0x410
+#define USB1_NO_LEGACY_MODE	BIT(0)
+#define USB1_VBUS_SENSE_CTL_MASK	(3 << 1)
+#define USB1_VBUS_SENSE_CTL_VBUS_WAKEUP	(0 << 1)
+#define USB1_VBUS_SENSE_CTL_AB_SESS_VLD_OR_VBUS_WAKEUP \
 						(1 << 1)
-#define   USB1_VBUS_SENSE_CTL_AB_SESS_VLD	(2 << 1)
-#define   USB1_VBUS_SENSE_CTL_A_SESS_VLD	(3 << 1)
-
-#define ULPI_TIMING_CTRL_0			0x424
-#define   ULPI_OUTPUT_PINMUX_BYP		BIT(10)
-#define   ULPI_CLKOUT_PINMUX_BYP		BIT(11)
-
-#define ULPI_TIMING_CTRL_1			0x428
-#define   ULPI_DATA_TRIMMER_LOAD		BIT(0)
-#define   ULPI_DATA_TRIMMER_SEL(x)		(((x) & 0x7) << 1)
-#define   ULPI_STPDIRNXT_TRIMMER_LOAD		BIT(16)
-#define   ULPI_STPDIRNXT_TRIMMER_SEL(x)		(((x) & 0x7) << 17)
-#define   ULPI_DIR_TRIMMER_LOAD			BIT(24)
-#define   ULPI_DIR_TRIMMER_SEL(x)		(((x) & 0x7) << 25)
-
-#define UTMIP_PLL_CFG1				0x804
-#define   UTMIP_XTAL_FREQ_COUNT(x)		(((x) & 0xfff) << 0)
-#define   UTMIP_PLLU_ENABLE_DLY_COUNT(x)	(((x) & 0x1f) << 27)
-
-#define UTMIP_XCVR_CFG0				0x808
-#define   UTMIP_XCVR_SETUP(x)			(((x) & 0xf) << 0)
-#define   UTMIP_XCVR_SETUP_MSB(x)		((((x) & 0x70) >> 4) << 22)
-#define   UTMIP_XCVR_LSRSLEW(x)			(((x) & 0x3) << 8)
-#define   UTMIP_XCVR_LSFSLEW(x)			(((x) & 0x3) << 10)
-#define   UTMIP_FORCE_PD_POWERDOWN		BIT(14)
-#define   UTMIP_FORCE_PD2_POWERDOWN		BIT(16)
-#define   UTMIP_FORCE_PDZI_POWERDOWN		BIT(18)
-#define   UTMIP_XCVR_LSBIAS_SEL			BIT(21)
-#define   UTMIP_XCVR_HSSLEW(x)			(((x) & 0x3) << 4)
-#define   UTMIP_XCVR_HSSLEW_MSB(x)		((((x) & 0x1fc) >> 2) << 25)
-
-#define UTMIP_BIAS_CFG0				0x80c
-#define   UTMIP_OTGPD				BIT(11)
-#define   UTMIP_BIASPD				BIT(10)
-#define   UTMIP_HSSQUELCH_LEVEL(x)		(((x) & 0x3) << 0)
-#define   UTMIP_HSDISCON_LEVEL(x)		(((x) & 0x3) << 2)
-#define   UTMIP_HSDISCON_LEVEL_MSB(x)		((((x) & 0x4) >> 2) << 24)
-
-#define UTMIP_HSRX_CFG0				0x810
-#define   UTMIP_ELASTIC_LIMIT(x)		(((x) & 0x1f) << 10)
-#define   UTMIP_IDLE_WAIT(x)			(((x) & 0x1f) << 15)
-
-#define UTMIP_HSRX_CFG1				0x814
-#define   UTMIP_HS_SYNC_START_DLY(x)		(((x) & 0x1f) << 1)
-
-#define UTMIP_TX_CFG0				0x820
-#define   UTMIP_FS_PREABMLE_J			BIT(19)
-#define   UTMIP_HS_DISCON_DISABLE		BIT(8)
-
-#define UTMIP_MISC_CFG0				0x824
-#define   UTMIP_DPDM_OBSERVE			BIT(26)
-#define   UTMIP_DPDM_OBSERVE_SEL(x)		(((x) & 0xf) << 27)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_J		UTMIP_DPDM_OBSERVE_SEL(0xf)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_K		UTMIP_DPDM_OBSERVE_SEL(0xe)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE1		UTMIP_DPDM_OBSERVE_SEL(0xd)
-#define   UTMIP_DPDM_OBSERVE_SEL_FS_SE0		UTMIP_DPDM_OBSERVE_SEL(0xc)
-#define   UTMIP_SUSPEND_EXIT_ON_EDGE		BIT(22)
-
-#define UTMIP_MISC_CFG1				0x828
-#define   UTMIP_PLL_ACTIVE_DLY_COUNT(x)		(((x) & 0x1f) << 18)
-#define   UTMIP_PLLU_STABLE_COUNT(x)		(((x) & 0xfff) << 6)
-
-#define UTMIP_DEBOUNCE_CFG0			0x82c
-#define   UTMIP_BIAS_DEBOUNCE_A(x)		(((x) & 0xffff) << 0)
-
-#define UTMIP_BAT_CHRG_CFG0			0x830
-#define   UTMIP_PD_CHRG				BIT(0)
-
-#define UTMIP_SPARE_CFG0			0x834
-#define   FUSE_SETUP_SEL			BIT(3)
-
-#define UTMIP_XCVR_CFG1				0x838
-#define   UTMIP_FORCE_PDDISC_POWERDOWN		BIT(0)
-#define   UTMIP_FORCE_PDCHRP_POWERDOWN		BIT(2)
-#define   UTMIP_FORCE_PDDR_POWERDOWN		BIT(4)
-#define   UTMIP_XCVR_TERM_RANGE_ADJ(x)		(((x) & 0xf) << 18)
-
-#define UTMIP_BIAS_CFG1				0x83c
-#define   UTMIP_BIAS_PDTRK_COUNT(x)		(((x) & 0x1f) << 3)
+#define USB1_VBUS_SENSE_CTL_AB_SESS_VLD	(2 << 1)
+#define USB1_VBUS_SENSE_CTL_A_SESS_VLD	(3 << 1)
+
+#define ULPI_TIMING_CTRL_0	0x424
+#define ULPI_OUTPUT_PINMUX_BYP	BIT(10)
+#define ULPI_CLKOUT_PINMUX_BYP	BIT(11)
+
+#define ULPI_TIMING_CTRL_1	0x428
+#define ULPI_DATA_TRIMMER_LOAD	BIT(0)
+#define ULPI_DATA_TRIMMER_SEL(x)	(((x) & 0x7) << 1)
+#define ULPI_STPDIRNXT_TRIMMER_LOAD	BIT(16)
+#define ULPI_STPDIRNXT_TRIMMER_SEL(x)	(((x) & 0x7) << 17)
+#define ULPI_DIR_TRIMMER_LOAD	BIT(24)
+#define ULPI_DIR_TRIMMER_SEL(x)	(((x) & 0x7) << 25)
+
+#define UTMIP_PLL_CFG1	0x804
+#define UTMIP_XTAL_FREQ_COUNT(x)	(((x) & 0xfff) << 0)
+#define UTMIP_PLLU_ENABLE_DLY_COUNT(x)	(((x) & 0x1f) << 27)
+
+#define UTMIP_XCVR_CFG0	0x808
+#define UTMIP_XCVR_SETUP(x)	(((x) & 0xf) << 0)
+#define UTMIP_XCVR_SETUP_MSB(x)	((((x) & 0x70) >> 4) << 22)
+#define UTMIP_XCVR_LSRSLEW(x)	(((x) & 0x3) << 8)
+#define UTMIP_XCVR_LSFSLEW(x)	(((x) & 0x3) << 10)
+#define UTMIP_FORCE_PD_POWERDOWN	BIT(14)
+#define UTMIP_FORCE_PD2_POWERDOWN	BIT(16)
+#define UTMIP_FORCE_PDZI_POWERDOWN	BIT(18)
+#define UTMIP_XCVR_LSBIAS_SEL	BIT(21)
+#define UTMIP_XCVR_HSSLEW(x)	(((x) & 0x3) << 4)
+#define UTMIP_XCVR_HSSLEW_MSB(x)	((((x) & 0x1fc) >> 2) << 25)
+
+#define UTMIP_BIAS_CFG0	0x80c
+#define UTMIP_OTGPD	BIT(11)
+#define UTMIP_BIASPD	BIT(10)
+#define UTMIP_HSSQUELCH_LEVEL(x)	(((x) & 0x3) << 0)
+#define UTMIP_HSDISCON_LEVEL(x)	(((x) & 0x3) << 2)
+#define UTMIP_HSDISCON_LEVEL_MSB(x)	((((x) & 0x4) >> 2) << 24)
+
+#define UTMIP_HSRX_CFG0	0x810
+#define UTMIP_ELASTIC_LIMIT(x)	(((x) & 0x1f) << 10)
+#define UTMIP_IDLE_WAIT(x)	(((x) & 0x1f) << 15)
+
+#define UTMIP_HSRX_CFG1	0x814
+#define UTMIP_HS_SYNC_START_DLY(x)	(((x) & 0x1f) << 1)
+
+#define UTMIP_TX_CFG0	0x820
+#define UTMIP_FS_PREABMLE_J	BIT(19)
+#define UTMIP_HS_DISCON_DISABLE	BIT(8)
+
+#define UTMIP_MISC_CFG0	0x824
+#define UTMIP_DPDM_OBSERVE	BIT(26)
+#define UTMIP_DPDM_OBSERVE_SEL(x)	(((x) & 0xf) << 27)
+#define UTMIP_DPDM_OBSERVE_SEL_FS_J	UTMIP_DPDM_OBSERVE_SEL(0xf)
+#define UTMIP_DPDM_OBSERVE_SEL_FS_K	UTMIP_DPDM_OBSERVE_SEL(0xe)
+#define UTMIP_DPDM_OBSERVE_SEL_FS_SE1	UTMIP_DPDM_OBSERVE_SEL(0xd)
+#define UTMIP_DPDM_OBSERVE_SEL_FS_SE0	UTMIP_DPDM_OBSERVE_SEL(0xc)
+#define UTMIP_SUSPEND_EXIT_ON_EDGE	BIT(22)
+
+#define UTMIP_MISC_CFG1	0x828
+#define UTMIP_PLL_ACTIVE_DLY_COUNT(x)	(((x) & 0x1f) << 18)
+#define UTMIP_PLLU_STABLE_COUNT(x)	(((x) & 0xfff) << 6)
+
+#define UTMIP_DEBOUNCE_CFG0	0x82c
+#define UTMIP_BIAS_DEBOUNCE_A(x)	(((x) & 0xffff) << 0)
+
+#define UTMIP_BAT_CHRG_CFG0	0x830
+#define UTMIP_PD_CHRG	BIT(0)
+
+#define UTMIP_SPARE_CFG0	0x834
+#define FUSE_SETUP_SEL	BIT(3)
+
+#define UTMIP_XCVR_CFG1	0x838
+#define UTMIP_FORCE_PDDISC_POWERDOWN	BIT(0)
+#define UTMIP_FORCE_PDCHRP_POWERDOWN	BIT(2)
+#define UTMIP_FORCE_PDDR_POWERDOWN	BIT(4)
+#define UTMIP_XCVR_TERM_RANGE_ADJ(x)	(((x) & 0xf) << 18)
+
+#define UTMIP_BIAS_CFG1	0x83c
+#define UTMIP_BIAS_PDTRK_COUNT(x)	(((x) & 0x1f) << 3)
 
 /* For Tegra30 and above only, the address is different in Tegra20 */
-#define USB_USBMODE				0x1f8
-#define   USB_USBMODE_MASK			(3 << 0)
-#define   USB_USBMODE_HOST			(3 << 0)
-#define   USB_USBMODE_DEVICE			(2 << 0)
+#define USB_USBMODE	0x1f8
+#define USB_USBMODE_MASK	(3 << 0)
+#define USB_USBMODE_HOST	(3 << 0)
+#define USB_USBMODE_DEVICE	(2 << 0)
 
 static DEFINE_SPINLOCK(utmip_pad_lock);
 static unsigned int utmip_pad_count;
-- 
2.20.1.windows.1



