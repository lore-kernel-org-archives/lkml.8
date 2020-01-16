Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CDA20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uN+X0R9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgAPOyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:54:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34835 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgAPOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:54:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116145445euoutp02b1fe9830a4ec8ef9afec4123118e57a2~qZb3EuE6j0239102391euoutp02O
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:54:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116145445euoutp02b1fe9830a4ec8ef9afec4123118e57a2~qZb3EuE6j0239102391euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579186485;
        bh=b65qnNpZPszXG+jwsFpQRilWQfE42OoelAKKff3CP5U=;
        h=From:Subject:To:Cc:Date:References:From;
        b=uN+X0R9DwJOTpEDHkYnjcPt7yQ9M8jqJz8rypj+G2eNGYCuAlr1semr2kznBVigYL
         v4xTaosFY8fbZeNT4i3/qCXsukjkeBE0qID3NRVjSsj4NQvTAeOHsKT4FG/Vr0Hk5a
         YT3pVMz747X2Jx/WdY+JRczcvOpWNK6cohMRfnSs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200116145444eucas1p22d4769c433e37f048f6100b6d032c9b5~qZb246Q5M1744817448eucas1p2B;
        Thu, 16 Jan 2020 14:54:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D9.84.60698.439702E5; Thu, 16
        Jan 2020 14:54:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493~qZb2VS-RQ0962409624eucas1p1S;
        Thu, 16 Jan 2020 14:54:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116145444eusmtrp1a6015b8d3fef1a854e9729889efd87c8~qZb2RoV471332413324eusmtrp1N;
        Thu, 16 Jan 2020 14:54:44 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-51-5e207934bdc2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.66.07950.439702E5; Thu, 16
        Jan 2020 14:54:44 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116145443eusmtip2609623863bfb9e2ba72cc8ce9cafe547~qZb1tBdpz3165131651eusmtip2J;
        Thu, 16 Jan 2020 14:54:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] video: fbdev: wm8505fb: fix sparse warnings about using
 incorrect types
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <411db705-a098-27e6-8f52-acfea2735738@samsung.com>
Date:   Thu, 16 Jan 2020 15:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7omlQpxBg2LdS1urTvHarFxxnpW
        iytf37NZnOj7wGpxedccNgdWj/vdx5k8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2Pyqf3M
        BZvZKq787WVsYNzB2sXIwSEhYCJx6G9CFyMXh5DACkaJvtXH2SGcL4wS8948Ze5i5ARyPjNK
        PHrGDWKDNHw50MgKUbScUWLx32WMEM5bRokrd5YwglSxCVhJTGxfBWYLC8RJfNr0CWySiECC
        xIrpM8DizALxEtuaj4LZvAJ2EjtenwGzWQRUJV4vu84GYosKREh8enCYFaJGUOLkzCcsEL3i
        EreezGeCsOUltr+dwwxyhITAbzaJaR9esEKc6iKxY/lMJghbWOLV8S3sELaMxOnJPSwQDesY
        Jf52vIDq3s4osXzyPzaIKmuJO+d+sYFCiVlAU2L9Ln2IsKPEtWPP2CGBxydx460gxBF8EpO2
        TWeGCPNKdLQJQVSrSWxYtoENZm3XzpVQJR4S9+eYTWBUnIXks1lIPpuF5LNZCCcsYGRZxSie
        Wlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhYTv87/nUH474/SYcYBTgYlXh4P4QoxAmxJpYV
        V+YeYpTgYFYS4T05QzZOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalF
        MFkmDk6pBsbLVXbPTso1ZDSs27zrV1jumRm66T3nfFUjW4VVfW83Zgct9NTiYfG3TlH6Hhpc
        zm10IfRX7695K493ap/7x/T5HduBgzFxm52K+lIuMzx75Krz7M38j0Uy/ac1655mnT1m9rXX
        dLfk5JyIKKdHS1SVXOa5Ft8K/aj3oyNwq+IE9bDZhdVr1JVYijMSDbWYi4oTAWc5Z/IoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7omlQpxBv032CxurTvHarFxxnpW
        iytf37NZnOj7wGpxedccNgdWj/vdx5k8+rasYvT4vEkugDlKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pyqf3MBZvZKq787WVsYNzB2sXIySEh
        YCLx5UAjkM3FISSwlFHizLXjjF2MHEAJGYnj68sgaoQl/lzrYoOoec0ocXR6MxNIgk3ASmJi
        +ypGEFtYIE7i06ZPzCC2iECCxNPX89lAbGaBeInObQ1gNbwCdhI7Xp8Bs1kEVCVeL7sOViMq
        ECFxeMcsqBpBiZMzn7BA9KpL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYwCs5C0zELSMgtJyywk
        LQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExsa2Yz+37GDsehd8iFGAg1GJh3dGkEKc
        EGtiWXFl7iFGCQ5mJRHekzNk44R4UxIrq1KL8uOLSnNSiw8xmgI9NJFZSjQ5Hxi3eSXxhqaG
        5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGEX2ZLVdb+9b9jC+xJYphYFV
        wXq3gYrN0Ut7N33LK7nwxKD6gGKc592DGnfsuZZuK/wsG3kvdYvWbcX7uw9s21Sy4M+kyXsn
        qWbJlc14sPl8N9fa/fMqc1/d8Fpe3b+nx1aq7oG7ffLJ30Z8oiXHJZLv+3c+Kb92OTxKwX+h
        gWzbF/b2iYqblyuxFGckGmoxFxUnAgBOhZfsowIAAA==
X-CMS-MailID: 20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493
References: <CGME20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/wm8505fb.c
===================================================================
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -339,7 +339,7 @@ static int wm8505fb_probe(struct platfor
 
 	fbi->fb.fix.smem_start		= fb_mem_phys;
 	fbi->fb.fix.smem_len		= fb_mem_len;
-	fbi->fb.screen_base		= fb_mem_virt;
+	fbi->fb.screen_buffer		= fb_mem_virt;
 	fbi->fb.screen_size		= fb_mem_len;
 
 	fbi->contrast = 0x10;
