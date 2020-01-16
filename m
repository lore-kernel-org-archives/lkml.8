Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A343EC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFE320748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IWwWgMi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:58:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35925 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAPO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:58:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116145810euoutp026fcf5fd9d452924ca67a673a3f264917~qZe2nMs9B0645706457euoutp02Y
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:58:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116145810euoutp026fcf5fd9d452924ca67a673a3f264917~qZe2nMs9B0645706457euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579186690;
        bh=LOKbJ5eqsGKknVC/oZwcYCd5dCgwHhDZl29qB7mWEHo=;
        h=From:Subject:To:Cc:Date:References:From;
        b=IWwWgMi5M8Qh7W39+idS6sXTLJOZt8QpB3rwsQjvOPuNmO0kK7vk1gGIHDiSIEXdK
         XDSbgbgT0WCrinkz9E5WesW9TNbdrfWHnRmFuVnxq4InZkt9MRgAWQFDZjv/F4/lbt
         /TZK9+Snz+UMZ3Y3OrVR1TF2X1LZxIEmWhJA93FE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116145810eucas1p117b8bff7f408d99fed0e80231ade4209~qZe2RIUnI2221422214eucas1p1A;
        Thu, 16 Jan 2020 14:58:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.F4.60698.20A702E5; Thu, 16
        Jan 2020 14:58:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa~qZe18cz8T1823218232eucas1p1r;
        Thu, 16 Jan 2020 14:58:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116145810eusmtrp194f8ac9affbf5d9e257221380232493a~qZe17wckF1562815628eusmtrp1Y;
        Thu, 16 Jan 2020 14:58:10 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b9-5e207a020448
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.C6.07950.10A702E5; Thu, 16
        Jan 2020 14:58:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116145808eusmtip2c39deaa6a221fcab8d8902823715c92d~qZe0_AHgE3196531965eusmtip2I;
        Thu, 16 Jan 2020 14:58:08 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] video: fbdev: wm8505fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Prisk <linux@prisktech.co.nz>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <900c16b3-9306-7d17-f467-0f98bc95416a@samsung.com>
Date:   Thu, 16 Jan 2020 15:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87pMVQpxBkeWCVjcWneO1WLjjPWs
        Fle+vmez2PT4GqvFib4PrBaXd81hs2i5vILZgd3jfvdxJo/NS+o9zv9vYffo27KK0ePzJrkA
        1igum5TUnMyy1CJ9uwSujKfN59kLetgqfu44z9rAOJW1i5GDQ0LARGL2Gc0uRi4OIYEVjBI3
        FzUwQThfGCX+fDgJVMQJ5HxmlHg22wKmYdFHU4ia5YwSS2evg6p5yyjxe50BiM0mYCUxsX0V
        I4gtLOAqcebbb7ChIgJtjBJfV0FsYBZoBmrY8YINpIpXwE7iz4sPzCAbWARUJXY/TwQJiwpE
        SHx6cJgVokRQ4uTMJywgNrOAuMStJ/OZIGx5ie1v5zCDzJQQWMQu8WnNAbCEhICLxOOHT5kh
        bGGJV8e3sEPYMhKnJ/ewQDSsY5T42/ECqns7o8Tyyf/YIKqsJe6c+8UGchGzgKbE+l36EGFH
        iU+3F7NAgoJP4sZbQYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0roc7xkOi5dJdxAqPi
        LCSvzULy2iwkr81CuGEBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwPRz+t/xrzsY
        9/1JOsQowMGoxMP7IUQhTog1say4MvcQowQHs5II78kZsnFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MJ6ySJBYOb+EYbH83qzjJjfqBN6b3D2dX/tV
        abfx1mk+6VseeLnFXJnrf8p75do7696E3FqqFHzySni8ZEi4/R39AieTpVIOnEbsOjyP/r1Y
        nBwg3x94sFRx9vKCY3LbpOXO/N/+2syFu09vTYIP+8EP37krc9cumrBTueibaO635RKTF/qw
        H1JiKc5INNRiLipOBADdcX1gOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7qMVQpxBjt7bSxurTvHarFxxnpW
        iytf37NZbHp8jdXiRN8HVovLu+awWbRcXsHswO5xv/s4k8fmJfUe5/+3sHv0bVnF6PF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextPm
        8+wFPWwVP3ecZ21gnMraxcjBISFgIrHoo2kXIxeHkMBSRoln2zewQ8RlJI6vL+ti5AQyhSX+
        XOtig6h5zSjRs62PFSTBJmAlMbF9FSOILSzgKnHm228mkCIRgTZGiflbXjCCOMwCzYwSd9at
        ZwKp4hWwk/jz4gMzyAYWAVWJ3c8TQcKiAhESh3fMYoQoEZQ4OfMJC4jNLKAu8WfeJWYIW1zi
        1pP5TBC2vMT2t3OYJzAKzELSMgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGEHbjv3csoOx613wIUYBDkYlHt4ZQQpxQqyJZcWVuYcYJTiYlUR4T86QjRPiTUmsrEot
        yo8vKs1JLT7EaAr0z0RmKdHkfGB055XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYNx7t3His6Jnn2O7tsm5Fr7cutdZ45LIvLOplw7lX9oWJibUrrZ396ZNyu+X
        8VuxdyUKLzYwmHj6UZuNOxurn4Bxr+SrSzlJcW8sd//W/L814N+rKr0fQj4P7T7OFtr/Q35i
        X3FYcdCar2vOhfywX3JaW+mjltAiDf/1rRHKMj9+HXY9fO/lNiclluKMREMt5qLiRAC1X1ue
        tgIAAA==
X-CMS-MailID: 20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa
References: <CGME20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to wm8505fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1639,7 +1639,7 @@ config FB_VT8500
 
 config FB_WM8505
 	bool "Wondermedia WM8xxx-series frame buffer support"
-	depends on (FB = y) && ARM && ARCH_VT8500
+	depends on (FB = y) && HAS_IOMEM && (ARCH_VT8500 || COMPILE_TEST)
 	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
 	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
 	select FB_SYS_IMAGEBLIT
