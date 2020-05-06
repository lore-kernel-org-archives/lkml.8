Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F525C38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF38C2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEFTHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:07:06 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47374 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEFTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:07:06 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 09799804FE;
        Wed,  6 May 2020 21:07:02 +0200 (CEST)
Date:   Wed, 6 May 2020 21:07:01 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: valkyriefb.c: fix warning comparing
 pointer to 0
Message-ID: <20200506190701.GE8227@ravnborg.org>
References: <20200429140942.8137-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140942.8137-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=NiWkjFAJyjduSeFMYQYA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:09:42PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
> 0, suggest !E
> drivers/video/fbdev/valkyriefb.c:334:12-13: WARNING comparing pointer to
> 0
> drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
> 0
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/valkyriefb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
> index 4d20c4603e5a..8425afe37d7c 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -331,7 +331,7 @@ int __init valkyriefb_init(void)
>  		struct resource r;
>  
>  		dp = of_find_node_by_name(NULL, "valkyrie");
> -		if (dp == 0)
> +		if (!dp)
>  			return 0;
>  
>  		if (of_address_to_resource(dp, 0, &r)) {
> @@ -345,7 +345,7 @@ int __init valkyriefb_init(void)
>  #endif /* ppc (!CONFIG_MAC) */
>  
>  	p = kzalloc(sizeof(*p), GFP_ATOMIC);
> -	if (p == 0)
> +	if (!p)
>  		return -ENOMEM;
>  
>  	/* Map in frame buffer and registers */
> -- 
> 2.21.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
