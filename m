Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF1C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECEB20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AhJUhy6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAPOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:53:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34455 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgAPOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:53:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116145321euoutp0205db4133e4c222a8c0f7ed6cb37e18ae~qZapiLxTG0280302803euoutp02l
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116145321euoutp0205db4133e4c222a8c0f7ed6cb37e18ae~qZapiLxTG0280302803euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579186401;
        bh=qdReotCGd+UjCIaeocM9Q0JnBul5Ap6ZtcTKBf4vIPY=;
        h=From:Subject:To:Cc:Date:References:From;
        b=AhJUhy6ehsqIXnu4G7OUCU3vjoBBEXTrS7VrJ5Rpi6msNUvTrsJrWdziZSn0saIqZ
         DMKq4pjJbU2w6mPnZi2MN018cv/0toRhvkiyCxK+pU+XqQdKVp8nf1Si5HNOkA/gWT
         mIudVHVmHV5OlcFml7JdrptijftgFL9rdgViViy4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200116145321eucas1p219e883ce6aa8b30d66e09365085f9029~qZapK-K2l1762917629eucas1p26;
        Thu, 16 Jan 2020 14:53:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B5.C4.61286.1E8702E5; Thu, 16
        Jan 2020 14:53:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8~qZaoufSws1377813778eucas1p1h;
        Thu, 16 Jan 2020 14:53:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116145320eusmtrp15a2638d51ab74ded203b3be359fe4d3e~qZaot7McK1239612396eusmtrp1E;
        Thu, 16 Jan 2020 14:53:20 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-d4-5e2078e154db
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.B5.08375.0E8702E5; Thu, 16
        Jan 2020 14:53:20 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145320eusmtip10c6d0826631e14819f5e6311a5ee14c3~qZaoNEHgd0309103091eusmtip15;
        Thu, 16 Jan 2020 14:53:20 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] video: fbdev: w100fb: fix sparse warnings
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d438108a-e569-a14a-a9b1-3fefd88fcadc@samsung.com>
Date:   Thu, 16 Jan 2020 15:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7oPKxTiDP4cFra4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2BxYPe53H2fy6NuyitHj8ya5AOYoLpuU1JzMstQifbsEroyvH5pZ
        C+7yVSyaOoW5gXEmTxcjB4eEgInEljvyXYxcHEICKxglNr45wgzhfGGU2DXtJmMXIyeQ85lR
        ove8OogN0jD9Zy8TRNFyRokVc7pZIZy3jBI7VvxhBaliE7CSmNi+CqxbWMBOon3tHiYQW0Qg
        QWLF9BlgcWaBeIltzUfBbF6gmht79rGA2CwCqhK3Pq0Gi4sKREh8enCYFaJGUOLkzCcsEL3i
        EreezGeCsOUltr+dA3a2hMBvNomfM3rZIE51kfi3eh0jhC0s8er4FnYIW0bi9OQeFoiGdYwS
        fzteQHVvZ5RYPvkfVLe1xJ1zv9hAocQsoCmxfpc+RNhRYk7vWhZI4PFJ3HgrCHEEn8SkbdOZ
        IcK8Eh1tQhDVahIblm1gg1nbtXMlM4TtIbHw9CLWCYyKs5C8NgvJa7OQvDYL4YYFjCyrGMVT
        S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPL6X/HP+1g/Hop6RCjAAejEg/vjCCFOCHWxLLi
        ytxDjBIczEoivCdnyMYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUI
        JsvEwSnVwBjqmL+tsINrSejlgw97bqlO4la+dm4G3/7r66UstV0zJkhMNItLD/w3a53w4SdH
        8ucfdFn44ED7/hNtjS8vX3m8+KubwNKEOs9bC1NM43JM8wRv6ztmHOefmN/IurPHbfMLlSVd
        pkFKfj4veCovRXHaL3U4d5VJwVP80b3ibT+ffJ3wvUB+0XclluKMREMt5qLiRAAeozuhKQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd0HFQpxBhfOm1jcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbXD82sBXf5KhZNncLcwDiTp4uRk0NC
        wERi+s9epi5GLg4hgaWMEq1Hv7B1MXIAJWQkjq8vg6gRlvhzrYsNxBYSeM0oseCGAIjNJmAl
        MbF9FSOILSxgJ9G+dg8TiC0ikCDx9PV8sHpmgXiJzm0NYDW8QDU39uxjAbFZBFQlbn1aDRYX
        FYiQOLxjFlSNoMTJmU9YIHrVJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGgVlIWmYhaZmFpGUW
        kpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNj27Gfm3cwXtoYfIhRgINRiYd3RpBC
        nBBrYllxZe4hRgkOZiUR3pMzZOOEeFMSK6tSi/Lji0pzUosPMZoCPTSRWUo0OR8YtXkl8Yam
        huYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhiLDrW1zfbsnGvs67Lrq/Km
        3W4LWx78kg3LtZzCWJ+3xuDtfAPfjk2JZWFCOsyxy1xeHvdYd79/96n6mT9eBZyRs2xU3q3O
        n7Oy4vfqurBsHmWuTfPlFeJeGTgpqYm9zJy3OyZKQGGy3/Lp01kCrvwq5rp/L+e04tKQF66Z
        x30+79JJjA/Ua1ZiKc5INNRiLipOBAAWyfJdogIAAA==
X-CMS-MailID: 20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8
References: <CGME20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add missing __iomem annotations where needed.
* Make w100fb_probe() static.
* Return NULL pointer (instead of using plain integer) in
  w100_get_xtal_tabl().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/w100fb.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: b/drivers/video/fbdev/w100fb.c
===================================================================
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -61,9 +61,9 @@ struct w100_pll_info *w100_get_xtal_tabl
 #define BITS_PER_PIXEL    16
 
 /* Remapped addresses for base cfg, memmapped regs and the frame buffer itself */
-static void *remapped_base;
-static void *remapped_regs;
-static void *remapped_fbuf;
+static void __iomem *remapped_base;
+static void __iomem *remapped_regs;
+static void __iomem *remapped_fbuf;
 
 #define REMAPPED_FB_LEN   0x15ffff
 
@@ -635,7 +635,7 @@ static int w100fb_resume(struct platform
 #endif
 
 
-int w100fb_probe(struct platform_device *pdev)
+static int w100fb_probe(struct platform_device *pdev)
 {
 	int err = -EIO;
 	struct w100fb_mach_info *inf;
@@ -807,10 +807,11 @@ static int w100fb_remove(struct platform
 
 static void w100_soft_reset(void)
 {
-	u16 val = readw((u16 *) remapped_base + cfgSTATUS);
-	writew(val | 0x08, (u16 *) remapped_base + cfgSTATUS);
+	u16 val = readw((u16 __iomem *)remapped_base + cfgSTATUS);
+
+	writew(val | 0x08, (u16 __iomem *)remapped_base + cfgSTATUS);
 	udelay(100);
-	writew(0x00, (u16 *) remapped_base + cfgSTATUS);
+	writew(0x00, (u16 __iomem *)remapped_base + cfgSTATUS);
 	udelay(100);
 }
 
@@ -1022,7 +1023,8 @@ struct w100_pll_info *w100_get_xtal_tabl
 			return pll_entry->pll_table;
 		pll_entry++;
 	} while (pll_entry->xtal_freq);
-	return 0;
+
+	return NULL;
 }
 
 
