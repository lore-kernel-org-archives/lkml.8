Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F8BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6512020706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fqx8dSb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgDXMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgDXMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:44:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C49C09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:44:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so10562986wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOdCgu/2Jy1tRi9zrYa6LH0k7m/VVjyha5EYFTG8NAo=;
        b=Fqx8dSb4SMac40DSvMTs7OdAWMYlayXuzLjkXiSvM/Hffc5WJknmgmnXLrrTHKpn2X
         0LkAKofMeSpQHMPvFNZSJ1Muv0cvJEXfsrkTjZ8le0kNVd10v/kh0p0mGsoPn/Sd01EK
         BE4vRSTePinMwUD/eZb/gMQ9AqXloYjTlbrsEFUpRzRz+z56zW9PSXgllsk4vUpjv9J0
         2PgpgaEiqX/z+UR0BmAH9WVGA5kwS3s3kxg1mBDXq6nkX+IFlROXk79HQnmAlz300v/j
         QxJCl5BQ9xbhC1Rh/MZKGylXN4Uj5ZrtMbxDzoDbay3FocxYJ1jarsL12w114sDejED0
         CeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOdCgu/2Jy1tRi9zrYa6LH0k7m/VVjyha5EYFTG8NAo=;
        b=DhFVuUdezc3M8wvHV4R/PBrh6XtMPlqL14O2hB8aNOaV4xJmA3Gt4A0ejmlqDjbxDt
         QRU+lOQkzh5H7fW7q+2Jg5h5nJHbqPnIGEKihda0RvDek35UTMT9PbKShCyQEkSqGvUG
         356Xlf4CsgOw1kP1xFd1Rg4n5TrU87ZF5bu6Xh7Q07y7O3tmR0iWqPLAxRvmaXOj10IB
         bKdGsB/qIhALHsza1/FFUBymGvPN/NhyRZDT4DO0eWkuDsWxeb+dlOt5CszFiHn7Ejd5
         uybnEQtPazFcIkXrqna36abJEnA2ghXjmU7lvdJJ+DADZxnvhV7qGxqarVGqHvTjgHoG
         XanA==
X-Gm-Message-State: AGi0PuarT1toLVAiJkCreTXBLYwfeCOt+gVtDfsPBFlTUEv7gGzkXdNu
        77vIo/dU/Ia4mEcjZCGHwWTBWg==
X-Google-Smtp-Source: APiQypI4uWmGIsxURAuSlISBDYaM7+FkzOgegq+RzXjv0ah8X7qTCaEjsrJvykKg8cNJ2UGbrdaBFA==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr9777439wme.58.1587732253434;
        Fri, 24 Apr 2020 05:44:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id q184sm2692689wma.25.2020.04.24.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 05:44:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add odroid-c4 bindings
Date:   Fri, 24 Apr 2020 14:44:05 +0200
Message-Id: <20200424124406.13870-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200424124406.13870-1-narmstrong@baylibre.com>
References: <20200424124406.13870-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the Hardkernel Odroid-C4 single board computer.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba48cec1..11908b151e0a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -159,6 +159,7 @@ properties:
           - enum:
               - seirobotics,sei610
               - khadas,vim3l
+              - hardkernel,odroid-c4
           - const: amlogic,sm1
 
       - description: Boards with the Amlogic Meson A1 A113L SoC
-- 
2.22.0

