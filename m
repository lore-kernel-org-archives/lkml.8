Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C65C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61B206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XZbNSmnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgCLPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:14:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46568 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:14:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id f28so6720183qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2UkcErBA53F3BNjpYaCxrTKEMvELmNBoZLVc53UTNuI=;
        b=XZbNSmnYbFATBaIbpTUipLV83lZIYT3fG6Lz8aAQdvdznkQDhdjG+RaQZWCjN3owOo
         hO1fMsqQrMw5i7+h6CpTEUzGA3Z4+DExyBSGEy194RLf6DIxLyBMNkTvAzMxkVV04sRq
         eoqa6wP3Iwq1urq33qErLwSuawBElpP/xXauoUTAksGcIE+FXUYIEKCPf8Xbn+nGyaK8
         CU8EDjc+ZuXcxLMyZn4d9mYORoq3H3S0z0HAjZayMJCdknd0QOj38zL6fp4/uykf5V6q
         m8mlHJH41SKwZGMBxBmViR49ndlQ8YKiwFlDqMdWYFIsfBzjo7UsRAn8YSi1Ulh6cP8Q
         AcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2UkcErBA53F3BNjpYaCxrTKEMvELmNBoZLVc53UTNuI=;
        b=axGle/Dw3+hYDiZOLA3JCL6XWXuvQUH21+RsQ8cxEmnDh6MhhWmHm7cb8O6hB3QrHm
         3BXrKSz5q/px/ZWsKGqDEOmY7M84OSg+nEWLGwkcJbeac3cZ8CQBz2PELio3nXwmrnkQ
         Uxlm8lg8kUMxlHbuakbxUULTTvCzzU3mSpgd/PMQc27LR+SxuXfVQU405TecekPG02vK
         LqRD/m9qtXw2Y1bp81oB4+6EWsIo3NDxqVwdbVaTIfZasR+K2koCcU7nD2rAm0GZQOo6
         l0ye1wpjXUdGm9AYlapRGrdiIFKRkQH7+WIqz6jSp5lPZcdokD9MfwMWLXxpEtItZxcN
         ageg==
X-Gm-Message-State: ANhLgQ0rS8iKvio2x64n04udb6L/zOgEe5jOMFZwVu0BffJE+7+g2vOe
        8vdg/F2oQVSRi/E4Y8CvzcGNWQ==
X-Google-Smtp-Source: ADFU+vtLoe18dnuHtbiTmsGIJmCiYFC7FTXBUsqpOvPlnhGUpTSjH4ukDMQ8Cj7sng4y+MmYN3cyxQ==
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr8250896qkh.311.1584026065613;
        Thu, 12 Mar 2020 08:14:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ef6a])
        by smtp.gmail.com with ESMTPSA id y5sm10401364qkb.123.2020.03.12.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:14:24 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:14:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: protect the workingset on anonymous LRU
Message-ID: <20200312151423.GH29835@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 02:11:46PM +0900, js1304@gmail.com wrote:
> @@ -1010,8 +1010,15 @@ static enum page_references page_check_references(struct page *page,
>  		return PAGEREF_RECLAIM;
>  
>  	if (referenced_ptes) {
> -		if (PageSwapBacked(page))
> -			return PAGEREF_ACTIVATE;
> +		if (PageSwapBacked(page)) {
> +			if (referenced_page) {
> +				ClearPageReferenced(page);
> +				return PAGEREF_ACTIVATE;
> +			}

This looks odd to me. referenced_page = TestClearPageReferenced()
above, so it's already be clear. Why clear it again?

> +
> +			SetPageReferenced(page);
> +			return PAGEREF_KEEP;
> +		}

The existing file code already does:

		SetPageReferenced(page);
		if (referenced_page || referenced_ptes > 1)
			return PAGEREF_ACTIVATE;
		if (vm_flags & VM_EXEC)
			return PAGEREF_ACTIVATE;
		return PAGEREF_KEEP;

The differences are:

1) referenced_ptes > 1. We did this so that heavily shared file
mappings are protected a bit better than others. Arguably the same
could apply for anon pages when we put them on the inactive list.

2) vm_flags & VM_EXEC. This mostly doesn't apply to anon pages. The
exception would be jit code pages, but if we put anon pages on the
inactive list we should protect jit code the same way we protect file
executables.

Seems to me you don't need to add anything. Just remove the
PageSwapBacked branch and apply equal treatment to both types.

> @@ -2056,6 +2063,15 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  			}
>  		}
>  
> +		/*
> +		 * Now, newly created anonymous page isn't appened to the
> +		 * active list. We don't need to clear the reference bit here.
> +		 */
> +		if (PageSwapBacked(page)) {
> +			ClearPageReferenced(page);
> +			goto deactivate;
> +		}

I don't understand this.

If you don't clear the pte references, you're leaving behind stale
data. You already decide here that we consider the page referenced
when it reaches the end of the inactive list, regardless of what
happens in between. That makes the deactivation kind of useless.

And it blurs the lines between the inactive and active list.

shrink_page_list() (and page_check_references()) are written with the
notion that any references they look at are from the inactive list. If
you carry over stale data, this can cause more subtle bugs later on.

And again, I don't quite understand why anon would need different
treatment here than file.

> +
>  		if (page_referenced(page, 0, sc->target_mem_cgroup,
>  				    &vm_flags)) {
>  			nr_rotated += hpage_nr_pages(page);
> @@ -2074,6 +2090,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  			}
>  		}
>  
> +deactivate:
>  		ClearPageActive(page);	/* we are de-activating */
>  		SetPageWorkingset(page);
>  		list_add(&page->lru, &l_inactive);
> -- 
> 2.7.4
> 
