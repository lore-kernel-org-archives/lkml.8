Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D68C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450FD204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="cwvYwi93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgIGKUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgIGKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:19:53 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A0C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:19:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so17505838ejf.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sedeRDWMoezcviADR+g7IKIn4HgyZAL0BcEk2Cj9tZo=;
        b=cwvYwi93Xujue0A27C22FmNrzTQWwpz6kGMpuy/j7b6GdGIeyuXjDFj4uvrkKbdMY1
         wbzjtDiqdlQmXOUvl4vMZNCWJr/AQNzh4Zu796aKup9VgeQiLwEoIessiz3aRLIUwBS1
         9nsjDL1bBTLClspl35thzutNjbZzhMCEMlBqNKATLqC3N432Uvi09vIXMAiBO3sv5rma
         olhEyAbmkK3XBVmDzm5Hg2wHMk5hJpY308RsaAVmF0Q4qZfb+piv6BiawJB8ErACdDaq
         b990X8S6pYUZrMF1qTPyawdpeq8c/otVnBPgB8GanDxRpq73TqLDwyedooU3I0JK4GWL
         fpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sedeRDWMoezcviADR+g7IKIn4HgyZAL0BcEk2Cj9tZo=;
        b=PI4qlvRoKiSGHK0Xq6oZ8G2K+0RY0goeZh9O5WHu/5+EcjFr0SaqcTC40zsozXwc2g
         pJ63ql9oxtukkJ9njixPovn6fpMGYjaOs4M63+tsm/3WR9d7p4Qnkwe7+zYrQ8V8+fIQ
         K50EmAmD8BZ9aV3eh4tjYNPmlLmDb7npQXaw98J5TOCeKo1kVMJuA1X2WiCe+HFtZYGO
         9CLkrqms4+R9Z+5oMPWdHFzrM9/GY3/7w2pfazG5W+dE5m1lYWnQaRdmoNXs0DoRDhuC
         KELi/HZ2mr4bAwj3OVjBMZzYtgHyEdDM8f9SJFDV7TskTbGfSyVRdxvFWxD56TWMx6Bk
         Zlrg==
X-Gm-Message-State: AOAM532VsyBkJo+7gkVxLaWZxE5bpm1XIS+4vubigZN/zfshS189RPa1
        fwYzoYDef2Bp9vI4O7jXFPlsog==
X-Google-Smtp-Source: ABdhPJwOUdKroG6QpMUeWOaEu37lfkcf9Z+8t4vcgTfcefFW6hh8pBRW9lP+6y7DW71SXqzxffL9hA==
X-Received: by 2002:a17:906:f6c9:: with SMTP id jo9mr20007781ejb.233.1599473991581;
        Mon, 07 Sep 2020 03:19:51 -0700 (PDT)
Received: from localhost.localdomain (dh207-98-39.xnet.hr. [88.207.98.39])
        by smtp.googlemail.com with ESMTPSA id q11sm14423160eds.16.2020.09.07.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:19:50 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] arm: dts: IPQ4019: add SDHCI VQMMC LDO node
Date:   Mon,  7 Sep 2020 12:19:37 +0200
Message-Id: <20200907101937.10155-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have driver for the SDHCI VQMMC LDO needed
for I/0 voltage levels lets introduce the necessary node for it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 6741a1972e55..7774dbd3cec7 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -211,6 +211,16 @@ tlmm: pinctrl@1000000 {
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		vqmmc: regulator@1948000 {
+			compatible = "qcom,vqmmc-ipq4019-regulator";
+			reg = <0x01948000 0x4>;
+			regulator-name = "vqmmc";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+			status = "disabled";
+		};
+
 		sdhci: sdhci@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
-- 
2.26.2

