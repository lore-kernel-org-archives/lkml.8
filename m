Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947612074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TPwP9+Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgFINbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:31:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24028 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbgFINbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:31:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709471; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Pu361BIVMutlEnaoObCy2bBsM7kC4Zxpj0q8V0gR8wA=; b=TPwP9+Qo+w8P5tk/FJD7DraoTyjRo28kgedkH0R1aoKOZGr9y+E8TFtXGBjit7HBl6XO0VQE
 N8y1I0VlD0aWqPf28tetRO148ikKfNkVimyDO/kmcobRQEjuGrpJ+Zkyg4xv4GBJ1+xtWDNc
 Gf9r93t+QsbKM9hG48BkjK1cWQU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5edf8f0ebfb34e631c7d52d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:30:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8FA96C433CA; Tue,  9 Jun 2020 13:30:53 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C744DC433C6;
        Tue,  9 Jun 2020 13:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C744DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org, Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sc7180: Add support to skip powering up of ETM
Date:   Tue,  9 Jun 2020 19:00:28 +0530
Message-Id: <8c5ff297d8c89d9d451352f189baf26c8938842a.1591708204.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1591708204.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1591708204.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,skip-power-up" property to skip powering up ETM
on SC7180 SoC to workaround a hardware errata where CPU
watchdog counter is stopped when ETM power up bit is set
(i.e., when TRCPDCR.PU = 1).

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---

Depends on ETM driver change here:
 - https://git.linaro.org/kernel/coresight.git/commit/?h=next-v5.8-rc1&id=159e248e75b1b548276b6571d7740a35cab1f5be 

---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 7c2b79dda3d7..f684a0b87848 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1810,6 +1810,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1829,6 +1830,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1848,6 +1850,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1867,6 +1870,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1886,6 +1890,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1905,6 +1910,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1924,6 +1930,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
@@ -1943,6 +1950,7 @@
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
 
 			out-ports {
 				port {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

