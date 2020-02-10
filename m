Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C2020838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSdwBSRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBJMI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:08:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBJMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so10307597wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGT7cuK2WmOqPM+GaMHuk0IBAIiJJMcrNXcAAtNhvDs=;
        b=cSdwBSRMX3Aviq82QTMjScosxXkhdcMKYXoCNznVnwf+pkT9GThDTgnxYeYSzHGkdA
         X5S5i7/xsj8W7RsOvC38JfGnwnYxs833tS/WOzyc0S/7XQVRfRxw+jkCZbhGr2Wgb+9f
         YzS2MIotiyOFzUnmJZCvqU4sPL/nH37ljbksCXL/vgYwNi+8pwIKcuWTbJO6qQ10szJ8
         fGGhKCXq7bAfyTEeE7/BWOvVth6cCBzmZ8H8VBkVubuVmn8Duqo0kTl43iVp8GHCO2oS
         Ri/QbwUB1mM8fLYmZCR9q90hOh0QLYP2gnm0XoZtPOgbiJSHY8Ta++XtTqUlh2kufx/J
         gKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGT7cuK2WmOqPM+GaMHuk0IBAIiJJMcrNXcAAtNhvDs=;
        b=ud8zjb0v8rrcPv/HzbnL+SDV06aE9twu1ue/WC8qYNDVlwmE5eU1JM/p5kFU1RetKq
         YOgeF3PN2GplfCSzcqiTzyX46tAdSXOam/s0/tRQMflWtGHy69AIQ7NBvdmD9tl0WBh1
         7N+43bEstkSlDxsQRRWTD0+plPrPcSabq2WalxTtaypsTjrWGaq01tu56HzOmMnXOfrQ
         TH0zj13gbAhrRRPgF2+8o0G9wKjCoHDzHUI5qxcKuWCbWKMZjDZMcxOLCxddWYiSxDIk
         LfTSJ49MRf8oBIsNdM3a83leiOqsVyY2As/B4p53/SdvGk6rQ3yX+HAEdRUZBtJl5V4K
         UQNA==
X-Gm-Message-State: APjAAAVXB1gJ/FML9s2HDbbo9K9msiM+MtBKi6i1PFe9lsMHf6pTYOwt
        sQdwbO/+o3NRtofNbtZWHBfcPQ==
X-Google-Smtp-Source: APXvYqyv8Db0ftvNxYsY8Fq9tIPM31b2DAu4z/a5J2irS2r7eqCCS0uE20oXnZMMubtd3YEE0oVtdA==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr16089761wmc.189.1581336455638;
        Mon, 10 Feb 2020 04:07:35 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i204sm293124wma.44.2020.02.10.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:07:35 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v6 12/18] usb: dwc3: qcom: Enable gpio-usb-conn based role-switching
Date:   Mon, 10 Feb 2020 12:07:17 +0000
Message-Id: <20200210120723.91794-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
References: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to receive a notification from the DRD code for
role-switch events and in doing so it introduces a disjunction between
gpio-usb-conn or extcon mode.

This is what we want to do, since the two methods are mutually exclusive.

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
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index fc66ca3316ef..48e43dbc88cf 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -571,6 +571,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		*res, *parent_res = NULL;
+	struct dwc3		*dwc;
 	int			ret, i;
 	bool			ignore_pipe_clk;
 
@@ -669,8 +670,16 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
 		dwc3_qcom_vbus_overrride_enable(qcom, true);
 
-	/* register extcon to override sw_vbus on Vbus change later */
-	ret = dwc3_qcom_register_extcon(qcom);
+	if (dwc3_qcom_find_gpio_usb_connector(qcom->dwc3)) {
+		/* Using gpio-usb-conn register a notifier for VBUS */
+		dwc = platform_get_drvdata(qcom->dwc3);
+		qcom->vbus_nb.notifier_call = dwc3_qcom_vbus_notifier;
+		ret = dwc3_role_switch_notifier_register(dwc, &qcom->vbus_nb);
+	} else {
+		/* register extcon to override sw_vbus on Vbus change later */
+		ret = dwc3_qcom_register_extcon(qcom);
+	}
+
 	if (ret)
 		goto depopulate;
 
@@ -702,8 +711,11 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	int i;
 
+	dwc3_role_switch_notifier_unregister(dwc, &qcom->vbus_nb);
+
 	of_platform_depopulate(dev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
-- 
2.25.0

