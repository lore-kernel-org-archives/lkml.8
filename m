Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66392072D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQg49/dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHHQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHHQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:06:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8586C061A27;
        Sat,  8 Aug 2020 09:06:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so3401757edy.5;
        Sat, 08 Aug 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6WsXeiq0Ut11OzvYqqtiLlAFgk8K33cS8Kgpn15xCo=;
        b=MQg49/dDoFPKDET/rcICcAaAIoNyR31tPeIs78lqlFEQSECptV4qgfNd0Mc4c2woee
         jWuWKR6LKkUfmweIMbokWAesfG7PO7RrkfddPD4BV+CRCItfNtEKE8/X6WnnazCUECHB
         bksRbcLIb07+RrJTMQcg+hxc5GBiFAQ1vvDX2A83t0pj/XCm+VhvakfFHKXEDCja29Qb
         ZI9i4dM3271KpEOG9LYgGkIbmd30P67QMU2buCi6pH6iHhb5jlVwmrlhvvTSRWY19bBV
         Ip77ScFcrvF2r0vp4BCGKQehAiql4gdeydKLPtqGa4HzakyNIqLVKxBjjMRlwOrnDfAE
         F4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6WsXeiq0Ut11OzvYqqtiLlAFgk8K33cS8Kgpn15xCo=;
        b=JYgGSGc+pWn0/3vSddwXvGaFftIl5Rpmsz+dFNb3mN/S1KdcP3MJ+gXQYVMHHCfBWs
         N47ptf05XbTVe+PaeuIscwEeT7ES4t2xExf6diRBZsmYhMLHugUvIKSHDmyL5h8knoio
         ZqUp6lNLRPvIMll/EeEwQ9uTI3W3/+b5lNB6CW7YhPL/fcFdwqERsMIkZovjFJZG6sB0
         QA7xSlUXyFqm3FoaJ+RBpv17r2IZpHEWSvequwjJ+j8ocTQRGY8/fBeHwl365yppwzVs
         AO8JuN2HpEUjXgDGgUtcvIBYJBEOqZR9ZaVsaxr0kCWwwMWCCRbfCYJWlxL4iX2rX2Dr
         0iqg==
X-Gm-Message-State: AOAM533S2CQvfhukL+RuvzZb5pg95ralG9M38J4h1tzmg3FMt5m78f+g
        BcwoWGyHha51dyOXuY2TA7T2frTX7fk=
X-Google-Smtp-Source: ABdhPJxnGuJi3oe1inrY1DofySMD4JumQKU8qO11m20jkq0TBp4OhWMoSja61/wkkbCQ6CtlQy0Xgg==
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr13980684edu.11.1596902787416;
        Sat, 08 Aug 2020 09:06:27 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k24sm8404338ejz.102.2020.08.08.09.06.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 09:06:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.
Date:   Sat,  8 Aug 2020 18:06:16 +0200
Message-Id: <20200808160618.15445-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200808160618.15445-1-jbx6244@gmail.com>
References: <20200808160618.15445-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f3d847832..f4bd9b9a1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1197,6 +1197,8 @@ patternProperties:
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
     description: Zodiac Inflight Innovations
+  "^zkmagic,.*":
+    description: Shenzhen Zkmagic Technology Co., Ltd.
   "^zte,.*":
     description: ZTE Corp.
   "^zyxel,.*":
-- 
2.11.0

