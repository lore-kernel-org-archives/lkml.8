Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33242C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AA820736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmDi33sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgCKTQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:16:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35566 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgCKTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so3401944wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqQ/iZ6acHWZPAsba1wMPoMpaq5MjC2qoVJ8NSKI8L8=;
        b=lmDi33sfyV2lemto8JmDdDcxVVlGb8yGDuHRCaRPUq/zqOKfIjYh902Z2pQMCid9+W
         cFEx3O3r0u3Dx3+jp1YZYEqPAin0p0LZfaZg8UgZME3kk3jyKtyCnVyHsdKvOKys2zdR
         E6cSVcNuGeaQcdqjBgUYGAM83/hrW+1jXvOp9cJYX5dNynb7VyAwTHWp0AFba6wcrPkw
         IzR9ZhGO5yryG7phjjEcUi1N/J0QbdgoxLwDC7tlqTGfZCy7+Zff2FUil5oJhXz/kgqa
         43Vt5ghZJrQJiIZVQAVZN3SukMpx24dTiOoUjMIo47/2Gc0SbGDtlx38kSXIW5q5KegA
         pjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqQ/iZ6acHWZPAsba1wMPoMpaq5MjC2qoVJ8NSKI8L8=;
        b=iakw7knmbw/pdP3+OPe0773baN/sRMTO/pq6FnTEsYiLrcHXDsFf1Q6amgHKPeN3dw
         W4T8PvZPVOxHg1qQSD/Rd932Baf8EZMYwtuT0Uww0IlKErRRG16jiQyC/l8s5N0nkagM
         3iNw3c/sTo39zGfrl/Exsy9cMddGcYo6kMQOVMwU1C01PQEPGEEIDnndbfjFRHCwiiUS
         MI7m+F2EsdvFT6L0xnwxJxhA+AWzxaO9RSmwREdfQcS+/bfItGaPjb1Q7VZTED7DZaZI
         Tvk/uNCa7y9eyrniqMSnLbk0VaXF7PMFFPSGy4gH26ajmE25emfD+1EnP0Ai8IJeXIlS
         MxDw==
X-Gm-Message-State: ANhLgQ0lkDXqBVgtdkRKPDgbzxaacNbd0zz1qWdYh4EUfes9nuIgb3FI
        +6jFn41WFVQfqRK3Qnlp6mjNpw==
X-Google-Smtp-Source: ADFU+vv5yioG/fvOMHKjmJf0DJLZbsaNh8WOn0Q5e9U7tmu4Mgr2zIiaOVjLo3TO7YwNUgDOQ9aTNA==
X-Received: by 2002:a7b:cb12:: with SMTP id u18mr199688wmj.153.1583954095797;
        Wed, 11 Mar 2020 12:14:55 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id n24sm32958496wra.61.2020.03.11.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:14:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 6/7] usb: dwc3: Add support for a role-switch notifier
Date:   Wed, 11 Mar 2020 19:15:00 +0000
Message-Id: <20200311191501.8165-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Role-switching is a 1:1 mapping between a producer and a consumer. For DWC3
we have some vendor specific wrappers, notably the qcom wrapper that want
to toggle some PHY related bits on a USB role switch.

This patch adds a role-switch notifier to the dwc3 drd code. When the USB
role-switch set() routine runs, the notifier will fire passing the notified
mode to the consumer, thus allowing vendor specific fix-ups to toggle from
the role-switching events.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Jack Pham <jackp@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/dwc3/core.h | 19 +++++++++++++++++++
 drivers/usb/dwc3/drd.c  | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a99e57636172..c2e85f587674 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -955,6 +955,7 @@ struct dwc3_scratchpad_array {
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
  * @role_sw: usb_role_switch handle
+ * @role_sw_nl: role switch notifier list
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1089,6 +1090,7 @@ struct dwc3 {
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
 	struct usb_role_switch	*role_sw;
+	struct raw_notifier_head role_sw_nl;
 
 	u32			fladj;
 	u32			irq_gadget;
@@ -1499,4 +1501,21 @@ static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
 { }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+int dwc3_role_switch_notifier_register(struct dwc3 *dwc,
+				       struct notifier_block *nb);
+int dwc3_role_switch_notifier_unregister(struct dwc3 *dwc,
+					 struct notifier_block *nb);
+#else
+static inline int
+dwc3_role_switch_notifier_register(struct dwc3 *dwc,
+				   struct notifier_block *nb)
+{ return 0; }
+
+static inline int
+dwc3_role_switch_notifier_unregister(struct dwc3 *dwc,
+				     struct notifier_block *nb)
+{ return 0; }
+#endif
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 2705871ec95e..789e93dd93b4 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -497,6 +497,8 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role ro
 	}
 
 	dwc3_set_mode(dwc, mode);
+	raw_notifier_call_chain(&dwc->role_sw_nl, mode, NULL);
+
 	return 0;
 }
 
@@ -560,6 +562,18 @@ static int dwc3_register_gpio_usb_connector(struct dwc3 *dwc)
 	return ret;
 }
 
+int dwc3_role_switch_notifier_register(struct dwc3 *dwc,
+				       struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&dwc->role_sw_nl, nb);
+}
+
+int dwc3_role_switch_notifier_unregister(struct dwc3 *dwc,
+					 struct notifier_block *nb)
+{
+	return raw_notifier_chain_unregister(&dwc->role_sw_nl, nb);
+}
+
 #else
 #define ROLE_SWITCH 0
 #define dwc3_setup_role_switch(x) 0
@@ -582,6 +596,9 @@ int dwc3_drd_init(struct dwc3 *dwc)
 		ret = dwc3_register_gpio_usb_connector(dwc);
 		if (ret < 0)
 			return ret;
+
+		RAW_INIT_NOTIFIER_HEAD(&dwc->role_sw_nl);
+
 	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
-- 
2.25.1

