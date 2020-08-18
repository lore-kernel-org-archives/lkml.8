Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F754C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC73207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNH7Rb4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHROhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHROhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812BC061389;
        Tue, 18 Aug 2020 07:37:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so22356392eje.7;
        Tue, 18 Aug 2020 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2UQZEODYOVCRlh1QRejLi/WzuJNA7W+JKPrcqeoHOhY=;
        b=aNH7Rb4UjQ427P0G/2djpJOYW+4jNcYTY5ueMZJdI+aPHwfi9IVWQ5lmpfsxgPoOyD
         2TembDjnXLlrJ/a8M5UAgVp4WnapO1DdLv6Z9TXH+CUQY9aWYahxInWFDBtnf2ZckZuK
         AXKdp/x2y4mmrDILUtOyZd5aSuFkRAX+X5z2oiFaOrCkQ0ZugqWmLtDxySXxGmQA2Yvz
         tep14aDEZDuEhoOfzeyidXqBxarz8eiwUJhOMdkx0QuWKYJN61zxdkXc/CgACP5Oco+T
         xJgT5p2ERAXYe45DoMXsh1b+c31xNrWX9ZRHjX+1wIklQj71eMW19I/v0zCKuEdPPIax
         Q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2UQZEODYOVCRlh1QRejLi/WzuJNA7W+JKPrcqeoHOhY=;
        b=iOs1Z572zUB+R5AVCxiLLMu7MoonkL0VNt3t0giKWs6WUomSi09Tqel/K0BfaR9F8/
         8cb9P6yiqvuc5QHy2ZTyNkUkQmtuwH/IWbYGdMFJrR+nijFbqzBOfXqDclxdaFTrB1Zs
         LkRYo9nZOvnN+Bg2Onp7uLJJR7L9AEGeDneNWISwjMlYMVcyrnrBH0sz+0etJ0PjcPWy
         sG095oCKi13tjDF3iOVKelBI2Pkvp0vxyKcjXKs3CSjEQGHt3w1z52G/4dwqYyzttt7e
         ttu9ntmdkUglUU/IZ7AEkz3lOzut1QReytJJ+NxroxqExbD4SRSb9bVkhCrNy+yd1La3
         G0HA==
X-Gm-Message-State: AOAM532zLNKSQkXNTV//AvTvfsPnZ1kM0UsGDIdeA60JCR+y1/MgwfYb
        mG7ABhAvwkmViyqBh5gmS8M=
X-Google-Smtp-Source: ABdhPJzVRX6brDlwaMQejDzk4wxMr/TJ+2T1mXXnWNI34f1CAvmV4y0EPIUTLj8CH4kNb+vCaskauA==
X-Received: by 2002:a17:907:20e6:: with SMTP id rh6mr20096569ejb.301.1597761455170;
        Tue, 18 Aug 2020 07:37:35 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r25sm16222575edy.93.2020.08.18.07.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:37:34 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Date:   Tue, 18 Aug 2020 16:37:26 +0200
Message-Id: <20200818143727.5882-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below shows that the compatible string

"rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

is already in use, but is not added to a document.
The current fallback string "rockchip,rk3328-spdif" points to a data
set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
in the mainline as in the manufacturer kernel.
(Of the enum only RK_SPDIF_RK3288 is used.)
So if the properties don't change we might as well use the first SoC
in line as fallback string and add the description for rk3308 as:

"rockchip,rk3308-spdif", "rockchip,rk3066-spdif"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  rebase
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 7bad6f16f..62a61b68d 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - rockchip,rk3188-spdif
               - rockchip,rk3288-spdif
+              - rockchip,rk3308-spdif
           - const: rockchip,rk3066-spdif
 
   reg:
-- 
2.11.0

