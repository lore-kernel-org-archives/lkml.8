Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D16C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4A52072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nx70jCGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgAPOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:51:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37837 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:51:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116145117euoutp0126b67e34e73515cd6c6b42b05006bc8c~qZY1bAzfs0632006320euoutp01j
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:51:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116145117euoutp0126b67e34e73515cd6c6b42b05006bc8c~qZY1bAzfs0632006320euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579186277;
        bh=zM5QKDUUFvzxmck4BWoQ7EibKTrMCs6fH624KxIH7Jo=;
        h=From:Subject:To:Cc:Date:References:From;
        b=Nx70jCGHt8zusZVaJ62EXB+XAubmMAIuJT4X5FwYCSS9/Ox+GDwpS5TCWVBpQNbUE
         rXSD0GYZ0i8QwplwZthQhHaokBRtHBBE9zo72YnS0rETBdr0slOHEjKkjjEB3xykhN
         K+zRFW9XMCXegsvs53RGz08yBGfs+JiG+W0YlNW0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116145116eucas1p1e42b04ca64c1403b153abc27e9a5c0cd~qZY1N42gL1036510365eucas1p1T;
        Thu, 16 Jan 2020 14:51:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.14.60679.468702E5; Thu, 16
        Jan 2020 14:51:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3~qZY016bKP0505605056eucas1p2B;
        Thu, 16 Jan 2020 14:51:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116145116eusmtrp11db69222731b0e45a88d3414e3f6582f~qZY01Xt4Y1110811108eusmtrp14;
        Thu, 16 Jan 2020 14:51:16 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-70-5e20786426b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.75.08375.468702E5; Thu, 16
        Jan 2020 14:51:16 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145115eusmtip1b9c1be999ff790774ec794ee71847d48~qZY0W6wQ43258232582eusmtip1g;
        Thu, 16 Jan 2020 14:51:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] video: fbdev: sh_mobile_lcdcfb: fix sparse warnings
 about using incorrect types
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
Date:   Thu, 16 Jan 2020 15:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7opFQpxBl8WmVjcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV0bL6vmM
        Bcc4K+acOMXewDiZo4uRk0NCwETiwNX5jCC2kMAKRomVt9Qh7C+MEqeb+boYuYDsz4wS/ddm
        sMI0/Nx4lRUisZxRomP5bWaIjreMEv+buEBsNgEriYntq8CmCgukSXz7/o8JxBYRSJBYMX0G
        WJxZIF5iW/NRMJtXwE5iycN+oBoODhYBVYkvhw1AwqICERKfHhxmhSgRlDg58wkLRKu4xK0n
        85kgbHmJ7W/nMIPcIyHwm01iwduZbBCHukhM2X2dEcIWlnh1fAs7hC0jcXpyDwtEwzpGib8d
        L6C6tzNKLJ/8D6rbWuLOuV9sIBcxC2hKrN+lDxF2lNjbMYkdJCwhwCdx460gxBF8EpO2TWeG
        CPNKdLQJQVSrSWxYtoENZm3XzpXMELaHxNTGnSwTGBVnIXltFpLXZiF5bRbCDQsYWVYxiqeW
        FuempxYb5aWW6xUn5haX5qXrJefnbmIEppXT/45/2cG460/SIUYBDkYlHt4ZQQpxQqyJZcWV
        uYcYJTiYlUR4T86QjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFM
        lomDU6qBUfOHRP6+qWwTtkR8+XauZ6rCN/Gzp/q8XU1EbvtN2Rv94em8incymsJ6r1NtGie/
        /ZL1QLc4f6L2m8bfC5Z4JC1x5D9VfHn2tculb7p/rTqhUWO0Ki3tHpd1G+usmZ1MCq08b0Sm
        urC1X9qySu5G0p3nBy5eSzFZ/bV3ZViL0r23DCetGWOWbVdiKc5INNRiLipOBABlbaKsJwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd2UCoU4gxs/ZC1urTvHarFxxnpW
        iytf37NZnOj7wGpxedccNgdWj/vdx5k8+rasYvT4vEkugDlKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6Nl9XzGgmOcFXNOnGJvYJzM0cXIySEh
        YCLxc+NV1i5GLg4hgaWMEn2/3rF1MXIAJWQkjq8vg6gRlvhzrYsNouY1o8TSOxvZQRJsAlYS
        E9tXMYLYwgJpEptXvmIFsUUEEiSevp7PBmIzC8RLdG5rAKvhFbCTWPKwnwlkPouAqsSXwwYg
        YVGBCInDO2ZBlQhKnJz5hAWiVV3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSYhaRlFpKWWUha
        ZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwMrYd+7l5B+OljcGHGAU4GJV4eGcE
        KcQJsSaWFVfmHmKU4GBWEuE9OUM2Tog3JbGyKrUoP76oNCe1+BCjKdA/E5mlRJPzgVGbVxJv
        aGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBccKBug39lQd5IryUgxQ8
        Dwdw5Lpd3cm3RH2O5DFOo0mZMa0ZgTIi6389NVj8YcGjz8r31TTjX81a+LGbs+K31Jz5LVJf
        q8rVviv+qbkwz6rX9uKKyl1feIvWTGbevc46JPqE5+e9JZMOOKcUTg38OTNqocPuLVMecZ1d
        +0gh80j988l7ebz8i5VYijMSDbWYi4oTAWFq3yGiAgAA
X-CMS-MailID: 20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3
References: <CGME20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/video/fbdev/sh_mobile_lcdcfb.c
===================================================================
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1572,7 +1572,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_overlay_ops;
 	info->device = priv->dev;
-	info->screen_base = ovl->fb_mem;
+	info->screen_buffer = ovl->fb_mem;
 	info->par = ovl;
 
 	/* Initialize fixed screen information. Restrict pan to 2 lines steps
@@ -2056,7 +2056,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_ops;
 	info->device = priv->dev;
-	info->screen_base = ch->fb_mem;
+	info->screen_buffer = ch->fb_mem;
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->par = ch;
 

