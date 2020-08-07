Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D782C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBACB221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SJ8+3B0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgHGJsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgHGJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:48:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B0C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:48:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so706836pfx.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbWvohNnPXJo/dYG1vb/RrldXZGnizxAUyzSnzTjrPA=;
        b=SJ8+3B0uxfaAA+gcYxH7Yj7PgoukbcaHJeSDbenJUgipbvSoaJRAeiRqKQb54bQ3d+
         apaTl9J9eIdgu6u/8BwwyhzYVXC0o74JkUAduGlYZ6+mMIr4j+HnL0KpIbEnZnfKE95n
         7R2zxqNxFUfFo/WhfPneq2U2LmhYziNlklFaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbWvohNnPXJo/dYG1vb/RrldXZGnizxAUyzSnzTjrPA=;
        b=idqSFT/QpYdMvoPjlpXPDwbMtnp9dJPAKm0dzo6D3TDjLvy7G1sfqVE5LHg3GdeGPx
         grc9wd2Xz1xdmO/L2M7k8d2gyUB53UpmAw6f8HYIAwI4dFIZra9onWbLrrr7UMwRjbD6
         H/UbIPFMG+99cnVytjxT2oai7E7Jsk/7wnyB5UDCebdOYWj5Q9K0jy/J8qp+1+XGjFA0
         wQyRlznvjQnK0KLAKGWFW/MyPPN65MNuQ4K5PPzUsVoPNjgy6+r9IOw+omVn2KQR3+pE
         aKAus7eFHu0ULd0Tm4X5BHlMIZaU+5BeJS8oJcGb+fIm3vRPupKVIbIVjOfh/H3rEr/T
         5TGg==
X-Gm-Message-State: AOAM533HDThamYdaQ4M85id5XeQxxP09Pf51ambCNjuk5MNo/jdnsHoA
        /AKiBjaLUQdw5e0zRTls3PyvHA==
X-Google-Smtp-Source: ABdhPJxbpTuigBUMypuy2A8EjJZO9vXIUv2QlhlMt2DcA/3nhfZt3SE0xEMh2hHcY6EINNwVSVZinA==
X-Received: by 2002:a63:5b5d:: with SMTP id l29mr11110552pgm.206.1596793720666;
        Fri, 07 Aug 2020 02:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:6097:2d32:26bb:64fe])
        by smtp.gmail.com with ESMTPSA id d65sm11412112pfc.97.2020.08.07.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:48:40 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4 binding
Date:   Fri,  7 Aug 2020 15:18:23 +0530
Message-Id: <20200807094826.12019-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCKPi 4 has 3 variants of hardware platforms called
ROCKPi 4A, 4B, and 4C.

- ROCKPi 4A has no Wif/BT.
- ROCKPi 4B has AP6256 Wifi/BT, PoE.
- ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
  GPIO pin change compared to 4B, 4C

So, update the existing ROCKPi 4 binding to support
ROCKPi 4A/B/C hardware platforms.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- update binding to satisfy dt_binding_check. 
Changes for v3:
- new patch

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index db2e35796795..7025d00c06cc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -430,8 +430,12 @@ properties:
           - const: radxa,rock
           - const: rockchip,rk3188
 
-      - description: Radxa ROCK Pi 4
+      - description: Radxa ROCK Pi 4A/B/C
         items:
+          - enum:
+              - radxa,rockpi4a
+              - radxa,rockpi4b
+              - radxa,rockpi4c
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
-- 
2.25.1

