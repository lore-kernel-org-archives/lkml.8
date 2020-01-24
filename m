Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C1C222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864141;
	bh=PFbsSZXlZx8BUpeeb4iYbhGgg1WAHLGn0S5otaYZcJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hqx89CLOIuNNlMtx4jRetYb6op1k+DAlJDfOVpwxMy1LWMH0zUbvkW7CwNgF8R9/L
	 tIsb8PQhMiO9RYcGeuWP6L3pZ8ha2LeygZEWUgUhC7rQ3TZN10QbWLwsZx2tolyh/5
	 idQU+2oFsNIMomYGTVDxgxCmT7eGwmCGnAhQrlbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbgAXLJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732762AbgAXLI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:57 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD07A2077C;
        Fri, 24 Jan 2020 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864137;
        bh=PFbsSZXlZx8BUpeeb4iYbhGgg1WAHLGn0S5otaYZcJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8jIFbdR6xR3IGl4pEL3PRwbAkiX0bjHVsVSb7zjkLJeeH0J1VJeeXdwJ+sOLAk2j
         mG5XtjqUi1aSQOqqEV449rfboqrrf8dqMg74U5YhrzcEawlQuw5cgnfUX75rORbFMd
         O//O4ID+LN5tdtgJOxMqs3d+UJRuAo0wkAiIslqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 174/639] arm64: dts: msm8916: remove bogus argument to the cpu clock
Date:   Fri, 24 Jan 2020 10:25:44 +0100
Message-Id: <20200124093108.977466286@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit e4f045ef38e61ba37aa4afc916fce4fc1b37aa19 ]

The apcs node has #clock-cells = <0>, which means that those who
references it should specify 0 arguments.

The apcs reference in the cpu node incorrectly specifies an argument,
remove this bogus argument.

Fixes: 65afdf458360 ("arm64: dts: qcom: msm8916: Add CPU frequency scaling support")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62f..8011e564a234b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -114,7 +114,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -126,7 +126,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -138,7 +138,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -150,7 +150,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
-- 
2.20.1



