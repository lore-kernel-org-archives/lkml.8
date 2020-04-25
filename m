Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6AEC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F8F2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYPLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:11:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:45748 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgDYPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:11:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E7A392007A;
        Sat, 25 Apr 2020 17:11:08 +0200 (CEST)
Date:   Sat, 25 Apr 2020 17:11:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adaplas@gmail.com, b.zolnierkie@samsung.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/fbdev/riva: Remove dead code
Message-ID: <20200425151107.GH32235@ravnborg.org>
References: <1587407244-32574-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587407244-32574-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=O4SDoXPlVXmpIDEQGbEA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick
On Mon, Apr 20, 2020 at 11:57:24PM +0530, Souptick Joarder wrote:
> These are dead code since 3.15. These can be removed forever if no
> plan to use it further.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks. Patch applied to drm-misc-next.
It will appear in mianline kernel in next merge window.

	Sam


> ---
>  drivers/video/fbdev/riva/riva_hw.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
> index 0601c13..08c9ee4 100644
> --- a/drivers/video/fbdev/riva/riva_hw.c
> +++ b/drivers/video/fbdev/riva/riva_hw.c
> @@ -1343,24 +1343,6 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
>  /*
>   * Load fixed function state and pre-calculated/stored state.
>   */
> -#if 0
> -#define LOAD_FIXED_STATE(tbl,dev)                                       \
> -    for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
> -        chip->dev[tbl##Table##dev[i][0]] = tbl##Table##dev[i][1]
> -#define LOAD_FIXED_STATE_8BPP(tbl,dev)                                  \
> -    for (i = 0; i < sizeof(tbl##Table##dev##_8BPP)/8; i++)            \
> -        chip->dev[tbl##Table##dev##_8BPP[i][0]] = tbl##Table##dev##_8BPP[i][1]
> -#define LOAD_FIXED_STATE_15BPP(tbl,dev)                                 \
> -    for (i = 0; i < sizeof(tbl##Table##dev##_15BPP)/8; i++)           \
> -        chip->dev[tbl##Table##dev##_15BPP[i][0]] = tbl##Table##dev##_15BPP[i][1]
> -#define LOAD_FIXED_STATE_16BPP(tbl,dev)                                 \
> -    for (i = 0; i < sizeof(tbl##Table##dev##_16BPP)/8; i++)           \
> -        chip->dev[tbl##Table##dev##_16BPP[i][0]] = tbl##Table##dev##_16BPP[i][1]
> -#define LOAD_FIXED_STATE_32BPP(tbl,dev)                                 \
> -    for (i = 0; i < sizeof(tbl##Table##dev##_32BPP)/8; i++)           \
> -        chip->dev[tbl##Table##dev##_32BPP[i][0]] = tbl##Table##dev##_32BPP[i][1]
> -#endif
> -
>  #define LOAD_FIXED_STATE(tbl,dev)                                       \
>      for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
>          NV_WR32(&chip->dev[tbl##Table##dev[i][0]], 0, tbl##Table##dev[i][1])
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
