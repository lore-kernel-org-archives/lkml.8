Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92046C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BCB2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MYor/+16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgCFKwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:52:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39995 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:52:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so1848633wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8x4FtQ0d/oXsHbBXZA0a8FImN+v9SImsm+MT1st6RXw=;
        b=MYor/+16j73bXX7/uGT0c3cBr72JfnsMFC9zRoQ8tKBqGaSnpuyBtQ/Pc2pT+i/T6+
         CadE482Jsn71oGcSH5NclZrfr7GH+WANRp/Nf85yOg0G8anIbUpha/p6B8Mwxcqx5yJ+
         dFkah+87JAvoVMiwxnQYqq5DlvArwxiNaUMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8x4FtQ0d/oXsHbBXZA0a8FImN+v9SImsm+MT1st6RXw=;
        b=ivN6mK62zzJY5QZWgO+XnXEo45w5eW9piozE5ebxizpSNk9ynzVki23QtHeLwzzPte
         TGQdevBkFvhgZNcvtguDZJAXDwVj6RZ3vEOqIOcXFEZpAkaouDxOOZPPRT27DpWj1N07
         aD9xUHe8V+T7jti04kycvW8l09EyGTt0ZGOVlgeXrLVOx51fOm6qcf1OZPzkVRUK4lMl
         VMv17wDixF7OYf+fLVUnfTvL0+XO/R0HXWY0KJjJnpUceYVK68N+uemZBReNprwbA0wb
         hTYhQVoCaHGriMz21OHCxg0y6AFqX/HdUPUAcesI8b/fhg7SZEV89ZpogFhrMWFNy0NS
         agKw==
X-Gm-Message-State: ANhLgQ02YGlYJsPjvjTlNUH4Acd2lsuABjgpr/wMvwUY5I67fQPChUaZ
        WULfk8mTEOKX+1AVysjUZo/UFA==
X-Google-Smtp-Source: ADFU+vvjzNcrEzP63jJVwo52keCCnOQtunBv4Ani1bZvt0MX8d8L9RvSU/GreJShkmBXFGphA1K55w==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr3261622wmc.129.1583491942868;
        Fri, 06 Mar 2020 02:52:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f6sm13125791wmc.9.2020.03.06.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:52:22 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:52:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/bridge/mhl.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200306105220.GX2363188@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200305110011.GA21056@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305110011.GA21056@embeddedor>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:00:11AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel


> ---
>  include/drm/bridge/mhl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/bridge/mhl.h b/include/drm/bridge/mhl.h
> index 1cc77bf38324..d96626a0e3fa 100644
> --- a/include/drm/bridge/mhl.h
> +++ b/include/drm/bridge/mhl.h
> @@ -327,13 +327,13 @@ struct mhl_burst_bits_per_pixel_fmt {
>  	struct {
>  		u8 stream_id;
>  		u8 pixel_format;
> -	} __packed desc[0];
> +	} __packed desc[];
>  } __packed;
>  
>  struct mhl_burst_emsc_support {
>  	struct mhl3_burst_header hdr;
>  	u8 num_entries;
> -	__be16 burst_id[0];
> +	__be16 burst_id[];
>  } __packed;
>  
>  struct mhl_burst_audio_descr {
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
