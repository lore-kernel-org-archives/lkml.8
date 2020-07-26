Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A7C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DF12053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YbtqbfsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGZEkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgGZEkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8CC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so7359276pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtjntBHs78gBBvXpncjh6tZl4Yv5U3MI9ZEGI0tw2Go=;
        b=YbtqbfsYYx3YQB8DjT3rSPrPxS1GMWDTkWQKIsOyZErTNno+XE2gPxqmitg/p58trr
         5XNWdXtP1M3Xe8RxoIZjrStbig8OjmCnxzPjmrwmFJhToUl23JwPvLz9/lHGMMCH32aD
         ncBnF4wjLRKlWioazT9PJdirI/QuqIwX/qufY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtjntBHs78gBBvXpncjh6tZl4Yv5U3MI9ZEGI0tw2Go=;
        b=A73AFEu5YmGy1ZxOX/FmSk+IN2Ik+5eMM6cmNJ8H4guxMaEQrc6/mRoHN1tGarAPb5
         Gl6pMFWb2tuaI6y4423Bv2fBkQR4ckcONwu4dwavN2dJW9NgxUz7bUkmpzaDq7WisUn1
         fiNgh1TvaLKCuDk9Xa7gg1/QY3jUY0n8v+5rghaS6zvm67JyPma6/E4Jjpk6MVdf4Y+J
         CvhJ4kdWyy/dVAolB3nGMAI6Vb2Dg21m0QSSAXRZ11cKGrDRW327XAz3o/p5cNo/VgkM
         kk8lDyC47HdJ3P3ac5Qdg4nT8eYeb6gxussB/fgDJI1irg+FZfJNrvxRstIUqSWCtgpx
         1S6Q==
X-Gm-Message-State: AOAM532hoPEDgZPE9mANjS4q6flD+xnQ0Nq9sYqtJAGsACWbgxpGThVN
        DMB7Z7+DphAujjQP0BIR6dxtrw==
X-Google-Smtp-Source: ABdhPJyGXFfEbk1Up0QL8oQbe+ycIHVfA3VLtaxuSUcbU05RUoGvG8/6nx8ComJuhhjWwmDLxJYwBQ==
X-Received: by 2002:a17:90a:2170:: with SMTP id a103mr5214636pje.198.1595738410839;
        Sat, 25 Jul 2020 21:40:10 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:10 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 6/7] ARM:mstar: Add syscon node for "pmsleep" area
Date:   Sun, 26 Jul 2020 13:39:47 +0900
Message-Id: <20200726043948.1357573-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MStar v7 SoCs contain a region of registers that are in the always on
domain that the vendor code calls the "pmsleep" area.

This area contains registers for a broad range of functionality and
needs to be shared between drivers.

This patch adds a syscon node for the pmsleep area so that other
drivers can access registers in the area.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index a73b1d162dfd..c8b192569d05 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -73,6 +73,11 @@ riu: bus@1f000000 {
 			#size-cells = <1>;
 			ranges = <0x0 0x1f000000 0x00400000>;
 
+			pmsleep: syscon@1c00 {
+				compatible = "syscon";
+				reg = <0x1c00 0x100>;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

