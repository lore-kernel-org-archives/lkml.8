Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B78C54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2D3206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d5jUFdTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgCXNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:45:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40752 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgCXNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:45:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200324134519euoutp01f00c668b1d9aad33612889bd0917ccaa~-QWqF1ml43236532365euoutp01O
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200324134519euoutp01f00c668b1d9aad33612889bd0917ccaa~-QWqF1ml43236532365euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585057519;
        bh=SajSZrgSCmkiA3SOS/mxic5vQrlN9IelcIMWcE8/GLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5jUFdTKQaVFPWpAf0uipwEun6bC3mIFdbwYT2aaQXRhrlXv0ylqWUVS0LKDMAAXY
         /CuyuQ/tuyr/jIH5975jyyiZPEbTM2OHyFEp7k/mlBeYhZSLQZiPDLj3kZAGq5EdM9
         HCqZuoEQx1BPk1iTGaA3FekP7TTM59M8IcoaTQvM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200324134519eucas1p2344c54ba5a04d90fe5361359c66b0040~-QWp2_HGz3229632296eucas1p2J;
        Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 76.48.60679.FEE0A7E5; Tue, 24
        Mar 2020 13:45:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f~-QWpegDiz0141301413eucas1p2A;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324134518eusmtrp137ac898f6d27c7cdcc3e13dfaeb80009~-QWpd7sUb2619426194eusmtrp1p;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-c3-5e7a0eef31a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.E6.08375.EEE0A7E5; Tue, 24
        Mar 2020 13:45:18 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134518eusmtip20667bf1fa79e19ce481678e76e0bad2d~-QWpJt6Ht2961629616eusmtip2_;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com
Subject: [PATCH v2 2/6] video: fbdev: controlfb: add COMPILE_TEST support
Date:   Tue, 24 Mar 2020 14:45:04 +0100
Message-Id: <20200324134508.25120-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87rv+ariDA5sELW4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2CxW/NzK6MDmcb/7OJPHkmlX2Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoEr4/uLHWwFxyQrXlxxbGCcI9rFyMkhIWAicX1LL2MXIxeHkMAKRonTfy5DOV8YJXqO
        fmaFcD4zSjw/d5cNpuX4zSNMEInljBIzd21igWtp7rvIClLFJmAlMbF9FSOILSKQILFi+gww
        m1kgReLDlv9MILawgKfErPbvYHEWAVWJz8c+sXcxcnDwCthKzHwbCLFMXmLrt09gIzkF7CR6
        px1iBrF5BQQlTs58wgIxUl6ieetsZpAbJASa2SUmHz4OdamLxOsZM1khbGGJV8e3sEPYMhKn
        J/ewQDSsY5T42/ECqns7o8Tyyf+guq0l7pz7xQZyEbOApsT6XfoQYUeJ9d+fMYGEJQT4JG68
        FYQ4gk9i0rbpzBBhXomONiGIajWJDcs2sMGs7dq5khnC9pB4tPQr2wRGxVlI3pmF5J1ZCHsX
        MDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwrp/8d/7KDcdefpEOMAhyMSjy8Gg8r
        44RYE8uKK3MPMUpwMCuJ8G5OrYgT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6Yklq
        dmpqQWoRTJaJg1OqgXFiyeQb9/z+f5JgzVA6NGWzFFvyjX6zXZdO347VWvj/2+NQoYoH6lNu
        sQs7nJnQvPzMRUOGIwwrF3zgfX62kfN+TuC1s8VJHw+ecf//s7jDwuYip7D7lod8xxq22nbL
        WJ+JKRUXNFCJ/6762mZtbV3nyaxO30BGppSGdGlF/ojy7qyXIhVCFUosxRmJhlrMRcWJAMrL
        6kMnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd13fFVxBm8nWFjcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bBYrfm5ldGDzuN99nMljybSrbB59W1YxenzeJBfAEqVnU5RfWpKq
        kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8f3FDraCY5IVL644
        NjDOEe1i5OSQEDCROH7zCFMXIxeHkMBSRolrP84ydzFyACVkJI6vL4OoEZb4c62LDaLmE6PE
        ox9b2UESbAJWEhPbVzGC2CICSRKdDSeZQWxmgTSJSWfvMoHYwgKeErPav4PVsAioSnw+9okd
        ZD6vgK3EzLeBEPPlJbZ++8QKYnMK2En0TjsENkYIqOTd+uNgrbwCghInZz5hgRgvL9G8dTbz
        BEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM/W3Hfm7ewXhpY/AhRgEO
        RiUeXo2HlXFCrIllxZW5hxglOJiVRHg3p1bECfGmJFZWpRblxxeV5qQWH2I0BfphIrOUaHI+
        MC7zSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwKr8pWMjyadvD
        pXxGS/g/lvpJ6m1aZHOi9MXf0vLjyRyTOs81vTpYJsfqfNHvkqn+5lV3L9zL/GiUPaMsrUC7
        rnOL7aMpPXXnszeXTRPbPeV8+vF05Tu7g01u2L25uvjwqsoaX1G/TQndX+t3OX5S3Zwaryw+
        Z/ET7+DLL8RdDVZO/uuc2f8oTImlOCPRUIu5qDgRAKNwfZeTAgAA
X-CMS-MailID: 20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
        <CGME20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to controlfb driver for better compile
testing coverage.

While at it:
- convert driver to use eieio() and dcbf() helpers instead of
  open-coding them
- add invalid_vram_cache() helper to avoid code duplication

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig     |  2 +-
 drivers/video/fbdev/controlfb.c | 41 ++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 91b0a719d221..fa88e8b9a83d 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -472,7 +472,7 @@ config FB_OF
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on (FB = y) && PPC_PMAC && PPC32
+	depends on (FB = y) && ((PPC_PMAC && PPC32) || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 9625792f4413..b347bc78bc4a 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -48,12 +48,37 @@
 #include <linux/nvram.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
+#ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
 #include <asm/btext.h>
+#endif
 
 #include "macmodes.h"
 #include "controlfb.h"
 
+#ifndef CONFIG_PPC_PMAC
+#define invalid_vram_cache(addr)
+#undef in_8
+#undef out_8
+#undef in_le32
+#undef out_le32
+#define in_8(addr)		0
+#define out_8(addr, val)
+#define in_le32(addr)		0
+#define out_le32(addr, val)
+#define pgprot_cached_wthru(prot) (prot)
+#else
+static void invalid_vram_cache(void __force *addr)
+{
+	eieio();
+	dcbf(addr);
+	mb();
+	eieio();
+	dcbf(addr);
+	mb();
+}
+#endif
+
 struct fb_par_control {
 	int	vmode, cmode;
 	int	xres, yres;
@@ -309,7 +334,7 @@ static int controlfb_mmap(struct fb_info *info,
 
 static int controlfb_blank(int blank_mode, struct fb_info *info)
 {
-	struct fb_info_control *p =
+	struct fb_info_control __maybe_unused *p =
 		container_of(info, struct fb_info_control, info);
 	unsigned ctrl;
 
@@ -605,12 +630,7 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0x600000], 0xb3);
 	out_8(&p->frame_buffer[0x600001], 0x71);
-	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0x600000])
-					: "memory" );
-	mb();
-	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000])
-					: "memory" );
-	mb();
+	invalid_vram_cache(&p->frame_buffer[0x600000]);
 
 	bank2 = (in_8(&p->frame_buffer[0x600000]) == 0xb3)
 		&& (in_8(&p->frame_buffer[0x600001]) == 0x71);
@@ -624,12 +644,7 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0], 0x5a);
 	out_8(&p->frame_buffer[1], 0xc7);
-	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0])
-					: "memory" );
-	mb();
-	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0])
-					: "memory" );
-	mb();
+	invalid_vram_cache(&p->frame_buffer[0]);
 
 	bank1 = (in_8(&p->frame_buffer[0]) == 0x5a)
 		&& (in_8(&p->frame_buffer[1]) == 0xc7);
-- 
2.24.1

