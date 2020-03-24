Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FACC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED62073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pAhzSjH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgCXNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:45:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35989 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgCXNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:45:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200324134521euoutp026863d9a96087bcf4c3490aa417801014~-QWrZ2m9l3077430774euoutp02o
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:45:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200324134521euoutp026863d9a96087bcf4c3490aa417801014~-QWrZ2m9l3077430774euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585057521;
        bh=y7WDft73AsF/tlQw5Gfp0YnETKJsrlEpFUULaVFBIVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAhzSjH8rf5BMxch3MdGkY1k4jVcoZn/35ePxU487PSFE1NpXS7oj8Fi8EKYwa+Wq
         jlS7SRU6zJXgN7tHgK9L+PgbX2aBCbHON0D4eiDhnkSFWqee/q400HmPRfGJDicjMg
         Zb/SA94UYkwqUic0Cr67pq3tlA/rHSrYoNNk9zvA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200324134520eucas1p2af62a5e61ebb15d644c96ae3eb6c58d2~-QWrBQsUw3230032300eucas1p2B;
        Tue, 24 Mar 2020 13:45:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0E.08.60698.0FE0A7E5; Tue, 24
        Mar 2020 13:45:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134520eucas1p2d95faa6d58939b45765ebca40d137f71~-QWqr5WhD0264102641eucas1p2F;
        Tue, 24 Mar 2020 13:45:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324134520eusmtrp1afb9d0198278ce147399a04a57e17c82~-QWqrb9CJ2619426194eusmtrp11;
        Tue, 24 Mar 2020 13:45:20 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-68-5e7a0ef0f038
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.E6.08375.0FE0A7E5; Tue, 24
        Mar 2020 13:45:20 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134519eusmtip29e2fdb78cdf5e55bafde3df6cd79646a~-QWqYK3G_3273332733eusmtip2t;
        Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com
Subject: [PATCH v2 6/6] video: fbdev: controlfb: remove function prototypes
 part #3
Date:   Tue, 24 Mar 2020 14:45:08 +0100
Message-Id: <20200324134508.25120-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87of+KriDN5fUbG4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2CxW/NzK6MDmcb/7OJPHkmlX2Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoErY8WPtywFJ90rdh05ydLAeNayi5GTQ0LAROLzyjUsILaQwApGieuH7LoYuYDsL4wS
        P/5uY4NwPjNKLLk1lwWmo2vWGUaIxHJGiZ57F9ngWv7N2sUIUsUmYCUxsX0VmC0ikCCxYvoM
        MJtZIEXiw5b/TCC2sECoxLNjvWwgNouAqsSSK4/BNvAK2Eq0NTxjgtgmL7H12ydWEJtTwE6i
        d9ohZogaQYmTM5+wQMyUl2jeOpsZ5AgJgWZ2iRX9t6FOdZFYv6wbapCwxKvjW9ghbBmJ05N7
        WCAa1jFK/O14AdW9nVFi+eR/bBBV1hJ3zv0CsjmAVmhKrN+lDxF2lDi6vp0FJCwhwCdx460g
        xBF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMELaHxO4JK1kmMCrOQvLOLCTvzELYu4CR
        eRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgYjn97/jXHYz7/iQdYhTgYFTi4dV4WBkn
        xJpYVlyZe4hRgoNZSYR3c2pFnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNT
        UwtSi2CyTBycUg2M8is3r3/tGJTFyThj399Fd+TKDq8XKA3/o7Gc4dlvj42ME7XvLbLjqU5X
        L9+5+9degR+XAp9VTP8TVN8fv/0Nk+INJgnf11/bLt1dvHf5uZ6/72qq3ig/zNr43uSYzu9p
        f19Jf7Kean1lj+fO7+8uel4/m/Cg5+lOa6nb4a1bzv26tUrZmS9FYoUSS3FGoqEWc1FxIgDS
        3FsTKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Pd0PfFVxBi2L+CxurTvHarFxxnpW
        iytf37NZnOj7wGpxedccNosVP7cyOrB53O8+zuSxZNpVNo++LasYPT5vkgtgidKzKcovLUlV
        yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPHjLUvBSfeKXUdO
        sjQwnrXsYuTkkBAwkeiadYaxi5GLQ0hgKaPEvNb7LF2MHEAJGYnj68sgaoQl/lzrYoOo+cQo
        sXnhWiaQBJuAlcTE9lWMILaIQJJEZ8NJZhCbWSBNYtLZu2A1wgLBEiv23gCrYRFQlVhy5TEL
        iM0rYCvR1vCMCWKBvMTWb59YQWxOATuJ3mmHwOYIAdW8W3+cEaJeUOLkzCcsEPPlJZq3zmae
        wCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHhv+3Yz807GC9tDD7EKMDB
        qMTDq/GwMk6INbGsuDL3EKMEB7OSCO/m1Io4Id6UxMqq1KL8+KLSnNTiQ4ymQE9MZJYSTc4H
        xmZeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG6h2/jOyPLd2g
        HfW97Fozd73x3hWHz/cE9ukdtFnYl7Ex9K5CUdjV30Hqb+66nwoybowPl5VW6Wh3qmrKmBMT
        8030SzNn8Z/X5xwuZIeuu8f5zC/rluMfoxn6T9P+P32dcvgw02FRlwnyt0RURUrdfWSeG55a
        2nIwhtdJN237t8Vh7sqWqzSUWIozEg21mIuKEwFFP+sBlQIAAA==
X-CMS-MailID: 20200324134520eucas1p2d95faa6d58939b45765ebca40d137f71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324134520eucas1p2d95faa6d58939b45765ebca40d137f71
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324134520eucas1p2d95faa6d58939b45765ebca40d137f71
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
        <CGME20200324134520eucas1p2d95faa6d58939b45765ebca40d137f71@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder code a bit and then remove no longer needed function
prototypes.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 302 +++++++++++++++-----------------
 1 file changed, 145 insertions(+), 157 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index c67d37103705..7f8f0081396e 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -141,16 +141,6 @@ struct fb_info_control {
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
@@ -159,153 +149,6 @@ static int default_vmode __initdata = VMODE_NVRAM;
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
-		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
-	}
-
-	return vm_iomap_memory(vma, start, len);
-}
-
-static int controlfb_blank(int blank_mode, struct fb_info *info)
-{
-	struct fb_info_control __maybe_unused *p =
-		container_of(info, struct fb_info_control, info);
-	unsigned ctrl;
-
-	ctrl = in_le32(CNTRL_REG(p, ctrl));
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
@@ -362,6 +205,20 @@ static void set_control_clock(unsigned char *params)
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
@@ -772,6 +629,137 @@ static inline void control_par_to_var(struct fb_par_control *par,
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
+	struct fb_info_control __maybe_unused *p =
+		container_of(info, struct fb_info_control, info);
+	unsigned ctrl;
+
+	ctrl = in_le32(CNTRL_REG(p, ctrl));
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
+		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
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

