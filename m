Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBACC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C45207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578997112;
	bh=AsJbEe2drDEZF42+Vj5f9Qd4fzm6cumGTNfq1AhDNew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYOsoDvQ8sxs5eEoNLRjvG9/HR2rJHy5bOLzRY1DyYFBxpIpYrd6dxhy2sYZlFS4R
	 jc5IjuPiHaYiMpZ0QrMG0J56Qw1vFbWZNvO896onh9Q1uCqN/R6ErgUrAUnlIipSxF
	 HeqZJ2yZMfufRe9la/NIMTTg6411JRwLRVWkb9jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgANKHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbgANKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DDA24688;
        Tue, 14 Jan 2020 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996437;
        bh=AsJbEe2drDEZF42+Vj5f9Qd4fzm6cumGTNfq1AhDNew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGLowJhCFfElZyAxojSWkdE6Pgd2wyeICk8MJJ7tAJVL+G2lMV2R2mzKMPsFPWQ3N
         SLW5UKb78+ydoPbfOsX1fnwlpfTtdh8s7yhKnOsLVm4vrFxQ6ordUeZl1WT3mnj9ZC
         BzasPVgyirTIlkxpjEmCsibg7xC2Re53YKCSgK14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 17/46] drm/fb-helper: Round up bits_per_pixel if possible
Date:   Tue, 14 Jan 2020 11:01:34 +0100
Message-Id: <20200114094344.042402634@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f30e27779d3031a092c2a177b7fb76adccc45241 upstream.

When userspace requests a video mode parameter value that is not
supported, frame buffer device drivers should round it up to a supported
value, if possible, instead of just rejecting it.  This allows
applications to quickly scan for supported video modes.

Currently this rule is not followed for the number of bits per pixel,
causing e.g. "fbset -depth N" to fail, if N is smaller than the current
number of bits per pixel.

Fix this by returning an error only if bits per pixel is too large, and
setting it to the current value otherwise.

See also Documentation/fb/framebuffer.rst, Section 2 (Programmer's View
of /dev/fb*").

Fixes: 865afb11949e5bf4 ("drm/fb-helper: reject any changes to the fbdev")
Cc: stable@vger.kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20191230132734.4538-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1702,7 +1702,7 @@ int drm_fb_helper_check_var(struct fb_va
 	 * Changes struct fb_var_screeninfo are currently not pushed back
 	 * to KMS, hence fail if different settings are requested.
 	 */
-	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
+	if (var->bits_per_pixel > fb->format->cpp[0] * 8 ||
 	    var->xres > fb->width || var->yres > fb->height ||
 	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
 		DRM_DEBUG("fb requested width/height/bpp can't fit in current fb "
@@ -1728,6 +1728,11 @@ int drm_fb_helper_check_var(struct fb_va
 	}
 
 	/*
+	 * Likewise, bits_per_pixel should be rounded up to a supported value.
+	 */
+	var->bits_per_pixel = fb->format->cpp[0] * 8;
+
+	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
 	 */


