Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714E21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQPZfw+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBGURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgBGURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:17:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so404232wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+UQAz0q2wT+hPhil+AjKDaACIV6FvKW10u3EuBLL/A=;
        b=FQPZfw+6zQI1OF1VYDBSfRcCw85TOhlV72NSHSI4ddw7n72AyPveFo4Zf9Js92ii8u
         o/yCPNDZ6eYd5igGiJFeIUOuihAMJIQlAbgbypo5k/FZxcZPkBl9xa1N0k8yryikqYlr
         tf+zVzCeLJ5zqSwAcgEqZrSydAbVA27r8Mc5Iuu5yYgcqKbN6VS1sWS0cEPHsvd6nQ3r
         +dqeLGnv9yHnT6NbshqtgYpD9NPUKWTBNdFgasvpy+Dpj72QJdTBtmK2VtDG1X/eWcds
         L0x/nbmcdUiTwR4C6Vbheg1SixjXx2zXtkWK1hKleZCDtCHE7Ejs3UoDUom99c+Sw82Q
         Qg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+UQAz0q2wT+hPhil+AjKDaACIV6FvKW10u3EuBLL/A=;
        b=QOrJ+H+BbFhF2iIMmpE1pILgaKTCB7Xh/xKX1GK4ryjMGSmG1SZxNRNKf2HZ42505s
         GfQSiegVo+aHbsDhD5FWlkphLcgaotC7VN8F+lu1TkwqSH64VkAuv3+fhq+EjRhD2XPg
         gAEfclpPZ+TXw2sJig3dBFHRTwqEvsr/liz7bNCuJR3UrEiTxw6CPYwJLslGltutp3Fg
         ME0fv+lUlH7l/szbRoZV5Rrb8opYr9QR2BbVPOzCpvvrfdyrCMAzSEhsQXV1DpX1tb5w
         OygmO5rmd2/4u1lpTFErhDXx56P1o/G1RY7ms62BhtClYciwAkHGMWX1MfSOwj6T8ewX
         akCA==
X-Gm-Message-State: APjAAAXngxV3sv+ovMETjOSSztdq/lFbwpCKuwsGzZYSHFEfKNAvgGCO
        5FmEOmyfVobADmlEZKz2t+a6PQ==
X-Google-Smtp-Source: APXvYqx01kngNPlIGzDq5HBY+vNR8oKZmh52HW4LG+ziZbTBl005+JjagvIK/af0j+GwcuTgXM+rpg==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr705518wru.227.1581106623941;
        Fri, 07 Feb 2020 12:17:03 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:17:03 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 12/18] usb: dwc3: qcom: Enable gpio-usb-conn based role-switching
Date:   Fri,  7 Feb 2020 20:16:48 +0000
Message-Id: <20200207201654.641525-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to receive a notification from the DRD code for
role-switch events in doing so it introduces a disjunction between
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

