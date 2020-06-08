Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD52075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lUwQr79n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgFHCyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHCyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:54:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003FC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 19:54:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c14so15912979qka.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWLNoW8KwtbFLEoTy9JRXC4yS5h7+K+nZ8ogvjRFT10=;
        b=lUwQr79nu0C3CUTx5rkUX1JM2BAtkwxCfNCE3s1x0fNiY1Ai8Oup/EwKIwZl7tFBk8
         imyo6wV2crCPek4sz6POKBBuGTzfNEAnIioM82j5x4sKLb3jTEzrt8WisrFNH9ljoReg
         sntjJM3Xr0qK2z6azZds/Oyt6hOeL0uCARX6/gmI+KgCo7d/BMeJYZjJj8JyyDWuQbw8
         VPuDpLRZpKoNqW3h+sWnPEWNx0xnRrQ/2bkq6QHe+Y8d820PmLmcGuxc0/+H2JE3LkG5
         zUYikng65h8Uj7adKCb3tyN4hs4V7MlP6HyJT9go5Tnx4My3H24EVbJIUHBq4oZlwfaP
         byPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWLNoW8KwtbFLEoTy9JRXC4yS5h7+K+nZ8ogvjRFT10=;
        b=ZVMeyvIKrusx/uCefD93LLMbFeXFg4ereazfcDwufGQdLtCGSvgBsxmhOFlc38AdNX
         pbuxhaQv9RnDEG9BaE+u6USHT5fqAsqFaP82Tct4U+ic3PgU8prmZualhgK/bzaarCcx
         jOPSAW5omEGV0Shr2x6wNN6hWqXt1Jmk3AHC9p457A7c3o1/XIawWKCXZJvazfKL4flQ
         gW3Oei2UW0NaDWVjgR2Yb5Tktotem7ec1qtQnSZXYWBMAXOs74h8b29Xx7mU2RNQ83en
         aA0uWwVtrOsZCW7BV7B38NBTgGXB0NUIXVhUwv11eE3ycns2cRBZOuxSklQKH/skjUtl
         mZcw==
X-Gm-Message-State: AOAM531NxyrtK3Q1OmTDEtn9N0B1bjipg0lfSSrYXBJ6CcQyI8rWPXbg
        kmPuwytSPGF5j1n+YTM30pT2jA==
X-Google-Smtp-Source: ABdhPJyGzJC7FOghKl0SH2kp3RlUIH1JilMo/46+zxMu50q5mqLmutt+XqNuAc3oTVPvFZkULek9Ag==
X-Received: by 2002:a05:620a:1407:: with SMTP id d7mr19353966qkj.89.1591584849407;
        Sun, 07 Jun 2020 19:54:09 -0700 (PDT)
Received: from ovpn-112-81.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x13sm6095629qkj.36.2020.06.07.19.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 19:54:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Date:   Sun,  7 Jun 2020 22:53:40 -0400
Message-Id: <20200608025340.3050-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to select DRM_RCAR_WRITEBACK if DRM=n which just make
the generated .config a bit ugly.

 # ARM devices
 #
 # end of ARM devices

 CONFIG_DRM_RCAR_WRITEBACK=y

 #
 # Frame buffer Devices

Let DRM_RCAR_WRITEBACK depend on DRM_RCAR_DU instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/rcar-du/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 0919f1f159a4..3304b41f5611 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -48,3 +48,4 @@ config DRM_RCAR_VSP
 config DRM_RCAR_WRITEBACK
 	bool
 	default y if ARM64
+	depends on DRM_RCAR_DU
-- 
2.21.0 (Apple Git-122.2)

