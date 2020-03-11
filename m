Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0305420575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRRcxJMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgCKTPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCKTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so4105555wrf.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9f/RMIcWlgabS9DXbbWR0nDB/AmM5zj7IJkKsoXLIU=;
        b=PRRcxJMXrJh7fbewIVca185JzZpd7vdSgFAU0gqvfH8cMn0pzWO28SI1VHH4IwZlY9
         0FE//oe7MYBljUmcWIktdo5ZWRduy5JQuIbmRNydhSly5iK232PPtQt0QDZhXuRKEu4C
         CEWliCnk3VuuUpdIledRZZ3ovKiLHDms4T2tQ8UR27SsFOMsWU0EEQazP3pPtKxWKj5y
         wmh4AacYJzF9kESt/KvxCS6PFLAoVoieFaOs8GtWoZDSx7jRAODkEoYhz3WSPP8JTtGe
         71swFQcqs1QXEqA0yZwJ8glgBotEWnvgXFESFo4ZEtz/8hEpi829xzbGI8fP+Phhaxlh
         AbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9f/RMIcWlgabS9DXbbWR0nDB/AmM5zj7IJkKsoXLIU=;
        b=SewIzmhq3IZHBDk7BEl2150bXp1AJAeyqWwreq0v7TIUQT3+jaSW7ghCcTI7oxJ+U5
         UX4r5bsHDGN8FqazzW99K3wnrYJmoZVJ2Uk89LaxB5H9XqpkNBJhB5KehkSL6wnUsv9D
         eXUBTvjJNaNtIpQCBDZvqUj2G9tVgcySGFjVhtlYvRIkSzWtLgqhLu+SHYot46UvbcJX
         bzKQzm92e7m++EKK6fHwPVyNaezehrqLI9arrRxUHl6s/q6tiePbxF2I/zZiRunm397d
         /zqtnTQzoW4Qc1ERQHBm0G0ontVYQ0Drlxb6w/oStdVtBErOtzNrmLCVgYC8IQm3HwyB
         JQTg==
X-Gm-Message-State: ANhLgQ2shl9j7+LH5RNV43SqtT7a/JsZhi9tlx36VIs7DmL/2YA6VRnH
        zsHlDZvQ/bC8dbem2PCBpHqyXgDcTD0=
X-Google-Smtp-Source: ADFU+vsNESGH2R0MWraSUxtoXYOPanK+N4SyHx/YW970exsdRbl2fb83FXgcCYN4IisEFn6Ku+ChQA==
X-Received: by 2002:adf:a419:: with SMTP id d25mr6270727wra.210.1583954106153;
        Wed, 11 Mar 2020 12:15:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c85sm9687437wmd.48.2020.03.11.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:15:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Wed, 11 Mar 2020 19:15:14 +0000
Message-Id: <20200311191517.8221-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
References: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
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
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 62ef9c34b04e..cb893ca76901 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -271,6 +271,20 @@ rclk {
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
2.25.1

