Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F95C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E82073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WuSaNB+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgCXNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:45:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40755 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgCXNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:45:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200324134519euoutp01ded632b4c3f25160664b609250d7eb13~-QWqMxYJm3230632306euoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200324134519euoutp01ded632b4c3f25160664b609250d7eb13~-QWqMxYJm3230632306euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585057519;
        bh=TjreQCi8GcZdeFqEmL9FdXNVZv2wetsWfI3p3DJjO/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuSaNB+LmG8uwpNLwpfGI0MUSOmtwdkUdYGSmOE52ALjT2ADqKdQFMc0+d/xgLZD4
         fBZhwhrpGCWU6Zif9wRkI4B8eDp2Zg1DSy3DXpxQjX2byul069qYxDFXja4ijF6lSJ
         iH2YdCF0dgtwDFal02g6GygYKlKzKE5mZnMsRxIU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200324134519eucas1p10cae7f4aab3c350027d35040def34e58~-QWp-Hh7H0905809058eucas1p1i;
        Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.08.60698.FEE0A7E5; Tue, 24
        Mar 2020 13:45:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134519eucas1p2d606db263a636433bf1545c836bed138~-QWpwJv6z3230032300eucas1p2-;
        Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324134519eusmtrp1900e7d86304abf94a785bccaaf113e69~-QWpvmFFf2619426194eusmtrp1s;
        Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-62-5e7a0eef48bb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.E6.08375.FEE0A7E5; Tue, 24
        Mar 2020 13:45:19 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134518eusmtip2393f1a7de356a334a301a81a58cc9dbf~-QWpc9-Ku2918929189eusmtip2i;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com
Subject: [PATCH v2 3/6] video: fbdev: controlfb: remove obsolete module
 support
Date:   Tue, 24 Mar 2020 14:45:05 +0100
Message-Id: <20200324134508.25120-4-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7rv+ariDOYelrG4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2CxW/NzK6MDmcb/7OJPHkmlX2Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoErY2HXS+aC6TwVE3+dYWlgbODqYuTkkBAwkfjw5QxzFyMXh5DACkaJH00b2SCcL4wS
        +04ch3I+M0pMfHuSEabl3KdfUInljBJ3Hj9hhWtZ/nYbO0gVm4CVxMT2VWAdIgIJEiumzwCz
        mQVSJD5s+c8EYgsLBEpc2dLJCmKzCKhK7Fm3lwXE5hWwlXhzu4EZYpu8xNZvn8BqOAXsJHqn
        HWKGqBGUODnzCQvETHmJ5q2zwZ6QEGhmlzj4dDcrRLOLxMt/m1ggbGGJV8e3sEPYMhKnJ/ew
        QDSsY5T42/ECqns70AuT/7FBVFlL3DkH8igH0ApNifW79CHCjhIPjz1mAQlLCPBJ3HgrCHEE
        n8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl1F8eEveO7GWZwKg4C8k7s5C8Mwth7wJG5lWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBqeX0v+NfdzDu+5N0iFGAg1GJh1fjYWWcEGti
        WXFl7iFGCQ5mJRHezakVcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1I
        LYLJMnFwSjUwau6x8rwmuDYiX9hxuY5N7Ypw/7uCZjfjbMS9KrsMrz81v53GOOX18gzjH4eZ
        GNM+f+V/Wqhc8/LglyucX6Q3F0xabr5zirRR+Yz90u/meHEKifMcTKjyZ9nnaeuYrT/Tzn/Z
        yzMvee9OqPjNvV15W/F9p/pV1pqT5m7P660QVN2uW+DZuWqJEktxRqKhFnNRcSIAPwc3pikD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Pd33fFVxBjfv8lncWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bBYrfm5ldGDzuN99nMljybSrbB59W1YxenzeJBfAEqVnU5RfWpKq
        kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsbDrJXPBdJ6Kib/O
        sDQwNnB1MXJySAiYSJz79Iuti5GLQ0hgKaNE+4nHrF2MHEAJGYnj68sgaoQl/lzrgqr5xCjx
        6+s3dpAEm4CVxMT2VYwgtohAkkRnw0lmEJtZIE1i0tm7TCC2sIC/xKylX8BsFgFViT3r9rKA
        2LwCthJvbjcwQyyQl9j67RMriM0pYCfRO+0QWFwIqObd+uOMEPWCEidnPmGBmC8v0bx1NvME
        RoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAz/bcd+bt7BeGlj8CFGAQ5G
        JR5ejYeVcUKsiWXFlbmHGCU4mJVEeDenVsQJ8aYkVlalFuXHF5XmpBYfYjQFemIis5Rocj4w
        NvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBmrT4/Y7fVbqmk
        2Gnxp5tvLksTtMpgVLzLvPl9y+ODPDrJ53su9NndUnbyzdPWWHLjldOabX2/Chnn5J9/82G5
        0h7rjobfgn+/2xXwbUs4nue/7ovoxXNKrNujQmZcaPNXzLraGLbmxu/zLXNmMu2y9+L9kZPh
        vGaFgiaLxty8zYsnZWYqd9sqsRRnJBpqMRcVJwIAgRlAp5UCAAA=
X-CMS-MailID: 20200324134519eucas1p2d606db263a636433bf1545c836bed138
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324134519eucas1p2d606db263a636433bf1545c836bed138
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324134519eucas1p2d606db263a636433bf1545c836bed138
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
        <CGME20200324134519eucas1p2d606db263a636433bf1545c836bed138@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FB_CONTROL is bool, hence the Apple "control" frame buffer
driver cannot be built as a module.

Replace module_init() by device_initcall().

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index b347bc78bc4a..92cffd2d0219 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -31,7 +31,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -198,28 +197,6 @@ static const struct fb_ops controlfb_ops = {
 
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
@@ -612,7 +589,7 @@ static int __init control_init(void)
 	return ret;
 }
 
-module_init(control_init);
+device_initcall(control_init);
 
 /* Work out which banks of VRAM we have installed. */
 /* danj: I guess the card just ignores writes to nonexistant VRAM... */
-- 
2.24.1

