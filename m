Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBAC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BFD20729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mSQz1x2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBPP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:58:48 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46088 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgBPP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581868716; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWPKAL7VcHZ83Yyg4q/gc+lgP9ejC9vw1JF+fldF7vg=;
        b=mSQz1x2zNZR9tW3vDl2l/CW/QWQGhWT9kP0iAPvo5LjtrZkvO4BOzyIgyisyq4csCYqTFW
        fyEC600I1QLJQ+TUIElJEFv3ty6gXotRMGKPGBZZeOXAa6jm6ROwnNgyt8JuSzKT9BL9v7
        gFbEK+iRhmRsTxEoZDeJnjVzNV4lZyw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] gpu/drm: ingenic: Add option to mmap GEM buffers cached
Date:   Sun, 16 Feb 2020 12:58:11 -0300
Message-Id: <20200216155811.68463-3-paul@crapouillou.net>
In-Reply-To: <20200216155811.68463-1-paul@crapouillou.net>
References: <20200216155811.68463-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingenic SoCs are most notably used in cheap chinese handheld gaming
consoles. There, the games and applications generally render in software
directly in the emulated framebuffer using SDL1.

Since the emulated framebuffer is mapped as write-combine by default,
these applications start to run really slow as soon as alpha-blending is
used.

Add a 'cached_gem_buffers' option to the ingenic-drm driver to mmap the
GEM buffers as fully cached to address this issue.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 41 +++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 9aa88fabbd2a..31f0346b55f0 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -30,6 +31,11 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+static bool ingenic_drm_cached_gem_buf;
+module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf, bool, 0400);
+MODULE_PARM_DESC(cached_gem_buffers,
+		 "Enable fully cached GEM buffers [default=false]");
+
 #define JZ_REG_LCD_CFG				0x00
 #define JZ_REG_LCD_VSYNC			0x04
 #define JZ_REG_LCD_HSYNC			0x08
@@ -378,16 +384,25 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 	struct ingenic_drm *priv = drm_plane_get_priv(plane);
 	struct drm_plane_state *state = plane->state;
 	unsigned int width, height, cpp;
+	unsigned long virt_addr;
 	dma_addr_t addr;
+	uint32_t len;
 
 	if (state && state->fb) {
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
+
 		width = state->src_w >> 16;
 		height = state->src_h >> 16;
 		cpp = state->fb->format->cpp[plane->index];
+		len = width * height * cpp;
+
+		if (ingenic_drm_cached_gem_buf) {
+			virt_addr = (unsigned long)phys_to_virt(addr);
+			dma_cache_wback_inv(virt_addr, len);
+		}
 
 		priv->dma_hwdesc->addr = addr;
-		priv->dma_hwdesc->cmd = width * height * cpp / 4;
+		priv->dma_hwdesc->cmd = len / 4;
 		priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
 	}
 }
@@ -533,6 +548,28 @@ static void ingenic_drm_disable_vblank(struct drm_crtc *crtc)
 
 DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
 
+static int ingenic_drm_gem_mmap(struct drm_gem_object *obj,
+				struct vm_area_struct *vma)
+{
+	unsigned long start, off;
+
+	if (!ingenic_drm_cached_gem_buf)
+		return drm_gem_cma_prime_mmap(obj, vma);
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	start = to_drm_gem_cma_obj(obj)->paddr;
+
+	off += start;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
+	pgprot_val(vma->vm_page_prot) |= _CACHE_CACHABLE_NONCOHERENT;
+
+	return io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
 static struct drm_driver ingenic_drm_driver_data = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
 	.name			= "ingenic-drm",
@@ -554,7 +591,7 @@ static struct drm_driver ingenic_drm_driver_data = {
 	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
 	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
 	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	.gem_prime_mmap		= ingenic_drm_gem_mmap,
 
 	.irq_handler		= ingenic_drm_irq_handler,
 	.release		= ingenic_drm_release,
-- 
2.25.0

