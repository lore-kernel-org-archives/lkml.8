Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F220814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="miP7UbEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390799AbgE1N7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390751AbgE1N7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:59:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B72C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:59:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so2163804wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4Mht0hOJ/x269vYNUbhZmvFvBpXKo/z9k8ZE3MlgiM=;
        b=miP7UbEnqGNLwbuCqX3AjlcLiVr/EEW+iM9ZpMml9MEg9sEtBhsE1bnK0HHD2uRhfF
         ADhtu3NmeTdU1c/V4b/dzY7krJThryWtxqu9nO06W+kDnFqn9IS9Sfknoz7lVfmo899S
         eDnBBRKKKyv6X5DgQFNmSm6ReWWv49Rd3VQbPJ2J0GJTRVXxJVR4yKEPRHo/F/K2rrur
         wtwbTHAPGLqhAzcaiKZCw8Sxw3dIK8TCHAMTYW2WnbKUh9rmUlyYwoziHLLhZm6zhmnw
         XokQF5+qlAi+Y/cFuLWs/+HMfeny26GRAeu553j7xxdsSymRXQPvz3pB+w/CKf3GFHJX
         0S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4Mht0hOJ/x269vYNUbhZmvFvBpXKo/z9k8ZE3MlgiM=;
        b=gKx4BviHfA0jNN0DjEDUnGOfta3kR/RBEH9brbm9k7BEDM2vR8soDN/ZsjzqbP0fap
         ZQSbAxeyN7C0PN7d9pdbVKcHF4PUuJoXzHtM5EfdOxH0YwjzTfOuR+VuABqeb7n8Oq/7
         0q/6TPuWJLDXPCv4g427FdWci1CL5cNSKhmwgB9CBqMGknRSMpcDvLBdCki2j8GHsc51
         TtqQdbpNvM+5hsDJuxGBf7rXZxT9CsdNOuDLZlSqB53ZF5VByrUqw2Sr6a5whb49jZ1e
         KKl9Kevr2nTsdLU33Dbp2ALSYfqum5oddBqp7zLwwWDwtm1MNP4vz41ZEflc+FS0H+R8
         jZ5w==
X-Gm-Message-State: AOAM530uH8AX8l0YTFwcDuIBvyD3WpgWhzjdLSjdBHdiITx3wo0CdX7r
        HkMufnrVxpqU6mW6O1P35YT5tQ==
X-Google-Smtp-Source: ABdhPJwa2kiLYWJHItumPfhGeufMSpJNKjrDcHYRwjVY19oFSl+hS6FpEyyraLAC5F2EWT/iMGIlLA==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1760608wml.173.1590674345652;
        Thu, 28 May 2020 06:59:05 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f2sm6395917wrg.17.2020.05.28.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:59:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH net-next v2] dt-bindings: net: rename the bindings document for MediaTek STAR EMAC
Date:   Thu, 28 May 2020 15:59:02 +0200
Message-Id: <20200528135902.14041-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver itself was renamed before getting merged into mainline, but
the binding document kept the old name. This makes both names consistent.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- update the id field as well

 .../net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml}      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml} (96%)

diff --git a/Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml b/Documentation/devicetree/bindings/net/mediatek,star-emac.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml
rename to Documentation/devicetree/bindings/net/mediatek,star-emac.yaml
index f85d91a9d6e5..aea88e621792 100644
--- a/Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,star-emac.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/mediatek,eth-mac.yaml#
+$id: http://devicetree.org/schemas/net/mediatek,star-emac.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek STAR Ethernet MAC Controller
-- 
2.26.1

