Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9992A20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CNzrNl4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGAGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgGAGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:17:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A240C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so10379698pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnO9Dbm5aKhNDV/xMOJzvJqucQG5L1b5w3UlETsElwI=;
        b=CNzrNl4ewU4Y4og7xI7FL9lkFyOtdzgBv6Dpsy7pNn1vwTQA/VkxQGNK5L9EDaqlpR
         8e5yjCeJDEnaPZk02a5dNv3Ogk912Zb+i+LwNSMKiLUO//KUPrBHWxSaVVFALoNTPp8w
         AE2wlailQpidFfipAWCVfGWRITt0v4Y9QqplA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnO9Dbm5aKhNDV/xMOJzvJqucQG5L1b5w3UlETsElwI=;
        b=UX2HirOshSNDu9NuO8BkNxlnJUSVEmMivGu61KMkpt49F0tLMJI44SKN0sM2FYn1mN
         P6yxP1RWBNuvRVH9hcE2GmUniovC70j5qBFpLXwIL7PBttAWGnNnBg1k4hvyS4VZHsJZ
         qLxXDQfslstw8hzDHCWEESNC4OqG1h6OTnR4hsTq0JrvSK9OX0K6ht3HcBrHvxXPOvpg
         y2LFfKBEYxUJOgTIvkIPCgGzGUcFxoNzhUqqEro6EAXz+ftKXbRnybgWjeeExAn+dHFK
         Z9FQUHb9HEE7FGB0N4X+NYnkKVXKkauU5143zVHuA3Cj2zH9Oo7BY1OJV9wPoabnT2RU
         DVUA==
X-Gm-Message-State: AOAM532mczxe2NZkyzg+/9ZZxC4KbziaLwq6dBFOoDcZlFCFdn4l75bj
        9CS7r6Myyd0cmXnv0uHBXWCKvA==
X-Google-Smtp-Source: ABdhPJzBfwpx18inVlPQA63juajFMREtwAWJwIcDgv2LrM96Z/BOUv9CquZaNeqE/BFFF7WCNyikOQ==
X-Received: by 2002:a63:3f42:: with SMTP id m63mr18898284pga.310.1593584263134;
        Tue, 30 Jun 2020 23:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:356d:fc3d:92ff:192e])
        by smtp.gmail.com with ESMTPSA id n189sm4555744pfn.108.2020.06.30.23.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 23:17:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add Rock Pi N8 binding
Date:   Wed,  1 Jul 2020 11:47:15 +0530
Message-Id: <20200701061717.143753-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701061717.143753-1-jagan@amarulasolutions.com>
References: <20200701061717.143753-1-jagan@amarulasolutions.com>
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

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

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

