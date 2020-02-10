Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E2C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ADE215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoXD7bV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgBJMHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:07:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBJMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so7362449wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcrmvU2z0cLhOQB/+dqbSeV2eKkKIKMdALmO0hbNuLQ=;
        b=EoXD7bV4GxFkQcFQtSLphW649GluB3LGqS/Z8T6EzHT1szUzngcglUJW3YPy5wcAgX
         PX17BluWQkPwYZkzR6AV/2fQ+pk19mSqK5ppynh0Yz5rLcb5adI0qZ3pnmIgQgykEtlS
         QMyiE0/zHiNaFwiGoGbwzVrdfGLh+rXk3Y+cwSIvkWYfRy1yaMr2nE/oMPX4VVuoXQiY
         4cE4K+lzfCrHyEIoHDiMhU6ORyw0PLBhawjiWiLAfmXYfphqV3B70NF8N1L82p689wjS
         8wMxrAtGv6r3gMWbr7twVPnviuzjHtHHKQXbA38IG4YnAtehEPscPrge72/1xy7PAP1A
         hB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcrmvU2z0cLhOQB/+dqbSeV2eKkKIKMdALmO0hbNuLQ=;
        b=VS0hGyVGrqWDyGISlX/SiKLHduzubqd1tT2K3lD4TYaK+JTmuvWfGsXi3qG7FTW25I
         qNpCi+mUaP/ylMxCYA0hy7P8iXRvNcOPpTILNAcBkGvbgI/VWKko1GPULZ7xQOspCN1a
         74H1cTpoOyzLKUzWRJbKCJx3FBov2zv7zuj6IaFCUFxlg4BRu6g6k8ZHyMOjgdPGGC/x
         82i45Em/j2yGu5kUoL89e6NwNlwzJNhrrTJjWTqfjO91l9x3Vm9GiA+LPHNW3HjxYqyG
         3nDCWwsImd25g1AIQ7RmtSGFZJcwuE5YrHU0SZa/mX2ILb4i0zvPNsm5FVDqLIm08tsS
         4n5Q==
X-Gm-Message-State: APjAAAWf4q9Ack6QIJCPrxiz2tA/UyUb0WA9ZfTmDc4x/OSJytQW3XAA
        1F2BBJXS18GCtr8nIc1z1PaGAA==
X-Google-Smtp-Source: APXvYqyAnLU9iQuYutwRESjo2btKREErpllDBdKucxC66zupF1+Ign/ZQLktBXphrrGN3ZXvQX2aWA==
X-Received: by 2002:a5d:4dc5:: with SMTP id f5mr1757026wru.114.1581336451454;
        Mon, 10 Feb 2020 04:07:31 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i204sm293124wma.44.2020.02.10.04.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:07:30 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v6 09/18] usb: dwc3: qcom: Add support for usb-conn-gpio connectors
Date:   Mon, 10 Feb 2020 12:07:14 +0000
Message-Id: <20200210120723.91794-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
References: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
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

