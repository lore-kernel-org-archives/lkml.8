Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57020C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FAD222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583932917;
	bh=5y8xGr0LyTBUCWo725QctGIq4zafP/QOt9DMF+QjAfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzWQnD0VuQpZemRCrGWn3JealOSVtYbK430+n7c4K3zIL6p8BtqZuzT0+Lprgi241
	 9SR5CBX9gdbR3gZcdBfagm9uJZ3hnmdvOKJxj0GV0YdgDeBajBy7ixwqY2oc+jzZsZ
	 b0Spbr6eZiPQa/IxP5Hc5DzmkLUilSvdnp5DcyGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgCKNV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgCKNV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:21:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7624B21655;
        Wed, 11 Mar 2020 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583932914;
        bh=5y8xGr0LyTBUCWo725QctGIq4zafP/QOt9DMF+QjAfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkDcCuPyYEZGcrv86SLVQuguuW/E1m1gK0iIkKbNL9o8fOIKzhybZvUdFI0FoYYBg
         zqcCPzewilogs4PgMZZcioeyPfWsvxlozdCu7QSRVBVNsmwGK5JX46enBEMtyAw64m
         qwqPIu0Dm+p4YZF6UcbDKligOMnWJIrXvD7HUVAE=
Date:   Wed, 11 Mar 2020 14:21:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] DRM: ARC: PGU: interlaced mode not supported
Message-ID: <20200311132152.GA3902788@kroah.com>
References: <20200311131310.20446-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311131310.20446-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 04:13:10PM +0300, Eugeniy Paltsev wrote:
> Filter out interlaced modes as they are not supported by ARC PGU
> hardware.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
> index 8ae1e1f97a73..c854066d4c75 100644
> --- a/drivers/gpu/drm/arc/arcpgu_crtc.c
> +++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
> @@ -67,6 +67,9 @@ static enum drm_mode_status arc_pgu_crtc_mode_valid(struct drm_crtc *crtc,
>  	long rate, clk_rate = mode->clock * 1000;
>  	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
>  
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		return MODE_NO_INTERLACE;
> +
>  	rate = clk_round_rate(arcpgu->clk, clk_rate);
>  	if ((max(rate, clk_rate) - min(rate, clk_rate) < diff) && (rate > 0))
>  		return MODE_OK;
> -- 
> 2.21.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
