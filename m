Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4475C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6D020578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1el2Upd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgCKTQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:16:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39923 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgCKTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so3393852wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z91zScAZZwulAyvz3u3tr6aLJzcsPLOyuebpL+WCLno=;
        b=r1el2UpdttKCVTo/Phr0FTb83h+6MEFUdXPmm4p8xDLISKy4paWoEmm8CM7JMi90MX
         8LmMTuCQvO7Bq9oSq0GPGpRj7JeM8uxk+4wRo09oNwhWKNpLuVxC/N4EmGzhLposlCVC
         A0OFwe+GJjE7LhizNca0Sia0ncEtfYZGL0ZSZYFOdefk0lZvc6Fx0i6remRMGo2mKeB+
         Kk/SCvJ9V2RAZOPZcpnztzT/rXtQ299Jd3KoUHROGDLGVshjqKEoXcnu/8fI5JOXwt2O
         Vc3DUO2PvWYHTPnkt9tJeOvPu0mbrhaj6WoOC0y+sJ/wULALRa+X/uSC+r6pfBo8MIRU
         SuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z91zScAZZwulAyvz3u3tr6aLJzcsPLOyuebpL+WCLno=;
        b=tpIU7eTCCBAHlY5VZN7A4OpKRcASAr2+7Jf4Hyj/tPbPBrTqjECMHdnLN7mM/r1AJ2
         2ym7eOEaxqmnXDSnOhPkWeoPmr7YPWQWrhCsfxnCeLYJS9QD+VfuP+1ZUliJGtrOhth3
         g3rVVZQf7LN6Rzozvkb+i1fm9dhoZHpYI6CHLSJUenMo0oK227IYxsSEpKxWcH0h5pa3
         mjDDeeXmSrf7rvQKNhK39mZqpF4YdJ1U2Vt8yga/WX+s4OrIy4k4y8SbemoYoodHdFat
         nTQoRZTRWnjuEnbORGTW6eD6VJJMhBsegz4wT7T7NlU8Nau6OyRY+KRFf6E7+bobR94e
         H0ZQ==
X-Gm-Message-State: ANhLgQ069IYLNtvckDE5Y3Yd/6ANMTdGhVMV4uWiTuKjxFpqhlr5ZxAF
        IXSGLbmAxZ3enTYgm+bSXDkcbw==
X-Google-Smtp-Source: ADFU+vvuhvgtiuMVWq5U8ezUlV4NbLmjf0dUAE8V/9qJPXi4TIiZ/VIBKWQAmz5mjTginjpk5wI9ag==
X-Received: by 2002:a1c:2747:: with SMTP id n68mr254288wmn.14.1583954096913;
        Wed, 11 Mar 2020 12:14:56 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id n24sm32958496wra.61.2020.03.11.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:14:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 7/7] usb: dwc3: qcom: Enable gpio-usb-conn based role-switching
Date:   Wed, 11 Mar 2020 19:15:01 +0000
Message-Id: <20200311191501.8165-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
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
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

