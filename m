Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9072206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvn7PMqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgEaR2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgEaR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:28:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250BCC061A0E;
        Sun, 31 May 2020 10:28:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so8556035wmd.5;
        Sun, 31 May 2020 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Mfc0JsGNz4abCu6QgeUv5oXG3KGO+T0GNyd7FH0VZ4=;
        b=qvn7PMqiahqjQxmI2dKsWxq7i+MD92yCwVjWd16J42yogrGHE6gz46bfi9k//peuNy
         OXjmAcLqZn9jUfvH2QLRicpSttRev2SdjEembykz5thp1KzYJC7+vV6QbcIq67BSMj6A
         0ZHBToGfIeFzLeURTn0gHF+VEzIzbIjkp1YcKeaRJrllr5GW8JyGl8OSjZNc2XXlnc+1
         +sGVZWCM/60f+zYZoEIEpxmSEPQ98hcVGwthm65DzNj5vKDXywM/D2IXXMxKu5ZeeOPD
         IkXHMd2mjoJ+KcpDhLhnr60wGflz+VvrLSgR+/AbUl4ElCftiIx2RjfN+m3LsQTMvnCl
         DW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Mfc0JsGNz4abCu6QgeUv5oXG3KGO+T0GNyd7FH0VZ4=;
        b=ie+jHuwjD7Zh/ww6wpXMvb94dO7VDenq/BAeLy+e0/4nQjYq2TkPPvZvu/iMZUSPkV
         hwwpLTYDW5msxFdUoLANAkycymbolKoWbWjeidPCDT7SDWxjWvtGT7zB2YrKjbQUzzqk
         8dIyTDHqs5FsRN6zJ9ao0KufsmBxty8LkJup+2eQDvTqL7gSLW9CN0gT/nIqRpKDnnoN
         hMu0zxmtkk4tduaEKHSDV3PTcp90COVYl0WvNfSObkN4ROzpXeqwmjiag0XWD5LjJoJg
         rDppIt5Zc0tEh39UOTGAg5QM7KZCY2+BHtwjjSEIDQ0HAIWi72ubvcUwu8MeIAIrsFzO
         u0RA==
X-Gm-Message-State: AOAM5322g6FHHwTZ1tCCRN0uFRIcMJAPMfwHVEDz53S4q1mUAUNf0yJc
        FvVXkIalxdv/DtR+Nug8bw4=
X-Google-Smtp-Source: ABdhPJxzQrooMB26NeNKlaCRh+yg3KsFKdo8KP6JFwOkiXFxuQ9q0M996BQW3kHxp8F1/XZ4M2/YCQ==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr18164835wmd.49.1590946111878;
        Sun, 31 May 2020 10:28:31 -0700 (PDT)
Received: from localhost.localdomain (abad130.neoplus.adsl.tpnet.pl. [83.6.167.130])
        by smtp.googlemail.com with ESMTPSA id b81sm8922326wmc.5.2020.05.31.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 10:28:31 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] arm64: dts: qcom: Fix msm8992 SDHCI
Date:   Sun, 31 May 2020 19:28:03 +0200
Message-Id: <20200531172804.256335-14-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531172804.256335-1-konradybcio@gmail.com>
References: <20200531172804.256335-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds correct IRQ settings and adds
the non-removable property to the msm8992 sdhci
node.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index e7354826d701..b5bd73205a55 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -302,8 +302,8 @@ sdhci1: mmc@f9824900 {
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
-			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
-					<GIC_SPI 138 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&clock_gcc GCC_SDCC1_APPS_CLK>,
@@ -319,6 +319,7 @@ sdhci1: mmc@f9824900 {
 			regulator-always-on;
 			bus-width = <8>;
 			mmc-hs400-1_8v;
+			non-removable;
 			status = "okay";
 		};
 
-- 
2.26.2

