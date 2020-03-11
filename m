Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DDFC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC66D20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SH69Nrk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgCKTOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:14:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbgCKTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so4078050wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxYn9/eUzH1CvBosREv7RzCwH8ptcn1WAjugUQRbaEY=;
        b=SH69Nrk2bsFHBbhRD6HWiTSONTCE5zrqAGtj8sAptlxQX5FUcJye+xc/EH8dqB7pU7
         kFyAoyONvASEIgRzgy/xWbCYXtvDAQz6v6IX67Rr8J+pJFLrnnO7SzPxwSvoOSU3EWXk
         MjK3tirdnPWGKlK0UZ5f/G0pukMM7wibAgNKoVEOmAo0e9SGcBT2kNYU+DxYhUyojUGf
         tFeI8Eg6d5WDObbVey5HDMmgxXJa/55NYdoXCqhkUzbf0xRw9kEyhgOST2cQLbX8EDgD
         JXTKIObf7Qg7EhzAmDy49HVB65Z7ykbVd8MRpnYDNiHTrwXxUHPt6Ala/qHPvROrlbcd
         Y0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxYn9/eUzH1CvBosREv7RzCwH8ptcn1WAjugUQRbaEY=;
        b=qTTXsrlPmH+irT/wXuvAhTFkC3/DSKhzbIOKAqXfmBwwZ/d6rRnVa+6/m7KwW47ins
         uaOnZu2bbt+XqZFeJK58zQodv6R9FApy0MKr8sNjbANKErunEEKzfISR5iQBMW9BMKUX
         oTN4NUwZMDkYnueKH2n1OtJlsbcq/WaNmDEBiYCBFo/NTJ3Cx46NTx2yoLnwNTQ3k1hU
         SCbGK/z61xAk9tRXFFojZil9XhNlNNobfAP9IhHQ0AWqE/PlniIdqzFzKLEaxlZpb0CV
         TZjzJXrRp8I+998K8uxxUVw1A6yPVlkolAjMW9ollmsnUKBtNyAgjTimELgUudotXFsU
         NOzQ==
X-Gm-Message-State: ANhLgQ2zNy5+CDI9KAH3FhYNH3+vC0Ez16w/Nf7xLWDr/kUIaFk8Vp/N
        gLOXwz7ADTR7oQyFfREj7zjS8Q==
X-Google-Smtp-Source: ADFU+vsvM/qNzy4SCq9g8Pk7GiEVmiI5Ug9pGAzeoV9RL24xC1SbW3WYrpe4/hIh0TnwBzZJKeKpsg==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr5882002wrt.274.1583954089902;
        Wed, 11 Mar 2020 12:14:49 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id n24sm32958496wra.61.2020.03.11.12.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:14:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/7] usb: dwc3: Registering a role switch in the DRD code.
Date:   Wed, 11 Mar 2020 19:14:55 +0000
Message-Id: <20200311191501.8165-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

The Type-C drivers use USB role switch API to inform the
system about the negotiated data role, so registering a role
switch in the DRD code in order to support platforms with
USB Type-C connectors.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/dwc3/core.h |  3 ++
 drivers/usb/dwc3/drd.c  | 78 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 77c4a9abe365..a99e57636172 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -953,6 +954,7 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @role_sw: usb_role_switch handle
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1086,6 +1088,7 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index c946d64142ad..ba0f6cdc4c71 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -476,6 +476,74 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+#define ROLE_SWITCH 1
+static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
+	u32 mode;
+
+	switch (role) {
+	case USB_ROLE_HOST:
+		mode = DWC3_GCTL_PRTCAP_HOST;
+		break;
+	case USB_ROLE_DEVICE:
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	default:
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	}
+
+	dwc3_set_mode(dwc, mode);
+	return 0;
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
+{
+	struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
+	unsigned long flags;
+	enum usb_role role;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		role = USB_ROLE_HOST;
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		role = USB_ROLE_DEVICE;
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		role = dwc->current_otg_role;
+		break;
+	default:
+		role = USB_ROLE_DEVICE;
+		break;
+	}
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return role;
+}
+
+static int dwc3_setup_role_switch(struct dwc3 *dwc)
+{
+	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+
+	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
+	dwc3_role_switch.set = dwc3_usb_role_switch_set;
+	dwc3_role_switch.get = dwc3_usb_role_switch_get;
+	dwc3_role_switch.driver_data = dwc;
+	dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
+	if (IS_ERR(dwc->role_sw))
+		return PTR_ERR(dwc->role_sw);
+
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	return 0;
+}
+#else
+#define ROLE_SWITCH 0
+#define dwc3_setup_role_switch(x) 0
+#endif
+
 int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
@@ -484,7 +552,12 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (dwc->edev) {
+	if (ROLE_SWITCH &&
+	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		ret = dwc3_setup_role_switch(dwc);
+		if (ret < 0)
+			return ret;
+	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -531,6 +604,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
+	if (dwc->role_sw)
+		usb_role_switch_unregister(dwc->role_sw);
+
 	if (dwc->edev)
 		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
 					   &dwc->edev_nb);
-- 
2.25.1

