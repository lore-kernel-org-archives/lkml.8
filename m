Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 20:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4445206A1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEaU6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 16:58:25 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36624 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 16:58:24 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C79CB80518;
        Sun, 31 May 2020 22:58:20 +0200 (CEST)
Date:   Sun, 31 May 2020 22:58:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to
 pin_user_pages*()
Message-ID: <20200531205819.GC138722@ravnborg.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522041506.39638-1-jhubbard@nvidia.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=hD80L64hAAAA:8 a=_Wotqz80AAAA:8 a=QyXUC8HyAAAA:8
        a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=0vaWVN_RBqfUHpfuwWIA:9
        a=CjuIK1q_8ugA:10 a=buJP51TR1BpY-zbLSsyS:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.
On Thu, May 21, 2020 at 09:15:04PM -0700, John Hubbard wrote:
> Hi,
> 
> Note that I have only compile-tested this series, although that does
> also include cross-compiling for a few other arches. I'm hoping that
> this posting will lead to some run-time testing.
> 
> Also: the proposed fix does not have a "Fixes:" tag, nor does it
> Cc stable. That's because the issue has been there since the dawn of
> git history for the kernel. If it's gone unnoticed this long, then
> there is clearly no need for the relatively fast track of putting it
> into stable, IMHO. But please correct me if that's wrong.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Thanks, patches are now applied to drm-misc-next.
They will hit -next soon, but you will have to wait
until next (not the upcoming) merge window before they hit
mainline linux.

	Sam

> 
> John Hubbard (2):
>   video: fbdev: fix error handling for get_user_pages_fast()
>   video: fbdev: convert get_user_pages() --> pin_user_pages()
> 
>  drivers/video/fbdev/pvr2fb.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 051143e1602d90ea71887d92363edd539d411de5
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
