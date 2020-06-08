Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22634C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EB02077D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UAH4VeW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFHBsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgFHBsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:48:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E3C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 18:48:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so15841889qkn.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+d1Eg/67SeROyIrXeX/NcuRKSdM7i+nQ7oJN4CqZ1s=;
        b=UAH4VeW8rcw5ifVzbhD0DAIm3EmtBlTSzdIjL4I3tUMNCd6rB0fHVN/Tcng7OXy/Im
         Igf39lXIWhkgyvfK6zpoYxZeHJ9SCdJ+f8d3by/31azigmWdLCtLGvTDBYcyx8rHCPDu
         5jS/dLex42d2wwtqbMlNX8B0gvlKzm5hNSvqdPjknfhKgf32GJAgLCJolzLhot278uUO
         NOYi+obqJcXHL6zWcPYKXYqTy4Jov9QFB1Zie2De44J2c4GaRa+XLY6a220Zff0kA0BO
         s5OGDXB3WVZmUVCRNZyBV0m+GVxHUC8TEXA+qs7zf0m5oqqoLjNbzFAB9wDZmxxdWSBv
         60aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+d1Eg/67SeROyIrXeX/NcuRKSdM7i+nQ7oJN4CqZ1s=;
        b=UFyBG71iuvzntiINaptQFDWudxADmrSsE/MFvr7Mrsw4lGbw044yDB9quCzSzPdGZ7
         yU4gBB3AAngvTpUkN+pRTpk3syVUQcsgcmLg2uUPgU0McmBrJOybQvp5GK6473KrGZ1g
         vJ+Za9ZHlSUMgzLl1iBEP+fX3qp6yXhFU8sruky628rENvmYmWFOXoXi4tm0wnBMa1nQ
         T729vpvXKKn97rqBJxdVmYobCZNtAqIixHDOwY7rggV9h3nMnDS8KyVvFKx/xPks1LPE
         fQ3+0LWLSthLczGzvnr9Ar8NhS3vE5Plhq7lXKw6VMUvPISQenpXxUWVntM5U7iWt3XM
         N0ow==
X-Gm-Message-State: AOAM531Kki3q7EvRTuWeCLSzFlJors10fafWTqv+/ISwPBB71NXvD7az
        sncmtSd/TydBD6kyD6Hg/YribA==
X-Google-Smtp-Source: ABdhPJxXcwD2HMq3mQYT+qLBtgZad05Y4KCfdKEMeIYCHdA/aBMZUtrEsncE5ONgoG1uUECyN+C8vg==
X-Received: by 2002:a37:a801:: with SMTP id r1mr21062926qke.174.1591580917048;
        Sun, 07 Jun 2020 18:48:37 -0700 (PDT)
Received: from ovpn-112-81.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f30sm6423106qtb.9.2020.06.07.18.48.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 18:48:36 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Date:   Sun,  7 Jun 2020 21:48:18 -0400
Message-Id: <20200608014818.2814-1-cai@lca.pw>
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

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/rcar-du/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 0919f1f159a4..d80696455d3e 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -48,3 +48,4 @@ config DRM_RCAR_VSP
 config DRM_RCAR_WRITEBACK
 	bool
 	default y if ARM64
+	depends on DRM
-- 
2.21.0 (Apple Git-122.2)

