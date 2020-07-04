Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B902D20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BCVdtmJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgGDUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGDUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:16:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981CC08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:16:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so1833529pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Pwa3FaE5tOhqm9VWi06eI/JUnaCwiRKrrFOCb3b/8Q=;
        b=BCVdtmJKEOCU6r8JCrHzJDPVM8EN/dHK2ItKsV6ymk1nWYbMIDlpH2ntTdb0FGtNNM
         cVEZYBXy/siafz6+boGi5TIO7o/+Ui7iGET7PFc+hIznFJ3XUiWvK3fe4JWm7yj3rKRv
         Xy25e2cAzVqORcpmPUrrmsEidl+wKmC31LENY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Pwa3FaE5tOhqm9VWi06eI/JUnaCwiRKrrFOCb3b/8Q=;
        b=HgTzuJylVjTPIs01aMqh3DR9HaKOwKs4dGmimPfOG8rlCOheVdFvpwtac+1gDXcqel
         6InustOMZ61FqeEYf0wfoSJIV41sLG1fWCQ0zllFGcvZPsIr7dqufyeUUeVWTA4nciMM
         EafTg70KCvq73MI3LzDQ41tTsm5MMYf3VCiCq2WlKJQqtx70P3UqxpUv3Cf2lRCMtfRs
         Ra14haSpwdRnK3LyGuIu1U997G39gaS4y9IRx7H7O98+QRvgEg8S+JKyz48ESGkMVHaj
         PvWyYdoZV6iST6w6z8dkcwz61J5BChdls/PK5JwsamanfMTFOgxs8o97dxfADy989URW
         rJkw==
X-Gm-Message-State: AOAM532Y9RpNFN6v00fdP2t4NNMfPjZxnjNOWJ5CXW5hlBi93Yec5Zkz
        ffZQ4aW22lzdbnHlmvqNACli7A==
X-Google-Smtp-Source: ABdhPJymbkAyrSbZ5ZZKlEnTRh+eUkzfKWa0yEMfNlD594tOjsE7aqAlUDNARxd465x1LgdSWEp9mg==
X-Received: by 2002:a17:90b:2348:: with SMTP id ms8mr42173414pjb.5.1593893784799;
        Sat, 04 Jul 2020 13:16:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:bdf4:3289:4b66:dcc0])
        by smtp.gmail.com with ESMTPSA id d16sm14960791pfo.156.2020.07.04.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 13:16:24 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add Rock Pi N8 binding
Date:   Sun,  5 Jul 2020 01:46:02 +0530
Message-Id: <20200704201604.85343-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704201604.85343-1-jagan@amarulasolutions.com>
References: <20200704201604.85343-1-jagan@amarulasolutions.com>
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
Changes for v3:
- none
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

