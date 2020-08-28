Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D02C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A873207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp9nwZfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgH1NyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH1Nx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:53:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED6C061232;
        Fri, 28 Aug 2020 06:53:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ay8so1227722edb.8;
        Fri, 28 Aug 2020 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hV5uJZHsvTb+qZMm6Fh/vKOZnWe5kKD9JZaAyweNigU=;
        b=hp9nwZfasbwEGUoXKE1NJRgbokRuyeaubaLo/Kc0ocQEuV3T1bJz1R6Vm5wpNOf8EH
         p6CDEHszPSPFIRqul+1b1uitnnFkd90dV5biLz8ab1bRZd03EoLlsKvI5PoJOW/ztRnd
         26Nnyw1fwLiR57S8fWkJSQqPJqHMPnKiVzYEExWdSnD/gbVnxdpbvrBMfLhQepwIQk17
         g4aj8aSPKgcQHQfrH5Z4VQBlYaKJJzdRTctfHo9uUm0oagKPvFmpdtxdjQKmCORQ+QAy
         jwoDhyFHkXuxdEtfDXHOTolfaxEPtrpJzLechj9zb668XP62ttPKsq5b0LqCSdkLPUsx
         QU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hV5uJZHsvTb+qZMm6Fh/vKOZnWe5kKD9JZaAyweNigU=;
        b=Nm3A0Ona2u3FrR6p9Zc0xBgGME7iPJ1Svr7wFXwkEr6nlD/95e0XSdN1QgvjvpNUZ5
         Opb32J5fz0eVfkQ88LGITIt+CXO0WksflibB/X6pOvaIGSQ6b5r2n6h83XTlsculpWqc
         WnIIgwSeMzp1NCYd9+Yr+2CrP2AHBhrKAKPaXUOrabmCWjAte6m81IswTK9ZM1rPHLWd
         TMXBOCizvWN59FmGJ7BQhNk6XwAPyz0g1vnB1JVcefVX8HoLpPIZdQXCsxMv4nBlwTjF
         +nCUkxpH2HLKp0UEkkKjkEXKuMIdwBdvqskwm5GErzC6TCu14sy5qsOOCEto0D87uZn/
         1+Tg==
X-Gm-Message-State: AOAM530p/Nsam9vl6RTPphidpijCCdgkfPQFTL8B5sfXg3WXIspjFgL3
        5t1k69MhF7gloEf/MzL3EDI=
X-Google-Smtp-Source: ABdhPJwBwd54XjIF2yG1Ai43w5bDSEkse4/CvzAve+mEXNIc+Jkbp8gW5514ehb317z/qe30tCuiog==
X-Received: by 2002:a50:8e11:: with SMTP id 17mr2101058edw.54.1598622805256;
        Fri, 28 Aug 2020 06:53:25 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f20sm981624ejq.60.2020.08.28.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:53:24 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: Add vendor prefix for RoseapplePi.org
Date:   Fri, 28 Aug 2020 16:53:18 +0300
Message-Id: <7b2624c1e2aa4cb09869ff38676ef2681caa2f77.1598621459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree vendor prefix for RoseapplePi.org Foundation.
Website: http://roseapplepi.org/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..0b5bd97b4211 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -894,6 +894,8 @@ patternProperties:
     description: Ronbo Electronics
   "^roofull,.*":
     description: Shenzhen Roofull Technology Co, Ltd
+  "^roseapplepi,.*":
+    description: RoseapplePi.org
   "^samsung,.*":
     description: Samsung Semiconductor
   "^samtec,.*":
-- 
2.28.0

