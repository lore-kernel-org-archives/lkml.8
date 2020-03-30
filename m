Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB9C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdQT2eUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgC3KGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:06:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgC3KGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:06:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so8429621pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6dK8u3Ci4GAi3GN9bbTpnkd43AAe8+AUsOiMI6bvC0=;
        b=xdQT2eUbhp8nx1J7AjCvv22o4zM0gzvLaFXDBW4y0IbTy+Lnae6LoOtlOZqf57NLif
         edtn21Z4YAjWs/sa0hBXOUL7tFKZ6dlUGQiMmIPCpLCAMV74mH4roFX6aQ3OF1GTtl/W
         FSU35yP816QjL+riZKwRlGVYRIzdpT7rYSyBjFvkW+pTwOUJZhoSh6nRB2veEBodUrpC
         XsPshkgaTq4RLKRMLRH9f/eYYKaSfIt5O8PgoUJ0IrLj9CCXchuFyRt1WBkShjK/ROtF
         5Y/IRyDSjWD6HkLhvlghKbnYfu1Ob4LoNh8o6tHp5ZrUwWCZPUqASywzbcVP3OCm3FOx
         kqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6dK8u3Ci4GAi3GN9bbTpnkd43AAe8+AUsOiMI6bvC0=;
        b=hRUPmuuO3vs3QmTl3T2J2TMFJ+NKKOAuueUbWveA22FV4KsDJ5WTQ4ITEy75/oc6Iw
         CnRSlk6hbK0f1OhgfIW47B1/20JHucRarCu+71iXef8S9eJ6bwplUlmXJSuUcPzxcaxn
         UNz2rkCcQoZKISrkwphQqcUyCZIU5TcTsI47mGIcu8U4ixzLsOV54c1QIha3R8qmHpdT
         92ZtrcW5d+5NlHTDIsHhpmMwYDBs8bDAivrm2NyFCx5LHPyE09dASYTYDPWvcsOngcKs
         PMTPanxFMlqO0/G08Z0vc4nAv+t61SL5IT6pvkRmRjx2lYNxRvY1R6NDnSVBTgR9OlFF
         3lrg==
X-Gm-Message-State: ANhLgQ2PvqIfXN68ZXgppvmGqY4Y2ZfJl8c1MvGfnab22GBS80OWO0Vd
        v+agM45eN5oldPLrltLM/Dl10dGmzc4=
X-Google-Smtp-Source: ADFU+vuMoHlC0K6zlDDwzmFApzIt9SLuUtIszxnCcvUCq73POzavk4G9bGjvH1/otBDwF8tWpkk2zA==
X-Received: by 2002:a62:1648:: with SMTP id 69mr12626213pfw.14.1585562801335;
        Mon, 30 Mar 2020 03:06:41 -0700 (PDT)
Received: from localhost ([103.195.202.48])
        by smtp.gmail.com with ESMTPSA id f15sm9931948pfq.100.2020.03.30.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 03:06:40 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996: remove unit name for thermal trip points
Date:   Mon, 30 Mar 2020 15:36:27 +0530
Message-Id: <2c0aa5357c96c3caff8554f9ef3ab9c5a2b8d2f8.1585562459.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585562459.git.amit.kucheria@linaro.org>
References: <cover.1585562459.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal trip points have unit name but no reg property, so we can
remove them. It also fixes the following warnings from 'make dtbs_check'
after adding the thermal yaml bindings.

arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cpu0-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cpu1-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cpu2-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cpu3-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
m4m-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
l3-or-venus-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cluster0-l2-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
cluster1-l2-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
camera-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
q6-dsp-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
mem-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml: thermal-zones:
modemtx-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'

arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cpu0-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cpu1-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cpu2-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cpu3-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
m4m-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
l3-or-venus-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cluster0-l2-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
cluster1-l2-thermal:trips: 'trip-point@0' does not match any of the
regexes: '^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
camera-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
q6-dsp-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
mem-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: thermal-zones:
modemtx-thermal:trips: 'trip-point@0' does not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$', 'pinctrl-[0-9]+'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7ae082ea14ea8..76a2ef2e01933 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2165,7 +2165,7 @@
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu0_alert0: trip-point@0 {
+				cpu0_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -2186,7 +2186,7 @@
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
-				cpu1_alert0: trip-point@0 {
+				cpu1_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -2207,7 +2207,7 @@
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu2_alert0: trip-point@0 {
+				cpu2_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -2228,7 +2228,7 @@
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu3_alert0: trip-point@0 {
+				cpu3_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
@@ -2249,7 +2249,7 @@
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
-				gpu1_alert0: trip-point@0 {
+				gpu1_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2264,7 +2264,7 @@
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
-				gpu2_alert0: trip-point@0 {
+				gpu2_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2279,7 +2279,7 @@
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
-				m4m_alert0: trip-point@0 {
+				m4m_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2294,7 +2294,7 @@
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
-				l3_or_venus_alert0: trip-point@0 {
+				l3_or_venus_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2309,7 +2309,7 @@
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
-				cluster0_l2_alert0: trip-point@0 {
+				cluster0_l2_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2324,7 +2324,7 @@
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
-				cluster1_l2_alert0: trip-point@0 {
+				cluster1_l2_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2339,7 +2339,7 @@
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
-				camera_alert0: trip-point@0 {
+				camera_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2354,7 +2354,7 @@
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
-				q6_dsp_alert0: trip-point@0 {
+				q6_dsp_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2369,7 +2369,7 @@
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
-				mem_alert0: trip-point@0 {
+				mem_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
@@ -2384,7 +2384,7 @@
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
-				modemtx_alert0: trip-point@0 {
+				modemtx_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
-- 
2.20.1

