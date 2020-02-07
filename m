Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F455C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287CA214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2LdOhjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgBGURH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgBGURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:17:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so422469wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcrmvU2z0cLhOQB/+dqbSeV2eKkKIKMdALmO0hbNuLQ=;
        b=T2LdOhjguiNRg/68bMXbp6BaK3e3MO8o6e3mhZm7RKTSP2PczK71c/If+fKaxAdI00
         XKxmPsditzk7hOeMTR+ytu1eRcYD2uB/JBkO8PDA2quMWWR9/2oQLVUtW6q44dyES9P3
         /31vFUT6MtaJ9f2Apb2/5Ycb2PT90oz0Ya9OowTS23aOg/Ne03nBiRTOo80wbW/0GW+t
         Dn+tRPpcVrpLM0cZtuhUwM3IEAqFqswiVWKvm+JwfL38DQ13+P0dWExB1ah5xVlXxs3H
         YPc85tAUr1RB+7DFoU7usCdSl5op1JvtAfBVirSRY7YdhCSeGbWOy1OaMujddO5w4lpJ
         9Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcrmvU2z0cLhOQB/+dqbSeV2eKkKIKMdALmO0hbNuLQ=;
        b=L/3jx1lpgxViwkxjN9LRGc1qI6ug0qgxUja2sRCu7mp7f6GqXgqoxMpG9bKtll6XD+
         n7N+pBLDFAqtqN5YJydvB5iEJNsQKXPWCOTHFjqsdL7ys6Yjgg7fPGhEge5/YnlTtLL9
         wA/W/5Zk9nBhW1qKFtm3LKfb9GJxdhpcKyrMwJWf/+DHhWIFipQdPdGI1STXTTPNKCQl
         DZ85dwSteO+Sq3wJLItM2YIz9sCSOljhFXmRtbR0x9XtB5r2E4CkWNOUKYFKI8tfikHE
         eUQmxq5gL8naSzAOYbwMn1xbnKxUd8dOD1QnKFcCkvsC9wk6WtylhRaFHLfRtRBHD1c/
         7FlA==
X-Gm-Message-State: APjAAAWBNS5hWd93ZEuLVHpUcvz1kdVAL9+0Mq+CSFb7NtwWuE9knkbs
        tHhcGmTs87g8woG51vyLTj4Eig==
X-Google-Smtp-Source: APXvYqxeTs+7n17elwjU6ghgTx0W3xzBNhfJaMOfAWYH9vUqTw96hBftX7ro2Adb6P9sxgB6f8hZtQ==
X-Received: by 2002:adf:e610:: with SMTP id p16mr776901wrm.81.1581106620394;
        Fri, 07 Feb 2020 12:17:00 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:16:59 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 09/18] usb: dwc3: qcom: Add support for usb-conn-gpio connectors
Date:   Fri,  7 Feb 2020 20:16:45 +0000
Message-Id: <20200207201654.641525-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a routine to find a usb-conn-gpio in the main DWC3 code.
This will be useful in a subsequent patch where we will reuse the current
extcon VBUS notifier with usb-conn-gpio.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 261af9e38ddd..fc66ca3316ef 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -550,6 +550,21 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.ss_phy_irq_index = 2
 };
 
+static bool dwc3_qcom_find_gpio_usb_connector(struct platform_device *pdev)
+{
+	struct device_node	*np;
+	bool			retval = false;
+
+	np = of_get_child_by_name(pdev->dev.of_node, "connector");
+	if (np) {
+		if (of_device_is_compatible(np, "gpio-usb-b-connector"))
+			retval = true;
+	}
+	of_node_put(np);
+
+	return retval;
+}
+
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct device_node	*np = pdev->dev.of_node;
-- 
2.25.0

