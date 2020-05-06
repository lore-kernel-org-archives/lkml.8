Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C78EC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E74214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEFRs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:48:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:38754 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgEFRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:48:56 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5DBF280501;
        Wed,  6 May 2020 19:48:50 +0200 (CEST)
Date:   Wed, 6 May 2020 19:48:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de, arnd@arndb.de,
        jani.nikula@intel.com, akpm@osdl.org, adaplas@pol.net,
        rpurdie@rpsys.net, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: w100fb: Fix a potential double free.
Message-ID: <20200506174849.GG19296@ravnborg.org>
References: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427091945.57534-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=-sM3sDvmAAAA:8 a=p1g2r8j9AAAA:8 a=hD80L64hAAAA:8
        a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=0rnci6YRAtboiwCnBc0A:9
        a=CjuIK1q_8ugA:10 a=LUHx1oGsa4U61Z4w8267:22 a=GEd6vGEn79KL1p3bDQhq:22
        a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe
On Mon, Apr 27, 2020 at 11:19:45AM +0200, Christophe JAILLET wrote:
> Some memory is vmalloc'ed in the 'suspend' function and freed in the
> 'resume' function.
> However, it is also freed in the remove function.
> 
> In order to avoid a potential double free, set the corresponding pointer
> to NULL once freed in the 'resume' function.

The changelog talks about a suspend and a resume function.
But the code has a w100fb_save_vidmem() and a w100fb_restore_vidmem()
functions.

> 
> Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
This "Fixes" should be followed by:
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: <stable@vger.kernel.org> # v2.6.14+

This is the output of "dim fixes" - that does some magic to provide
the above list.
I filtered a few candidates out that should not be there.

Please fix both issues and resend.

Thanks,

	Sam


> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/fbdev/w100fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
> index 2d6e2738b792..d96ab28f8ce4 100644
> --- a/drivers/video/fbdev/w100fb.c
> +++ b/drivers/video/fbdev/w100fb.c
> @@ -588,6 +588,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
>  		memsize=par->mach->mem->size;
>  		memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
>  		vfree(par->saved_extmem);
> +		par->saved_extmem = NULL;
>  	}
>  	if (par->saved_intmem) {
>  		memsize=MEM_INT_SIZE;
> @@ -596,6 +597,7 @@ static void w100fb_restore_vidmem(struct w100fb_par *par)
>  		else
>  			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
>  		vfree(par->saved_intmem);
> +		par->saved_intmem = NULL;
>  	}
>  }
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
