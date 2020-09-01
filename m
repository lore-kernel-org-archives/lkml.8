Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AE820C56
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ERD9V7gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIAC77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgIAC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0375C06137B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v11so11398137ybm.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VSpQ0YX3bKyUlkQKFI7ZHqKsrWBz5JA4kim0dUzXG7A=;
        b=ERD9V7gyga2yEuFuhqx4bi4TCRgcY15pnqAFbl9BppGXAcR11+fQDrlavIwKmQcPtQ
         3TRDZ0nqLP8ejh53ug2pojdrWA50OJsFcLnkvEP8Pk60v69mr8Gk7q57NDReE49wKb75
         nJakp6+I+NT1S6b4k8PhaaRX7Omvp8kPmWI5i1A2whMbAXd/8iPFC4HnHIeLLm2pi8Lg
         RgipkOxs1eV1IRPPgNY0BJG+cTQ/b++QzVDmybQrM2D+yFhxqXhr524DJxne7UkqgYg+
         fBVuFf8h2HNg3fHplilbHrmlSP7KcHC6pM0dqHvS91vOYeUaBHWbkmZ/pA15oHWl9Rh/
         4R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VSpQ0YX3bKyUlkQKFI7ZHqKsrWBz5JA4kim0dUzXG7A=;
        b=OC3OrxkPgG8ikNqidOyBrcDgxAIpbhRN/ppxGMGpKfuP6PFJMXhx7drrs1yanGRMk7
         UvR04xFs7TSGm1Nge1Iz0nP1j91+fqvoP5zcrLbGXV6RtjN0DsJ6k+/PYV5TVNGy45uw
         oQlNGcCko+/rLxEPEtGviwZnLfkACElaBvYrW67bw2EiZwee1b93IAxDSs5G4F5tMuPO
         QllFNgAo6VnS/7ZFpCHUGrFrHjVYCrMOWREnA79x/YDURrHSyNOII4sOShUhse70+UiH
         JvgURK/idQ2s0YqISagG6QolNojia20lO2hvtH674uaLH30uhHGXGHcaPNl+q5/GTQdH
         zkNw==
X-Gm-Message-State: AOAM532iVkxUG95vNV/YcOQ5W0328buuMWUTZ2y0zArS0KJzQ1PNQaXy
        pQeqJJBXunejQ7l2S8imo38ZvZvlPDY=
X-Google-Smtp-Source: ABdhPJwRQjxnSR1b09vQ3Gct5a9ZNZF9H0pSfv0XwIehdlhkRXi9tdNLg53YBRo73FJHXY8wodTAXJug3qk=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:f20c:: with SMTP id i12mr6913334ybe.406.1598929191912;
 Mon, 31 Aug 2020 19:59:51 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:24 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-12-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 11/14] usb: typec: tcpci_maxim: Add support for Sink FRS
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon receiving ALERT_EXTENDED.TCPC_SINK_FAST_ROLE_SWAP signal
tcpm to start Sink fast role swap signal.

Inform when TCPM is sourcing vbus.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 50 +++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index b61f290a8f96..6ba808ad901a 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -106,13 +106,22 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 	}
 
+	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, 0xff);
+	if (ret < 0) {
+		dev_err(chip->dev, "Unable to clear TCPC_ALERT_EXTENDED ret:%d\n", ret);
+		return;
+	}
+
 	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
 		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
-		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS;
+		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
+		/* Enable Extended alert for detecting Fast Role Swap Signal */
+		TCPC_ALERT_EXTND;
 
 	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
 	if (ret < 0) {
-		dev_err(chip->dev, "Error writing to TCPC_ALERT_MASK ret:%d\n", ret);
+		dev_err(chip->dev,
+			"Error enabling TCPC_ALERT: TCPC_ALERT_MASK write failed ret:%d\n", ret);
 		return;
 	}
 
@@ -122,6 +131,10 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		dev_err(chip->dev, "Error writing to TCPC_POWER_CTRL ret:%d\n", ret);
 		return;
 	}
+
+	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED_MASK, TCPC_SINK_FAST_ROLE_SWAP);
+	if (ret < 0)
+		return;
 }
 
 static void process_rx(struct max_tcpci_chip *chip, u16 status)
@@ -225,10 +238,23 @@ static void process_power_status(struct max_tcpci_chip *chip)
 	if (ret < 0)
 		return;
 
-	if (pwr_status == 0xff)
+	if (pwr_status == 0xff) {
 		max_tcpci_init_regs(chip);
-	else
+	} else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS) {
+		tcpm_sourcing_vbus(chip->port);
+		/*
+		 * Alawys re-enable boost here.
+		 * In normal case, when say an headset is attached, TCPM would
+		 * have instructed to TCPC to enable boost, so the call is a
+		 * no-op.
+		 * But for Fast Role Swap case, Boost turns on autonomously without
+		 * AP intervention, but, needs AP to enable source mode explicitly
+		 * for AP to regain control.
+		 */
+		max_tcpci_set_vbus(chip->tcpci, &chip->data, true, false);
+	} else {
 		tcpm_vbus_change(chip->port);
+	}
 }
 
 static void process_tx(struct max_tcpci_chip *chip, u16 status)
@@ -249,6 +275,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 {
 	u16 mask;
 	int ret;
+	u8 reg_status;
 
 	/*
 	 * Clear alert status for everything except RX_STATUS, which shouldn't
@@ -274,6 +301,21 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		}
 	}
 
+	if (status & TCPC_ALERT_EXTND) {
+		ret = max_tcpci_read8(chip, TCPC_ALERT_EXTENDED, &reg_status);
+		if (ret < 0)
+			return ret;
+
+		ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, reg_status);
+		if (ret < 0)
+			return ret;
+
+		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
+			dev_info(chip->dev, "FRS Signal");
+			tcpm_sink_frs(chip->port);
+		}
+	}
+
 	if (status & TCPC_ALERT_RX_STATUS)
 		process_rx(chip, status);
 
-- 
2.28.0.402.g5ffc5be6b7-goog

