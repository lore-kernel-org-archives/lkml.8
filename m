Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D110C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523720863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQg3gJI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgCCRMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:12:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgCCRMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:12:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so5266185wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI2dvaqnaXgVRLTA8Gq+Dkeh53zWLBjjx0tbj7kwpJA=;
        b=aQg3gJI1L0OyeHLKTM9cGLf83HJrBKqsJtzx1BXU4wgrJty2MKxf3vSfGJsqwu1MLO
         whNWhD1ybEWj498bVAyhTZzft8A5Fg/2wvWnTiGuTGH/+A8jEfENMjpN2zLcV9lAjLLt
         kSlZBKcSWLF5e/v7oD7MFL+jt3VbdIe+InzlHuFYRlOpDaWhACt7gRytDB2456HT5H79
         MuiYWGIx0FaggY4E9oK5TaQ8zAT/Q2dO56NKurhqDY+Qwz2pMMy42ZhMi4LGXDFVgqZW
         zCI45A/nlbt6kYLmSZqfi7QWoS90+f5Lzmxhj6mqKUSDUHnXkDgGYU+ulnI79/KcT1eQ
         hbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI2dvaqnaXgVRLTA8Gq+Dkeh53zWLBjjx0tbj7kwpJA=;
        b=QusFASEOBwqlFzHrMTA/kqWOJ66S3ceobmfiQeTyWloUGOOCbSKbketBUKuJDTYot/
         Sh1RMQHEH04Sj91YYU5TaI2Mu4ndBAK96V/J2N9NpnTrSdFkshptScjvga8BHlG6hh3r
         FoPYbVS4aVwcL2bwdLon7tSFVJegTxapi16rvv/42p9cSxInrhRmu5jd0/gN+WSLoH3W
         N8oH7Rwcenk/5xTh1v0RJZ43SFpjSxyVNtGhqOdi51Pfuwx/0BYrBhE4m9PB34VF01In
         ZJT5rZ8DuprewVrr1CibTBU+kShO+VhPJDgKQwBDvJj8iMI4OyBTfadj8SGfclG4y1ae
         6FKg==
X-Gm-Message-State: ANhLgQ1VzIMu8bu4iI+YuZYneucqwAMomIgr6fTJx9qTW0H8ukwZYq7L
        HtXxIisLHpRMhjfGFWBC2r4jaw==
X-Google-Smtp-Source: ADFU+vuGxDQf00b4sygNxdjaFDvWSaoNzKh1O1Tout/dxDgS/5HWpSM/KcGJx9n9uBksnC+16tFWzg==
X-Received: by 2002:a5d:604c:: with SMTP id j12mr6280581wrt.162.1583255525944;
        Tue, 03 Mar 2020 09:12:05 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:12:05 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 11/18] usb: dwc3: Add support for a role-switch notifier
Date:   Tue,  3 Mar 2020 17:11:52 +0000
Message-Id: <20200303171159.246992-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
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
index 2ec1ae30bcc5..d65b1cc2f4b6 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -497,6 +497,8 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
 	}
 
 	dwc3_set_mode(dwc, mode);
+	raw_notifier_call_chain(&dwc->role_sw_nl, mode, NULL);
+
 	return 0;
 }
 
@@ -559,6 +561,18 @@ static int dwc3_register_gpio_usb_connector(struct dwc3 *dwc)
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
@@ -581,6 +595,9 @@ int dwc3_drd_init(struct dwc3 *dwc)
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

