Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4155C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2FE20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2ehGRGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407060AbgFYSN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407029AbgFYSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:13:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC6C08C5C1;
        Thu, 25 Jun 2020 11:13:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so6884965ejd.0;
        Thu, 25 Jun 2020 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaqwY05/r3k7x6kZ9wCj64JmBphdqzDzvJ/AelDNrH0=;
        b=a2ehGRGI6AlMtvlsLGnRsJR3dq4x0ZAyn+2UIQIloRnNPZ67Tg+nFXRIIRkT2VtrWR
         T4Y6Rm/n/KjtbZFYQ+1iGh3lnXiEdJhBPEeopn8z9D5OLg/zBeRP65zFZx8H3NM9J2Ak
         bF7fmgnf9dLdSetSXQPU1WjSEHEhXohRBWtQPOvrDHWVeL/Tc8bD8vqD9535m10Mb/JH
         +vjwwQnatRH+P0AwYybNUwroJUEOkfJCvbCPqKRp8TSFqLbiUnXIPyjbgsEBde8yov0o
         noPee9hbRLjyj8m0N+U/yA23S0ZOUsrFhNNBipiJszq6v7V0b3GyYRcekmUDj9gkRefl
         UoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaqwY05/r3k7x6kZ9wCj64JmBphdqzDzvJ/AelDNrH0=;
        b=BdRZVqfI1/vIuW7TNvpXMJXRnu4izKMUY0N2XFhESVv0TFbx85OY0AwZ9Ud30rmIDJ
         Ys2UtlIm4QKrO+tzIX/kQy+hRJ3BubKdSc4blR+x5e+9SgoCpNRVtrld0cyTLucKEEhD
         vt7E5nTh8af/g5eNq5Njea75Piyg0Or+pjRtLsIFPzUDPJsm9rxy6TeAI3G4K0QGcY2Q
         F+mF8J/bBdPopCrzKMcRsZcL8HA2sqgkAKOA5JM0tPi+StVTtlLwh+K9q7hTTKA58wPZ
         7+Qi30vVnGgTXPXybmySUrBnxGqSryr5aXEU+hmnuLY3Eezue4iMZ7IKnHbIgVZVBXPn
         UWsA==
X-Gm-Message-State: AOAM531y5MG9whLPlpt6EagJYpwwOgKxNq4ypZ5oIKqb2UevXFflzOGP
        CS2E7VYilLa9QX2EAh53bAD77CIyID0=
X-Google-Smtp-Source: ABdhPJwTZxgljQFiscKjkufCd+SPF5kR/74nvJYDnDu7vD4FHB5L24T7FUtTYCnpt/lMjqbUiRu8vA==
X-Received: by 2002:a17:906:5496:: with SMTP id r22mr31993911ejo.449.1593108797147;
        Thu, 25 Jun 2020 11:13:17 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id p4sm19511112edj.64.2020.06.25.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:13:16 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] arm64: dts: qcom: bullhead: Move UART pinctrl to SoC
Date:   Thu, 25 Jun 2020 20:12:52 +0200
Message-Id: <20200625181303.129874-5-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625181303.129874-1-konradybcio@gmail.com>
References: <20200625181303.129874-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pinout is common for every 8992-based device and
should therefore reside in the SoC device tree.

Also convert addresses into phandles.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts      | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
index 4f70681e730d..5969b5cfdc85 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
@@ -23,15 +23,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	soc {
-		serial@f991e000 {
-			status = "okay";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_uart2_default>;
-			pinctrl-1 = <&blsp1_uart2_sleep>;
-		};
-	};
-
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -48,6 +39,10 @@ ramoops@1ff00000 {
 	};
 };
 
+&blsp1_uart2 {
+	status = "okay";
+};
+
 &rpm_requests {
 	pm8994-regulators {
 		compatible = "qcom,rpm-pm8994-regulators";
-- 
2.27.0

