Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF635C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8630D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503624;
	bh=1cKrfS1k/FTqLWxScjIkRzSaVkeywk5f5Ol2DtbQ8gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbOf5tnN9dLhduo0B5TPJfD0kuLUxfDbnfvLMYpI0k/3gvn5JW5ZF5kdvyN7MtLeF
	 N0UCU3wcMoTv8kQTkN0SsrJv6uNdbyAmwZWbJW/oKsrTNgKElJzG/VCqEM1HRc5e8P
	 lp91ShiNmqy7yybnBNiouuBy4tDbNsWjmMnjf5dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgIGSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgIGSdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E3620C09;
        Mon,  7 Sep 2020 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503616;
        bh=1cKrfS1k/FTqLWxScjIkRzSaVkeywk5f5Ol2DtbQ8gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpvTj8nMf0zCNXrSA2KRIurA6Nl4Gj0W8iJ6s0uT10tPDyORYTf3e2tlKW7ItfPQO
         kB3i2jUKzE+jwT6dJbDLnk4yKUgKhTHC6m/1X7L+R7rJm+MvZGdMut5EhnozoM4mS3
         g/RIOiGunRjxmMqGRcXk7ZWazTxrpCnTlEgtkSh0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 04/11] ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410
Date:   Mon,  7 Sep 2020 20:33:06 +0200
Message-Id: <20200907183313.29234-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SROM controller is modeled with a bus so align the device node name
with dtschema to fix warning:

  srom-cs1@18000000: $nodename:0: 'srom-cs1@18000000'
    does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 75067dbcf7e8..285555b9ed94 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -42,7 +42,7 @@
 		#clock-cells = <0>;
 	};
 
-	srom-cs1@18000000 {
+	srom-cs1-bus@18000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.17.1

