Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57255C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E034206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0Has8Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgIJEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIJEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:14:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:14:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c196so4020862pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8c0TlCjltGNPv4rO1/Om9Bj2FreW//+32287ppV2e8=;
        b=C0Has8PshVIeDcAQTJrxM9ZzNdfDxXuEqG5zNv5qYtLXbKUFj9EBIzfY9dWxm4thpT
         DjWXa1ho0Ww850nBUNan6kcto2RrCWkI8NU7l+Wu7qwyqTX4KVv1RoCdnbw7lbVxN7gz
         peZDzv6PQsO07P9+X9UjV7dc6MsCI9MURi3XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8c0TlCjltGNPv4rO1/Om9Bj2FreW//+32287ppV2e8=;
        b=iAnYsZsVsPx5b6lcttEBoUI5mKhLKXVDftFi1GOScySD/gCALCeEHf/qf1+rDxTude
         po9HFHCVtwFxPo/O9CMj04nvvVQ6/d8RF46ogAcEfuf+FT3Ox3DGQ1ZXQWYqVepjxzi7
         A0Okaf5rS0EmWb2cNPBxpjI3dip3cUXT9uMDuQfe6LiS1UlTeEvexWl1iJIHsAj+s76+
         /fCkno35LKc1Z0izyaJtNwka4WefoO2YGG4yNCjZi3uRl+YODx9sG7WAfRGYJ5gqOlAj
         Or1mm9WAugWt/fXnopDenyNwe2FCFkYnHnvAGrppJM1gIG/uX7eQVKVtG9rYMA2hz8OV
         wL4Q==
X-Gm-Message-State: AOAM533QACDLcdjlmigckbQMBZX+q4SloPZwXWymVYFmlcbsovm1W7Fn
        MYc2OTvRsnFQhAR0B29SrEf/pg==
X-Google-Smtp-Source: ABdhPJyEfGAaDdXT0yj3+AgZpsKtXjp78eyXQV6Ft8bAtu4SuDhI8K5uZicrEwMQlYm4yqJi/J4MPw==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:6525 with SMTP id x124-20020a627c820000b029013c16116525mr3778979pfc.5.1599711264257;
        Wed, 09 Sep 2020 21:14:24 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id z11sm4266169pfc.181.2020.09.09.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:14:23 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: spi: add mt8192-nor compatible string
Date:   Thu, 10 Sep 2020 12:11:00 +0800
Message-Id: <20200910041101.1695195-2-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910041101.1695195-1-ikjn@chromium.org>
References: <20200910041101.1695195-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 spi-nor controller binding.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 42c9205ac991..55c239446a5b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7622-nor
               - mediatek,mt7623-nor
               - mediatek,mt7629-nor
+              - mediatek,mt8192-nor
           - enum:
               - mediatek,mt8173-nor
       - items:
-- 
2.28.0.526.ge36021eeef-goog

