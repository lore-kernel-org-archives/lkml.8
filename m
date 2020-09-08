Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378D921D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tCb7Xyjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgIHHyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgIHHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:54:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451FC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:54:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so16161616wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=un3Gh2gweDlAUsvqGdAT6fJ9irEjsQvOrf4xpheQKFc=;
        b=tCb7Xyjyf1pbyOxpVBg4F0iVcyXBpfcmtbaHZdYb60cttT+CeyHT6RB+AwUBtq2Vf1
         RdYIVREjuQImrCPeIQahoOFtc6cSUYC2q20fncg2NMlKVTVhbJ4mPXkydSj7AOgcC49n
         U7YPR9aFYv9Csqy6oOmfqK+ps590dJ8SsHDVA3QfK/8O41Zr0MK4lVvfsFSmAH6d4Kdm
         uRdElAGxaVHyKlgDX3xN/3jx0DV1HvK/dMAVAm/TKIdx4+1lgk+oHix0dZMGJ+z8TdPt
         rNpdfI0UJLbU6FJ7OcMjjAz5FCC5Ew5b1m8/tX1RLMRlfWSCIzhcj1wQhnHzLmaSTRsJ
         hW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=un3Gh2gweDlAUsvqGdAT6fJ9irEjsQvOrf4xpheQKFc=;
        b=eFWEZsIH5E5dKgDO+TqUHmDNlPdc811Kz+inNJA3fs/tVdTqRfe+YzCvR3qD2FwtU9
         Fboq/IvLB+0SruF2rl0G5wwfnoFDFH+N7mviRewlIUGET4JbvlwH3TZKTB0mQ6/rjZFb
         NVPcI9xOXwVuDbvf/1/JGncuyyciq3LHWd0jHhKM5mM3cyu+ybBOhSQC1U4/qb8PK3qA
         rW1aoYZ99tafZTbpgRTOuAWsKKyExCcgA8/KUsewPApvnegysSMYVRYNUDqHb+nHnema
         VLWnZhE9DrxNRs5e9/P1Jq4XopOAKlExbJ8Q/9rG/EkTgpoL3GF9k5VHSDtvqFmvpzM3
         mT5w==
X-Gm-Message-State: AOAM530mv3lLPAw1BBfD/IoK1VSThbyaaaeg/uBYEBEaaHULaPLijdDT
        nNUEaacCD2LZkZQ6QIIPQiLqEA==
X-Google-Smtp-Source: ABdhPJy8k9dRtwiSz7EuBFI6BBdW9mwejGQ/bhYXctxJ64XJ3GDkHhArqskhdpzLqbmeozv+wzk4Eg==
X-Received: by 2002:a1c:a90a:: with SMTP id s10mr3027307wme.11.1599551670992;
        Tue, 08 Sep 2020 00:54:30 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id f14sm33788291wrv.72.2020.09.08.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:54:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 3/4] dt-bindings: display: panel-simple-dsi: add TDO TL070WSH30 DSI panel bindings
Date:   Tue,  8 Sep 2020 09:54:20 +0200
Message-Id: <20200908075421.17344-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908075421.17344-1-narmstrong@baylibre.com>
References: <20200908075421.17344-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the 1024x600 TFT LCD TL070WSH30 DSI panel to panel-simple-dsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 4d08e746cb21..a29ab65507f0 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -47,6 +47,8 @@ properties:
       - panasonic,vvx10f004b00
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
+        # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
+      - tdo,tl070wsh30
 
   reg:
     maxItems: 1
-- 
2.22.0

