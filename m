Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFB82078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948501;
	bh=RqUV47Xl7l506UHysYK6LyPd/cA3yhC+6UhX+Vh3Bis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bTmIf1Qb/poOc2qD8RCIBgNNqznqjCyL+pZn8dPga6p+Bh57gvEPRYeKl7Sx3Qw2Z
	 pdLcgPtRpqOlGVyw39LxvCaDk9cfeWtIMlmc3d+VYJzJItm2Ll+dC3KY9iaxLRGjPa
	 D+JXcQwGHwWtSKHBf3NilPDbJyW7LcYFZoKKuuGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbgFWVlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbgFWUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:05:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98D7206C3;
        Tue, 23 Jun 2020 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942749;
        bh=RqUV47Xl7l506UHysYK6LyPd/cA3yhC+6UhX+Vh3Bis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcmhSwvVYQOfMBidyx3anR5wrwJGyDZirLA5ZrBFvuOuuAHhg4dYYd35UTQ9XdRrk
         1XPtxnhj1QnPgcw/XkqeSTvTmjTRxxjZ2vAQHCCD8gstL7W5gsUt6Em8dZmctHIE8P
         Yv3beMCHwxJWO3IAfB7aY16++0UHzVRSv6C7fxcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 120/477] arm64: dts: qcom: msm8916: remove unit name for thermal trip points
Date:   Tue, 23 Jun 2020 21:51:57 +0200
Message-Id: <20200623195413.278405955@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kucheria <amit.kucheria@linaro.org>

[ Upstream commit fe2aff0c574d206f34f1864d5a0b093694c27142 ]

The thermal trip points have unit name but no reg property, so we can
remove them. It also fixes the following warnings from 'make dtbs_check'
after adding the thermal yaml bindings.

arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml: thermal-zones:
gpu-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml: thermal-zones:
camera-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml: thermal-zones:
modem-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'

arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml: thermal-zones:
gpu-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml: thermal-zones:
camera-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml: thermal-zones:
modem-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Link: https://lore.kernel.org/r/2d3d045c18a2fb85b28cf304aa11ae6e6538d75e.1585562459.git.amit.kucheria@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a88a15f2352bc..5548d7b5096ca 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -261,7 +261,7 @@
 			thermal-sensors = <&tsens 4>;
 
 			trips {
-				cpu2_3_alert0: trip-point@0 {
+				cpu2_3_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -291,7 +291,7 @@
 			thermal-sensors = <&tsens 2>;
 
 			trips {
-				gpu_alert0: trip-point@0 {
+				gpu_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -311,7 +311,7 @@
 			thermal-sensors = <&tsens 1>;
 
 			trips {
-				cam_alert0: trip-point@0 {
+				cam_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -326,7 +326,7 @@
 			thermal-sensors = <&tsens 0>;
 
 			trips {
-				modem_alert0: trip-point@0 {
+				modem_alert0: trip-point0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "hot";
-- 
2.25.1



