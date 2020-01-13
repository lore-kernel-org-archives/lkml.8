Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A3C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7CA20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hdpFHpri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgAMWlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:41:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42514 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:41:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so11997713ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHYh9j36ArO/eqx7TqOqNjk3A/xrwDgvNGjQPzs8xj0=;
        b=hdpFHprijpWg7DyZBvcIOtbN2/3VYCwH51GiDFMYEerwnS1a9VLZQuARItAcv5M3ZH
         KDhPbZQqK569Xp7Inonuv1b3B8ie56ADZ20LljZfDqLsKHudNw8D0L8On93YNyR83ncX
         2y1lO2o4N2HfLDsijX6joDqf4y8V1pIDitcQuM2hWkDBB9q7CBWo+tTNpQs/l3uqPymB
         FBHFA5mG28M1OKIZjhjgB7YbqmgTwmXRg9h6cgv782B9zV5cJyQViHhET+007eRk/mbP
         nupDrBxPYvMXDgYMI7e4myHN4xk6Zd5mC9tTrwfPlrozXf/Z5SJ1apIBPK7Sk0mhxDXs
         WtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHYh9j36ArO/eqx7TqOqNjk3A/xrwDgvNGjQPzs8xj0=;
        b=no0g2NNXe84sjU0Or/+ckbMRafiNaEkprogAdLo4h2smgKPZigdw5weB2ztUtQnTrl
         z175pg7qYOQk7TifbwA65WykbJ6X3IE06K1xqCnH+puFnpoNApn9p5evAjnyF30A1PZ9
         AXe29edqfmPX0Rxo7SJBvKBCBQPiq2hoVHm22MYW16cfcJzgTFTGCG96jdFnVEXYhLg1
         +Csb7SO7IBPPdx6BXpv54PTJ+shM68jo9uDeadWbLC8p7oxP1fhYKuur6xZ0FzQnB6H0
         HyK5qMR7XMgOBdh2lRQHwotc+W0FOTIHrhmFOuQhNaCv+OE2d0WVLrCcRtbQ3p7tkXzb
         d2EQ==
X-Gm-Message-State: APjAAAUAD0JKW/UgBXnBlM0pLmHLHNRiG9e900sDmNH1n83/fHB6EM5z
        PGzOvCzcxBrTfI90S+j+haNYzvH5YF0=
X-Google-Smtp-Source: APXvYqyM6bVdRXM1Np0RA/KS4RuUn2PTWXgwaePejNo3d9j2PZ1Bth/CLngpBGsJCATkuKxmJUpENQ==
X-Received: by 2002:a2e:9744:: with SMTP id f4mr12863750ljj.120.1578955312988;
        Mon, 13 Jan 2020 14:41:52 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h24sm6581565ljc.84.2020.01.13.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:41:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9A28910052D; Tue, 14 Jan 2020 01:41:55 +0300 (+03)
Date:   Tue, 14 Jan 2020 01:41:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Message-ID: <20200113224155.efoekgw4hyey2by2@box>
References: <20200113144035.10848-1-david@redhat.com>
 <20200113144035.10848-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113144035.10848-3-david@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:40:35PM +0100, David Hildenbrand wrote:
> Let's move it to the header and use the shorter variant from
> mm/page_alloc.c (the original one will also check
> "__highest_present_section_nr + 1", which is not necessary). While at it,
> make the section_nr in next_pfn() const.
> 
> In next_pfn(), we now return section_nr_to_pfn(-1) instead of -1 once
> we exceed __highest_present_section_nr, which doesn't make a difference in
> the caller as it is big enough (>= all sane end_pfn).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mmzone.h | 10 ++++++++++
>  mm/page_alloc.c        | 11 ++---------
>  mm/sparse.c            | 10 ----------
>  3 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c2bc309d1634..462f6873905a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1379,6 +1379,16 @@ static inline int pfn_present(unsigned long pfn)
>  	return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
>  }
>  
> +static inline unsigned long next_present_section_nr(unsigned long section_nr)
> +{
> +	while (++section_nr <= __highest_present_section_nr) {
> +		if (present_section_nr(section_nr))
> +			return section_nr;
> +	}
> +
> +	return -1;
> +}
> +
>  /*
>   * These are _only_ used during initialisation, therefore they
>   * can use __initdata ...  They could have names to indicate
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a92791512077..26e8044e9848 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5852,18 +5852,11 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>  /* Skip PFNs that belong to non-present sections */
>  static inline __meminit unsigned long next_pfn(unsigned long pfn)
>  {
> -	unsigned long section_nr;
> +	const unsigned long section_nr = pfn_to_section_nr(++pfn);
>  
> -	section_nr = pfn_to_section_nr(++pfn);
>  	if (present_section_nr(section_nr))
>  		return pfn;
> -
> -	while (++section_nr <= __highest_present_section_nr) {
> -		if (present_section_nr(section_nr))
> -			return section_nr_to_pfn(section_nr);
> -	}
> -
> -	return -1;
> +	return section_nr_to_pfn(next_present_section_nr(section_nr));

This changes behaviour in the corner case: if next_present_section_nr()
returns -1, we call section_nr_to_pfn() for it. It's unlikely would give
any valid pfn, but I can't say for sure for all archs. I guess the worst
case scenrio would be endless loop over the same secitons/pfns.

Have you considered the case?

-- 
 Kirill A. Shutemov
