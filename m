Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5983524688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699537;
	bh=CwO59PbTdVKOyDrsOdRLWCsCcz/uskxyshRXPtiz8uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U1wy5hj8yFNGJW9OIeK8LK3B8tQjQw73AdGnMqeZiPdw1l3mQdl+Ida+iZeaw3iAe
	 PFbopOO1GiN/ngV0kH/RygUBmkpaMWdC+yoc36yoit/UBJzsX49OVZr53F9i+6+gLG
	 e7gAQbHuH90rLeYSzxnO39lUFs+LxkIA6Fpr5OgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgAVNZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbgAVNZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:33 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A9424688;
        Wed, 22 Jan 2020 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699531;
        bh=CwO59PbTdVKOyDrsOdRLWCsCcz/uskxyshRXPtiz8uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zD740MO7Qr41c630P2eqhsy0jRGMBjlOSRh6gpnVTNHbcnI8xt5nGIo/OEkDsOChe
         aR/7Ob1ClpvC81XJxxPb4b56Ms2hdLyGSBncy2CYoHU+B+VMcf077o27N6C/qfY1LC
         0MpmlE+XGbWrzly7MExGY7zzwhY7oxI8Bh/SbNRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 5.4 174/222] arm64: dts: qcom: msm8998: Disable coresight by default
Date:   Wed, 22 Jan 2020 10:29:20 +0100
Message-Id: <20200122092846.161440544@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

commit a636f93fcdb4a516e7cba6a365645ee8429602b2 upstream.

Boot failure has been reported on MSM8998 based laptop when
coresight is enabled. This is most likely due to lack of
firmware support for coresight on production device when
compared to debug device like MTP where this issue is not
observed. So disable coresight by default for MSM8998 and
enable it only for MSM8998 MTP.

Reported-and-tested-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Fixes: 783abfa2249a ("arm64: dts: qcom: msm8998: Add Coresight support")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi |   68 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |   51 +++++++++++++++-------
 2 files changed, 102 insertions(+), 17 deletions(-)

--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -27,6 +27,66 @@
 	status = "okay";
 };
 
+&etf {
+	status = "okay";
+};
+
+&etm1 {
+	status = "okay";
+};
+
+&etm2 {
+	status = "okay";
+};
+
+&etm3 {
+	status = "okay";
+};
+
+&etm4 {
+	status = "okay";
+};
+
+&etm5 {
+	status = "okay";
+};
+
+&etm6 {
+	status = "okay";
+};
+
+&etm7 {
+	status = "okay";
+};
+
+&etm8 {
+	status = "okay";
+};
+
+&etr {
+	status = "okay";
+};
+
+&funnel1 {
+	status = "okay";
+};
+
+&funnel2 {
+	status = "okay";
+};
+
+&funnel3 {
+	status = "okay";
+};
+
+&funnel4 {
+	status = "okay";
+};
+
+&funnel5 {
+	status = "okay";
+};
+
 &pm8005_lsid1 {
 	pm8005-regulators {
 		compatible = "qcom,pm8005-regulators";
@@ -51,6 +111,10 @@
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 };
 
+&replicator1 {
+	status = "okay";
+};
+
 &rpm_requests {
 	pm8998-regulators {
 		compatible = "qcom,rpm-pm8998-regulators";
@@ -249,6 +313,10 @@
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
 };
 
+&stm {
+	status = "okay";
+};
+
 &ufshc {
 	vcc-supply = <&vreg_l20a_2p95>;
 	vccq-supply = <&vreg_l26a_1p2>;
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -998,11 +998,12 @@
 			#interrupt-cells = <0x2>;
 		};
 
-		stm@6002000 {
+		stm: stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
 			reg-names = "stm-base", "stm-data-base";
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1016,9 +1017,10 @@
 			};
 		};
 
-		funnel@6041000 {
+		funnel1: funnel@6041000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x06041000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1045,9 +1047,10 @@
 			};
 		};
 
-		funnel@6042000 {
+		funnel2: funnel@6042000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x06042000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1075,9 +1078,10 @@
 			};
 		};
 
-		funnel@6045000 {
+		funnel3: funnel@6045000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x06045000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1113,9 +1117,10 @@
 			};
 		};
 
-		replicator@6046000 {
+		replicator1: replicator@6046000 {
 			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
 			reg = <0x06046000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1137,9 +1142,10 @@
 			};
 		};
 
-		etf@6047000 {
+		etf: etf@6047000 {
 			compatible = "arm,coresight-tmc", "arm,primecell";
 			reg = <0x06047000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1163,9 +1169,10 @@
 			};
 		};
 
-		etr@6048000 {
+		etr: etr@6048000 {
 			compatible = "arm,coresight-tmc", "arm,primecell";
 			reg = <0x06048000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1181,9 +1188,10 @@
 			};
 		};
 
-		etm@7840000 {
+		etm1: etm@7840000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07840000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1200,9 +1208,10 @@
 			};
 		};
 
-		etm@7940000 {
+		etm2: etm@7940000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07940000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1219,9 +1228,10 @@
 			};
 		};
 
-		etm@7a40000 {
+		etm3: etm@7a40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07a40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1238,9 +1248,10 @@
 			};
 		};
 
-		etm@7b40000 {
+		etm4: etm@7b40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07b40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1257,9 +1268,10 @@
 			};
 		};
 
-		funnel@7b60000 { /* APSS Funnel */
+		funnel4: funnel@7b60000 { /* APSS Funnel */
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07b60000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1343,9 +1355,10 @@
 			};
 		};
 
-		funnel@7b70000 {
+		funnel5: funnel@7b70000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x07b70000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1369,9 +1382,10 @@
 			};
 		};
 
-		etm@7c40000 {
+		etm5: etm@7c40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07c40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1385,9 +1399,10 @@
 			};
 		};
 
-		etm@7d40000 {
+		etm6: etm@7d40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07d40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1401,9 +1416,10 @@
 			};
 		};
 
-		etm@7e40000 {
+		etm7: etm@7e40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07e40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
@@ -1417,9 +1433,10 @@
 			};
 		};
 
-		etm@7f40000 {
+		etm8: etm@7f40000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x07f40000 0x1000>;
+			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";


