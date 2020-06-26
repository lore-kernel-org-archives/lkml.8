Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3140C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D080520836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2EBCVQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgFZIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgFZIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B6C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:05:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f9so4339181pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EK21azx3U+MX6plvAOsvSL8DWdtKiCwgYO42rwHtnU=;
        b=l2EBCVQRTZ1GvNRGorRxQ6hXJXjOjoDGYnvKhzHO+DLJU7s+7wLVA9NsIXmu6asZzH
         13vUknQpNnorfz87qepVpXQWBbbuLj6lQ7DY+7mES6wDd+PKKguz+rNMBemGCHtczyDV
         /KHM1hjyoTXOmFIO5dl3tV+SR6IWtz608dIx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EK21azx3U+MX6plvAOsvSL8DWdtKiCwgYO42rwHtnU=;
        b=io36caIjcNxjP962wkMXT0JbkvkSMA905OZV7U1hetkK78/HvRkeCCWjImqUF46cU8
         g3ByI/e/0PgOP6xKXM7xW9zuuA7M4zBGotaRRrkX/IT/P6mVrz/j780Y0KZnwSHaOxEe
         r+a9H4lODIvTmIXpBiH1wNcT0FLCA3ia91yh7qUV808glSQtUsccu04UfDsdZPG1eP4D
         MTMRYA47SZUmQzhJDlY0ruGYrh+wPjFMvByHDBx0npCTKghHQBPDTsyBA9fCi7pBnMNx
         to3QQnJkCBLvWEyOgWYy0ZjYCYdl5gn38zEB0/cW78YekK2XgM5JKwAeU5X3up2HR2Am
         NGwg==
X-Gm-Message-State: AOAM531C1wnLEKetHZQMkxsENNARVJgZ9wnXlbUlQ0tpn+RSIdGnzcqQ
        nBb7xmxRCKVlANutRqTZKoPUmQ==
X-Google-Smtp-Source: ABdhPJwcsLeI2i7wvAzzhzjrDVGLxbJKSHWqgsBFUOzN0435v6V6qxxM741pfFYX5NEcBlUADnWc4Q==
X-Received: by 2002:a63:f1a:: with SMTP id e26mr1742157pgl.80.1593158759096;
        Fri, 26 Jun 2020 01:05:59 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:05:58 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 09/18] media: dt-bindings: mtk-vcodec: document mediatek,mt8183-vcodec-enc
Date:   Fri, 26 Jun 2020 17:04:33 +0900
Message-Id: <20200626080442.292309-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the MT8183 encoder has been added, document the
corresponding DT bindings.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 7aef0a4fe207..8093335afecb 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -4,8 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
 supports high resolution encoding and decoding functionalities.
 
 Required properties:
-- compatible : "mediatek,mt8173-vcodec-enc" for encoder
-  "mediatek,mt8173-vcodec-dec" for decoder.
+- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
+  "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
+  "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.27.0.212.ge8ba1cc988-goog

