Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C2C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA28B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eW0VN+C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgAPOJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:09:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46523 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAPOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:09:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116140915euoutp0200081688878750b1f67605b5c5e515ff~qY0JWxQqQ0753207532euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116140915euoutp0200081688878750b1f67605b5c5e515ff~qY0JWxQqQ0753207532euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579183755;
        bh=hxK11kkBXgZVMjcY/jODBwxg2OYmZ/75Eq6amFqRm4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eW0VN+C1yNOO6GJEn0/vu0BcxOKdT7dtSEzJ+OrAhebt+AfCWlv3usqMiIVgAtctO
         GQnSvnigTjoa3SPVgbyYznwoOq+r7tyRfkHK2xYHRDrWYgByooX+EuHZ/Xs2jbn1NG
         7e7RC+y4moL5jF1wxnBc+gNUSL13efEFJ19voGAc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116140915eucas1p15a447ecd8f844fb1d40dbb25e8fa8040~qY0JJWPyO0480504805eucas1p13;
        Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9C.FD.60679.B8E602E5; Thu, 16
        Jan 2020 14:09:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116140915eucas1p1d3696cbe492d55a4e4946c7e2d13f9d2~qY0I5x6_20480904809eucas1p1n;
        Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200116140915eusmtrp2e809632a577c2e4646290929e975520b~qY0I5Of9E0965509655eusmtrp2C;
        Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4d-5e206e8b9b8c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.80.07950.B8E602E5; Thu, 16
        Jan 2020 14:09:15 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116140915eusmtip1c758cc05f169c2eef57dd474eb558d23~qY0Il6wSt0665506655eusmtip1V;
        Thu, 16 Jan 2020 14:09:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>, b.zolnierkie@samsung.com
Subject: [PATCH 2/6] video: fbdev: controlfb: remove obsolete module support
Date:   Thu, 16 Jan 2020 15:08:56 +0100
Message-Id: <20200116140900.26363-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd3uPIU4g91LNCxurTvHarFxxnpW
        iytf37NZnOj7wGpxedccNgdWj/vdx5k8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2Niv0LB
        G+6KmQe3sDcw3uLsYuTkkBAwkbg54SVLFyMXh5DACkaJWw+vsYEkhAS+MEr822QGkfjMKPFy
        yn9GmI4nL7YzQSSWM0rM+fCWEa5jxaQ0EJtNwEpiYvsqsLiIQILEiukzgGwODmYBR4nmfj6Q
        sLCAj8TbJcfBSlgEVCWmL3/CCmLzCthKbGl/xAqxS15i67dPYDangJ3EvFP3GCFqBCVOznzC
        AmIzA9U0b53NDHKPhMBnNon9796xQTS7SCyZe5QJwhaWeHV8CzuELSPxf+d8JoiGdYwSfzte
        QHVvZ5RYPvkfVLe1xJ1zv9ggrtaUWL9LHyLsKDF79zWwZyQE+CRuvBWEOIJPYtK26cwQYV6J
        jjYhiGo1iQ3LNrDBrO3auZIZwvaQ2LnnEtMERsVZSN6ZheSdWQh7FzAyr2IUTy0tzk1PLTbK
        Sy3XK07MLS7NS9dLzs/dxAhMH6f/Hf+yg3HXn6RDjAIcjEo8vDOCFOKEWBPLiitzDzFKcDAr
        ifCenCEbJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANj
        RPXLvds3zLq6cubqIPv/P09EH7rw+FoZ0+4LR45NOczs9Ki82/omv8Gy6epOc47pqq+Yz3jq
        2afC9FvHFyxg7rXt/+n2IDG+5psdb+fFg+Xr1v7QT7pm+rf1TuYXXsu+VQ1nuW7vlZ+mekps
        Q8amA1oa8jmVbv9l46eVbHj1T3Nii5aJb5rqDCWW4oxEQy3mouJEALdmArAbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xu7rdeQpxBgdWiFvcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbEfoWCN9wVMw9uYW9gvMXZxcjJISFg
        IvHkxXamLkYuDiGBpYwSyz4cYO9i5ABKyEgcX18GUSMs8edaFxtEzSdGiVk3pzGCJNgErCQm
        tq8Cs0UEkiQ6G04yg9jMAs4Ss249YgKxhQV8JN4uOQ5WwyKgKjF9+RNWEJtXwFZiS/sjVogF
        8hJbv30CszkF7CTmnbrHCHKDEFDNoWlSEOWCEidnPmGBGC8v0bx1NvMERoFZSFKzkKQWMDKt
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzzbcd+btnB2PUu+BCjAAejEg/vjCCFOCHWxLLi
        ytxDjBIczEoivCdnyMYJ8aYkVlalFuXHF5XmpBYfYjQF+mEis5Rocj4wBvNK4g1NDc0tLA3N
        jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCerF4x66L+ObZ7e1uUX0jOf9gRk/uL
        qzc19OyOjtain4/+LqmS+nk92uvBK7eESeqr8yZZFk1JOLR0c7eO3GqThIZ0Cbu0e86sqcaf
        d8yofXpR1jHm0cyHUo4aM57HO2lO37NmdfjToucvH/c9n9jlytlsL/n+1AeLI9H3vmqafPip
        PnV+u8E3JZbijERDLeai4kQAv0PkF4kCAAA=
X-CMS-MailID: 20200116140915eucas1p1d3696cbe492d55a4e4946c7e2d13f9d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116140915eucas1p1d3696cbe492d55a4e4946c7e2d13f9d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116140915eucas1p1d3696cbe492d55a4e4946c7e2d13f9d2
References: <20200116140900.26363-1-b.zolnierkie@samsung.com>
        <CGME20200116140915eucas1p1d3696cbe492d55a4e4946c7e2d13f9d2@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FB_CONTROL is bool, hence the Apple "control" frame buffer
driver cannot be built as a module.

Replace module_init() by device_initcall().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index d7e53520a24c..bd0f61d8bdb5 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -31,7 +31,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -173,28 +172,6 @@ static const struct fb_ops controlfb_ops = {
 
 /********************  The functions for controlfb_ops ********************/
 
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	struct device_node *dp;
-	int ret = -ENXIO;
-
-	dp = of_find_node_by_name(NULL, "control");
-	if (dp && !control_of_init(dp))
-		ret = 0;
-	of_node_put(dp);
-
-	return ret;
-}
-
-void cleanup_module(void)
-{
-	control_cleanup();
-}
-#endif
-
 /*
  * Checks a var structure
  */
@@ -587,7 +564,7 @@ static int __init control_init(void)
 	return ret;
 }
 
-module_init(control_init);
+device_initcall(control_init);
 
 /* Work out which banks of VRAM we have installed. */
 /* danj: I guess the card just ignores writes to nonexistant VRAM... */
-- 
2.24.1

