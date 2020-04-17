Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011FC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB19F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TXP1WCvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgDQOIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:08:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49871 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbgDQOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:08:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200417140817euoutp014b7b8255e591a0c9e0cbbe852b98fb4d~GoJjaee7_1953319533euoutp013
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:08:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200417140817euoutp014b7b8255e591a0c9e0cbbe852b98fb4d~GoJjaee7_1953319533euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587132497;
        bh=16upKzKyTiu3aFEpAG+ygdLfWOrTahFZ2E9DYh1WVz0=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=TXP1WCvDURwwVBUlAblrIcX+XlyFW7vaGKQ7TGAnlHDiMorHWeOE5+ue8XCSFMBaP
         33UfXO7WNyYAyq4KBtah1eFGcbuROAxM78XQMR+RF/q8ESD6oGe20Btt7mrrJQPJ/A
         g28iHMba2BZwkYeP0meKdA19syL76xPd729ZL3tk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200417140816eucas1p18745d66b72be5c656f74ba76e0792e08~GoJjRamCy2643126431eucas1p1M;
        Fri, 17 Apr 2020 14:08:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.DA.60698.058B99E5; Fri, 17
        Apr 2020 15:08:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200417140816eucas1p17126f1fc212d31f1fc5a9d3e60c18986~GoJjDpSlW1463014630eucas1p1G;
        Fri, 17 Apr 2020 14:08:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417140816eusmtrp1e2ddd70c971b0b5624b45003ca841c3f~GoJjDE5sY2264522645eusmtrp1V;
        Fri, 17 Apr 2020 14:08:16 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e6-5e99b850ae95
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.E0.07950.058B99E5; Fri, 17
        Apr 2020 15:08:16 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200417140816eusmtip1a9ffa33b586fcd376b7486c24b4cccea~GoJis6ED50847608476eusmtip1O;
        Fri, 17 Apr 2020 14:08:16 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] fbdev: s1d13xxxfb: add missed unregister_framebuffer
 in remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <903cffdd-2f4e-b825-0d2f-7ffd2d0fc4e0@samsung.com>
Date:   Fri, 17 Apr 2020 16:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200324132311.21729-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7oBO2bGGSxsMbO48vU9m8XsQy+Z
        LeadlLA40feB1eLyrjlsDqweO2fdZfe4332cyePzJrkA5igum5TUnMyy1CJ9uwSujP+PJrEW
        fBeoOHx7EmMD4wfeLkZODgkBE4kD1y6xdjFycQgJrGCU+Lv4IxuE84VRYtWxPywQzmdGickb
        fgCVcYC1XPnIDtItJLCcUeLoFTeImreMEpPObwRLsAlYSUxsX8UIYgsLREjMmjCLDcQWEVCX
        +LxrJ1gNs8BURonXt3JBbF4BO4lZ058xgdgsAqoSe5euYAGxRYF6Pz04zApRIyhxcuYTsDgn
        0PzvW9+xQMwRl7j1ZD4ThC0vsf3tHGaQgyQE+tklrs3+ywTxp4vEnKOHGCFsYYlXx7ewQ9gy
        Eqcn97BANKwD+r/jBVT3dkaJ5ZP/sUFUWUvcOfeLDeR9ZgFNifW79CHCjhKLfx1ngYQKn8SN
        t4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXknVkIexcwsqxi
        FE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITCyn/x3/uoNx35+kQ4wCHIxKPLwGPTPjhFgT
        y4orcw8xSnAwK4nwHnQDCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1
        CCbLxMEp1cB4/t4jnurY930mq415pll835domc9xLGiW4AJWK44Gz6BrF9I4JMNeqF969XLZ
        3McZvvYiqu3C3qvn7jF39Xnz5tjpXIHttrtbAhkV/3bxh4VNU78rnbY4e59vl2jBiU3sdtrT
        n1YzHNKZ/PWDy44T+U+2L/t/S8VWVbP0j2i74beSXT7xillKLMUZiYZazEXFiQDRZvRwKAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7oBO2bGGUzYp2xx5et7NovZh14y
        W8w7KWFxou8Dq8XlXXPYHFg9ds66y+5xv/s4k8fnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6
        hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gf8fTWIt+C5Qcfj2JMYGxg+8XYwcHBIC
        JhJXPrJ3MXJxCAksZZSYfm8PK0RcRuL4+rIuRk4gU1jiz7UuNoia14wSF87fYARJsAlYSUxs
        XwVmCwtESMyaMIsNxBYRUJf4vGsn2FBmgamMEhM6JzJCdPcySry4fQWsg1fATmLW9GdMIDaL
        gKrE3qUrWEBsUaBJh3fMgqoRlDg58wlYnBNo2/et78BsZqANf+ZdYoawxSVuPZnPBGHLS2x/
        O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbTt2M8t
        Oxi73gUfYhTgYFTi4TXomRknxJpYVlyZe4hRgoNZSYT3oBtQiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBcZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHx
        8tu9C6c63bKdEGIhMydBeO3159IH7+x48p8x2nlj95Tp6r25Gb9dVk4rObgzcg9Lrc4U4WZ1
        wxo9v1X5tZk3/s2cG2+kmm3+//glsw8C36+FzLpSUjbv6kLxo8cmWXjdf6z/yITD1fSdVkTu
        9Glv7AO3JfwsiUqZ6F+8YPdUp2tMu+JOu003UGIpzkg01GIuKk4EABB23TG7AgAA
X-CMS-MailID: 20200417140816eucas1p17126f1fc212d31f1fc5a9d3e60c18986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324132625eucas1p1dc7c0d591946a44d149418e3525630ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324132625eucas1p1dc7c0d591946a44d149418e3525630ed
References: <CGME20200324132625eucas1p1dc7c0d591946a44d149418e3525630ed@eucas1p1.samsung.com>
        <20200324132311.21729-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/20 2:23 PM, Chuhong Yuan wrote:
> The driver calls register_framebuffer() in probe but does not call
> unregister_framebuffer() in remove.
> Rename current remove to __s1d13xxxfb_remove() for error handler.
> Then add a new remove to call unregister_framebuffer().
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch queued for v5.8 (w/ extra newline removed), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> Changes in v3:
>   - Fix code style.
>   - Set __s1d13xxxfb_remove() to return void.
>   - Remove redundant check for info.
> 
>  drivers/video/fbdev/s1d13xxxfb.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index 8048499e398d..d51ef7619115 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -721,9 +721,7 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
>  		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
>  }
>  
> -
> -static int
> -s1d13xxxfb_remove(struct platform_device *pdev)
> +static void __s1d13xxxfb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  	struct s1d13xxxfb_par *par = NULL;
> @@ -749,9 +747,18 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  			pdev->resource[0].end - pdev->resource[0].start +1);
>  	release_mem_region(pdev->resource[1].start,
>  			pdev->resource[1].end - pdev->resource[1].start +1);
> +}
> +
> +static int s1d13xxxfb_remove(struct platform_device *pdev)
> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +
> +	unregister_framebuffer(info);
> +	__s1d13xxxfb_remove(pdev);
>  	return 0;
>  }
>  
> +
>  static int s1d13xxxfb_probe(struct platform_device *pdev)
>  {
>  	struct s1d13xxxfb_par *default_par;
> @@ -895,7 +902,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  bail:
> -	s1d13xxxfb_remove(pdev);
> +	__s1d13xxxfb_remove(pdev);
>  	return ret;
>  
>  }
> 
