Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60406C2BD11
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3779020C09
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160494;
	bh=vj18EzxilM/NmZXB65j0LqcoNeKYgR4PMBJi6Kfb2uk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/QBHS2jwGex1oCtfGs3DdgLeQWelYF2TBCXAT9b34R5OedoaPMhfo1v3t0UbepO3
	 pEX0utlHFZxfU8gt4ZEQPnCcOG4lWN43xh6nsQpxcYcEXRVx2Srxti0wrTkknbkEGA
	 TbEnNJc0zMZ+cEauoIQg99ou6TKhvIje8Bn7pii0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgICTOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgICTOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:14:48 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B11020DD4;
        Thu,  3 Sep 2020 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160487;
        bh=vj18EzxilM/NmZXB65j0LqcoNeKYgR4PMBJi6Kfb2uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pDmDEb0JKf0b1trsl6+0FL1tLHU0jngWlKv9HiZ7s7T518UBV5MSRwT/86YgK0GCX
         Vv8ubF+xRRmJwBydsSiNfgDas+XlBVIiMcu8czndBgDMf3sJe/quZlCRwl82vjN7zd
         ELxmFiVOsT7fH/pnbSmp33KJe4XTqTTbcopxcKzI=
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
Subject: [PATCH v2 2/6] dt-bindings: gpu: arm,mali-utgard: Add missing properties
Date:   Thu,  3 Sep 2020 21:14:34 +0200
Message-Id: <20200903191438.12781-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903191438.12781-1-krzk@kernel.org>
References: <20200903191438.12781-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (opp-table) to fix dtbs_check
warnings like:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: gpu@13000000:
    'opp-table' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index d4d785790eaa..30d421e6ba38 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -101,6 +101,8 @@ properties:
 
   mali-supply: true
 
+  opp-table: true
+
   power-domains:
     maxItems: 1
 
-- 
2.17.1

