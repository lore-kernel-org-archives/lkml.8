Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3994C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89183206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG8ozdPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgIDNGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgIDNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:06:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997FEC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:06:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so6731612wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=E9G/uEXRmNdCZf+xjqHOCF0OHoHgJrExnYXekXh18dQ=;
        b=DG8ozdPssbxATQ9WJd35Z9K3V8uEpQMDgQuro20wVwXg8IdJ2bfSseQ5Cn+/hqgsMU
         TEI6MIPtxAWk344mWNkvg0lRjxOZ7t278YfZ9VKTElYBgR6kckoL8B/RS8PBSiKsgZ4w
         CrwYhVW4Zy/gpm8odZHtkf2EpGMzednQnohupkqw+a5xLNFjnBMyLxcF0IC+0wWRrnhs
         6wS5PZe5UG4i7+B3foyVPfMOOaQZ5WOwkmE7dT7kA5eLmQEIcefge7MwM8P3pLO3601j
         iWwv2VnDXawOFx4+tcAhhmgL/RsXmY3fJ7gYV0DpvyeeYAuclIKb8KqAyinlIOiswMSc
         yjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E9G/uEXRmNdCZf+xjqHOCF0OHoHgJrExnYXekXh18dQ=;
        b=lgcYAl+N74S6srCOSXGv32soRNJr6WTLpB8jByOkc3J19Fi4MzZAieO7kemQ4an9HQ
         1Kff9EZ5EfiWE9XHGEogrESMOCLPOJASnD5suNgjHZUfiLqSprI4OaVNgf4sow+uX8yQ
         tss1ekZnvcFUHUw5Exc5ymmk7ZlScQX4+39BDAXXxbz6Ft9QX/+QLCtuvBkNmWy3apiE
         oxPTU6zTz4UrJstOx906zR59Stq+kGkBUzxtFrvZkYkaUv2sbJmDKvNY1tOwl/UWBCTy
         xYXpXmLhLYOdM7zJX5TOg62JpOw0p2jJCsk/gLVcyUXunyJETDBD6jf/uHN13+OlmUO/
         jsTQ==
X-Gm-Message-State: AOAM531KijoQURYJxgFuoaUapFq7nW+/DHwZ1G4h3l/ZpEuLFWc84O0D
        mkFEsq7Y9M6EBQDF7TXI0Dc=
X-Google-Smtp-Source: ABdhPJxBo2YRoEMAGlF/dNKtG7Kr6QHVTHVLDM5g9dnKAeh1mu2DJSneo7DAt5CcOF3Nyna8A87yTg==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr7890912wrj.92.1599224772308;
        Fri, 04 Sep 2020 06:06:12 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id e18sm13176384wra.36.2020.09.04.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:06:11 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:06:05 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add entry for VKMS
Message-ID: <20200904130605.vs5tnfhgnemnz6pt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of VKMS driver

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01fb9ee6b951..d4277824a01c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5640,6 +5640,7 @@ F:	drivers/gpu/drm/udl/
 
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
+M:	Melissa Wen <melissa.srw@gmail.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
 R:	Daniel Vetter <daniel@ffwll.ch>
 L:	dri-devel@lists.freedesktop.org
-- 
2.28.0

