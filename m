Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF192075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lugw2ssD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgETBnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgETBnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:43:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF50C061A0E;
        Tue, 19 May 2020 18:43:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so1452371wrn.6;
        Tue, 19 May 2020 18:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjQbbX91rvnNhlDfTgwfaBNtgngEI5glR7O7U8xJEyo=;
        b=lugw2ssDYNL2LcmLnwPmMdsxe4DWxowyinpMaoTghscznQiRWqC0VIY5uDb9XK2DKh
         BH6F+3TqNj1xdWpMuLVXvNRqcrzU7NPn62eAi0FIICdZNwKliW833pKS55sXILBaippw
         7yq/rA7M5/8mi0AYFGSavd/ww4egz6bdQkgwDkoecin5FhmB+Z3U4OLNrGEWo1/uBzxl
         65ucGpTfmK878WEvbxcKFb4reQXNmy0bd+/K+PuWuETgTCyDsGVhOjSaTVpliLYP/OMP
         tRNwf4tF6UVq49dGbRKrUPat8F3rrph29QoZbuhnvmy9kk34I5aeaD3WHi1f9yQqsPWo
         vL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjQbbX91rvnNhlDfTgwfaBNtgngEI5glR7O7U8xJEyo=;
        b=ezP1sN7pYLxd/Jpju0w8pjcD2mJN+41HKmMiT09Uza5SXISVI356k25L9crxtun+jN
         tUm3abnAV3DJr7GOGjFEt05gkbYOjurMop3wa6Cn6ZKzAe4hKhUcALGX8pTxRU1tr6rA
         uwLbvddSV1blxtjNGGh6MtDmjiOhBHkqnrc/uAVJ7rHnmujmT7nHNWtHXY3Yss2cqZms
         +9nrkFB62qCOkujsd9xklNnunOoZrqJ5O2XR44JL+Nsy78sUxvtglKzIR2klw9fJTbjQ
         4XlEiutabmHQXKiieB6R2F39WN8Blwcc8yjbNjlzJmaVWuKxEMgmmIohtq6BuGyyrsm2
         4A0Q==
X-Gm-Message-State: AOAM532BjUpXfEqgLzSoVDpQnezG2ZVXacGSK6vsqdCbLhaxlg2OgJaF
        VZQGov/4MQi1x6uchRqNNy4=
X-Google-Smtp-Source: ABdhPJw+8PK/stydHq+zPhT/JPDq8RF8MCxCKKZ7i1pkIox3rB1Kwqp3FM7mdjRv/Qt237Pna3LWTw==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr1801879wrt.77.1589939018483;
        Tue, 19 May 2020 18:43:38 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z10sm1493351wmi.2.2020.05.19.18.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:43:38 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 2/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King
Date:   Wed, 20 May 2020 01:43:26 +0000
Message-Id: <20200520014329.12469-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520014329.12469-1-christianshewitt@gmail.com>
References: <20200520014329.12469-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 47badda69ef5..cd7a081a4f17 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -149,6 +149,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gtking
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

