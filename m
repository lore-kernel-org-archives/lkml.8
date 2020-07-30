Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732BE20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="iyjT2kOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgG3Osy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:48:54 -0400
Received: from crapouillou.net ([89.234.176.41]:35680 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Osx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596120517; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qt3g3tEVpW7ed636/4tctSkOhvgTtF4IyDUbEY1/K24=;
        b=iyjT2kOLlcBMF51VsqjIRvQl4qzXQLULQ97FlzLdnj4Xc7sjsxYrccGYbWGIsYp689mmwi
        ayjn9IJx1ssEL6eBL3mz6GnsuLdYSCDnr2pWs7VphhSiSDopBF/8my7PAfHbrAZCS3m0+a
        nCqyg175MIoL8OnbUhjLrsvyAJZ0LnA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] drm/ingenic: ipu: Remove YUV422 from supported formats on JZ4725B
Date:   Thu, 30 Jul 2020 16:48:29 +0200
Message-Id: <20200730144830.10479-3-paul@crapouillou.net>
In-Reply-To: <20200730144830.10479-1-paul@crapouillou.net>
References: <20200730144830.10479-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configuring the IPU for packed YUV 4:2:2, depending on the scaling
ratios given by the source and destination resolutions, it is possible
to crash the IPU block, to the point where a software reset of the IP
does not fix it. This can happen anytime, in the first few frames, or
after dozens of minutes. The same crash also happens when the IPU is
fully controlled by the LCD controller (in that case no HW register is
written at any moment after startup), which points towards a hardware
bug.

Thanksfully multiplanar YUV is not affected.

Until this bug is fixed or worked around, address this issue by removing
support for YUV 4:2:2 on the IPU of the JZ4725B.

v2: Update commit message (remove the "crash beyond repair" bit)

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-ipu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 7eae56fa92ea..7dd2a6ae4994 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -795,10 +795,16 @@ static int ingenic_ipu_remove(struct platform_device *pdev)
 }
 
 static const u32 jz4725b_ipu_formats[] = {
+	/*
+	 * While officially supported, packed YUV 4:2:2 formats can cause
+	 * random hardware crashes on JZ4725B under certain circumstances.
+	 * It seems to happen with some specific resize ratios.
+	 * Until a proper workaround or fix is found, disable these formats.
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YVYU,
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
+	*/
 	DRM_FORMAT_YUV411,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
-- 
2.27.0

