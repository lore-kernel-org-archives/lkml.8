Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D7C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A801920578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586875557;
	bh=BKt0ly0X0uSnzjL/jCTuX7kQW79brFOyTVWQb3pvaVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jkNndXPfA6zDdQXHxhQ9OEKr6rzlVwWN6B1kxHKl4qYU5MSgUvl3Ks0UFx81e+BtH
	 RyweD8SOx46pfPL35dt2BwhUdeL6JJhtSb5PV1lh+7vqwXkR+CHOxJb3ITPsO49wQ8
	 VXSyBgFCPtZbUNbN/v6KygXeAibHIJswYO3UA3OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbgDNOp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404554AbgDNOpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:45:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA4320578;
        Tue, 14 Apr 2020 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586875553;
        bh=BKt0ly0X0uSnzjL/jCTuX7kQW79brFOyTVWQb3pvaVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xj0eRvpcd0zAHHGgS+wlkuC4N5yFk7/Jl/HNtK96l4XQMHdwnPoEAvivqpMhgIeM0
         vPngoZWMyKMqw4h4vqjDFcvzCxx/XMchC3Fwy/4lD2/mzfQ7AASvzYHB+w1bkMcJI+
         NNDw8/wBVhwYCKjYJlDHd/tPPcA8jAUWZt/e+Xmw=
Date:   Tue, 14 Apr 2020 15:45:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
Subject: Applied "ASoC: rockchip-i2s: add power-domains property" to the asoc tree
In-Reply-To:  <20200324094149.6904-3-jbx6244@gmail.com>
Message-Id:  <applied-20200324094149.6904-3-jbx6244@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip-i2s: add power-domains property

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 2a79c31a498e002eeb7c7d759241c3cca95b28d9 Mon Sep 17 00:00:00 2001
From: Johan Jonker <jbx6244@gmail.com>
Date: Tue, 24 Mar 2020 10:41:49 +0100
Subject: [PATCH] ASoC: rockchip-i2s: add power-domains property

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'power-domains' for rk3399,
so add it to 'rockchip-i2s.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200324094149.6904-3-jbx6244@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index 7cd0e278ed85..a3ba2186d6a1 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -56,6 +56,9 @@ properties:
       - const: tx
       - const: rx
 
+  power-domains:
+    maxItems: 1
+
   rockchip,capture-channels:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.20.1

