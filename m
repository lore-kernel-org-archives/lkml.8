Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F8FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC70206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TGm4wEID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgFPOHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:07:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25404 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728646AbgFPOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:07:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GE44Ct030421;
        Tue, 16 Jun 2020 16:07:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ydeF6ETpxTBbmQ0fRC/MIdpYyb6iLv+85u+JaQah+VY=;
 b=TGm4wEIDB1TOPu0P9XHaOA8GGeUzYuSLPYQ51F9KY99rIYo7dt6QA+3Jt9CKP6gQhPUa
 4uUrTluUy1PSOOlKZMEnOdHkzvYVycBX/67travUXltxNxyDGwNLj+nMrr4uRNLYYyHl
 q5dusClXMT/uVhHH4o18oPztl0qEKru7vvZ+nmNTwe6tw40lk4Hscyz1QXg6srfMEcVE
 wjqLnUfWtI7jHV4KDP5KngnoTbX4PTYUzfm85aBcSkfVu3ikIcRub69yCmlxAbQdwYpJ
 ioaD0nYBL1MpL/tjAXx/2KVidiWONVLUl733LQTfD13Vqpixib/LZEml+4OL8AjfVO8p 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mkx97uf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 16:07:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7DAC10002A;
        Tue, 16 Jun 2020 16:07:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A30CA2B56B6;
        Tue, 16 Jun 2020 16:07:28 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 16 Jun 2020 16:07:27
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/3] usb: dwc2: override PHY input signals with usb role switch support
Date:   Tue, 16 Jun 2020 16:07:15 +0200
Message-ID: <20200616140717.28465-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140717.28465-1-amelie.delaunay@st.com>
References: <20200616140717.28465-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for usb role switch to dwc2, by using overriding
control of the PHY voltage valid and ID input signals.

iddig signal (ID) can be overridden:
- when setting GUSBCFG_FORCEHOSTMODE, iddig input pin is overridden with 1;
- when setting GUSBCFG_FORCEDEVMODE, iddig input pin is overridden with 0.

avalid/bvalid/vbusvalid signals can be overridden respectively with:
- GOTGCTL_AVALOEN + GOTGCTL_AVALOVAL
- GOTGCTL_BVALOEN + GOTGCTL_BVALOVAL
- GOTGCTL_VBVALEN + GOTGCTL_VBVALOVAL

It is possible to determine valid sessions thanks to usb role switch:
- if USB_ROLE_NONE then !avalid && !bvalid && !vbusvalid
- if USB_ROLE_DEVICE then !avalid && bvalid && vbusvalid
- if USB_ROLE_HOST then avalid && !bvalid && vbusvalid

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/Kconfig    |   1 +
 drivers/usb/dwc2/Makefile   |   2 +-
 drivers/usb/dwc2/core.h     |   8 ++
 drivers/usb/dwc2/drd.c      | 190 ++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/gadget.c   |   2 +-
 drivers/usb/dwc2/platform.c |  13 +++
 6 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/dwc2/drd.c

diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig
index 16e1aa304edc..dceb8f32414e 100644
--- a/drivers/usb/dwc2/Kconfig
+++ b/drivers/usb/dwc2/Kconfig
@@ -47,6 +47,7 @@ config USB_DWC2_PERIPHERAL
 config USB_DWC2_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on (USB=y && USB_GADGET=y) || (USB_DWC2=m && USB && USB_GADGET)
+	select USB_ROLE_SWITCH
 	help
 	  Select this option if you want the driver to work in a dual-role
 	  mode. In this mode both host and gadget features are enabled, and
diff --git a/drivers/usb/dwc2/Makefile b/drivers/usb/dwc2/Makefile
index 440320cc20a4..2bcd6945df46 100644
--- a/drivers/usb/dwc2/Makefile
+++ b/drivers/usb/dwc2/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_USB_DWC2_DEBUG)	+= -DDEBUG
 ccflags-$(CONFIG_USB_DWC2_VERBOSE)	+= -DVERBOSE_DEBUG
 
 obj-$(CONFIG_USB_DWC2)			+= dwc2.o
-dwc2-y					:= core.o core_intr.o platform.o
+dwc2-y					:= core.o core_intr.o platform.o drd.o
 dwc2-y					+= params.o
 
 ifneq ($(filter y,$(CONFIG_USB_DWC2_HOST) $(CONFIG_USB_DWC2_DUAL_ROLE)),)
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 132d687f1590..9f529e27eaaa 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -860,6 +860,7 @@ struct dwc2_hregs_backup {
  *                      - USB_DR_MODE_PERIPHERAL
  *                      - USB_DR_MODE_HOST
  *                      - USB_DR_MODE_OTG
+ * @role_sw:		usb_role_switch handle
  * @hcd_enabled:	Host mode sub-driver initialization indicator.
  * @gadget_enabled:	Peripheral mode sub-driver initialization indicator.
  * @ll_hw_enabled:	Status of low-level hardware resources.
@@ -1054,6 +1055,7 @@ struct dwc2_hsotg {
 	struct dwc2_core_params params;
 	enum usb_otg_state op_state;
 	enum usb_dr_mode dr_mode;
+	struct usb_role_switch *role_sw;
 	unsigned int hcd_enabled:1;
 	unsigned int gadget_enabled:1;
 	unsigned int ll_hw_enabled:1;
@@ -1376,6 +1378,11 @@ static inline int dwc2_is_device_mode(struct dwc2_hsotg *hsotg)
 	return (dwc2_readl(hsotg, GINTSTS) & GINTSTS_CURMODE_HOST) == 0;
 }
 
+int dwc2_drd_init(struct dwc2_hsotg *hsotg);
+void dwc2_drd_suspend(struct dwc2_hsotg *hsotg);
+void dwc2_drd_resume(struct dwc2_hsotg *hsotg);
+void dwc2_drd_exit(struct dwc2_hsotg *hsotg);
+
 /*
  * Dump core registers and SPRAM
  */
@@ -1392,6 +1399,7 @@ int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2);
 int dwc2_gadget_init(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 				       bool reset);
+void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2);
 int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode);
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
new file mode 100644
index 000000000000..032efffa37ab
--- /dev/null
+++ b/drivers/usb/dwc2/drd.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * drd.c - DesignWare USB2 DRD Controller Dual-role support
+ *
+ * Copyright (C) 2020 STMicroelectronics
+ *
+ * Author(s): Amelie Delaunay <amelie.delaunay@st.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/usb/role.h>
+#include "core.h"
+
+static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 gotgctl;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN | GOTGCTL_VBVALOEN;
+	gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl &= ~(GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+
+	dwc2_force_mode(hsotg, false);
+
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+}
+
+static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
+{
+	u32 gotgctl = dwc2_readl(hsotg, GOTGCTL);
+
+	/* Check if A-Session is already in the right state */
+	if ((valid && (gotgctl & GOTGCTL_ASESVLD)) ||
+	    (!valid && !(gotgctl & GOTGCTL_ASESVLD)))
+		return -EALREADY;
+
+	if (valid)
+		gotgctl |= GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL;
+	else
+		gotgctl &= ~(GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+
+	return 0;
+}
+
+static int dwc2_ovr_bvalid(struct dwc2_hsotg *hsotg, bool valid)
+{
+	u32 gotgctl = dwc2_readl(hsotg, GOTGCTL);
+
+	/* Check if B-Session is already in the right state */
+	if ((valid && (gotgctl & GOTGCTL_BSESVLD)) ||
+	    (!valid && !(gotgctl & GOTGCTL_BSESVLD)))
+		return -EALREADY;
+
+	if (valid)
+		gotgctl |= GOTGCTL_BVALOVAL | GOTGCTL_VBVALOVAL;
+	else
+		gotgctl &= ~(GOTGCTL_BVALOVAL | GOTGCTL_VBVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+
+	return 0;
+}
+
+static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct dwc2_hsotg *hsotg = usb_role_switch_get_drvdata(sw);
+	unsigned long flags;
+
+	/* Skip session not in line with dr_mode */
+	if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
+	    (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
+		return -EINVAL;
+
+	/* Skip session if core is in test mode */
+	if (role == USB_ROLE_NONE && hsotg->test_mode) {
+		dev_dbg(hsotg->dev, "Core is in test mode\n");
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+
+	if (role == USB_ROLE_HOST) {
+		if (dwc2_ovr_avalid(hsotg, true))
+			goto unlock;
+
+		if (hsotg->dr_mode == USB_DR_MODE_OTG)
+			/*
+			 * This will raise a Connector ID Status Change
+			 * Interrupt - connID A
+			 */
+			dwc2_force_mode(hsotg, true);
+	} else if (role == USB_ROLE_DEVICE) {
+		if (dwc2_ovr_bvalid(hsotg, true))
+			goto unlock;
+
+		if (hsotg->dr_mode == USB_DR_MODE_OTG)
+			/*
+			 * This will raise a Connector ID Status Change
+			 * Interrupt - connID B
+			 */
+			dwc2_force_mode(hsotg, false);
+
+		/* This clear DCTL.SFTDISCON bit */
+		dwc2_hsotg_core_connect(hsotg);
+	} else {
+		if (dwc2_is_device_mode(hsotg)) {
+			if (!dwc2_ovr_bvalid(hsotg, false))
+				/* This set DCTL.SFTDISCON bit */
+				dwc2_hsotg_core_disconnect(hsotg);
+		} else {
+			dwc2_ovr_avalid(hsotg, false);
+		}
+	}
+
+unlock:
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	dev_dbg(hsotg->dev, "%s-session valid\n",
+		role == USB_ROLE_NONE ? "No" :
+		role == USB_ROLE_HOST ? "A" : "B");
+
+	return 0;
+}
+
+int dwc2_drd_init(struct dwc2_hsotg *hsotg)
+{
+	struct usb_role_switch_desc role_sw_desc = {0};
+	struct usb_role_switch *role_sw;
+	int ret;
+
+	if (!device_property_read_bool(hsotg->dev, "usb-role-switch"))
+		return 0;
+
+	role_sw_desc.driver_data = hsotg;
+	role_sw_desc.fwnode = dev_fwnode(hsotg->dev);
+	role_sw_desc.set = dwc2_drd_role_sw_set;
+	role_sw_desc.allow_userspace_control = true;
+
+	role_sw = usb_role_switch_register(hsotg->dev, &role_sw_desc);
+	if (IS_ERR(role_sw)) {
+		ret = PTR_ERR(role_sw);
+		dev_err(hsotg->dev,
+			"failed to register role switch: %d\n", ret);
+		return ret;
+	}
+
+	hsotg->role_sw = role_sw;
+
+	/* Enable override and initialize values */
+	dwc2_ovr_init(hsotg);
+
+	return 0;
+}
+
+void dwc2_drd_suspend(struct dwc2_hsotg *hsotg)
+{
+	u32 gintsts, gintmsk;
+
+	if (hsotg->role_sw && !hsotg->params.external_id_pin_ctl) {
+		gintmsk = dwc2_readl(hsotg, GINTMSK);
+		gintmsk &= ~GINTSTS_CONIDSTSCHNG;
+		dwc2_writel(hsotg, gintmsk, GINTMSK);
+		gintsts = dwc2_readl(hsotg, GINTSTS);
+		dwc2_writel(hsotg, gintsts | GINTSTS_CONIDSTSCHNG, GINTSTS);
+	}
+}
+
+void dwc2_drd_resume(struct dwc2_hsotg *hsotg)
+{
+	u32 gintsts, gintmsk;
+
+	if (hsotg->role_sw && !hsotg->params.external_id_pin_ctl) {
+		gintsts = dwc2_readl(hsotg, GINTSTS);
+		dwc2_writel(hsotg, gintsts | GINTSTS_CONIDSTSCHNG, GINTSTS);
+		gintmsk = dwc2_readl(hsotg, GINTMSK);
+		gintmsk |= GINTSTS_CONIDSTSCHNG;
+		dwc2_writel(hsotg, gintmsk, GINTMSK);
+	}
+}
+
+void dwc2_drd_exit(struct dwc2_hsotg *hsotg)
+{
+	if (hsotg->role_sw)
+		usb_role_switch_unregister(hsotg->role_sw);
+}
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 12b98b466287..e7702252d48c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3532,7 +3532,7 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 		dwc2_readl(hsotg, DOEPCTL0));
 }
 
-static void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
+void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
 {
 	/* set the soft-disconnect bit */
 	dwc2_set_bit(hsotg, DCTL, DCTL_SFTDISCON);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index e571c8ae65ec..629a119f04b7 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -317,6 +317,8 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
 
+	dwc2_drd_exit(hsotg);
+
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 
@@ -532,6 +534,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		dwc2_writel(hsotg, ggpio, GGPIO);
 	}
 
+	retval = dwc2_drd_init(hsotg);
+	if (retval) {
+		if (retval != -EPROBE_DEFER)
+			dev_err(hsotg->dev, "failed to initialize dual-role\n");
+		goto error_init;
+	}
+
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
 		retval = dwc2_gadget_init(hsotg);
 		if (retval)
@@ -594,6 +603,8 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
+	dwc2_drd_suspend(dwc2);
+
 	if (dwc2->params.activate_stm_id_vb_detection) {
 		unsigned long flags;
 		u32 ggpio, gotgctl;
@@ -674,6 +685,8 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 	dwc2_force_dr_mode(dwc2);
 
+	dwc2_drd_resume(dwc2);
+
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
 
-- 
2.17.1

