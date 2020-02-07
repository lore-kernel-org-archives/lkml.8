Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003D7C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD8B20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWP7RK3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBGURe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50614 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgBGURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:17:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3856590wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=RWP7RK3h6AzOSpxh5XkjjBfKP94Q2tWcVCM7Eo0zAsIH+f05Gyx4k8PpujF3lXJUJa
         tSXs2Xf91emkXQg05rdyKiOgEw9RMST/yqj9zCzI3sHWcouwVDVofKWhk285OD+9iiTI
         nhffaKDxZ5YR5EfiEDBU22RUKxQjR5KFhe8nVrzVQqHkiCZV0UuhewueMta3BkU8+Wb6
         LAQPCTW6aonTWan57LvVLf+PUb2Rm2ta2uaUDC3dAjGgbwmJ6Z0Yis/S5Jo9KYRUNkre
         8RAAW0rrN3BJe40oIgGTiJBpiTCsCJZGwGBefH5kxdEuFfNpvOECSF76LA+WZxxHM2yd
         vGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=QexxLUjpB8JjEvqUP3J7GQ0AZmXyqquR/ofkDIuabDokO3ghukS+YO1/x4ykheejB6
         jubzzLX0K5w7LnrMjkIkBjmYS1sA4Bn0MOoTFX8IzQHUW1h9AKTHoweDzFdXPa0/IIhz
         9HNItWmc2JJOyRVwlxbwvM9iwHkGXKxKMG9ehd55eVjk/+pG+Q3eGNHJI22EDJ9JM40a
         +YWSBRme0G/FH25n/O0IhiXVV9DuiAdEcp+JekcuXJvLJFjbnuffMA9BgWZbKBqL7J77
         DJSzY29+KaggDTqHk4N3HuUikYuQujxLj1gd/6IuXHn5mX0dkRSio8EQ8kjynKu/IY1U
         0bNw==
X-Gm-Message-State: APjAAAVwNniastrQSpbZMFr0AlKyUPrCGXlMQKRHfHAQJPTWxkbZls2f
        edpCfkGgLa62N0lb+8qWaaFqkA==
X-Google-Smtp-Source: APXvYqz/KfvjcJfby9r5wr2ptN9l/Ajghv7BZxCOpp8rYMpBbWqmMuZjAJZGB1wcqtDscS9bYK4z8g==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr5081wmg.163.1581106627340;
        Fri, 07 Feb 2020 12:17:07 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:17:06 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 15/18] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Fri,  7 Feb 2020 20:16:51 +0000
Message-Id: <20200207201654.641525-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB ID pin is used to tell if a system is a Host or a Device. For our
purposes we will bind this pin into gpio-usb-conn later.

For now define the pin with its pinmux.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index b6147b5ab5cb..abfb2a9a37e9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -270,6 +270,20 @@ rclk {
 			bias-pull-down;
 		};
 	};
+
+	usb3_id_pin: usb3-id-pin {
+		pinmux {
+			pins = "gpio116";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio116";
+			drive-strength = <2>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
 };
 
 &pms405_gpios {
-- 
2.25.0

