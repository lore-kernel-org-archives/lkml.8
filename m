Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E69C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2C82075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKiw2WCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgETBnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgETBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:43:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076FC061A0E;
        Tue, 19 May 2020 18:43:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so1487858wru.0;
        Tue, 19 May 2020 18:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mgc/ds3i5rPSJg4nQkW0agG9zLMcqHYeWci5jVpxRbE=;
        b=gKiw2WCdT80gtPyNeWAzwQflZsVbMe7s3ePl6h5iiT4Gl6OEH8k0yBOwH97pVGS4ZL
         MjO76cH/DKqUi1Qm7KTwDfuxWalTptIQh1fw6oYPWOsm3DBZ42VWI0YZusr/gkOQKFBB
         l+fEajCY/jRdzSdWPnyK6DwMgW+Os+9zwCf6G/WPK8i1by3tXOVoiSdGbxxq+AdQgbMR
         oUQuCYqnLpNpYiwIzpIICiY+VL8Bf+gNcv0QX7WYj2iHjSkNUhwTTpr9I0woD9UlbsZK
         +oUjy5g7ANH90hZuaLELuI8h99R+uoN5sXJCUYJkdv5owfAMeG/ZMpjulqp1BhyZi5k+
         jnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mgc/ds3i5rPSJg4nQkW0agG9zLMcqHYeWci5jVpxRbE=;
        b=EIwkn30NVhQNv0XrqnDsfzmkzIyy0z9S9v8CaD3lt7ZnlnguIYK2zQceK+NjhSlDD1
         9Pl3+XqMjCjLHxvbqAsrpr5bf0KKLkEq2pWu0kjtHQWWRSmQ/YR3NfEYPOAaj6QXDjJn
         BYxDlZd3+dNl+GxH1ETTt6xGVUmMwcdb3jC0Rg9rICbJfBsLTWYkgaDlL19OQ9GfK6mn
         U0OQqPwV/dgK0t5ubPt3JxOJSkuEawcFCRsgLevtWbv2vYeyHd/Vb/eoHndaFHUWT7Tw
         77yy/26ALlsuWFigKuP0YDdabtA7S5tgBO71X/rph5b67n65/KXi41aEGyIyDP6ceVvc
         TFvQ==
X-Gm-Message-State: AOAM530h9lJiRZnAFZ9yYgsWOmlf/4AogETydRC7TLPb+CcVBpBY7pe3
        /osV060LgXWkT9npTxNI6N0+X8gS
X-Google-Smtp-Source: ABdhPJwXnlsRU3f6ngJsAlED0L79WhGm8IWhfAwGH1W31Ou5U+mb9yYbdccRkvLXtHkRp/6UbpRnBA==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr1808632wrx.372.1589939022831;
        Tue, 19 May 2020 18:43:42 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z10sm1493351wmi.2.2020.05.19.18.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:43:42 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 4/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
Date:   Wed, 20 May 2020 01:43:28 +0000
Message-Id: <20200520014329.12469-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520014329.12469-1-christianshewitt@gmail.com>
References: <20200520014329.12469-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
board with an S922X chip.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index cd7a081a4f17..db35e0d0134c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -150,6 +150,7 @@ properties:
         items:
           - enum:
               - azw,gtking
+              - azw,gtking-pro
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

