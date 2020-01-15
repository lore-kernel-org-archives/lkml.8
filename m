Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C124C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508582467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqow9njW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgAOONX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:13:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34808 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgAOONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so15912321wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocnZYGpg6yFKKLUpsN1HHuLypXoe9Q32/jf1lCHrlrU=;
        b=pqow9njW0/Q1XGJtL1i64+9mYUWPAqmZv8Bfr9JREIoHHs3coqfVqdKQMeKZavmGOX
         xmlIVgQC65vTYDaLhFUHO4TZJl9Tk/1iF144e8YfYD3B71p473kUDlBrCLCtOIyEySqx
         TXQ2UQ5v33+cj2VnEXQYV2T9Syh0oV9vRaN4o7jOcqeVDWo5ZEWUIzMDOLPWNgxMCC+0
         qJA7OyJ+WMq/PmNwAvrDWKkRqM9b6APULRtLFZDNPPURu0i7pPOFYjG+JXzYbEERHymy
         2RW6RWIIi+PckKMnoJNaI11vOuhC7LE3WbKY5i4vs5HpBG66zARYlWmpL0PT6lHfLWsA
         KjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocnZYGpg6yFKKLUpsN1HHuLypXoe9Q32/jf1lCHrlrU=;
        b=rOwa8m1lpbcGFJfmsU8FnGdESkBR1lwJpJ9VxM1Fr8+7hgrrhOEdbAvJh3NdNcmfkG
         5GQN+onZE9USdLg5sqfSEoxl5w1bHDXmzdqRT9twm1ess01QcRAeBq4aJY0wg0dfFngt
         inMrFPB8bNsy7CK+fq3UxfSH3dEtawlxDtqFvpLL9HASuqY4mQ7Xlx2O0tqmrWcTL1J9
         RU1vGVlecJmAvi0bSVuFPBKSOXQ5pJMm/B2trSV7YPiHf5LTgpesUTZpxcU3dXRBdaly
         4/0tWVwzXlbKu/0Mx5+Q0K+ja7cAD0QhLYV9Zc6l/nCnLdLuV+HrtQ6i6C/ns8vq5Sp8
         65aA==
X-Gm-Message-State: APjAAAUJ/uMtBsYQToDHM5/huco1o5Ez7jN30EEz+t4X2VZr4q+or38k
        /miOvnb/6aXdcXvjZvU0Aan3Ig==
X-Google-Smtp-Source: APXvYqxiks20p1vcbhgJKtiiAPeYy/e3DCfR0VwT0lt4PoEXw/9zoQIkOTjCzZmAcH7P46O/oIgF7Q==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr31524663wrx.153.1579097597704;
        Wed, 15 Jan 2020 06:13:17 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:17 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 09/19] usb: dwc3: qcom: Override VBUS when using gpio_usb_connector
Date:   Wed, 15 Jan 2020 14:13:23 +0000
Message-Id: <20200115141333.1222676-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the gpio_usb_connector driver also means that we are not supplying
VBUS via the SoC but by an external PMIC directly.

This patch searches for a gpio_usb_connector as a child node of the core
DWC3 block and if found switches on the VBUS over-ride, leaving it up to
the role-switching code in gpio-usb-connector to switch off and on VBUS.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 261af9e38ddd..73f9f3bcec59 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -550,6 +550,16 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.ss_phy_irq_index = 2
 };
 
+static bool dwc3_qcom_find_gpio_usb_connector(struct platform_device *pdev)
+{
+	struct device_node	*np = pdev->dev.of_node;
+
+	if (of_get_child_by_name(np, "gpio_usb_connector"))
+		return true;
+
+	return false;
+}
+
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct device_node	*np = pdev->dev.of_node;
@@ -557,7 +567,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
 	int			ret, i;
-	bool			ignore_pipe_clk;
+	bool			ignore_pipe_clk, gpio_usb_conn;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
@@ -649,9 +659,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	}
 
 	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
+	gpio_usb_conn = dwc3_qcom_find_gpio_usb_connector(qcom->dwc3);
 
-	/* enable vbus override for device mode */
-	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
+	/* enable vbus override for device mode or GPIO USB connector mode */
+	if (qcom->mode == USB_DR_MODE_PERIPHERAL || gpio_usb_conn)
 		dwc3_qcom_vbus_overrride_enable(qcom, true);
 
 	/* register extcon to override sw_vbus on Vbus change later */
-- 
2.24.0

