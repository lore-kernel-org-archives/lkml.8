Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA7BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFFD20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezklgun3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgEGLct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:32:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427AC05BD43;
        Thu,  7 May 2020 04:32:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so5952415wrt.9;
        Thu, 07 May 2020 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=miVjUF+kU459Gr4P0bFX33XFzImTaFGt5nwVSljspPk=;
        b=ezklgun3NG8L1ZLbd0I/M8AZkRmb1NVMMIzZtOYA91JKlr7sDY4h8dRsT8fHiZr5sc
         2sKrYYkfWy7mm6Dop7KFiE7THZONbRDESBN5SaxRJyxxPlV75OGFN5EwIeHYNMfcUs+7
         WHfoMElCdA+YwRMYWk7eDqMnoBRVoOdWHVwFqlgVvXodrb/6OyPVetautl0IkOlR0lSd
         bhoqGy1Uwk+sx7DQBfov++lxLzCGHj2VbAqkaGnjQyqRWtZU9QeEENpE13pjwZsSlp0c
         prbBP2cwXGsLBVjkN2TnjXD2QppwjO/pDiBiyJtvIxq1e2LCMS0YGWJdTZe2otTlprTs
         k33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=miVjUF+kU459Gr4P0bFX33XFzImTaFGt5nwVSljspPk=;
        b=Cny1AeQyB80SoiyPXOs3y3asR2BywmUluOee3m+KpmhQduWvx0yJWbdd6Ax/C3Ru8X
         fTgWNXbWiR5u8OFga6dJKenGL2Ffn+2//ZVtj8ApmZvbVtnTABqkNFfY7tTvl9tFlmLP
         JeCa3PfYBDgpM7H+11uFmhFAPu94+ffzpk+5Ky7TVDpeV9eHRh2/cIAJcaMeX7Z33HdD
         yNRoYFiHOnsQq1lGTUv9b3U39h3DUPh/UYwxbnSHd7DLY+q+9Ek7i12FtlaCVKFlvcPQ
         8j/AfHbP0RvjLIaGrLkfthPjX40tiGIK1v/+uolvcF0OqnuGNvX0YpRzdGW0B4RySrcH
         MPOw==
X-Gm-Message-State: AGi0PuacPWWa5ll3ki3CyFKhey2g4bGT5C/oLHIkcml0FFNYgumc7Ewe
        xN8DSSTEtM1WA3XCimZc/n4=
X-Google-Smtp-Source: APiQypKZOjvXEiIprA5Ny63FeE9kMmGQs4HOWplnvTx4gD1ekq4zG5NManY4iny4mcyhjAje3EfW1Q==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr16171936wru.115.1588851165984;
        Thu, 07 May 2020 04:32:45 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e21sm7745787wrc.1.2020.05.07.04.32.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:32:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: rockchip-i2s: add description for rk3308
Date:   Thu,  7 May 2020 13:32:38 +0200
Message-Id: <20200507113238.7904-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-i2s", "rockchip,rk3066-i2s"
for i2s nodes on a rk3308 platform to rockchip-i2s.yaml.
One of the rk3308 i2s nodes also has a different dma layout,
so change that as well.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
The rk3308 i2s nodes also contain the properties
"reset-names" and "resets". Code in the manufacturer tree is
not yet applied in the mainline kernel, so skip them for now.
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index a3ba2186d..10f9d3ad0 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -24,6 +24,7 @@ properties:
             - rockchip,rk3188-i2s
             - rockchip,rk3228-i2s
             - rockchip,rk3288-i2s
+            - rockchip,rk3308-i2s
             - rockchip,rk3328-i2s
             - rockchip,rk3366-i2s
             - rockchip,rk3368-i2s
@@ -47,14 +48,15 @@ properties:
       - const: i2s_hclk
 
   dmas:
-    items:
-      - description: TX DMA Channel
-      - description: RX DMA Channel
+    minItems: 1
+    maxItems: 2
 
   dma-names:
-    items:
-      - const: tx
+    oneOf:
       - const: rx
+      - items:
+        - const: tx
+        - const: rx
 
   power-domains:
     maxItems: 1
-- 
2.11.0

