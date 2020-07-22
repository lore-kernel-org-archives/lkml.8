Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E907BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C760C20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d9mR8BMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgGVTKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:10:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6FC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j19so1785742pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuJDZTXppS2/lPeSSOe4OB8nx8zh/tKr/I+u+TYREG8=;
        b=d9mR8BMydxSpnuTpa5NiN2g2YR6AZTKppO1ZncRPaTF0Dqb5ij3brR5b/zkgEmcEZO
         mKMiEAmsmtFI/zoTCazyxL1JObJA+pi78LzGSLd0SPbb9/Kd1pJ3aahjc8+SIxB2GHgz
         QKD2YNfZ+rQzSyGvAof0fxNrygIIwzQkum7aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuJDZTXppS2/lPeSSOe4OB8nx8zh/tKr/I+u+TYREG8=;
        b=YGYeDbH1XxHr7HEs0h+7fFSv3hFPjHHDBWBTmISdRB6Uv2m48rsUVtJwraz/K2KlfN
         tCsR1vI/SGuZ+FIN6ZrDGDOjQlMjRKVZx/Li27L8W9svS0pGIVB9bYLy+RuOaFL6oT1o
         bWPwWncvXX0Mj2bexSDVnf1aEia30v8JB3icYNgBkHT12ZN99vLNEb+AdQGxR/IDzhzQ
         dKhzT13QCFNeQ5xzZQUK4W197i7fpKyVMTNBZjdMyzcLEEUO3ni96pPHrYJnNQcll2Fb
         xiqKZOBAI/Y+FRPeAHxKyQvKbYXUAWcwqF3FauDi1NlVvw3wPfREWtCY680X4geBMFtv
         pCnw==
X-Gm-Message-State: AOAM533uaycOQ79s1ttw+tBCq7yE89Sg/klhLE3WszfNcV7s/Rybk1qG
        BAfk5gmdjs1NKk/FUBCYmsg1iA==
X-Google-Smtp-Source: ABdhPJzos6BQqkw3PXj9Jq/Sl4exM0k2aunKwHLCox4HWTC6kXg+R+E6M/FPY0hogr7QFJTQUJPq4g==
X-Received: by 2002:aa7:91cd:: with SMTP id z13mr995868pfa.133.1595445000304;
        Wed, 22 Jul 2020 12:10:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:fda7:aaf8:9d1a:6749])
        by smtp.gmail.com with ESMTPSA id n137sm342398pfd.194.2020.07.22.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:09:59 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/6] dt-bindings: arm: rockchip: Update ROCKPi 4 with 4A binding
Date:   Thu, 23 Jul 2020 00:39:44 +0530
Message-Id: <20200722190949.215656-1-jagan@amarulasolutions.com>
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

So, update the existing ROCKPi 4 with ROCKPi 4A binding.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 Documentation/devicetree/bindings/arm/rockchip.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 41f919de1ad4..36057c9e4b83 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -442,9 +442,10 @@ properties:
           - const: radxa,rock
           - const: rockchip,rk3188
 
-      - description: Radxa ROCK Pi 4
+      - description: Radxa ROCK Pi 4A
         items:
           - const: radxa,rockpi4
+          - const: radxa,rockpi4a
           - const: rockchip,rk3399
 
       - description: Radxa ROCK Pi N8
-- 
2.25.1

