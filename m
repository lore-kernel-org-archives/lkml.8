Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490DBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="egbkHbC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbgBNSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:25:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45042 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388295AbgBNSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:25:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so11974832wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2v+GbDgoBeXkfNQ+uPKJ4b5v6lv/LCiGoeI5/c1pCwk=;
        b=egbkHbC31/YhDg1VmB5sT3a5h0Kd7EKe0qtYoL4U/ny71evn0bseAzLeKOqEEG0YPs
         g4FPsCzY2SHlrNVtlkq6L5/JwNrT52GXKeWzuUXkODzWvc1EdEbU6W8ZSNxsHm18+Fki
         icj3t5cRrP4ZGZWNYCCGYWVDv1gIOCpJtFBs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2v+GbDgoBeXkfNQ+uPKJ4b5v6lv/LCiGoeI5/c1pCwk=;
        b=S1BEMP63MR/KfDHXlJuDXswaEfiU4kzRsXScg4NpS9Zqpk8/gD4FYKesVFPOCH0j4y
         7xyR0wJnmWcMgzGPB1kjhuX6QNbAr1yveLxPekPlspheFiAz8ATN8N37eZLFRQclorwK
         h6OTMBvREEYsw69+0eyBFczxOTsWIoJGAFkr6djDsoGTGKUtBeeOgCmflEDYMbGtJ+qf
         HlCiR/t1/nfZDRYH2v2CUTJ3ib7wbVFQE0t4K08ukY4l71ov6KPIL3CmF3ihEtvpU44b
         KEmmlFO7ZoDnQ1A0tEcvkKKLRXsdt0zaA98d4NlooWoR0PcS/Jw9CilMQNl4Tn+zWAcr
         FPhg==
X-Gm-Message-State: APjAAAXVdt6LFD8uSejA5MEYy7NW2SkLnlk2l+4TvugiDV835Xuk1MGL
        djIBMcWpjbTMC9isYZflibT3Hw==
X-Google-Smtp-Source: APXvYqxvnSdhkfrz6JtmNai++r29ZoWmc0+KBKkFhTTQh97u0Qh45uAjpdW1mvHJ+nElDGQ1b6Sokw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr5202104wrm.131.1581704709694;
        Fri, 14 Feb 2020 10:25:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g21sm7939394wmh.17.2020.02.14.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:25:09 -0800 (PST)
Date:   Fri, 14 Feb 2020 19:25:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/mcde: Fix Sphinx formatting
Message-ID: <20200214182507.GX2363188@phenom.ffwll.local>
Mail-Followup-To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20200214163815.25442-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214163815.25442-1-j.neuschaefer@gmx.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 05:38:15PM +0100, Jonathan Neuschäfer wrote:
> - Format the pipe diagram as a monospace block.
> - Fix formatting of the list. Without the empty line, the first dash is
>   not parsed as a bullet point.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> Previous copy: https://lore.kernel.org/lkml/20191002153827.23026-2-j.neuschaefer@gmx.net/
> 
> It seems that this patch got lost, somehow.

Occasionally happens with the committer model we have, especially for
smaller drivers. Thanks for resending, applied to drm-misc-next now.
-Daniel

> ---
>  drivers/gpu/drm/mcde/mcde_drv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
> index 9a09eba53182..c535abed4765 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -20,11 +20,11 @@
>   * input formats including most variants of RGB and YUV.
>   *
>   * The hardware has four display pipes, and the layout is a little
> - * bit like this:
> + * bit like this::
>   *
> - * Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
> - * External      0..5       0..3       A,B,    3 x DSI         bridge
> - * source 0..9                         C0,C1   2 x DPI
> + *   Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
> + *   External      0..5       0..3       A,B,    3 x DSI         bridge
> + *   source 0..9                         C0,C1   2 x DPI
>   *
>   * FIFOs A and B are for LCD and HDMI while FIFO CO/C1 are for
>   * panels with embedded buffer.
> @@ -43,6 +43,7 @@
>   * to change as we exploit more of the hardware capabilities.
>   *
>   * TODO:
> + *
>   * - Enabled damaged rectangles using drm_plane_enable_fb_damage_clips()
>   *   so we can selectively just transmit the damaged area to a
>   *   command-only display.
> --
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
