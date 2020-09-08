Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33854C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC18622CBE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CzyQpw5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgIHNF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 09:05:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44853 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgIHLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:37:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113644euoutp015f6ceec073618456f24a5a1693e6c304~yy_WHx45e0538805388euoutp01j
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200908113644euoutp015f6ceec073618456f24a5a1693e6c304~yy_WHx45e0538805388euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565004;
        bh=m5SiHGtB7aCZeEWY7mux4FUg5x879IROw2zkg7TBLFc=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=CzyQpw5K7szWGHITINdvKlIa5UqDlYA1UkJcYk5XZ3M6lvp7gzsyV3DA2PtPuVaG+
         fqbvwA+53JYkmMyknvJXXV4yktv8+oxkyuw73TtS+RKoLMZIiHDXlTOo95G0AR9vZr
         rF537hVoOZ/yq2I4oXbFRleIlWRLnzkTKINPEc6Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113644eucas1p103a7469440b3e66640ad0b64a26ff0aa~yy_V6qfQK0545005450eucas1p1z;
        Tue,  8 Sep 2020 11:36:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.3E.06456.BCC675F5; Tue,  8
        Sep 2020 12:36:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113643eucas1p17854ce62206401d0fdf33653380a4b46~yy_VfbuY61373613736eucas1p1Q;
        Tue,  8 Sep 2020 11:36:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908113643eusmtrp13517167108b3686fb356fa7757cb01ac~yy_Ve19p62002320023eusmtrp1Y;
        Tue,  8 Sep 2020 11:36:43 +0000 (GMT)
X-AuditID: cbfec7f2-c30869c000001938-5a-5f576ccb4b05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.94.06017.BCC675F5; Tue,  8
        Sep 2020 12:36:43 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200908113643eusmtip1a0e4ba746f1b94b17a4c1ddcf20074f6~yy_VIg-mD0442104421eusmtip1i;
        Tue,  8 Sep 2020 11:36:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: fix setting of pixclock because a
 pass-by-value error
To:     Colin King <colin.king@canonical.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ed082436-9ce3-23fd-679c-9cdf7b1da0cd@samsung.com>
Date:   Tue, 8 Sep 2020 13:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200723170227.996229-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87pncsLjDV70Mlr8Xt3LZrHw4V1m
        iytf37NZ7LnzmtFi6y1pixN9H1gtLu+aw+bA7jGroZfNY++3BSwei/e8ZPK4332cyePzJrkA
        1igum5TUnMyy1CJ9uwSujC0XO5gKTopVNEw4ztjAeFSwi5GTQ0LARKJ3TQt7FyMXh5DACkaJ
        n1OusEE4Xxglvr2dzwzhfGaU6D67hQWmZV3vBqiq5YwSa/vOMkI4bxklerZcAqtiE7CSmNi+
        ihHEFhaIklh85j3QEg4OEQFNifPnikDqmQUuMUpsnbsHrIZXwE7iyrJfbCA2i4CKxK+Tn5lA
        bFGBCIlPDw6zQtQISpyc+QRsPqeAvcTlw2/BbGYBcYlbT+YzQdjyEtvfzgE7W0JgG7vElnMf
        oM52kTj85AI7hC0s8er4FihbRuL05B4WiIZ1jBJ/O15AdW9nlFg++R8bRJW1xJ1zIOdxAK3Q
        lFi/Sx8i7Cixq/kLM0hYQoBP4sZbQYgj+CQmbZsOFeaV6GgTgqhWk9iwbAMbzNqunSuZJzAq
        zULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCah0/+Of9rB
        +PVS0iFGAQ5GJR7eD15h8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgZEzsutJzd+tjyZMqArffPbD0rbj5x0OC6bt
        5qhb1Sttn55R8++Qy2xzfReOTx4u1eteb4z2LtN8MMVWeply2Le9gT+XHuf9lTt/kqZT3P03
        GULWOis1xKNfW++zdDoXcsOUvyEnNto42/zQD/5Lu1aFrGNfxp8RxFEvfcC04KD4lzvi8jFz
        fiqxFGckGmoxFxUnAgCnkfvPPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7qnc8LjDQ4vUrX4vbqXzWLhw7vM
        Fle+vmez2HPnNaPF1lvSFif6PrBaXN41h82B3WNWQy+bx95vC1g8Fu95yeRxv/s4k8fnTXIB
        rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GVsu
        djAVnBSraJhwnLGB8ahgFyMnh4SAicS63g1sXYxcHEICSxkllnd/Yuxi5ABKyEgcX18GUSMs
        8edaF1TNa0aJxUdnsYIk2ASsJCa2r2IEsYUFoiQWn3nPDtIrIqApcf5cEUg9s8AlRokLR26w
        QzRPAmpe9gWsmVfATuLKsl9sIDaLgIrEr5OfmUBsUYEIicM7ZjFC1AhKnJz5hAXE5hSwl7h8
        +C2YzSygLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqc
        m55bbKRXnJhbXJqXrpecn7uJERhz24793LKDsetd8CFGAQ5GJR7eD15h8UKsiWXFlbmHGCU4
        mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgOsgriTc0NTS3sDQ0NzY3NrNQ
        EuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDo+at/9qLNq3j/LRO5nFlSXGZ2qrx4kx/PqYe3
        ny3jODC3bpF81+lJlp2rgmULtPonb9/88NuDNTO8OvfvbuIMnhj/sabt5sWi4G6hlX4zPnTW
        u/vaXcj77cxcKmHRM48hUH310zNVPXb9W7fMDJ+7V43Z5+5FR80TMs0LF2tGBrtKcDhIPRJV
        YinOSDTUYi4qTgQAKPrPVM8CAAA=
X-CMS-MailID: 20200908113643eucas1p17854ce62206401d0fdf33653380a4b46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200723170235eucas1p21b1e0f5ff092d550d65057ae2a31a897
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200723170235eucas1p21b1e0f5ff092d550d65057ae2a31a897
References: <CGME20200723170235eucas1p21b1e0f5ff092d550d65057ae2a31a897@eucas1p2.samsung.com>
        <20200723170227.996229-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/23/20 7:02 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pixclock is being set locally because it is being passed as a
> pass-by-value argument rather than pass-by-reference, so the computed
> pixclock is never being set in var->pixclock. Fix this by passing
> by reference.
> 
> [This dates back to 2002, I found the offending commit from the git
> history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git ]
> 
> Addresses-Coverity: ("Unused value")
> Fixes: 115f4504a64a ("Removed currcon and other console related code. Very little is now left.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next tree, thanks and sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/vga16fb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index a20eeb8308ff..52f273af6cae 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -243,7 +243,7 @@ static void vga16fb_update_fix(struct fb_info *info)
>  }
>  
>  static void vga16fb_clock_chip(struct vga16fb_par *par,
> -			       unsigned int pixclock,
> +			       unsigned int *pixclock,
>  			       const struct fb_info *info,
>  			       int mul, int div)
>  {
> @@ -259,14 +259,14 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
>  		{     0 /* bad */,    0x00, 0x00}};
>  	int err;
>  
> -	pixclock = (pixclock * mul) / div;
> +	*pixclock = (*pixclock * mul) / div;
>  	best = vgaclocks;
> -	err = pixclock - best->pixclock;
> +	err = *pixclock - best->pixclock;
>  	if (err < 0) err = -err;
>  	for (ptr = vgaclocks + 1; ptr->pixclock; ptr++) {
>  		int tmp;
>  
> -		tmp = pixclock - ptr->pixclock;
> +		tmp = *pixclock - ptr->pixclock;
>  		if (tmp < 0) tmp = -tmp;
>  		if (tmp < err) {
>  			err = tmp;
> @@ -275,7 +275,7 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
>  	}
>  	par->misc |= best->misc;
>  	par->clkdiv = best->seq_clock_mode;
> -	pixclock = (best->pixclock * div) / mul;		
> +	*pixclock = (best->pixclock * div) / mul;
>  }
>  			       
>  #define FAIL(X) return -EINVAL
> @@ -497,10 +497,10 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
>  
>  	if (mode & MODE_8BPP)
>  		/* pixel clock == vga clock / 2 */
> -		vga16fb_clock_chip(par, var->pixclock, info, 1, 2);
> +		vga16fb_clock_chip(par, &var->pixclock, info, 1, 2);
>  	else
>  		/* pixel clock == vga clock */
> -		vga16fb_clock_chip(par, var->pixclock, info, 1, 1);
> +		vga16fb_clock_chip(par, &var->pixclock, info, 1, 1);
>  	
>  	var->red.offset = var->green.offset = var->blue.offset = 
>  	var->transp.offset = 0;
> 
