Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E972087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503631;
	bh=SNHOlGVRp9tnGD12pIQzWTN4qNINzqpUoktgGrWekX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFoscxw9OlDoabe0QkLPWcwtadobOnBzn7mLtST0DbF+oSpJs1S2CMjOJG/pw6Qw1
	 YRQh+1vmmOXEpOO8X8vKZ6Bs9NYWIx/Z9Wj6N7OUeV4SuxjzME73/+a9FLHcCGKB82
	 ncPLzbz5Up6qv9Z3iJJQ3RwxfmUeF+ZKxnoxi7x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgIGSdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgIGSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417C020C09;
        Mon,  7 Sep 2020 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503622;
        bh=SNHOlGVRp9tnGD12pIQzWTN4qNINzqpUoktgGrWekX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmYZJQRShqYDqRLZyvXggf1qSytOj7VpU7EDxcaA9jEW6nyLDunWqaQ/XlQk49yPe
         K9XCjNfWGvnEcEmhmP8PLru5OLEHMnMN2oORtld2/ceLiH9sIoj7iGBAa2N/Dbsi8i
         F4FaJA59RnivKNFIksNg87IzAzW4cwMk/avMnFkg=
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
Subject: [PATCH 06/11] ARM: dts: s3c6410: remove additional CPU compatible
Date:   Mon,  7 Sep 2020 20:33:08 +0200
Message-Id: <20200907183313.29234-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the specific compatible (arm,arm1176jzf-s) is allowed by dtschema:

  cpu@0: compatible: ['arm,arm1176jzf-s', 'arm,arm1176'] is too long
  cpu@0: compatible: Additional items are not allowed ('arm,arm1176' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 2e611df37911..cb11a87dbc42 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -34,7 +34,7 @@
 
 		cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,arm1176jzf-s", "arm,arm1176";
+			compatible = "arm,arm1176jzf-s";
 			reg = <0x0>;
 		};
 	};
-- 
2.17.1

