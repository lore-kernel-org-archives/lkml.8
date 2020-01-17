Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B141C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgAQS7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:59:07 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:38102 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:59:07 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 34B2420026;
        Fri, 17 Jan 2020 19:59:05 +0100 (CET)
Date:   Fri, 17 Jan 2020 19:59:03 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 2/2] video: fbdev: wm8505fb: add COMPILE_TEST support
Message-ID: <20200117185903.GB24722@ravnborg.org>
References: <CGME20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa@eucas1p1.samsung.com>
 <900c16b3-9306-7d17-f467-0f98bc95416a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900c16b3-9306-7d17-f467-0f98bc95416a@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=hD80L64hAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=CiNoIfpPnEEG5fnF954A:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:58:08PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to wm8505fb driver for better compile
> testing coverage.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1639,7 +1639,7 @@ config FB_VT8500
>  
>  config FB_WM8505
>  	bool "Wondermedia WM8xxx-series frame buffer support"
> -	depends on (FB = y) && ARM && ARCH_VT8500
> +	depends on (FB = y) && HAS_IOMEM && (ARCH_VT8500 || COMPILE_TEST)
>  	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
>  	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
>  	select FB_SYS_IMAGEBLIT
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
