Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982DC433FC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D29920787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qME/dSWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgGVKdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:33:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31079 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732165AbgGVKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:33:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595413997; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4ZcJZRqgWj+6QIY6hkUHcRQ09IHCpYWQan00993+llo=; b=qME/dSWdU+okB00uZ50ocS6r2CME9SpVcFpa/wUy3REg9X7EJ/T1AHzTwdje8iF1Zjtv5kFD
 uu14y8oh74dYZ9qEl9HNK4j0Nhqc79694dvAGKV9VDZqORRvFrip0Bmtm/TkAkPj63sLQmZd
 XKDUTdTmBNKQCy1+x55JOpgY4Gs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f1815ece3bee1251063c594 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:33:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E898C433AF; Wed, 22 Jul 2020 10:33:15 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F322DC43395;
        Wed, 22 Jul 2020 10:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F322DC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 07/12] dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node
Date:   Wed, 22 Jul 2020 16:01:50 +0530
Message-Id: <1595413915-17867-8-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings to support "qcom,lpass-cpu-sc7180" node.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 55 +++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index 32c2cdb..c21392e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -4,7 +4,8 @@ This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
 
 Required properties:
 
-- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu"
+- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu" or
+			  "qcom,lpass-cpu-sc7180"
 - clocks		: Must contain an entry for each entry in clock-names.
 - clock-names		: A list which must include the following entries:
 				* "ahbix-clk"
@@ -18,6 +19,13 @@ Required properties:
 				* "mi2s-bit-clk3"
 				* "pcnoc-mport-clk"
 				* "pcnoc-sway-clk"
+			: required clocks for "qcom,lpass-cpu-sc7180"
+				* "audio-core"
+				* "mclk0"
+				* "mi2s-bit-clk0"
+				* "mi2s-bit-clk1"
+				* "pcnoc-sway-clk"
+				* "pcnoc-mport-clk"
 
 - interrupts		: Must contain an entry for each entry in
 			  interrupt-names.
@@ -53,7 +61,8 @@ Required properties for each DAI (represented by a subnode):
 Note that adding a subnode changes the default to "no lines configured",
 so both playback and capture lines should be configured when a subnode is added.
 
-Example:
+Examples:
+1)
 
 lpass@28100000 {
 	compatible = "qcom,lpass-cpu";
@@ -77,3 +86,45 @@ lpass@28100000 {
 		qcom,playback-sd-lines = <0 1>;
 	};
 };
+
+2)
+
+#include <dt-bindings/sound/sc7180-lpass.h>
+
+lpass_cpu: lpass {
+	compatible = "qcom,lpass-cpu-sc7180";
+
+	reg = <0 0x62F00000 0 0x29000>;
+
+	iommus = <&apps_smmu 0x1020 0>;
+
+	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
+	clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_CORE_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
+	clock-names = "pcnoc-sway-clk", "audio-core",
+			"mclk0", "pcnoc-mport-clk",
+			"mi2s-bit-clk0", "mi2s-bit-clk1";
+	interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "lpass-irq-lpaif";
+
+
+	#sound-dai-cells = <1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mi2s-primary@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	mi2s-secondary@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+};
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

