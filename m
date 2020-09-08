Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADDC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F8821D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599549670;
	bh=r7Fv01Z9Ejp9fmpejYk5KV+SaVtmW/EqNzWanMi4jcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMHg+109bCN3B3CYEqZ8taQGvOG6qOBvfgIgDUKBaY++o6LzcrL94+SsErfaI2dpS
	 VzxUl/dnjJJotJLxoBhdm92IKmL3HFMlqJIQVjo+2/G6SHSHHFvAPnYi6TRq74A7bG
	 zrI43Wi2nbMC5Z0sn4xbRi8vrFDytLIU3/2zZPN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgIHHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgIHHVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:21:04 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93305218AC;
        Tue,  8 Sep 2020 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599549663;
        bh=r7Fv01Z9Ejp9fmpejYk5KV+SaVtmW/EqNzWanMi4jcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBdp2s9Shk72T3UZWEmUPBXudBP4lhoDE1f8Ukw8q6vIHnT2WOsuUmX/pTkZHB+bw
         IZxhgiizg5wgFyPFX/3P2DemrPTxJGu1xlGL6j0BLmB+KKZHr7ZvpycTDs8d/Q+K5H
         xxv4XunxbHffp3sZ9e7qvXspvND4dA4N7sz5Qivk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFXw5-00Axvn-4h; Tue, 08 Sep 2020 09:21:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc
Date:   Tue,  8 Sep 2020 09:20:56 +0200
Message-Id: <087af4859a71956dbb744db79ddc0b80c5eb6d6b.1599549364.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599549364.git.mchehab+huawei@kernel.org>
References: <cover.1599549364.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

SPLIT_BOUNDARY_DISABLE should be set for DesignWare USB3 DRD Core
of Hisilicon Kirin Soc when dwc3 core act as host.

[mchehab: dropped a dev_dbg() as only traces are now allowwed on this driver]

Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/dwc3/core.c | 25 +++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..e476e83308bc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -119,6 +119,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
 	int ret;
+	u32 reg;
 
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
@@ -172,6 +173,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			if (dwc->dis_split_quirk) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+				reg |= DWC3_GUCTL3_SPLITDISABLE;
+				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+			}
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1357,6 +1363,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
 
+	dwc->dis_split_quirk = device_property_read_bool(dev,
+				"snps,dis-split-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1866,10 +1875,26 @@ static int dwc3_resume(struct device *dev)
 
 	return 0;
 }
+
+static void dwc3_complete(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	u32		reg;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
+			dwc->dis_split_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_SPLITDISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+}
+#else
+#define dwc3_complete NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	.complete = dwc3_complete,
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 013f42a2b5dc..af5533b09713 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -138,6 +138,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
@@ -380,6 +381,9 @@
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
+/* Global User Control Register 3 */
+#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -1052,6 +1056,7 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @dis_split_quirk: set to disable split boundary.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1245,6 +1250,8 @@ struct dwc3 {
 
 	unsigned		dis_metastability_quirk:1;
 
+	unsigned		dis_split_quirk:1;
+
 	u16			imod_interval;
 };
 
-- 
2.26.2

