Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCEA20716
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD2zhUQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgHHQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgHHQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:06:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A904C061756;
        Sat,  8 Aug 2020 09:06:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so5146826eje.10;
        Sat, 08 Aug 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2sFgXcnIBH3BAdG/TrIwuGuxYCM6OR36iuOQEsH9gg8=;
        b=ZD2zhUQettw/LUSJy82zbSh+vatYrE4Y4cOH0Iu0lSROrFfWoX9Jc97etay5Nucp9x
         LLKMuKrLRBA951bS9ESTTsqsZzPXyAhGi2ue9JiRwjpg2nG+bgejokXf8pYOPl8488Sf
         r5cz1TMTYPdoFSw1tyjOzhjaLsEPHp8rnqkvOpPb2xIqygF92yR9uElWCYHeHO+iveE5
         yVQf4eUIHQ4bcISfjiV4BVeUHJ9NwA3vC9GG17ULLIU7R3KurtciBCxURWaqgLdrVzSl
         mINSI5vPTkZ/kJfxdiJQIwYb6vrgESSSMHnPTq2/ay95xTUMe1/2gYOQk/1k46Pz7AgY
         h6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2sFgXcnIBH3BAdG/TrIwuGuxYCM6OR36iuOQEsH9gg8=;
        b=npIKcW0sB7fL+4f1idNQMkWdDpOcO3vBZQDgRcdEIlr53ZJw9+2D9OzUXirAdG/yMP
         Gr+55zuhxkRsPR8MBkAupbxr5XhBj6npuyNpHtmN0y7/5p8Tqddvu2FpXP6N+7h8hJsj
         0lseTdxFF1ZP2g7XIRGwbzacgdJoC/+ZTBViSnI4eKHqlDd4VjC+QAOcHX8JM8A+00IO
         PUy83X3AM1ug6a8JTt34HmumPBB1vJ+E7ChiTz+Mytj8bEQSEV+D65I03yHSj6JEZRxV
         Dh1C8JT1FlunwDjcKBWZCD9DOWmXQCJERVe4a1LoPNNQuKRVset+VNf/xFkNKlJWy/T+
         VWEQ==
X-Gm-Message-State: AOAM5314q8vSymIQgXZtSWb42PMc77RyuVcEWhbGtiAJ1lvh7dEwVBIa
        5mI4yl/vwIaOgt14gqpTUIU=
X-Google-Smtp-Source: ABdhPJwCvKvZjDPxoc7YMRmDHgX5p6FT0ZFQ+M56jlR3ESnxPUNbsJ6CnJ8frjscbUYvtsYL4d3FxA==
X-Received: by 2002:a17:906:2e93:: with SMTP id o19mr15247920eji.167.1596902788198;
        Sat, 08 Aug 2020 09:06:28 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k24sm8404338ejz.102.2020.08.08.09.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 09:06:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
Date:   Sat,  8 Aug 2020 18:06:17 +0200
Message-Id: <20200808160618.15445-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200808160618.15445-1-jbx6244@gmail.com>
References: <20200808160618.15445-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Zkmagic A95X Z2 description for a board with rk3318 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index db2e35796..7d1961bbd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -555,4 +555,9 @@ properties:
         items:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
+
+      - description: Zkmagic A95X Z2
+        items:
+          - const: zkmagic,a95x-z2
+          - const: rockchip,rk3318
 ...
-- 
2.11.0

