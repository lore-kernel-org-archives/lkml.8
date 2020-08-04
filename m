Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842DC20738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fJNZ+ZMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgHDLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:47:31 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17114 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730309AbgHDLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:47:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596541638; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9fHpmvzcjn/WksFVNHKlyTEU4Iz3HuXFQuXdLVDER64=; b=fJNZ+ZMpjnSQweQiXw4OEWmLg00Y/+HP+aXXcpAJ3sgVaeAdcxGtCcbzIBTmLdp2nr/qAUPn
 DmkcRGUZTHjRbvNctQQ7FwpFgRl9I6iUCow0qLkequVyhzcNytc3BP8meaIq0iyL7cLHYigV
 JBSLn6XfZnyT0qIyimovATUeAW0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f294ac64e5050c6c5d424e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 11:47:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18857C433CB; Tue,  4 Aug 2020 11:47:18 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D72FCC433CA;
        Tue,  4 Aug 2020 11:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D72FCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: sc7180: Add assigned-performance-states for i2c
Date:   Tue,  4 Aug 2020 17:16:56 +0530
Message-Id: <1596541616-27688-4-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 Mhz)
Though qup-i2c does not support DVFS, it still needs to vote for a
performance state on 'cx' to satisfy the 19.2 Mhz clock frequency
requirement.

Use 'assigned-performance-states' to pass this information from
device tree, and also add the power-domains property to specify
the cx power-domain.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index d46b383..f96ca21 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -767,6 +767,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -819,6 +821,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -871,6 +875,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -905,6 +911,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -957,6 +965,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -991,6 +1001,8 @@
 						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1058,6 +1070,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1110,6 +1124,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1144,6 +1160,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1196,6 +1214,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1230,6 +1250,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
@@ -1282,6 +1304,8 @@
 						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7180_CX>;
+				assigned-performance-states = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				status = "disabled";
 			};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

