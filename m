Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085AC47258
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507C42137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lntpnX2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEBLsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727823AbgEBLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C564C061A0E;
        Sat,  2 May 2020 04:48:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so2865137wmb.4;
        Sat, 02 May 2020 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvA5b2DQSI44cr3o1jiTAHv9fqEf3DsLbZQwG9U+Tvs=;
        b=lntpnX2P7ussyaemFcrojFKaVk6tZ4Rm23GVBeAzymcvtkUz7pDRllMViOK+nQyzox
         0EADAUuTugXqZTw6fAyL4b78FjGgjbcIXb21oTM5py0vCqCPdvut8B6kASQwqbCI/v3C
         g+3lqgQFwNmVzxjDraHMhSNq+R8A4ZaLNVF+jRTO5U7IXJnY/Y4bTqRtUawsiRjoo2Aq
         mCwD6MKblcJMD6UzL8hwbNcmXpU3V13KuCN4sz5Rf6yjGU4xyVYEFPLetIUhHk9MkmE1
         2ieICDdazzU2Ut1G+GFXOIdjL2d9FaqYvn2gbCEU35E45500kZOP4svPYV0U0ptyPLlb
         bxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvA5b2DQSI44cr3o1jiTAHv9fqEf3DsLbZQwG9U+Tvs=;
        b=oJ4cz1ql3C9ErMPqpVsXbdNnU6VDhDE2w23aNH827oba8q1wJjynW6dWrIJu9ON6Eq
         DQM1N4g1A1NwYaNiU8bCzPxng+cHBzL1BkxdXeFQmWOcxEX9iK/eQRNyu7sR32PUFWBL
         LC0llvslLUeoZ4I3sZvOFHi2wrwN761cWOYiHkBgtP4zJIwzsi4y8p0QiV/5yD+4GSUJ
         9KGvY7uF5tyB1HaqfH9C3c4GbR+avEXXvwC4/088CMmQdSAsMoVhQR+Ni8opdB57LqMd
         8OVYA0qAy3mXKZkQBLTav36yPVTwbDuk/xSrw2aSfCfePr7mMMHbXPgLzHvo8mTauJpT
         bFjg==
X-Gm-Message-State: AGi0PuaCu8Mm9Z15sGSnGQdome9BoFZ8h/AgXGHwHZEE7T3X/XwG3Iwg
        LPqjue/L55zjB8r85blbNf4=
X-Google-Smtp-Source: APiQypIFunrF283WMUXHWC0y7h03zmE1LjpFk7NL6YETkVqdiu1Zwem3gkqe4Qn156YjEsmL1+OsTA==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr4502594wmj.21.1588420109231;
        Sat, 02 May 2020 04:48:29 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:28 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/6] dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
Date:   Sat,  2 May 2020 13:47:48 +0200
Message-Id: <20200502114752.1048500-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2 PHY on Meson8m2 is identical to the one on Meson8b but
different to the one on Meson8. The only known difference is that Meson8
does not set the ACA_ENABLE bit while Meson8b and Meson8m2 do.
Add an explicit compatible string for Meson8m2 so those differences can
be taken care of.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
index c2fe8c08d99e..1d402e055045 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
             - amlogic,meson8-usb2-phy
             - amlogic,meson8b-usb2-phy
+            - amlogic,meson8m2-usb2-phy
           - const: amlogic,meson-mx-usb2-phy
       - const: amlogic,meson-gxbb-usb2-phy
 
-- 
2.26.2

