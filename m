Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CE5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD62083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598890326;
	bh=AN/d5dS86d/EbitIqLwCS9w3KgDwC+T8YZziwmEC+vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3WDiO0PqTPpRQEWC2PP26KyhpebcLa5GHeDDH9N7kl7K1qhPC7n2EiVRr3pez55s
	 C8nXiD4U5ndqAzB8mmB1IM+R7H2EBs4rULKVn5sJrg8CUkiVq6SyKXQZ2Ll8j/hniA
	 M8a/EFHWpmnL1bFiR1lSapa17SgiO87AOXDmSGHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHaQMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHaQL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5AB2083E;
        Mon, 31 Aug 2020 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598890319;
        bh=AN/d5dS86d/EbitIqLwCS9w3KgDwC+T8YZziwmEC+vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPIwY0uCbpRLbB+K6SzgotqSpd+G5zrhY4Q4UbrfiJkTXG6tm25NBin5WIFHk12xp
         JU2SCKxnis9ImL5EcuayeCmo+PpkOU4XAtbvnXBUyRCIiTLlNeK0WpQ1u2WiOaSuwQ
         IzsT/bDFg38aYdGkmHH0Y4L5QDnWdNg7/tfauD0U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dt-bindings: mmc: mmc-pwreq-simple: Accept more than one reset GPIO
Date:   Mon, 31 Aug 2020 18:11:47 +0200
Message-Id: <20200831161147.13515-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831161147.13515-1-krzk@kernel.org>
References: <20200831161147.13515-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There might be multiple reset GPIOs but dtschema has trouble parsing it
if there are no maxItems:

  arch/arm/boot/dts/exynos5250-snow.dt.yaml: mmc3_pwrseq: reset-gpios: [[20, 2, 1], [20, 1, 1]] is too long
    From schema: Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
index 449215444723..8d625f903856 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
@@ -20,6 +20,8 @@ properties:
 
   reset-gpios:
     minItems: 1
+    # Put some limit to avoid false warnings
+    maxItems: 32
     description:
       contains a list of GPIO specifiers. The reset GPIOs are asserted
       at initialization and prior we start the power up procedure of the card.
-- 
2.17.1

