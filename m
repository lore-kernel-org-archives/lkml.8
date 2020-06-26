Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6B6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F6F20857
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158777;
	bh=9+1hSzgiVymwCB66UaU86LnUIVfzzROZydYB5/Idn/A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HWTdUrOIBzWxrQqz85d2GhncxI93yJnZx8YOnnjfIagpxUtdxdvFmyVn1FedCyreU
	 naWuv6wAzJv01lGXUpg0FlNicDDw34q1w2jqrjKzkx91s88QIb2w8XxG7ugM3NCxdH
	 l4VxIR5kV/4WIo83BrfQneKm5Ubsng7qztzW51Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgFZIGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgFZIGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:12 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DB920836;
        Fri, 26 Jun 2020 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158772;
        bh=9+1hSzgiVymwCB66UaU86LnUIVfzzROZydYB5/Idn/A=;
        h=From:To:Cc:Subject:Date:From;
        b=nkZ4z8taddylf4E5+kh0l367oPcPA0QW/oY/a+n2LoWkSiCkyIKlqn91cbrZBaK/R
         /5BdKB/meaL2UhyPlQO5M5BJfTwIYUXCawB5vj15Eyys/w3WP9Z/LH2FSRqSdvRa8g
         DhbMWqO3qsDMmvs6CDOGEQqhIn+FqNqO3DVdmV2I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:07 +0200
Message-Id: <20200626080607.3848-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache@2040000: $nodename:0:
        'l2-cache@2040000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 347b4f7d7889..dda2ceec6591 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -98,7 +98,7 @@
 		ranges;
 		compatible = "simple-bus";
 
-		L2: l2-cache@2040000 {
+		L2: cache-controller@2040000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x02040000 0x1000>;
 			arm,data-latency = <2 2 0>;
-- 
2.17.1

