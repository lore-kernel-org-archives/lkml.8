Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7986C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DFA20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="IFnTibco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgFPRQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPRQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:16:01 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD7C061573;
        Tue, 16 Jun 2020 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dbQoMBtrvJc0duBMGogI6Q7i8MYxJOUerLAn0kA1v6A=; b=IFnTibcoYkhRgl0owbzd+OjLr2
        KxHKhhfPdJtgiGhxvZtAjpC1PlZoVr9V5bJMz+Vc2EO8EWEE9b3MUkRmMHwjDmv4OThvEcQXbfJrH
        KSZfIBCuKwHWNzvpV02JOUeF0ue+b1CM9qrhwI/auPhhPnYl0eI5iUDZ+oyfRK3T2S66vS2UtgaLG
        XX9CdRH4WKq0T97IGCM/2KX9EN8TIxFsErgpQnapOTKrLgGOPpxAEmiz9UG6f8VRme+Evb+T4twW+
        tBFodIS6sR+HbCsWIDPkqZepCJsj5Uc/NlZRqgjbyq7lTIsy6wFM5ex7JqIuQYbin3W5u26ohQd/R
        MND8kOrA==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1jlFBi-0001Vi-Ma; Tue, 16 Jun 2020 18:15:54 +0100
Date:   Tue, 16 Jun 2020 18:15:54 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: add qfprom definition to ipq806x
Message-ID: <20200616171554.GA5632@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing qfprom definition for ipq806x SoC

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b912da9a3ff3..8f299cae2628 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -425,6 +425,13 @@
 			qcom,controller-type = "pmic-arbiter";
 		};
 
+		qfprom: qfprom@700000 {
+			compatible = "qcom,qfprom";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-ipq8064";
 			reg = <0x00900000 0x4000>;
-- 
2.20.1

