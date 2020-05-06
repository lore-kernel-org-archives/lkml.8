Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC9C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA63520661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aetJOg64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEFIHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgEFIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:07:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F351C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:07:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so1043513wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOdCgu/2Jy1tRi9zrYa6LH0k7m/VVjyha5EYFTG8NAo=;
        b=aetJOg64fafwbqr8yYkLGjHl6qzscu85yjX9IHjyMS/h5GpuGUxpoRAUiYs0qqZBi0
         ZDoWMlbT6vYd+OZHgqWo08TI/ZgElBqLEoPr1P8fDk8ybf2Xz0z4d6xf7Je2Cez9n6UX
         kwuHd+/wwRXTGLYKZ1ZxW4HaBaKOBMyOY/2gjmNfKl3ODiz4l6LEVoJasYaHt2QlvVqH
         qIBt6rlgmwptvWBp6ovFpNBRCyGa4rvjEIIhBNiqxNzuUFwWGvUYjr57bHCsW0ztr3re
         m5tXQa6QzSeweTLwmDgtZqT793p7ZQ6cOYcJBClNE3Q33sVQUwWgifH3Kmw46o0p4zM1
         krCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOdCgu/2Jy1tRi9zrYa6LH0k7m/VVjyha5EYFTG8NAo=;
        b=MEQK8fIjOgIW23hEBa7Ew+qM0V/anPOmUeH67imKrkSrisfzwRMTrajhk+G9fZmMB2
         /8aOy2A29v/f0BCfIdn1R5If/a3HwaP1Kz8G7H2SS/YSDagFihzrhWj5521a9KgI/zOT
         38jcCpwCbc14aLIPSMreRSaUIz+gFvSMn7QUmFQwnkfk/+Nx46Q1RX/cQfvA4acJygjJ
         nbMPEt1cnprxs14xdZKmpZvAKJjNhcVkV5bAt3a3m7Qsxsf1BGg1R0MpqKE4NGUszm0a
         lwapwYqhCBMhOn+MuoyiNzbOO4a6SpuzumGLLl8WAa8nVhH5uX8WIUzgKsusMNbrtoD5
         Ytcg==
X-Gm-Message-State: AGi0PuZSQWGr8HvY54C939A4goQ+B+//JSROVdkg2UGbFu7AHUbly4tw
        w/ZzcsSEfO9IcqlWXR9jj6D4Ew==
X-Google-Smtp-Source: APiQypIy9oYBfj3mT0Be+u73kYYCxHD4KaaaPWnaw+q/zH2bB13J5wEk7HAF5mwNCjpdHTIciHNyxg==
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr8748742wrn.66.1588752428801;
        Wed, 06 May 2020 01:07:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id 185sm1872098wmc.32.2020.05.06.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:07:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add odroid-c4 bindings
Date:   Wed,  6 May 2020 10:07:01 +0200
Message-Id: <20200506080702.6645-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200506080702.6645-1-narmstrong@baylibre.com>
References: <20200506080702.6645-1-narmstrong@baylibre.com>
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

