Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42827C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230DA20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgC3TIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:08:06 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46740 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC3TIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:08:05 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BD7EB20039;
        Mon, 30 Mar 2020 21:08:00 +0200 (CEST)
Date:   Mon, 30 Mar 2020 21:07:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     gregkh@linuxfoundation.org, Chen Wandun <chenwandun@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: don't use kmalloc() for the unicode screen buffer
Message-ID: <20200330190759.GE7594@ravnborg.org>
References: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
 <nycvar.YSQ.7.76.2003282214210.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2003282214210.2671@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dg4UtMH5AAAA:8
        a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8 a=2V0kcv-1AK-FgQnCDtkA:9
        a=CjuIK1q_8ugA:10 a=byNfn09xH3PuSfgbYLsR:22 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

On Sat, Mar 28, 2020 at 10:25:11PM -0400, Nicolas Pitre wrote:
> Even if the actual screen size is bounded in vc_do_resize(), the unicode 
> buffer is still a little more than twice the size of the glyph buffer
> and may exceed MAX_ORDER down the kmalloc() path. This can be triggered
> from user space.
> 
> Since there is no point having a physically contiguous buffer here, 
> let's avoid the above issue as well as reducing pressure on high order
> allocations by using vmalloc() instead.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Cc: <stable@vger.kernel.org>
> 
> ---
> 
> Changes since v1:
> 
> - Added missing include, found by kbuild test robot.
>   Strange that my own build doesn't complain.

When I did the drmP.h removal vmalloc was one of the header files
that turned up missing in many cases - but only for some architectures.
I learned to include alpha in the build.
If it survived building for alpha then I had fixed the majority
of the issues related to random inherited includes.

The patch itself looks good.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 15d2769805..d9eb5661e9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -81,6 +81,7 @@
>  #include <linux/errno.h>
>  #include <linux/kd.h>
>  #include <linux/slab.h>
> +#include <linux/vmalloc.h>
>  #include <linux/major.h>
>  #include <linux/mm.h>
>  #include <linux/console.h>
> @@ -350,7 +351,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>  	/* allocate everything in one go */
>  	memsize = cols * rows * sizeof(char32_t);
>  	memsize += rows * sizeof(char32_t *);
> -	p = kmalloc(memsize, GFP_KERNEL);
> +	p = vmalloc(memsize);
>  	if (!p)
>  		return NULL;
>  
> @@ -366,7 +367,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>  
>  static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
>  {
> -	kfree(vc->vc_uni_screen);
> +	vfree(vc->vc_uni_screen);
>  	vc->vc_uni_screen = new_uniscr;
>  }
>  
