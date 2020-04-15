Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3C4206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbADryP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634816AbgDOGWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393547AbgDOGWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:22:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80881C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:22:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so885520plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7avCLbe9HAwosQBa6LlVF/qUTGXim4biWBuIF11jNCU=;
        b=lbADryP1UsnJT4+HlIV8WcjjuaMWFzGRcULDWPvuyis2HA6h2gAf8PIDWQ2M7Lc5qL
         E2FsT5EO06c9Rsgfb6b3Ul4bCJOotCGIOnetst2/FbuDcRWm0PeulgY3nJnxNmlETAan
         oGA6BRApANilKEsMzDnOF65f/BhoVhKkzh3IEpoWco2RPUtkKEEZqM5vXtHa1pUnDfIG
         jy0dpd2zKihNeVvwXFEBASQ47bAolWY9CsRhlTWIk7E4EgCrLXIdGwz98dAEOcbvUQzG
         Nxo8EH40SEmDLYb0OjtnC3Kpfzklx7ObUKiUVDEx0I/hqmdhsQiRYb7Tv/k5ZUa1/aXt
         a+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7avCLbe9HAwosQBa6LlVF/qUTGXim4biWBuIF11jNCU=;
        b=mJN+KIhCBqU5NmkdnSPZbP1JOf1zsLAQcO+3FnoGhBfQhOTvp+KKqbjg1/sG2g42mS
         tLPMgcQm3u6ZZzxFXc9mBCj4KyjR97mXhUg9gedcG56jEkEkCvscPvB0Fw1Rc+mL3Ctr
         uSI6176q+BzuYwHDmGEaIKff2PWky2lRtP1Ar1xzlNTJKPvVZaiDzX2n+ghFOi5YmTtb
         nWLhyPfx0Zu0jfNb4heNQZNZ/5KD2iuujkj63PgS3U/kOv1YQ1L/J/nKNUSPeqlxYAzr
         2yHPu4RuRW/5urz7AP0kmYkLv9oFRuU2ZMQvQnLd0kvjclkCtnVittx01cdL6ECNQwC+
         zFGA==
X-Gm-Message-State: AGi0PubFU0vO8+aAvDedL3dR/gYdssjrzt8UK+ok0K13wJQV0NmLC7W9
        IHpqCE3BI69BkVnCb9+1qK0TUg==
X-Google-Smtp-Source: APiQypIdwUPC4FfOrzwT02GzsEBa0duhvaBxGkyGhlCmkXhoVszx2qook34zcRpOUVAOB9HMAAGUBA==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr4330672pjb.147.1586931740009;
        Tue, 14 Apr 2020 23:22:20 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nu13sm14032899pjb.22.2020.04.14.23.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:22:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: Add rpmhpd node
Date:   Tue, 14 Apr 2020 23:21:54 -0700
Message-Id: <20200415062154.741179-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415062154.741179-1-bjorn.andersson@linaro.org>
References: <20200415062154.741179-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a560f2cb40fe..f6ae5f55ca5e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8250.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -441,6 +442,56 @@ rpmhcc: clock-controller {
 				clock-names = "xo";
 				clocks = <&xo_board>;
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sm8250-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
 		};
 
 		tcsr_mutex_regs: syscon@1f40000 {
-- 
2.24.0

