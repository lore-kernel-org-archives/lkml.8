Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9003C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B384D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyJUtXHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBJKve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:51:34 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35356 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:51:31 -0500
Received: by mail-pg1-f173.google.com with SMTP id l24so3729691pgk.2;
        Mon, 10 Feb 2020 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+I5Vz5Y/bf9NOZjHVeJmgKIYJ8e4mYf1dL2DgZM3YDI=;
        b=qyJUtXHVXYAu/sr0GivJeiaRTdRUijQCUOsZTbvzKKsYHr7GhenvmmvTt2RpfD8iph
         AtjDY7jm7YX0y6Dd87t7Z5Vf07JU9wmW2AwnzbM8gF60xDyLNTkU6+d8h4MK7MvAjLvL
         HxYu6lKQtgQjAKXwDCnccqlVqs7JORPT2UtAa7SgO3qnEsSAGr2lu/qR8MsPc5SdAeEB
         QWGIZndqchW8XLtK6vso4OB+1La2W7dDfo6lxoS+G7aEyKjlzrSVmBXtd2RVI5XxDAN6
         jZuk8wB8xQbE6qeYwrpChJ2zYTTmjFO7CBjEbY3xWGeWNpyLU3Ghbk3X1qFA+0965K05
         UhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+I5Vz5Y/bf9NOZjHVeJmgKIYJ8e4mYf1dL2DgZM3YDI=;
        b=mdwE1h9HbjxBr/PxOaFmdIukHsokkF/C9I73u1LmRQu20U2BJiZYAdDLYxGVWCI9Vq
         GZ56qkwp9f0w7sx2rqLeZgz4CuLFnrMQcM5wAuwEhPS6SToREgIeV0mSZHyVuJpn+kIi
         qAHma1nCG8+TiEYHB7D50zC9Axet5KuIWl8RnRvei6LQveZLMbPPepb0sHTH9POx0mPX
         pL7RRLzJBnaqsHdr5LM7yJUWLgDITZvKffym21AXu00ZyatiK77VsxCHwJ0qLEUXn+nF
         2J4bwJbLUCPPAauCYdea9/XH3NnLJr4y4SfI2Y8YXgPqJSw9q5LJc4yjDMW1denK5XvQ
         J6+Q==
X-Gm-Message-State: APjAAAXbdWk60uiYI5lEfFF0yX6vRpE+iUkQDSybyFVjnSGO4iwZfEhp
        k+gS5Vz81RYMNXXUo1ajrTCm4Icn
X-Google-Smtp-Source: APXvYqyTY6TLRP4Dwq+bD55A2fJN5GgbXaRWBorCCV/tnxDI+KNTYZmNEtNXHHH7SqoTqEwC8KZQPw==
X-Received: by 2002:a63:ed01:: with SMTP id d1mr936995pgi.95.1581331890249;
        Mon, 10 Feb 2020 02:51:30 -0800 (PST)
Received: from localhost.localdomain ([45.114.62.33])
        by smtp.gmail.com with ESMTPSA id g18sm12104833pfi.80.2020.02.10.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:51:29 -0800 (PST)
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
Subject: [PATCHv3 3/3] usb: dwc3: exynos: Add support for Exynos5422 suspend clk
Date:   Mon, 10 Feb 2020 10:51:08 +0000
Message-Id: <20200210105108.1128-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210105108.1128-1-linux.amoon@gmail.com>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5422 DWC3 module support two clk USBD300 and SCLK_USBD300
so add missing code to enable/disable code and suspend clk, for this
add a new compatible samsung,exynos5420-dwusb3 to help configure
dwc3 code and dwc3 suspend clk.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
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
2.25.0

