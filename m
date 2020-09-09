Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9097EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF742087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="S4uiWi7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIIJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:36:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22558 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729940AbgIIJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:35:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0899XgOt010720;
        Wed, 9 Sep 2020 11:35:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=F+RyVrRyuVDcq2uli2XOzKzUDeHhpR/Cq/nJcI1f7p0=;
 b=S4uiWi7zJsapMyc6KQ5OiT5Igyw51a8XIWRi+UX7c02O0ou9hCJ8NDihBSLcVTUqJg4Q
 FqCTEAFjfK1dGkiJuX4wJXRzFOiidfc2qGpO6pIDNvmPkNsUnf5gWm0LtmxHnwhepI7w
 9PUC2xEko1WP6auOJrRpE3GWMwgYuknQrsg5aBaQoq01/8UWUsNfZgic1gZfLQbrH91k
 RE9AESBHHiKa/yKIiCdYWYKg31Rpn6kUKyXPOLCoTZVpUki7oMh6LRUH7CvNpHhs7B76
 SU0axSpa/LgIGKz1w9VlOAwfbAwKNYBtWLiskbaR5a4Xh/FKOnK00NK6ZuTdNju1i6N0 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33byt7vsfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 11:35:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4139A10002A;
        Wed,  9 Sep 2020 11:35:21 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag3node5.st.com [10.75.127.72])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 284E5220AEB;
        Wed,  9 Sep 2020 11:35:21 +0200 (CEST)
Received: from localhost (10.75.127.47) by GPXDAG3NODE5.st.com (10.75.127.72)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep 2020 11:35:20
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
        Amelie Delaunay <amelie.delaunay@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v6 2/3] usb: dwc2: override PHY input signals with usb role switch support
Date:   Wed, 9 Sep 2020 11:35:10 +0200
Message-ID: <20200909093511.4728-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909093511.4728-1-amelie.delaunay@st.com>
References: <20200909093511.4728-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
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

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
Changes in v5:
- Select USB_ROLE_SWITCH if USB_DWC2, and not only if USB_DWC2_DUAL_ROLE:
  drd.c is built whatever DWC2 mode (DUAL, HOST, PERIPHERAL) as it is used also
  to detect attach/detach (so a-valid/b-valid sessions). 
No changes in v5.
Changes in v4:
- Simplify call to dwc2_force_mode in drd.c
- Add error_drd label in probe error path in platform.c
Changes in v3:
- Fix build issue reported by kernel test robot in drd.c
Changes in v2:
- Fix build issue reported by kernel test robot
- Move call to dwc2_force_mode outside spinlock context
- Add dwc2_drd_exit call in probe error path
---
 drivers/usb/dwc2/Kconfig    |   1 +
 drivers/usb/dwc2/Makefile   |   2 +-
 drivers/usb/dwc2/core.h     |   9 ++
 drivers/usb/dwc2/drd.c      | 180 ++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/gadget.c   |   2 +-
 drivers/usb/dwc2/platform.c |  20 +++-
 6 files changed, 210 insertions(+), 4 deletions(-)
 create mode 100644 drivers/usb/dwc2/drd.c

diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig
index 16e1aa304edc..c131719367ec 100644
--- a/drivers/usb/dwc2/Kconfig
+++ b/drivers/usb/dwc2/Kconfig
@@ -5,6 +5,7 @@ config USB_DWC2
 	depends on HAS_DMA
 	depends on USB || USB_GADGET
 	depends on HAS_IOMEM
+	select USB_ROLE_SWITCH
 	help
 	  Say Y here if your system has a Dual Role Hi-Speed USB
 	  controller based on the DesignWare HSOTG IP Core.
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
index 9deff0400a92..7161344c6522 100644
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
@@ -1417,6 +1425,7 @@ static inline int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 						     bool reset) {}
+static inline void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2) {}
 static inline int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg,
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
new file mode 100644
index 000000000000..2d4176f5788e
--- /dev/null
+++ b/drivers/usb/dwc2/drd.c
@@ -0,0 +1,180 @@
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
+	int already = 0;
+
+	/* Skip session not in line with dr_mode */
+	if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
+	    (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
+		return -EINVAL;
+
+#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
+	/* Skip session if core is in test mode */
+	if (role == USB_ROLE_NONE && hsotg->test_mode) {
+		dev_dbg(hsotg->dev, "Core is in test mode\n");
+		return -EBUSY;
+	}
+#endif
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+
+	if (role == USB_ROLE_HOST) {
+		already = dwc2_ovr_avalid(hsotg, true);
+	} else if (role == USB_ROLE_DEVICE) {
+		already = dwc2_ovr_bvalid(hsotg, true);
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
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	if (!already && hsotg->dr_mode == USB_DR_MODE_OTG)
+		/* This will raise a Connector ID Status Change Interrupt */
+		dwc2_force_mode(hsotg, role == USB_ROLE_HOST);
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
index 5b9d23991c99..16c5f976f141 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3530,7 +3530,7 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 		dwc2_readl(hsotg, DOEPCTL0));
 }
 
-static void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
+void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
 {
 	/* set the soft-disconnect bit */
 	dwc2_set_bit(hsotg, DCTL, DCTL_SFTDISCON);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index b28e90e0b685..238004050557 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -314,6 +314,8 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->gadget_enabled)
 		dwc2_hsotg_remove(hsotg);
 
+	dwc2_drd_exit(hsotg);
+
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
 
@@ -533,10 +535,17 @@ static int dwc2_driver_probe(struct platform_device *dev)
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
-			goto error_init;
+			goto error_drd;
 		hsotg->gadget_enabled = 1;
 	}
 
@@ -562,7 +571,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		if (retval) {
 			if (hsotg->gadget_enabled)
 				dwc2_hsotg_remove(hsotg);
-			goto error_init;
+			goto error_drd;
 		}
 		hsotg->hcd_enabled = 1;
 	}
@@ -594,6 +603,9 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	dwc2_debugfs_exit(hsotg);
 	if (hsotg->hcd_enabled)
 		dwc2_hcd_remove(hsotg);
+error_drd:
+	dwc2_drd_exit(hsotg);
+
 error_init:
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
@@ -612,6 +624,8 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
+	dwc2_drd_suspend(dwc2);
+
 	if (dwc2->params.activate_stm_id_vb_detection) {
 		unsigned long flags;
 		u32 ggpio, gotgctl;
@@ -692,6 +706,8 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 	dwc2_force_dr_mode(dwc2);
 
+	dwc2_drd_resume(dwc2);
+
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
 
-- 
2.17.1

