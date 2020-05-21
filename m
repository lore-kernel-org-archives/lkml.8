Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885E020748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iw1k6LzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgEUV4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgEUV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:56:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:56:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f6so3961133pgm.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zj7wlorajH5QEGOvmukt5Ng2y7zQi2o9lvN+n4B6Bus=;
        b=iw1k6LzKCJq6WK0AdVAgBoDK+EWjot2oTJVT/KHAX7p+eCdQiphbcxF431SUFyUI4i
         OyNpBrzqs2JiBAUnOWvTfHFcLdrtbDfwHI0P8kYg1cNuFbcPVY16iDo0GxR2hmo1uu6A
         4SJ2dB17qspfCpVczaxcW/+IpJ0p3zGfCZKBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zj7wlorajH5QEGOvmukt5Ng2y7zQi2o9lvN+n4B6Bus=;
        b=aSGSgV8EUG5//POjoH6nYatDpD+Wxp/yTvwv2Iq4LVdcsHeR/D+TuuAORQkSc21C1T
         kKTbnhxkvO/5dT90I9hXD6idlml8I7m/rFM6oH9bMUCiXfB/4p6ORak85h0ONsB5ht3Q
         3U6B7D07vfeeIIF8q4faXUz3Fh1mVdzksgBwZJNi6ORecJ0fmCLJ0EcYoVBMzVM7yVnM
         TLtfnRuUO6D/sGdb5/+g73nDRyY8SdfvSsb3Xxvh5voWndK6rtA5GmyXC3czIlsahGWA
         +4U+WY02jqSCUJN4smRrdgj6UETtGxw/A+vyQqoXhrFdw8H02otHXQZgRUsmLnmqX7XF
         cYTw==
X-Gm-Message-State: AOAM533G00gA1kE/NF0i42WQqGRNcnvKKfCzyHa7iFqD7Dtb6avUxqzq
        X8EXl22VxO3D/gZIcGfmmJclsg==
X-Google-Smtp-Source: ABdhPJzCsFW0nm2Qct8yq42nWr1ZTuEp7ugkiSONj0p2gPfJLVqnYoYCLzuzUC+EeKuwrFn+US6BPQ==
X-Received: by 2002:a63:715a:: with SMTP id b26mr10709591pgn.433.1590098175026;
        Thu, 21 May 2020 14:56:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm5137607pjr.31.2020.05.21.14.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:56:14 -0700 (PDT)
Date:   Thu, 21 May 2020 14:56:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pstore/ram: Undefine the correct macro after a
 recent renaming
Message-ID: <202005211456.F9125761@keescook>
References: <20200521205223.175957-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521205223.175957-1-tyhicks@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:52:23PM -0500, Tyler Hicks wrote:
> Undefine parse_u32, instead of parse_size, as the name of the macro
> recently changed but the #undef directive wasn't updated at that time.
> 
> Fixes: 6b31e99b85b0 ("pstore/ram: Refactor DT size parsing")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
> 
> Hi Kees - Here's a minor fixup that I noticed was needed while reviewing
> your for-next/pstore branch. It is only build-tested but I think that's
> all that's needed here.

Whoops! Thanks; applied!

-Kees

> 
> Tyler
> 
>  fs/pstore/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index df8965817c7b..ca6d8a867285 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -674,7 +674,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	parse_u32("flags", pdata->flags, 0);
>  	parse_u32("max-reason", pdata->max_reason, pdata->max_reason);
>  
> -#undef parse_size
> +#undef parse_u32
>  
>  	/*
>  	 * Some old Chromebooks relied on the kernel setting the
> -- 
> 2.25.1
> 

-- 
Kees Cook
