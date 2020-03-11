Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D392C4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECF120736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v90sNn9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgCKRVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37671 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgCKRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id p14so1711008pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WAV7i9DpkYyptymNiUj/uooXSddOTDPzEmF8/rLdzNA=;
        b=v90sNn9X8BRpEKbFTfSlIt7FhpVLPNq1rrz4UZ7BYSmcgkeS70mPrFQdBay6B2aYbc
         Wc24d+bXbldbfKuYcztn/Sxpn/Vorbs7SKjHroXEeGHiW4jgp+7sliYnr9hqgXo+kZxS
         VmoKRdgQRScp0c6BfVlLCYO9+St3c+3uV40jsxs9HETJxMMJYk3nVIo/wAR6L/mcK54c
         1wBFH0MKtHl/7lhS8EhQBry7zOu7W0vX4ImD6kR1Xm0pTBNPnHskBiB4KNgW3NfaeSE5
         LTlrHOKFur2u2ndk8PQWPoCWPC2GJmZlpVdsLOwaRLgHQ0BsWtcjNL9dIYdf1pjMfqd+
         i+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WAV7i9DpkYyptymNiUj/uooXSddOTDPzEmF8/rLdzNA=;
        b=cnaKu7PmG7bNr2i4cTuxietDolS+3pZ0VaTImajLEQXVshbFSGonvjC6379BeOqQrx
         Xq7VrXNAS4RuxcG2AsIQS3Z4s/8DlLcMbb/rFlLz39Bx06RB1ZTOa9k2LlTdC3gmk/EB
         HLpS2jYtP1wnR6aXfFfCdA7lDSYxcH+4Zm6emKe2Xc8iZMY2C1hUf130f+8/zmFgu/My
         8M/a+Ho3vLvbyP/J6x8uK3Tya30zrEJyvcJHlqO+V+/Keaz6j7WD7zIKAGA/YbHPlIJP
         j7W7S4+JzU+WrVUA8e/pu9kW2R8ZmCCno10f+EAWusLJPNvLtDnZJw+JgmMqHzjztimr
         aYgw==
X-Gm-Message-State: ANhLgQ2m5RRWNR7s3vEBKFWH+dmbb63/cPjDZJ3I00mKPuZbmEys/UAd
        lKSWaQsGEBiqNfTJMQoBBXm6AYG9hlI=
X-Google-Smtp-Source: ADFU+vtzBoZFcIDWNjK9MIBKHCBmyqHTO+sxRnhI5ba4B3NJdzaRPyIUlCz+gPylTkgIih79KI+8Yg==
X-Received: by 2002:a63:a06e:: with SMTP id u46mr3790733pgn.140.1583947278772;
        Wed, 11 Mar 2020 10:21:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm14914053pfi.52.2020.03.11.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:21:18 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH v8 1/6] usb: dwc3: Registering a role switch in the DRD code.
Date:   Wed, 11 Mar 2020 17:21:04 +0000
Message-Id: <20200311172109.45134-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311172109.45134-1-john.stultz@linaro.org>
References: <20200311172109.45134-1-john.stultz@linaro.org>
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
---
v2: Fix role_sw and role_switch_default_mode descriptions as
    reported by kbuild test robot <lkp@intel.com>

v3: Split out the role-switch-default-host logic into its own
    patch

v5: Drop selecting CONFIG_USB_ROLE_SWITCH & ifdef dependent code

v6: Fix build issue Reported-by: kbuild test robot <lkp@intel.com>

v7: Minor fix for CONFIG_USB_ROLE_SWITCH=m case not building
    the role switch handling code, reported by
    Guillaume Gardet <Guillaume.Gardet@arm.com>
---
 drivers/usb/dwc3/core.h |  3 ++
 drivers/usb/dwc3/drd.c  | 77 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

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
index c946d64142ad..331c6e997f0c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -476,6 +476,73 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+#define ROLE_SWITCH 1
+static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
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
+static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
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
@@ -484,7 +551,12 @@ int dwc3_drd_init(struct dwc3 *dwc)
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
@@ -531,6 +603,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
+	if (dwc->role_sw)
+		usb_role_switch_unregister(dwc->role_sw);
+
 	if (dwc->edev)
 		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
 					   &dwc->edev_nb);
-- 
2.17.1

