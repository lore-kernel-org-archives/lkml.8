Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D99BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5667620734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nbZuEJ/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFAHru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:47:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49640 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:47:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200601074747epoutp03488da6f94da9e7f1f7bd4acb6cb89e65~UW-L9PXpx1373413734epoutp030
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200601074747epoutp03488da6f94da9e7f1f7bd4acb6cb89e65~UW-L9PXpx1373413734epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590997667;
        bh=I1XJhVwGb1aiZhRqaZu6fK9WRM7TeK3+lRgg314FF/Y=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=nbZuEJ/Sm8QyqdVBbrMkxwBe9USsCEOHAks1+0aF4FuXKJXCKzYQFjDOvZNqWz1lO
         nAxsVoyRJv9aZyvAxRP5flMFbEnmR6Yju1lbNBR0f9AB/R5PtqJnt37pLWomV9+2dI
         vSYosxBpxnGw83oZKpOkXpJ9s+74p2dpXMqJjX/4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200601074746epcas1p40dafe27ac966d4d18bff15421d5b5dab~UW-LPUWeR1074810748epcas1p4S;
        Mon,  1 Jun 2020 07:47:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49b6hx4tFZzMqYkr; Mon,  1 Jun
        2020 07:47:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.1C.28581.1A2B4DE5; Mon,  1 Jun 2020 16:47:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601074744epcas1p261de13984e22e1b95b32b51c86cedbab~UW-JHxyLo2653626536epcas1p25;
        Mon,  1 Jun 2020 07:47:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601074744epsmtrp25ccbb1d6aacc9e025449befbaa48a4fc~UW-JHACfy1541615416epsmtrp2B;
        Mon,  1 Jun 2020 07:47:44 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-ea-5ed4b2a15003
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.92.08382.0A2B4DE5; Mon,  1 Jun 2020 16:47:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200601074744epsmtip27344f96ffa2c1a08e2233ae2d4d2211a~UW-IzeW4z2383523835epsmtip2o;
        Mon,  1 Jun 2020 07:47:44 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH v5 6/6] drm: exynos: mixer: Add interconnect support
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Organization: Samsung Electronics
Message-ID: <7e42706f-2e69-79a6-d138-f2aa5e800270@samsung.com>
Date:   Mon, 1 Jun 2020 16:58:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200529163200.18031-7-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmnu7CTVfiDG4+4rW4P6+V0WLjjPWs
        Fle+vmezmL53E5vFpPsTWCzOn9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77Ba3G1ewWRx+085q
        MWPySzYHXo9NqzrZPO5c28Pmcb/7OJPH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+S
        mZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SokkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y8ma82wFC6QqTrVeY25g
        XC7axcjJISFgIjH3ehtrFyMXh5DADkaJ6VfnM0M4nxgl+v62sEM43xgldl9cxQzTsmHdVqiq
        vYwST2fvYIFw3jNKfLh2AqyKTUBLYv+LG2wgtrCAj8TjM9eA4hwcIgIxEuvfRYDUMwssYpJY
        O/03K0gNv4CixNUfjxlBbF4BO4nHm4+xgNgsAioSk3vWg9miAmESJ7e1QNUISpyc+YQFZCan
        gI3E05clIGFmAXGJW0/mM0HY8hLNW2eDHSohcIZD4vrM12wQH7hIzP32lgnCFpZ4dXwLO4Qt
        JfH53V6ommqJlSePsEE0dzBKbNl/gRUiYSyxf+lkJpDFzAKaEut36UOEFSV2/p7LCLGYT+Ld
        1x5WkBIJAV6JjjYhiBJlicsP7kKtlZRY3N7JNoFRaRaSb2YheWEWkhdmISxbwMiyilEstaA4
        Nz212LDABDm2NzGCE7GWxQ7GuW8/6B1iZOJgPMQowcGsJMI7Wf1SnBBvSmJlVWpRfnxRaU5q
        8SFGU2D4TmSWEk3OB+aCvJJ4Q1MjY2NjCxNDM1NDQyVx3pNWF+KEBNITS1KzU1MLUotg+pg4
        OKUamKrP3Uw4UzDDVj7wYNJT/QaJSWmtan66e7WmBn0U0Jmmd335h+fZ3C+KHxzR3TGTr0N5
        yeMox3ATT7m4W79fVH/YLf0k4NfC0zVHdoTtKdmg8+W3eN2up/NbrG5+TT3EaK/2zcl1yvpF
        K2yW7Fmgt+yhcHbMBWM+tqdZobuurX93/uO2j5q953gPMJyfJfXAVWJ7nUPzh38dl4+YPVy7
        tWVav0OFZlWEWulyz7SS9sU5SgsVdsz5o7lCdYsc27Tv/7MqO9jTipjyzW+uCQyeu1rs1lbp
        9AnMWne3fteWnmn9ewXPvlNaExY6sXus6L1k0TA16ITbKTf3jTe3hq96k1W0805o+dUC1tb0
        oo1f3X8rsRRnJBpqMRcVJwIA+u6R300EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvO6CTVfiDB7+EbG4P6+V0WLjjPWs
        Fle+vmezmL53E5vFpPsTWCzOn9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77Ba3G1ewWRx+085q
        MWPySzYHXo9NqzrZPO5c28Pmcb/7OJPH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWx
        ZM15toIFUhWnWq8xNzAuF+1i5OSQEDCR2LBuK3MXIxeHkMBuRonvU34xQSQkJaZdPAqU4ACy
        hSUOHy6GqHnLKPHnawsLSA2bgJbE/hc32EBsYQEficdnrjGD2CICMRKnJs8Cq2EWWMQk8aJJ
        GaL5IKPEru+TwRr4BRQlrv54zAhi8wrYSTzefAysgUVARWJyz3owW1QgTGLnksdMEDWCEidn
        PmEBOYhTwEbi6csSiPnqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFReBaS7llIWmYhaZmFpGUB
        I8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgiNTS3MG4fdUHvUOMTByMhxglOJiV
        RHgnq1+KE+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZqakFqEUyWiYNTqoFp
        3bGMpY6KAjeXR85ocxW2thLtm6j3K9ro3KJVK/4c0EwSlevp+yhcf8u2IkHxb9HMyKjKrxPt
        c2MSty6dta1ZxGbSWX2Fr6brGeQtsvZZ5PCv2Z0rf9Im076wd4LA8vQrWy8fcnrkt2jyL41m
        /rN9lzds5/tob/pt8c3LW2efubmSV+XrLmvrqzmZfp1P9xms4QruZ85VXdgrOOP1uft955em
        GMvnv7K/PrPp7dFH+95/ZD0QsfBn0F3mavXSr1FanvMKy7SMr7V9mPhz6tZPJYFRyTNf3v13
        zTNH6rLTpKfK8WGniuZ8YWqI3PZj510hd3dvNe6Fe57tmlN/jFHT9Lq6loX55NViC5LfXLiw
        SomlOCPRUIu5qDgRAGsy97Q3AwAA
X-CMS-MailID: 20200601074744epcas1p261de13984e22e1b95b32b51c86cedbab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde@eucas1p2.samsung.com>
        <20200529163200.18031-7-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 5/30/20 1:32 AM, Sylwester Nawrocki wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This patch adds interconnect support to exynos-mixer. The mixer works
> the same as before when CONFIG_INTERCONNECT is 'n'.
> 
> For proper operation of the video mixer block we need to ensure the
> interconnect busses like DMC or LEFTBUS provide enough bandwidth so
> as to avoid DMA buffer underruns in the mixer block. i.e we need to
> prevent those busses from operating in low perfomance OPPs when
> the mixer is running.
> In this patch the bus bandwidth request is done through the interconnect
> API, the bandiwidth value is calculated from selected DRM mode, i.e.
> video plane width, height, refresh rate and pixel format.
> 
> Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> [s.nawrocki: renamed soc_path variable to icc_path, edited commit desc.]
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v5:
>  - renamed soc_path variable to icc_path
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 73 ++++++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 21b726b..bdae683 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -13,6 +13,7 @@
>  #include <linux/component.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -98,6 +99,7 @@ struct mixer_context {
>  	struct exynos_drm_crtc	*crtc;
>  	struct exynos_drm_plane	planes[MIXER_WIN_NR];
>  	unsigned long		flags;
> +	struct icc_path		*icc_path;
>  
>  	int			irq;
>  	void __iomem		*mixer_regs;
> @@ -934,6 +936,42 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
>  	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
>  }
>  
> +static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
> +{
> +	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
> +	struct mixer_context *ctx = crtc->ctx;
> +	unsigned long bw, bandwidth = 0;
> +	u32 avg_bw, peak_bw;
> +	int i, j, sub;
> +
> +	if (!ctx->icc_path)
> +		return;
> +
> +	for (i = 0; i < MIXER_WIN_NR; i++) {
> +		struct drm_plane *plane = &ctx->planes[i].base;
> +		const struct drm_format_info *format;
> +
> +		if (plane->state && plane->state->crtc && plane->state->fb) {
> +			format = plane->state->fb->format;
> +			bw = mode->hdisplay * mode->vdisplay *
> +							drm_mode_vrefresh(mode);
> +			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +				bw /= 2;
> +			for (j = 0; j < format->num_planes; j++) {
> +				sub = j ? (format->vsub * format->hsub) : 1;
> +				bandwidth += format->cpp[j] * bw / sub;

First of all, I agree this approach.

Could you please add more detailed comments for understadning
about this calculation? As you commented, it seems that
the final bandwidth contains the width/height/refresh rate
and pixel format. If you add one real example, it will be very helpful.


(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
