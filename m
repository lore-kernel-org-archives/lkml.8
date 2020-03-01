Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B67C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FCA24680
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgqWfHeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCAVUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:20:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgCAVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:20:48 -0500
Received: by mail-pj1-f65.google.com with SMTP id lt1so802659pjb.2;
        Sun, 01 Mar 2020 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6dnU3YCYSZUcdITT9tRm2FU4sfYo2G5AyV3xv+G08o=;
        b=MgqWfHeI0HYwF89+XYqy06+aARmL6UTcW9w64ZmEKNGLgJWHqfPaY2/BjjcxpeSmOg
         drJB2EsgzlbcfszvaC/s77CI5iWgYl4eAZAritTid4/RvPI6EPf57V0I+CC+nGjPaNlH
         fjW3FRuhURZIEjsLXEZOB53t6MYxEkm6vXJYu7cLfmL+Q1XDifYbhVJEXArvmb4R1yWw
         dhQYZ6Al24wX7bxpEz+/YdGgfiRmHkr2xfonMXtUOLJx6yHmkeWr7rslE8ov7T+VxT0K
         R7t8BvLQ/qpdW+w55dkMKSPgxnbZPxHnS8zerjNIFgrYCjSAxQPWkeVG12L8maX2gzJH
         cz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6dnU3YCYSZUcdITT9tRm2FU4sfYo2G5AyV3xv+G08o=;
        b=CX/LZeo9xszEH227P/bgiJRMEYxM0R1ZILgbYcsecsk6dAbRc5tQl/72f5lpyaFM6L
         vzknCtYqaWCjLEjxFDR7P4h7+o/hzTsG0zJx+9yJPPKNy50TvL3n/YyZnAUGQJqL6BI3
         A37NWrGc7s3RYHb6P3VzZBmfio55d+Wufd8fqcFiKtRj0YTd0ieXWpdCjEqM/YSnXoVM
         kqgglV5nOJSddwUuL0qSB+JsVN9gFZjFoI4wsGgCFSdRyqkzlf4wuJOtP0HDQcle9KfL
         3qB5kHS5Z+BrJz+EcPHGynrUKXbM3Gai9JNElZxjGrc6wdgwxqvu01BXHL7uKAqEy9JR
         ONJg==
X-Gm-Message-State: APjAAAX1tCgyQQk1gK/9zwLwrg3keiKkQgNXqIgaAS8mB7Eo7MTKBdcN
        4x65KfAlNCfNiezX1rBsyMe+1RZI
X-Google-Smtp-Source: APXvYqz5y/2XYySv8A042ORhLqlk6CxHi1FMncc8+lWZy0TS48OgPtnqt5PE2f7/b+21BO2umkDcZw==
X-Received: by 2002:a17:90a:928c:: with SMTP id n12mr18093932pjo.45.1583097645413;
        Sun, 01 Mar 2020 13:20:45 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id u19sm4547686pgf.11.2020.03.01.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:20:44 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 3/3] usb: dwc3: exynos: Add support for Exynos5422 suspend clk
Date:   Sun,  1 Mar 2020 21:20:18 +0000
Message-Id: <20200301212019.2248-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200301212019.2248-1-linux.amoon@gmail.com>
References: <20200301212019.2248-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5422 DWC3 module support two clk USBD300 and SCLK_USBD300
so add missing code to enable/disable code and suspend clk, for this
add a new compatible samsung,exynos5420-dwusb3 to help configure
dwc3 code and dwc3 suspend clock. Suspend clock controls the PHY power
change from P0 to P1/P2/P3 during U0 to U1/U2/U3 transition.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Append the Power Managment State control by the suspend clk for USB3.0
---
 drivers/usb/dwc3/dwc3-exynos.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 90bb022737da..48b68b6f0dc8 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -162,6 +162,12 @@ static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
 	.suspend_clk_idx = -1,
 };
 
+static const struct dwc3_exynos_driverdata exynos5420_drvdata = {
+	.clk_names = { "usbdrd30", "usbdrd30_susp_clk"},
+	.num_clks = 2,
+	.suspend_clk_idx = 1,
+};
+
 static const struct dwc3_exynos_driverdata exynos5433_drvdata = {
 	.clk_names = { "aclk", "susp_clk", "pipe_pclk", "phyclk" },
 	.num_clks = 4,
@@ -178,6 +184,9 @@ static const struct of_device_id exynos_dwc3_match[] = {
 	{
 		.compatible = "samsung,exynos5250-dwusb3",
 		.data = &exynos5250_drvdata,
+	}, {
+		.compatible = "samsung,exynos5420-dwusb3",
+		.data = &exynos5420_drvdata,
 	}, {
 		.compatible = "samsung,exynos5433-dwusb3",
 		.data = &exynos5433_drvdata,
-- 
2.25.1

