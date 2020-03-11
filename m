Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21CC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D5D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLwUXOrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgCKMfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:35:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56163 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgCKMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:35:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so1893000wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S8YiKSlFY8C2wfSnfYCKEk3w9krt/5PEihft8xMBGs=;
        b=iLwUXOrjXX1JgooKK4C1Ej7aG++N6vBTyANbdSesx4J5LANkA4rttAdfoN3Cl9OWKN
         MK8FbGS80ejPexHaTTEhYRZed+ckS3C6aTIXTWQoEcjAesHoSKfGdtfNIVffBZmNij0t
         +c2hNFirdEnegtp+oJcHVUXtcCiOFQ1TIXBLoKbywdKv2X4tr3zE+Jm0Jr6KfhgZ9Hdn
         FQwJX8RDzIZLP0muodqY9eAC77ehypRz/hCnqognQa2LPPREWDxA1l8jr+KkOTWZORaS
         +0M7U1ItFDSyfQdvkdvSylEi4p8LuqqNHh2RTBb26xVVV85ZQnPO8I3Gec63XEFl93md
         8W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S8YiKSlFY8C2wfSnfYCKEk3w9krt/5PEihft8xMBGs=;
        b=t0pQvSlHhiAJ38Fdeqb5FvgMOxiGp6TDNgOtjHVv/xtrO9PLmHLE05b+2hJl/sy/AE
         M4Znrcg0hfMEtVJUdJpXGKYL7SXOKZl4WNsjkbSHJ5Puje6BPnMhUjkLwZmqiI4g6SHD
         9hFaGKI6QYgwZ7oXXuJr3Y9X90/VxfgW9dyv5pZCKZ7nP41OoEaCquWH86PDJ57xbtUF
         kjA+7ho3uucN2/Nm/I6zywSwTJYUhNhrDB6RNizMEoCg4u0bH7JvSylh0nj0dRPsJnRX
         jRq8YcbnmiaXZvjcoeBlz5eqFXZwp1u+ZeMQloVCcRT8TEnWFKB4Y5ijt0HdbMgW4syy
         EPdQ==
X-Gm-Message-State: ANhLgQ1qfCfKvxcq1EALeHyLQpgvhsOlHmxEiHyJRx8OgaLueis++st1
        zFhdli8jsYj2qpGjbFzgEsIksA==
X-Google-Smtp-Source: ADFU+vtnJUfH6dtY/lJKtuEbOdGr7AEex8lhT/SZQ0KZ7Kab7Njaq1yaVX/R+8xktDk/P5+P/+x86w==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr3670765wml.60.1583930111399;
        Wed, 11 Mar 2020 05:35:11 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:9087:3e80:4ebc:ae7b])
        by smtp.gmail.com with ESMTPSA id m25sm7822732wml.35.2020.03.11.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:35:10 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v1 4/6] arm64: dts: sdm845-db845c: Add pm_8998 gpio names
Date:   Wed, 11 Mar 2020 13:34:59 +0100
Message-Id: <20200311123501.18202-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311123501.18202-1-robert.foss@linaro.org>
References: <20200311123501.18202-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_8998 GPIO trace names. These names are defined in
the 96boards db845c mezzanine schematic.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index a6b6837c3d68..e8c056d02ace 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -584,6 +584,36 @@
 	};
 };
 
+&pm8998_gpio {
+	gpio-line-names =
+		"NC",
+		"NC",
+		"WLAN_SW_CTRL",
+		"NC",
+		"PM_GPIO5_BLUE_BT_LED",
+		"VOL_UP_N",
+		"NC",
+		"ADC_IN1",
+		"PM_GPIO9_YEL_WIFI_LED",
+		"CAM0_AVDD_EN",
+		"NC",
+		"CAM0_DVDD_EN",
+		"PM_GPIO13_GREEN_U4_LED",
+		"DIV_CLK2",
+		"NC",
+		"NC",
+		"NC",
+		"SMB_STAT",
+		"NC",
+		"NC",
+		"ADC_IN2",
+		"OPTION1",
+		"WCSS_PWR_REQ",
+		"PM845_GPIO24",
+		"OPTION2",
+		"PM845_SLB";
+};
+
 &cci {
 	status = "ok";
 };
-- 
2.20.1

