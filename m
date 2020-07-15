Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DFC2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mWZQDuU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgGOIfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgGOIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:35:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:35:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so2741512pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxI9YhDE5SV3Io8wREotQldzA482P0rWaokyh+vxGCY=;
        b=mWZQDuU7rGN2pEgKRcvEzQtssPL4zTWKq1U65H4fQMz3uuPkHUarbzxXLgLTksol+x
         ZDHShfHOIE8TnHtHp/zFmUH/XqZF4teZTnS39Zm6o0LGcXMSEGc/d2JQ5sxsl2+/pj78
         TBFkvM5RR49xK+kjK2gzB59By8moD6zK4u/CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxI9YhDE5SV3Io8wREotQldzA482P0rWaokyh+vxGCY=;
        b=rJkiGY6IqXEbB2MtEB7bYlmWTYPcVyHFaWHMZ6ZzorUIGTQlq+0+YxAOZ9JXBiteNm
         ANL4KD4ykF7IAQTNSM78/MHdJsPL3amq16r6zeFM71Z0bkwbqD9OwIt4OJSjtDvP2uJE
         5W/UnUID5/TtM/7+xiQo9dWanwIVFgDpRTix0toCDif4zOKwpU1ogsf1cZs7kLKzACBW
         xt1kva+T3CzeM51egQTlYXDsdIL1GOUSQ8iqm28rmKa+schIHo6Lahi1uqRsCVZbK3Rl
         ufkvLBcYeOTzgfGiFoZK4KfWmnJtaU6qhLfCzd2WV1Ag7ysR7TYkSapvBTTw7OYmui5q
         OuGA==
X-Gm-Message-State: AOAM532kELl+KWmbUZhgyPj9jfuDhJVhrYr8Eg8SJsyf62PHxmNc4SuD
        BPYv/Iya9X1AlKatODHgePWbAg==
X-Google-Smtp-Source: ABdhPJwp41qrBoUG2O+1o21NarpOFZdNuLSnTVTnVazpWy1sBZXw+vbp0VgkdH4BHsqxByv6Sx7IhQ==
X-Received: by 2002:a17:90a:a0a:: with SMTP id o10mr8851118pjo.12.1594802107223;
        Wed, 15 Jul 2020 01:35:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9887:56a8:c916:cfdb])
        by smtp.gmail.com with ESMTPSA id m92sm1467584pje.13.2020.07.15.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:35:06 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 5/7] dt-bindings: arm: rockchip: Add Rock Pi N8 binding
Date:   Wed, 15 Jul 2020 14:04:16 +0530
Message-Id: <20200715083418.112003-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715083418.112003-1-jagan@amarulasolutions.com>
References: <20200715083418.112003-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N8 is a Rockchip RK3288 based SBC, which has
- VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3288 SOM need to mount on top of dalang carrier
board for making Rock PI N8 SBC.

Add dt-bindings for it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- collect Rob reviewed-by

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d4a4045092df..db2e35796795 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -435,6 +435,12 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi N8
+        items:
+          - const: radxa,rockpi-n8
+          - const: vamrs,rk3288-vmarc-som
+          - const: rockchip,rk3288
+
       - description: Radxa ROCK Pi N10
         items:
           - const: radxa,rockpi-n10
-- 
2.25.1

