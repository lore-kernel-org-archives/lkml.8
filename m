Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF5EC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643E4206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598890318;
	bh=X3xRWSr6QaWkcJ/HP05VEo8bTsvsoAiagYc94uHMyDA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eL/brfWJUWNPvmKiOBpL47MsLBlz3zWhxzkuO74tJPCd9XF+NkVjMcvwmpWSbMrjl
	 O6g+XTdnPhFFWnZdzXNgZlUlqKIr57KW2H2t7/bLfUtlFMcgWj0gbiM1lJCHxb87p5
	 5MCzP4Xdzr28b4uW5mpmqXQ1gmA9nRW9mzzCTbrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgHaQL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHaQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:55 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0C8206CD;
        Mon, 31 Aug 2020 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598890315;
        bh=X3xRWSr6QaWkcJ/HP05VEo8bTsvsoAiagYc94uHMyDA=;
        h=From:To:Cc:Subject:Date:From;
        b=kb3W+RdMfxd2RwzibXzpiVaPgiueCYfXdb7pAp0jp4y6SuVk6f0phl9MyLRDDt+1X
         qzKnwIK7iUgKwURpmUfDzLRr/MgqHGdsyf+lJjqSZI22ZFcbtfcDUvRTTk0Ye5wrpm
         Sf+ka+hm7WJh1Yc2ZBvvJ8rkCHb4zo5Mjb6ks+aM=
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
Subject: [PATCH 1/2] dt-bindings: mfd: google,cros-ec: Use unevaluatedProperties
Date:   Mon, 31 Aug 2020 18:11:46 +0200
Message-Id: <20200831161147.13515-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional properties or nodes actually might appear (e.g. wakeup) so
use unevaluatedProperties to fix dtbs_check warnings like:

  arch/arm/boot/dts/exynos5250-snow.dt.yaml: embedded-controller@1e:
    'keyboard-controller', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 6a7279a85ec1..0586c5791cf6 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -79,7 +79,7 @@ then:
     google,cros-ec-spi-msg-delay: false
     spi-max-frequency: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   # Example for I2C
-- 
2.17.1

