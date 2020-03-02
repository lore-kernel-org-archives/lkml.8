Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECB3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A629D24677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZHQc0RES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCBPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47097 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCBPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154240euoutp0260b343ebcaf38123a0336cd9abd8fe8d~4hw1mOPat1227412274euoutp02j
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302154240euoutp0260b343ebcaf38123a0336cd9abd8fe8d~4hw1mOPat1227412274euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163760;
        bh=KWzOteUQaHJimJ522eyRNnUZIVwvvujxlZPPxP9BqIA=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=ZHQc0RESSl8K6Ftivo41sDPRdup7cZCMZEsgLzyfg121Fkr4OGMU5ybM/ONNrQQsG
         BkMH0hsBcFbuHm3ojr1W47yCsU7DTALa6PuururxBmOSz+kMCktKbOLlL5OqTakz46
         qlPisHxoUg+U7KMxY0avtSsF0ORBX+BP3ztOdUKE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302154240eucas1p13c93cc0a78c632aa4bc02b5803bb67d1~4hw1Z0j6M0821908219eucas1p1k;
        Mon,  2 Mar 2020 15:42:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.20.60679.0792D5E5; Mon,  2
        Mar 2020 15:42:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154239eucas1p1a0bec3246c7e62f1698b46fdd5f4d087~4hw0xJhk92477324773eucas1p1s;
        Mon,  2 Mar 2020 15:42:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154239eusmtrp1c9c4771037707be72791a4124d74faf1~4hw0wgOEh2922329223eusmtrp1g;
        Mon,  2 Mar 2020 15:42:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-39-5e5d29703169
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.20.08375.F692D5E5; Mon,  2
        Mar 2020 15:42:39 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154239eusmtip17adf9ee8f0c96b9ac9baa9a9c1ffce59~4hw0dpRVB1015510155eusmtip1j;
        Mon,  2 Mar 2020 15:42:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2] video: remove set but not used variable
 'mach64RefFreq'
To:     yu kuai <yukuai3@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Message-ID: <d2c1eb0f-2129-a658-b0ab-5c7c1ba203c1@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200120063327.43548-1-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87oFmrFxBrtPC1tc+fqezeJE3wdW
        i8u75rBZXHt3hs1izkI2i4WPbrA5sHm0HHnL6nG/+ziTx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        jROfMBfM5Kn4tPIySwPjD84uRg4OCQETiU9v3LsYuTiEBFYwSnS/P80M4XwBcqZPZoJwPjNK
        NEydAORwgnU8ub6UHSKxnFHi/fNXUM5bRomJK5eyglSxCVhJTGxfxQhiCwsESpyZuoAdxBYR
        UJC41fwCrIFZoIdR4sCXPSwgCV4BO4mu5b/YQY5iEVCROHvaCyQsKhAh8enBYVaIEkGJkzOf
        gJVzClhI7Jy3FMxmFhCXuPVkPhOELS/RvHU22A8SAovYJS71XGSHONtFYu/tk4wQtrDEq+Nb
        oOIyEqcn97BANKxjlPjb8QKqezujxPLJ/9ggqqwl7pz7xQZyHbOApsT6XfoQYUeJ6S+eMkJC
        kk/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy2iwk78xC8s4shL0L
        GFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaZ0/+Of9nBuOtP0iFGAQ5GJR7eAObY
        OCHWxLLiytxDjBIczEoivL6c0XFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnN
        Tk0tSC2CyTJxcEo1MIZd9n37uez6SZ9Yc6av6bsKmEq//k+vqrrbwa17hGFh696JRxZ0P41Q
        nSd+1nPnw/KjMm/qvtzh93I/ZOFwYqbAkaQm77XH0zNmMRXU5FtecC9OXNkl3MZQf0Ds+T+h
        Vf+Du9u6M/MXOnIfzV18wZ7xuUj8m8o73n5H2c0iel99/PDqG9vHbCWW4oxEQy3mouJEAAGa
        1YguAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7r5mrFxBptm61hc+fqezeJE3wdW
        i8u75rBZXHt3hs1izkI2i4WPbrA5sHm0HHnL6nG/+ziTx+dNcgHMUXo2RfmlJakKGfnFJbZK
        0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZjROfMBfM5Kn4tPIySwPjD84u
        Rk4OCQETiSfXl7J3MXJxCAksZZRYcewZYxcjB1BCRuL4+jKIGmGJP9e62CBqXjNK7LlyiQkk
        wSZgJTGxfRUjiC0sEChxZuoCdhBbREBB4lbzCzCbWaCHUeLXvHiI5m5Gibn/57CBJHgF7CS6
        lv9iB1nGIqAicfa0F0hYVCBC4vCOWYwQJYISJ2c+YQGxOQUsJHbOW8oCMVNd4s+8S8wQtrjE
        rSfzmSBseYnmrbOZJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGFPbjv3cvIPx0sbgQ4wCHIxKPLwBzLFxQqyJZcWVuYcYJTiYlUR4fTmj44R4UxIrq1KL
        8uOLSnNSiw8xmgL9NpFZSjQ5HxjveSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1ML
        Uotg+pg4OKUaGF2Cmw6Wbqhs31e3hn2+6gY30cqXL1/O+7n0zlplr3mVm56WvPz1YpFF716F
        mo+r/2gx/Lo+fWv6zCthv+zfPJv8+afH3XsyOyMTGpVm/31juPHllR6tiGKz3zFn7A+pzD1/
        WPiD57T+mlv7TymfEGs4ttn86HclvrdHoq4ukHioPWnzT235dT2HlViKMxINtZiLihMBCnfB
        dL8CAAA=
X-CMS-MailID: 20200302154239eucas1p1a0bec3246c7e62f1698b46fdd5f4d087
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200120063426eucas1p278d9f947fad536a5af16356afddab0e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200120063426eucas1p278d9f947fad536a5af16356afddab0e4
References: <CGME20200120063426eucas1p278d9f947fad536a5af16356afddab0e4@eucas1p2.samsung.com>
        <20200120063327.43548-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/20 7:33 AM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/mach64_gx.c: In function ‘aty_var_to_pll_8398’:
> drivers/video/fbdev/aty/mach64_gx.c:621:36: warning: variable
> ‘mach64RefFreq’ set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Patch queued for v5.7, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> changes in V2:
>  Fix the mistake that definition of 'mach64MinFreq' and 'mach64MaxFreq'
>  was removed.
> 
>  drivers/video/fbdev/aty/mach64_gx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
> index 27cb65fa2ba2..9c37e28fb78b 100644
> --- a/drivers/video/fbdev/aty/mach64_gx.c
> +++ b/drivers/video/fbdev/aty/mach64_gx.c
> @@ -618,14 +618,13 @@ static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
>  	u32 mhz100;		/* in 0.01 MHz */
>  	u32 program_bits;
>  	/* u32 post_divider; */
> -	u32 mach64MinFreq, mach64MaxFreq, mach64RefFreq;
> +	u32 mach64MinFreq, mach64MaxFreq;
>  	u16 m, n, k = 0, save_m, save_n, twoToKth;
>  
>  	/* Calculate the programming word */
>  	mhz100 = 100000000 / vclk_per;
>  	mach64MinFreq = MIN_FREQ_2595;
>  	mach64MaxFreq = MAX_FREQ_2595;
> -	mach64RefFreq = REF_FREQ_2595;	/* 14.32 MHz */
>  
>  	save_m = 0;
>  	save_n = 0;
> 
