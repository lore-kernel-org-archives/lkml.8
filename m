Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2116C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C89A21744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WlD5QsrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHKPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:06:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46969 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHKPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:06:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200811150639euoutp013f3d7b47a499d018ecfe804a087b4638~qPxowy-Mn0790007900euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:06:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200811150639euoutp013f3d7b47a499d018ecfe804a087b4638~qPxowy-Mn0790007900euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597158399;
        bh=B8NeOVKyY8VT4+bA/2LmW2ziYNbU/Azec2agY1TnN0I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WlD5QsrKhkIJRu2WQm01WFnnF72jxCM6fvRXzVyegPvphXyRYce6zPjX3t/+APk67
         1t2/g79c8AFxVazAonkgQTpHR2tOsetONGkUDHrUmVj8eAxsFr3bajoQ6QojdZ5l3V
         QsxXni1q/UtmXhH7BJs9fR+ROogx6eT1b7b9C+0M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200811150639eucas1p1ee6e0cb6e4ec8eafb1830b718fbf2241~qPxoYzStF1447314473eucas1p12;
        Tue, 11 Aug 2020 15:06:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.97.06318.FF3B23F5; Tue, 11
        Aug 2020 16:06:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200811150638eucas1p1fdaaa2c0b31b5c73d8f8d639018056f9~qPxoF-63u1457514575eucas1p12;
        Tue, 11 Aug 2020 15:06:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200811150638eusmtrp28bd56dc5d51418d3ccade4d0c02cfb56~qPxoFZ6NO2743627436eusmtrp2Q;
        Tue, 11 Aug 2020 15:06:38 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-3a-5f32b3ffc4ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.50.06314.EF3B23F5; Tue, 11
        Aug 2020 16:06:38 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200811150637eusmtip23c73cfaf01d27591a88cca2e9790129f~qPxm0etqe0481804818eusmtip20;
        Tue, 11 Aug 2020 15:06:37 +0000 (GMT)
Subject: Re: [PATCH] driver core: Let dev_err_probe() use the symbolic error
 code
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <432e6dce-f5ca-3fdd-7e24-5e343c430eab@samsung.com>
Date:   Tue, 11 Aug 2020 17:06:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811072036.4596-1-u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7r/NxvFG8xdxG7xcsJhRoupD5+w
        WTQvXs9msWrqThaLy7vmsFnM/TKV2eL2xMmMDuweO2fdZffYtKqTzWP/3DXsHv1/DTw+b5IL
        YI3isklJzcksSy3St0vgynj+5QFjwXWOigun7rM3ML5g62Lk4JAQMJE488+ki5GTQ0hgBaPE
        qcW1XYxcQPYXRonZjROYIJzPjBKdRyYzglSBNLz9t40RIrGcUeLJ135WCOc9o8SuthZWkLHC
        AsESb7eHgzSICHxllPjYagtiMwuYS7Stugk2iE1AU+Lv5ptsIDavgJ3EylOXGUFaWQRUJe41
        yoGERQXiJLYev8oEUSIocXLmExaQEk4BZ4mnPzkgJspLNG+dzQxhi0s0fVnJCnHmJnaJb6cM
        IGwXiYcnWpggbGGJV8e3sEPYMhL/d86HitdL3F/RwgzyiYRAB6PE1g07mSES1hJ3zv0CBxYz
        0Mnrd+lDhB0lPnzpYoSEIZ/EjbeCECfwSUzaNp0ZIswr0dEmBFGtKHH/7FaogeISSy98ZZvA
        qDQLyV+zkDwzC8kzsxD2LmBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYdk7/O/51
        B+O+P0mHGAU4GJV4eBdMNIoXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MBc7crlPyA1+cYddsS1qy/NSdpZH5ScqM
        f62FbsnfiNcPEfE//7m5eE/8OtugBW0MOl1Lle/Vq7KtzugpK748+9SGSJPkzKZbTAWfS03L
        dx9ty1Gd2SYouUzL/BjDK4X2V47nf1slf9O/2nrLft327CK3eNezM5e6xr9IqDQ3k8zKjtv/
        p1yJpTgj0VCLuag4EQB57sTbNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7r/NhvFGxz9Z2jxcsJhRoupD5+w
        WTQvXs9msWrqThaLy7vmsFnM/TKV2eL2xMmMDuweO2fdZffYtKqTzWP/3DXsHv1/DTw+b5IL
        YI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j+
        5QFjwXWOigun7rM3ML5g62Lk5JAQMJF4+28bYxcjF4eQwFJGiffzrrFDJMQlds9/ywxhC0v8
        udbFBlH0llGicc42oCIODmGBYIm328NB4iICXxkljl6cxwjSwCxgLtG26ibU1GmMEls7nzCB
        JNgENCX+br4JtppXwE5i5anLjCCDWARUJe41yoGERQXiJB73/meGKBGUODnzCQtICaeAs8TT
        nxwQ480k5m1+yAxhy0s0b50NZYtLNH1ZyTqBUWgWku5ZSFpmIWmZhaRlASPLKkaR1NLi3PTc
        YkO94sTc4tK8dL3k/NxNjMCI23bs5+YdjJc2Bh9iFOBgVOLhXTDRKF6INbGsuDL3EKMEB7OS
        CK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgV6byCwlmpwPTAZ5JfGGpobmFpaG5sbmxmYWSuK8
        HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYbTm5Zz3Z6FpR7j6HqdqhT9moSL7zxsfKko3bjr6b
        27nqxRVVNffovQubN5z682/lrBN/zq2/I39CpXsKM99Vu6Vs3CWrTzNdjFTI77NsKL/1eJK8
        5atNl9Ie87N59DN73151VVRCIVvNhaH01WUhjWQWEe553b5FRpedwmXd2/Z0r2ostXVSYinO
        SDTUYi4qTgQAk4mZBs4CAAA=
X-CMS-MailID: 20200811150638eucas1p1fdaaa2c0b31b5c73d8f8d639018056f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811072058eucas1p18f846c1fb01f2dc91c2bd74091ce05cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811072058eucas1p18f846c1fb01f2dc91c2bd74091ce05cd
References: <CGME20200811072058eucas1p18f846c1fb01f2dc91c2bd74091ce05cd@eucas1p1.samsung.com>
        <20200811072036.4596-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 11.08.2020 09:20, Uwe Kleine-König wrote:
> This makes the error message:
>
> 	error -EIO: ...
>
> instead of
>
> 	error -5: ...
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/base/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ac1046a382bc..33734d8831c7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4237,10 +4237,10 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
>   	vaf.va = &args;
>   
>   	if (err != -EPROBE_DEFER) {
> -		dev_err(dev, "error %d: %pV", err, &vaf);
> +		dev_err(dev, "error %pE: %pV", ERR_PTR(err), &vaf);
>   	} else {
>   		device_set_deferred_probe_reason(dev, &vaf);
> -		dev_dbg(dev, "error %d: %pV", err, &vaf);
> +		dev_dbg(dev, "error %pE: %pV", ERR_PTR(err), &vaf);


Apparently I have misread docs about %pE flag. Thanks for spotting this.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej


>   	}
>   
>   	va_end(args);
