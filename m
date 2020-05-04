Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A3C206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G708xptw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgEDWnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727982AbgEDWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:43:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F78C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 15:43:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so82709wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eguzFUkYwYoGv/m+tGA5f5qo5AojxZ5F9SIUcjcPN6U=;
        b=G708xptwUNMdoaDhkWTWdkVl70aBxf1k6we+ylWmrZCMEQ116539Bcq9mHU8SFp/vr
         z45AxdioUnE9/Rx5uU6u+hwGiqRyDdivefA9Wa6qVXlVy4Z226Q0iA8iaoN2sIfctX+g
         9zLI0mNdUjV+1TIbXKjvoqMFZPhT2eYOzSVLAc21aZT6okWRRqPCAsjd5Amf8QMEywbL
         HrWh+3xI0GtHFL5xSR+GOVsTPrdV3gJ4b7jSf/T8mQ3uSA/Z9usj2w/yLzoqw2+bIQbN
         XbDHKSkyiRfCnvsDiKit8OZLq2hRyybfHEi1UTjuDPrwfXptw67cxzr89GmSP0XU+wVT
         vQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eguzFUkYwYoGv/m+tGA5f5qo5AojxZ5F9SIUcjcPN6U=;
        b=aWaRW/TYfw0p/KwM4ae3uEqQA0/EZQYcEui7Ln4g3egcFbAwErHkG5DIeW1uyv5sYq
         n81lUoaclrwUs3PrL77yrYpsIPl6ucjBYEtxBi1sxotTMLvumfMYfHN/+wkhMNCSk9Sd
         92RMm6HV+JMtRqEaZuK5Jfc8h0s7ImFxVyavXAsd5up/MCCR0JWqnkGeUQIXyhBSgz7y
         UfGSgXZFaFVxZV6s8ImaFDxeb/nfiYwsd1yP9DYAFjBcRce9KI17wnkPxki72g+Yqgc0
         34gxKKQEwYKI7Eq+w5bjibC8/NPY2DGrwC4zbypu2rX2rdEiSp1iQkk5DlsGlqevvLeV
         485Q==
X-Gm-Message-State: AGi0Pub6NpifHtB5yQPqO5rSP0x/hin9DP3msZ7rrNha7KiCMebb30iu
        0rHgs2EiX1MlVajsolfwC1XqKw==
X-Google-Smtp-Source: APiQypICMTKYBacQ6uREMSUVWz+Vi3PjmMK1sykrqSI26bOeTzB/YVc6M5dzRmrJaGaSLH66XLUX8A==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr16864695wme.89.1588632196295;
        Mon, 04 May 2020 15:43:16 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a13sm13895888wrv.67.2020.05.04.15.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:43:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Peter.Chen@nxp.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jun Li <jun.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 2/2] usb: chipidea: Enable user-space triggered role-switching
Date:   Mon,  4 May 2020 23:43:46 +0100
Message-Id: <20200504224346.613377-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200504224346.613377-1-bryan.odonoghue@linaro.org>
References: <20200504224346.613377-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag provided by the USB role-switch logic allow_userspace_control
allows user-space to trigger a role-switch. Several other USB controller
drivers already enable this feature. Let's switch it on for the chipidea
core now also.

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: Jun Li <jun.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/chipidea/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index ae0bdc036464..5f31fda92292 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -666,6 +666,7 @@ static int ci_usb_role_switch_set(struct usb_role_switch *sw,
 static struct usb_role_switch_desc ci_role_switch = {
 	.set = ci_usb_role_switch_set,
 	.get = ci_usb_role_switch_get,
+	.allow_userspace_control = true,
 };
 
 static int ci_get_platdata(struct device *dev,
-- 
2.25.1

