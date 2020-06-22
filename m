Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19207C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE99920768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ka+uBa7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgFVTTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFVTTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:19:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573FC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:39 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so16633502oiy.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2L+Mhvq+/QLJ6s5baaKgwq1IZScyJrE7rnKltkZT9o=;
        b=ka+uBa7FIcJeK8CgO6RXxITT33pGLfZ63eiaUCT7Nb48LV5CAPKvN5tES0V7m2Ecmz
         tFIPsq7/qm3+zM6zY2BHKubnPfchxPMjIZ8UmmXLsNb2MtJjIvSTKuJz84+om6QCP+m5
         AQnYZX0pcDE/QtswD6a7RAsEETvBnHYmoclB2RQObRBY7ASMEXcFESO/CBCdljKCYj09
         WL6KmMjhXz9sIQCHNPwjOjSCbdhC76iXaB3g2yZZMp0G4Vcf5G7NMbxTA8yoLpzedanE
         t66MKlDj2VsqQlmWOtHkHm0/l7mK17lz+oZowaLvAZPgk8eJfXYLN7aZBIs1WDnDiuLe
         Ksug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2L+Mhvq+/QLJ6s5baaKgwq1IZScyJrE7rnKltkZT9o=;
        b=kNHheCsXhHyw+8dEWNO/C+EkEdGsaHAHRS6V/mO9bgz8IpgUfnFLvQ5r51imM92+GC
         4QQW1nn61dyrhemYZSwu6JeIxv6pSdy/ATqpQB5zs3WKKHaYxBW1PpsZEh5m6fYrUIIM
         gft8diPZZRLsrOfQutYFxZyeItQzBKTbs9A1atoCnj4zaApXlsHYxNA/Xzb/4KUAn9gH
         2fa/TfyIG57A+J4hQsx4kByAVqZu4KmgZm/LOwGQesoZ4raAUf32XEndrlppa43d0chm
         fH4ESwTAOsmol8sZ0Pvg1NnqbymXn42dInFLSA9m9ICwfPa9s3rJ9fEKJGft0VdMp/AB
         UIVQ==
X-Gm-Message-State: AOAM532VzwH/XjD7NzAOZ06EVeCL+BsTfRx5cYmGb7g6CHtvtEoPphhq
        4QwWegEpSkHqc0eQNbrUxkDFTw==
X-Google-Smtp-Source: ABdhPJzw6ccz1uU5Uf2ltsXgH7Zq3OgNdP5PuLVjI3xR1MjVSkJBl1b7NNmbs1oJBVW3YapMRvDWvA==
X-Received: by 2002:a05:6808:5d3:: with SMTP id d19mr12948002oij.145.1592853578833;
        Mon, 22 Jun 2020 12:19:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m84sm3348294oif.32.2020.06.22.12.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:19:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 4/5] arm64: dts: qcom: qcs404: Add IMEM and PIL info region
Date:   Mon, 22 Jun 2020 12:19:41 -0700
Message-Id: <20200622191942.255460-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622191942.255460-1-bjorn.andersson@linaro.org>
References: <20200622191942.255460-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on QCS404 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteprocs.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- None

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index c685a1664810..b654b802e95c 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1097,6 +1097,21 @@ blsp2_spi0: spi@7af5000 {
 			status = "disabled";
 		};
 
+		imem@8600000 {
+			compatible = "simple-mfd";
+			reg = <0x08600000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0x08600000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.26.2

