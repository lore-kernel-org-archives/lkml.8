Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1375FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B920863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrCUZFKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgCCRMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:12:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgCCRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:12:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id a132so4159282wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjQamL43DyX5ZKZxf76rV+ncjDjjqwHBvZnOMO71+5w=;
        b=qrCUZFKTC26uiV3nWZX+HnZvyKjvdogewT44WMI46nlrCqDj0HF5Z1tU/RBRyGnv6e
         XuHz34+k9XTdGzKbGVuyvu1Gv0gj5TXl1pdX7vkHVn2a+Ra2tqf4QIOl+0iOrkZrBRHG
         acyQFA1tjPXzY+rts+qubM6YHC+Ox8un4bDXVkM+8nV/DBKTGTyjqf/iSDJcTrj5kxTk
         wRUs7dCyko+YZnC6K6/DMoXHNSnCmF/YC/k2dn9NydXeOJZwvIGr0SRVhM75Rvccdswr
         sD7oagf/vnF5lB/VcbZ5i5gttuR8v4Q55greTjSJeZobtzEuHFbrDEO39crTqIZkz7ax
         x8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjQamL43DyX5ZKZxf76rV+ncjDjjqwHBvZnOMO71+5w=;
        b=uVNRmyHXHnhtKMxC0cN5AGZn5XD3HiRvlFFnPGuSRHnG8mUv60OQp7SmB662tlFnxR
         W3/KzELMU6fsW9Z0zC3RCzk6MgCq41EkXS/VpXhDpfbcXWuZOnrjXr+c5MW8Hqe3yxJn
         vNC+CkAoVJcR1J8XiIrPGFuls7yAwsYSucbUShbeS475DFYkqIW03khHZXMCsD6euFcA
         xPGztLygWmGCIdlOz57qN4hWdRxeTIZz6KjHwXNyKo/o2C/IM2cyzTWLVs/3psdDnpRP
         N6FhB0DK7IukAV/K00YbPFoLDAar3VjdIKtVjnujQqt9qAalBYDL5uDaRQroZNDVqZw3
         cn9g==
X-Gm-Message-State: ANhLgQ0eSuhL2LP6+PRzieIKUuVAkMKp5/TymDuL9t5YkL6atMZ+tj2p
        +y1CE2SQ78W+OHBa1Jd6hd69rA==
X-Google-Smtp-Source: ADFU+vsjOLSBRTWQQ5+w29BeK4bsLgwDfVpvP7UETnHiuzQw5xkU3zKeMsfaQUmL8yjS8uItlXC1uw==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr5208820wmi.54.1583255527125;
        Tue, 03 Mar 2020 09:12:07 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:12:06 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 12/18] usb: dwc3: qcom: Enable gpio-usb-conn based role-switching
Date:   Tue,  3 Mar 2020 17:11:53 +0000
Message-Id: <20200303171159.246992-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
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
index 6f4b2b3cffce..f6a7ede5953e 100644
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
2.25.1

