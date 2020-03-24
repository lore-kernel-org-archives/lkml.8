Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F84C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3N5twz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCXJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:42:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCXJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:42:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so20538423wrv.5;
        Tue, 24 Mar 2020 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dfxSm/ZXM3N66X722SNsL52L/LGFXqsTtz+9P19Vsaw=;
        b=t3N5twz1dwcUQlv/08FOM9GloZJW4uZFPOoAGwANFxm+gRTe7xCqofDI6qPDLyif0I
         EKQz1253Y/rNmPOh+fUE4y4OiDiLPLkrhoI+TKhmK5sjXDtCL1D/LuEtCUxjkMZaId07
         o8mmzuIja7j7REE1UdenUBxgPbbhXKBA4dwFA35SfT6ap1e8zFHy1RkAomULznQlAi+0
         As9q2Ey7X3TXiHSzybimrHuKLKdRiuRPnt49y9lb9QB86QNEIv8xMi1pn2RW97lwZ1E5
         KagS2B/fuqU5oVwOCble67kAx9WmHsXkcznJRjUbSoe/wtRfhnhF7FZoQbaImvc6yha/
         2JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dfxSm/ZXM3N66X722SNsL52L/LGFXqsTtz+9P19Vsaw=;
        b=T/GdH9XMtzb3A6VaAhLe3kOxamZ/bT/6dAITYG5a32ajYH/8KPOQLTNSCf8bypuUOr
         dF5yJolwz+Mc0Py+136eDPFlamnP4U6OgcQ0zrHIrf2Mk4YUgQjGWNVaD9MPCjrb2Ulv
         KmcKSZiAV1ffRxp/hh1T7BIPduMLe35/HBRfPx+DThhtJJXxZsHAAJlKV5E0ZYFHCwbG
         T9EkFmU1dwt36ds+bWE0vs4ErBgzZDpvfcwMEBLF34jmvJGRtOXVWXaMTj+negtBMu0E
         w0gVqt5su49DkWhh03ZVIFRgwadDvmG/pz1HBosieOqztqbQqcfIynsRWyJALDBbzFlj
         MRQw==
X-Gm-Message-State: ANhLgQ3VhfIiXJnu9GU36Mh0BnJ8K7MMrvPnpL9gs9xyluTvLT2S6+K6
        vhKNZGmFccBZ4cmVF+hdt54=
X-Google-Smtp-Source: ADFU+vvzCwo910TMGcnGtFYdDqZ3y/Vb2IoyGQ7eCMIcLg9baIfRO2Gk1omipjrbpyK3LZsE5oNM2A==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr13022001wrh.1.1585042919263;
        Tue, 24 Mar 2020 02:41:59 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r15sm22489916wra.19.2020.03.24.02.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 02:41:58 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: sound: rockchip-i2s: add power-domains property
Date:   Tue, 24 Mar 2020 10:41:49 +0100
Message-Id: <20200324094149.6904-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324094149.6904-1-jbx6244@gmail.com>
References: <20200324094149.6904-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'power-domains' for rk3399,
so add it to 'rockchip-i2s.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index 7cd0e278e..a3ba2186d 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -56,6 +56,9 @@ properties:
       - const: tx
       - const: rx
 
+  power-domains:
+    maxItems: 1
+
   rockchip,capture-channels:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.11.0

