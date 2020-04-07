Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8898C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2CF20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDGTsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:48:30 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50210 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:48:30 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0EAE380533;
        Tue,  7 Apr 2020 21:48:26 +0200 (CEST)
Date:   Tue, 7 Apr 2020 21:48:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        boqun.feng@gmail.com, Russell King <linux@armlinux.org.uk>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        "moderated list:CYBERPRO FB DRIVER" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] video: Add missing annotation for
 cyber2000fb_enable_ddc() and cyber2000fb_disable_ddc()
Message-ID: <20200407194824.GA28801@ravnborg.org>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
 <20200403160505.2832-3-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403160505.2832-3-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=c_KzuGgbJLCNkQNsKyQA:9 a=CjuIK1q_8ugA:10
        a=Vxmtnl_E_bksehYqCbjh:22 a=pHzHmUro8NiASowvMSCR:22
        a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jules.

On Fri, Apr 03, 2020 at 05:05:02PM +0100, Jules Irenge wrote:
> Sparse reports warnings at cyber2000fb_enable_ddc()
> 	and cyber2000fb_disable_ddc()
> 
> warning: context imbalance in cyber2000fb_enable_ddc()
> 	- wrong count at exit
> 
> warning: context imbalance in cyber2000fb_disable_ddc()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at cyber2000fb_enable_ddc()
> 	and cyber2000fb_disable_ddc()
> 
> Add the missing __acquires(&cfb->reg_b0_lock) annotation
> Add the missing __releases(&cfb->reg_b0_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Thanks, added to drm-misc-next, so the patch will hit the kernel
when the merge windows opens the next time.

Was this the only locking relevant warning in fbdev?
I would expect a few more.

	Sam

> ---
>  drivers/video/fbdev/cyber2000fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
> index 460826a7ad55..513f58f28b0f 100644
> --- a/drivers/video/fbdev/cyber2000fb.c
> +++ b/drivers/video/fbdev/cyber2000fb.c
> @@ -1160,12 +1160,14 @@ EXPORT_SYMBOL(cyber2000fb_detach);
>  #define DDC_SDA_IN	(1 << 6)
>  
>  static void cyber2000fb_enable_ddc(struct cfb_info *cfb)
> +	__acquires(&cfb->reg_b0_lock)
>  {
>  	spin_lock(&cfb->reg_b0_lock);
>  	cyber2000fb_writew(0x1bf, 0x3ce, cfb);
>  }
>  
>  static void cyber2000fb_disable_ddc(struct cfb_info *cfb)
> +	__releases(&cfb->reg_b0_lock)
>  {
>  	cyber2000fb_writew(0x0bf, 0x3ce, cfb);
>  	spin_unlock(&cfb->reg_b0_lock);
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
