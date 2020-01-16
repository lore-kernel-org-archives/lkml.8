Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606BC33CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28882208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lfdA8L3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAPOJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:09:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50650 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAPOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:09:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116140917euoutp0168760db240785a387da69e47a18c7910~qY0Kyjeo50568405684euoutp01F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:09:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116140917euoutp0168760db240785a387da69e47a18c7910~qY0Kyjeo50568405684euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579183757;
        bh=hpgw6xnVEWj+E/Pyg9EDeM6sLEMaetg0XhqQOF1Ravk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfdA8L3MqjAn4KlFojNgxkuF8+x8Tj2lV+V6c0kCjeoNxWre96swmsCDz7OR0OV4I
         N+kYYUEtV/eX3SC+0uBfmGGDeZYdTcRbKNyWp6USm9JXJt4icibyBrp/Rmy5rQt/QA
         In/tuWfxTwnhHNVgdMr5wlzH9L9q8wct/6T5powQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116140917eucas1p1d640595b59ab2a8f67765c3873bc61bf~qY0KczGcV1322413224eucas1p1O;
        Thu, 16 Jan 2020 14:09:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8D.FD.60679.C8E602E5; Thu, 16
        Jan 2020 14:09:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3~qY0KCTod32425224252eucas1p27;
        Thu, 16 Jan 2020 14:09:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200116140916eusmtrp2bf28e8ece2286e3860f47641f36a9439~qY0KBtxrl0965509655eusmtrp2H;
        Thu, 16 Jan 2020 14:09:16 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-51-5e206e8c3e51
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.FF.08375.C8E602E5; Thu, 16
        Jan 2020 14:09:16 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116140916eusmtip139c44590ab708c090249338a68ceb2be~qY0Jt7Ymx0711307113eusmtip1C;
        Thu, 16 Jan 2020 14:09:16 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>, b.zolnierkie@samsung.com
Subject: [PATCH 6/6] video: fbdev: controlfb: remove function prototypes
 part #3
Date:   Thu, 16 Jan 2020 15:09:00 +0100
Message-Id: <20200116140900.26363-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd3ePIU4g/Z+Zotb686xWmycsZ7V
        4srX92wWJ/o+sFpc3jWHzYHV4373cSaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgypgx3afg
        n3vFkr9PGRsYf1p2MXJwSAiYSGw8EdfFyMUhJLCCUaJhzldmCOcLo8Sb+5tZIJzPjBLbZzcC
        OZxgHRNnv4ZKLGeUOHKggw2u5XTzAXaQKjYBK4mJ7asYQWwRgQSJFdNnMILsYxZwlGju5wMx
        hQWCJHrPR4JUsAioSnyf0M0GYvMK2Er8+76JHWKXvMTWb59YQWxOATuJeafuMULUCEqcnPkE
        7B5moJrmrbPBrpYQ+MwmcXPJdahDXST+H9sHNUhY4tXxLVC2jMT/nfOZIBrWMUr87XgB1b2d
        UWL55H9sEFXWEnfO/WKDOFpTYv0ufYiwo8T0pcfYIGHHJ3HjrSDEEXwSk7ZNZ4YI80p0tAlB
        VKtJbFi2gQ1mbdfOlcwQtodET8sktgmMirOQvDMLyTuzEPYuYGRexSieWlqcm55abJSXWq5X
        nJhbXJqXrpecn7uJEZg+Tv87/mUH464/SYcYBTgYlXh4ZwQpxAmxJpYVV+YeYpTgYFYS4T05
        QzZOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkbtovI3
        0neCV4g2XCqr81pmMfeHT3jjE9n236VRy77P5ov1DGpl61v7kSFXc/PbGzn9LoJ++tGrsu9M
        Nt1Z5iHy7MH+5aKLNq3ddeZ4RrfD78NK2fG/D0T82fHXoMBOoK1u9eJ7LM1d+fadDl2My3O2
        sx67vuuyXKsqh8yJsxcm8T3mz7pjaKjEUpyRaKjFXFScCAC2vAG8GwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xu7o9eQpxBge+K1vcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaM6T4F/9wrlvx9ytjA+NOyi5GTQ0LA
        RGLi7NcsXYxcHEICSxklJp48xtTFyAGUkJE4vr4MokZY4s+1LjaImk+MEsdvtbGDJNgErCQm
        tq9iBLFFBJIkOhtOMoPYzALOErNuPWICsYUFAiQutHWzgdgsAqoS3ydA2LwCthL/vm9ih1gg
        L7H12ydWEJtTwE5i3ql7jCA3CAHVHJomBVEuKHFy5hMWiPHyEs1bZzNPYBSYhSQ1C0lqASPT
        KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAw33bs5+YdjJc2Bh9iFOBgVOLhnRGkECfEmlhW
        XJl7iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTiQ4ymQD9MZJYSTc4HxmBeSbyhqaG5haWh
        ubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGL71Tl2Qjsmy1N1VtszHe8Kjy6smZ
        M4LYp0uuY4x453wp5fuvwP2CHdzJd+5urfU/c+xe6qLEzdJlMv0PFx0pKniS0/PphcK9hEqG
        A/Y5GuE3y5r9P5vrzhK3ivp9w7741kbO6x/0V/zdcNV+yYxPLFzaEb/XmMxQjf8/I8x6Ye+/
        pZzdvE6zlViKMxINtZiLihMBmJZlOYkCAAA=
X-CMS-MailID: 20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3
References: <20200116140900.26363-1-b.zolnierkie@samsung.com>
        <CGME20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder code a bit and then remove no longer needed function
prototypes.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 306 +++++++++++++++-----------------
 1 file changed, 147 insertions(+), 159 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 4012ecf72d47..e71192ee5650 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -129,16 +129,6 @@ struct fb_info_control {
 #define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs->REG).r))
 
 
-/******************** Prototypes for internal functions **********************/
-
-static void control_set_hardware(struct fb_info_control *p,
-	struct fb_par_control *par);
-static int control_var_to_par(struct fb_var_screeninfo *var,
-	struct fb_par_control *par, const struct fb_info *fb_info);
-static inline void control_par_to_var(struct fb_par_control *par,
-	struct fb_var_screeninfo *var);
-
-
 /************************** Internal variables *******************************/
 
 static struct fb_info_control *control_fb;
@@ -147,155 +137,6 @@ static int default_vmode __initdata = VMODE_NVRAM;
 static int default_cmode __initdata = CMODE_NVRAM;
 
 
-/********************  The functions for controlfb_ops ********************/
-
-/*
- * Checks a var structure
- */
-static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	struct fb_par_control par;
-	int err;
-
-	err = control_var_to_par(var, &par, info);
-	if (err)
-		return err;	
-	control_par_to_var(&par, var);
-
-	return 0;
-}
-
-/*
- * Applies current var to display
- */
-static int controlfb_set_par (struct fb_info *info)
-{
-	struct fb_info_control *p =
-		container_of(info, struct fb_info_control, info);
-	struct fb_par_control par;
-	int err;
-
-	if((err = control_var_to_par(&info->var, &par, info))) {
-		printk (KERN_ERR "controlfb_set_par: error calling"
-				 " control_var_to_par: %d.\n", err);
-		return err;
-	}
-	
-	control_set_hardware(p, &par);
-
-	info->fix.visual = (p->par.cmode == CMODE_8) ?
-		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-	info->fix.line_length = p->par.pitch;
-	info->fix.xpanstep = 32 >> p->par.cmode;
-	info->fix.ypanstep = 1;
-
-	return 0;
-}
-
-/*
- * Set screen start address according to var offset values
- */
-static inline void set_screen_start(int xoffset, int yoffset,
-	struct fb_info_control *p)
-{
-	struct fb_par_control *par = &p->par;
-
-	par->xoffset = xoffset;
-	par->yoffset = yoffset;
-	out_le32(CNTRL_REG(p,start_addr),
-		 par->yoffset * par->pitch + (par->xoffset << par->cmode));
-}
-
-
-static int controlfb_pan_display(struct fb_var_screeninfo *var,
-				 struct fb_info *info)
-{
-	unsigned int xoffset, hstep;
-	struct fb_info_control *p =
-		container_of(info, struct fb_info_control, info);
-	struct fb_par_control *par = &p->par;
-
-	/*
-	 * make sure start addr will be 32-byte aligned
-	 */
-	hstep = 0x1f >> par->cmode;
-	xoffset = (var->xoffset + hstep) & ~hstep;
-
-	if (xoffset+par->xres > par->vxres ||
-	    var->yoffset+par->yres > par->vyres)
-		return -EINVAL;
-
-	set_screen_start(xoffset, var->yoffset, p);
-
-	return 0;
-}
-
-
-/*
- * Private mmap since we want to have a different caching on the framebuffer
- * for controlfb.
- * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
- */
-static int controlfb_mmap(struct fb_info *info,
-                       struct vm_area_struct *vma)
-{
-	unsigned long mmio_pgoff;
-	unsigned long start;
-	u32 len;
-
-	start = info->fix.smem_start;
-	len = info->fix.smem_len;
-	mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
-	if (vma->vm_pgoff >= mmio_pgoff) {
-		if (info->var.accel_flags)
-			return -EINVAL;
-		vma->vm_pgoff -= mmio_pgoff;
-		start = info->fix.mmio_start;
-		len = info->fix.mmio_len;
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	} else {
-		/* framebuffer */
-#ifdef CONFIG_PPC_PMAC
-		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
-#endif
-	}
-
-	return vm_iomap_memory(vma, start, len);
-}
-
-static int controlfb_blank(int blank_mode, struct fb_info *info)
-{
-	struct fb_info_control *p =
-		container_of(info, struct fb_info_control, info);
-	unsigned ctrl;
-
-	ctrl = le32_to_cpup((const __force __le32 *)CNTRL_REG(p, ctrl));
-	if (blank_mode > 0)
-		switch (blank_mode) {
-		case FB_BLANK_VSYNC_SUSPEND:
-			ctrl &= ~3;
-			break;
-		case FB_BLANK_HSYNC_SUSPEND:
-			ctrl &= ~0x30;
-			break;
-		case FB_BLANK_POWERDOWN:
-			ctrl &= ~0x33;
-			/* fall through */
-		case FB_BLANK_NORMAL:
-			ctrl |= 0x400;
-			break;
-		default:
-			break;
-		}
-	else {
-		ctrl &= ~0x400;
-		ctrl |= 0x33;
-	}
-	out_le32(CNTRL_REG(p,ctrl), ctrl);
-
-	return 0;
-}
-
 static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info)
 {
@@ -352,6 +193,20 @@ static void set_control_clock(unsigned char *params)
 #endif	
 }
 
+/*
+ * Set screen start address according to var offset values
+ */
+static inline void set_screen_start(int xoffset, int yoffset,
+	struct fb_info_control *p)
+{
+	struct fb_par_control *par = &p->par;
+
+	par->xoffset = xoffset;
+	par->yoffset = yoffset;
+	out_le32(CNTRL_REG(p,start_addr),
+		 par->yoffset * par->pitch + (par->xoffset << par->cmode));
+}
+
 #define RADACAL_WRITE(a,d) \
 	out_8(&p->cmap_regs->addr, (a)); \
 	out_8(&p->cmap_regs->dat,   (d))
@@ -774,6 +629,139 @@ static inline void control_par_to_var(struct fb_par_control *par,
 	var->pixclock >>= par->regvals.clock_params[2];
 }
 
+/********************  The functions for controlfb_ops ********************/
+
+/*
+ * Checks a var structure
+ */
+static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct fb_par_control par;
+	int err;
+
+	err = control_var_to_par(var, &par, info);
+	if (err)
+		return err;	
+	control_par_to_var(&par, var);
+
+	return 0;
+}
+
+/*
+ * Applies current var to display
+ */
+static int controlfb_set_par (struct fb_info *info)
+{
+	struct fb_info_control *p =
+		container_of(info, struct fb_info_control, info);
+	struct fb_par_control par;
+	int err;
+
+	if((err = control_var_to_par(&info->var, &par, info))) {
+		printk (KERN_ERR "controlfb_set_par: error calling"
+				 " control_var_to_par: %d.\n", err);
+		return err;
+	}
+	
+	control_set_hardware(p, &par);
+
+	info->fix.visual = (p->par.cmode == CMODE_8) ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+	info->fix.line_length = p->par.pitch;
+	info->fix.xpanstep = 32 >> p->par.cmode;
+	info->fix.ypanstep = 1;
+
+	return 0;
+}
+
+static int controlfb_pan_display(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
+{
+	unsigned int xoffset, hstep;
+	struct fb_info_control *p =
+		container_of(info, struct fb_info_control, info);
+	struct fb_par_control *par = &p->par;
+
+	/*
+	 * make sure start addr will be 32-byte aligned
+	 */
+	hstep = 0x1f >> par->cmode;
+	xoffset = (var->xoffset + hstep) & ~hstep;
+
+	if (xoffset+par->xres > par->vxres ||
+	    var->yoffset+par->yres > par->vyres)
+		return -EINVAL;
+
+	set_screen_start(xoffset, var->yoffset, p);
+
+	return 0;
+}
+
+static int controlfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct fb_info_control *p =
+		container_of(info, struct fb_info_control, info);
+	unsigned ctrl;
+
+	ctrl = le32_to_cpup((const __force __le32 *)CNTRL_REG(p, ctrl));
+	if (blank_mode > 0)
+		switch (blank_mode) {
+		case FB_BLANK_VSYNC_SUSPEND:
+			ctrl &= ~3;
+			break;
+		case FB_BLANK_HSYNC_SUSPEND:
+			ctrl &= ~0x30;
+			break;
+		case FB_BLANK_POWERDOWN:
+			ctrl &= ~0x33;
+			/* fall through */
+		case FB_BLANK_NORMAL:
+			ctrl |= 0x400;
+			break;
+		default:
+			break;
+		}
+	else {
+		ctrl &= ~0x400;
+		ctrl |= 0x33;
+	}
+	out_le32(CNTRL_REG(p,ctrl), ctrl);
+
+	return 0;
+}
+
+/*
+ * Private mmap since we want to have a different caching on the framebuffer
+ * for controlfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int controlfb_mmap(struct fb_info *info,
+                       struct vm_area_struct *vma)
+{
+	unsigned long mmio_pgoff;
+	unsigned long start;
+	u32 len;
+
+	start = info->fix.smem_start;
+	len = info->fix.smem_len;
+	mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
+	if (vma->vm_pgoff >= mmio_pgoff) {
+		if (info->var.accel_flags)
+			return -EINVAL;
+		vma->vm_pgoff -= mmio_pgoff;
+		start = info->fix.mmio_start;
+		len = info->fix.mmio_len;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	} else {
+		/* framebuffer */
+#ifdef CONFIG_PPC_PMAC
+		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
+#endif
+	}
+
+	return vm_iomap_memory(vma, start, len);
+}
+
 static const struct fb_ops controlfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= controlfb_check_var,
-- 
2.24.1

