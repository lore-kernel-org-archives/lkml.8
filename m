Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C73C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCC4206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5BasPFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgEDRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729839AbgEDRti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:49:38 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:49:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so261323qtt.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9O9pOv93g7JmOc2UpRRs5DUt0jFUPNWmQLQ3nDY1Vjc=;
        b=S5BasPFcYpNCX02Po60a7tIfWWh50cRfls4aZ8I6Zi7e2YDq8cgTPHA7QqOUNMY7n8
         8OB8NvLBMMSfoaiCEyDGke/7MZcdrOr/FwiL9Fv4Xyx+BH8Emf7of8pg/T0NyJkl8Esg
         Nx6bGhzRLerxuGWbM19JNvOvLwa0DA0+QgXzBchAPDrcMbv4aafsq0jXAZA4z26HP+o7
         iEwhatzAhhZyFg++5gRLUCOxYTL6637TbGHDZdxx48WPSlNWUsNhWUF+awyaEchH8Xgb
         uWuSeD/GlNCUfHODM0pVP00OJBNe2wq9YXVqbEE82j9u6y8zinuHXtPqpQD4jrg0pP7+
         Cz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9O9pOv93g7JmOc2UpRRs5DUt0jFUPNWmQLQ3nDY1Vjc=;
        b=R1dZQSxLPLmdPqHZg3bHfYlYTEg7836l/2ui64xzHf24Em5DZpU8l88EeDOYtJAxnc
         iIgrLR6+R3pSk8D55N0MYnSod35BVoHjGaHgDvhX1rrNWAwS0XidmMlSinr5L2oREZmo
         ClA1oIA0nK6gw8vdw/yRUjqy5bQq/kFG6mqP6OZZQw8mUxxHmwvcJ6lzKaDHR31BpT+u
         s29nCwnsn8M212jZgMiKfo/JkAb5A/c55uXOv8cifwA5AYg6AiKPYSz/24L4bjNkrknd
         zD8bcs48tZhmZQF38i/MzAh+NKkx7CtMdxjZCurz0+fwlS6Kd+TALkJPLv9NF3m7lWO0
         oCVg==
X-Gm-Message-State: AGi0PubbYsTT5r7FcyP6kUP0JWHs76yfYnjpi2TkmgvCHdnh5CDrA2tG
        dcU+xBRIRBRwEIAdFZGsb0GWkQ==
X-Google-Smtp-Source: APiQypITbt1cZYJweE1W6xTp3vnqrk2qUN/sIDoZBQOauDUv68RNU+RbcvLqS/MtFwfEPVmDlPlDRg==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr268950qtv.328.1588614577576;
        Mon, 04 May 2020 10:49:37 -0700 (PDT)
Received: from google.com ([2620:0:1003:510:c948:3327:92b6:e959])
        by smtp.gmail.com with ESMTPSA id k43sm12239311qtk.67.2020.05.04.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:49:36 -0700 (PDT)
Date:   Mon, 4 May 2020 13:49:33 -0400
From:   Richard Yeh <rcy@google.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Que <sque@chromium.org>,
        John Joseph <jnjoseph@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: Check the return value of
 gasket_get_bar_index()
Message-ID: <20200504174933.GA83381@google.com>
References: <20200501155118.13380-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501155118.13380-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 05:51:18PM +0200, Oscar Carter wrote:
> Check the return value of gasket_get_bar_index function as it can return
> a negative one (-EINVAL). If this happens, a negative index is used in
> the "gasket_dev->bar_data" array.
> 
> Addresses-Coverity-ID: 1438542 ("Negative array index read")
> Fixes: 9a69f5087ccc2 ("drivers/staging: Gasket driver framework + Apex driver")
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 8e0575fcb4c8..67325fbaf760 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -925,6 +925,10 @@ do_map_region(const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
>  		gasket_get_bar_index(gasket_dev,
>  				     (vma->vm_pgoff << PAGE_SHIFT) +
>  				     driver_desc->legacy_mmap_address_offset);
> +
> +	if (bar_index < 0)
> +		return DO_MAP_REGION_INVALID;
> +
>  	phys_base = gasket_dev->bar_data[bar_index].phys_base + phys_offset;
>  	while (mapped_bytes < map_length) {
>  		/*
> --
> 2.20.1
> 

Reviewed-by: Richard Yeh <rcy@google.com>
