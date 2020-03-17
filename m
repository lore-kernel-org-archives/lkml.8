Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E2BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD7205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgCQIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:17:57 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41114 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgCQIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:17:56 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3646A20044;
        Tue, 17 Mar 2020 09:17:52 +0100 (CET)
Date:   Tue, 17 Mar 2020 09:17:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
Message-ID: <20200317081751.GA1455@ravnborg.org>
References: <20200317071547.1008622-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317071547.1008622-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=IJv9LcIfAAAA:8
        a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8
        a=yHm9WYn_3syTCuk5iU0A:9 a=CjuIK1q_8ugA:10 a=cmr4hm9N53k6aw-X_--Q:22
        a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Tue, Mar 17, 2020 at 08:15:47AM +0100, Daniel Vetter wrote:
> We're getting some random other stuff that we're not relly interested
                                                       really

> in, so match only word boundaries. Also avoid the capture group while
> at it.
> 
> Suggested by Joe Perches.

You want a:
Suggested-by: Joe Perches <joe@perches.com>

The patch looks correct, but I am not fluent in perlish.

	Sam
> 
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: Joe Perches <joe@perches.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3005be638c2c..fc5d5aa53147 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5025,7 +5025,7 @@ F:	include/linux/dma-buf*
>  F:	include/linux/reservation.h
>  F:	include/linux/*fence.h
>  F:	Documentation/driver-api/dma-buf.rst
> -K:	dma_(buf|fence|resv)
> +K:	'\bdma_(?:buf|fence|resv)\b'
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DMA-BUF HEAPS FRAMEWORK
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
