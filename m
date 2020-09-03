Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D28C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F082100A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160499;
	bh=5wEJhG2qmYzHCfFTECenuZ9F/HtYOo5DQI6qyiDLdrE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YSqZ4lRQHc8kzZ75P6FXcvN8ZZljsstGbvNylHjdfD1o46Z2dJa2awSpC+hC/1be7
	 xjMnGMEGzet1djPETZLTx+Sbk3jajPhj+YV8UkhIRaIXy6hkBvdH3x0mW9h9ssJAqi
	 hbHWH0ft23oaArFaHPXM6l60lp/yh75DAuCgChPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgICTO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgICTOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5334320DD4;
        Thu,  3 Sep 2020 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160494;
        bh=5wEJhG2qmYzHCfFTECenuZ9F/HtYOo5DQI6qyiDLdrE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2FC8aimwkuS5Ij29DocsCjkGFX8YLW5sNerkU/tTLZUNN1YWCZoIqD7qV2OsuBL0c
         2mVDDSB0VtORO6hzQuBoCvWDF9Gm4xPzaigkWrZyG/SsaQFVZwCx+K0dBnshRkEHgO
         Nl8mejAC2BVFBo/OVwsbHUgAZMJRTwbTt9tTFksU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: gpu: samsung-rotator: Add missing properties
Date:   Thu,  3 Sep 2020 21:14:36 +0200
Message-Id: <20200903191438.12781-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903191438.12781-1-krzk@kernel.org>
References: <20200903191438.12781-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (iommus, power-domains) to fix
dtbs_check warnings like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rotator@12810000:
    'iommus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index 665c6e3b31d3..f480174fe0d3 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -22,6 +22,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  iommus: true
+  power-domains: true
+
   clocks:
     maxItems: 1
 
-- 
2.17.1

