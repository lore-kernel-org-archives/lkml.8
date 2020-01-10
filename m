Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF61C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDB22082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lm8HeRtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgAJOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:47:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46947 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgAJOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:47:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so2374925ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1rwufjQnA4g2FcEE+Hw9tHrpM49MduEVKVJ7Jw8thHc=;
        b=lm8HeRtO2UBly/vIgHQCWyFZx6yJ42674vP0/RRSdTeooHSRPGFtwJ4h+kfcxeoGJa
         lC0YKZS3mrRJglwt/Y33G1HvGLwTvOcQaLeyGE2yuohDnO1QqQa/Wopj8WbXBLkEB9u2
         BFWFVCSu2vsnd772rIns7oiZD7XW2DmE/Y6WvG0rruCR3UG7ghUAYhg8xuqBzsn5KT0K
         14+AnfSiQti/aw+klrKO5fiaNzo6c44l2O4YQ48EmpHMAOvR4AFMQG+MEyWYLZ6c3umH
         klJ1P52IDzrRpS7aU2iojRwQn1eOstpCkIzd5MLj56fUoG66LBc0hii/EI21YpQA9AlW
         YEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1rwufjQnA4g2FcEE+Hw9tHrpM49MduEVKVJ7Jw8thHc=;
        b=aJjHew0gfjsvkHm1mgCubTwnxciMEeWbbNkY2eJ2Kn9lNnKCrY5UGIOqqMdBoettyM
         zhq5MTjboWr3st797FliQR9bFAeK2gLwu6hVTnyUQD58d9LZUK++evL8ZP2JvmDXd4TO
         bwgdk2nDlv1U0plQBoxkoZX8WqhbJC9DfLGTnLTVpAnl9/Cp2sSo7nsi6FmuTdTqmObI
         3G5HrEpO37f7m91G86zTcOB26qgsIUVhitYxfoJ6mlO6Omjgp/dGIwo8M0sH9Ph4r4tg
         4ipq7TtveoAOvKZAEnOmJX+jP5pFjso4ohF2EdAeJ5V/s8tohhXg5rv4G2UrmA8CTdvY
         od6w==
X-Gm-Message-State: APjAAAUfMZj9Iy73DtzWJKxLQn9yrocixsC3hDvzjdoh1FKA238XyD6B
        814B0UvGDoTMeqzjJw8v1oFrYLVKfV8=
X-Google-Smtp-Source: APXvYqxz/vQGL11CyyNJM2Flh4SD0MmSYzBSxvp2JudE9NgZa+eXRt15IFtOs5rB5M3MWL4XmGFpcA==
X-Received: by 2002:a2e:9850:: with SMTP id e16mr665958ljj.268.1578667638712;
        Fri, 10 Jan 2020 06:47:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n11sm1104599ljg.15.2020.01.10.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:47:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AB8CE100C65; Fri, 10 Jan 2020 17:47:17 +0300 (+03)
Date:   Fri, 10 Jan 2020 17:47:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        "Jin, Zhi" <zhi.jin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/page_alloc: Skip non present sections on zone
 initialization
Message-ID: <20200110144717.xufpf4yjkjlngymy@box>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
 <20200108144044.GB30379@dhcp22.suse.cz>
 <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
 <20200110134547.v6ju5dxazknfjdj3@box>
 <de70ec09-492d-292b-0738-db1ce1f05673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de70ec09-492d-292b-0738-db1ce1f05673@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:34:49PM +0100, David Hildenbrand wrote:
> On 10.01.20 14:45, Kirill A. Shutemov wrote:
> > On Fri, Jan 10, 2020 at 02:15:26PM +0100, David Hildenbrand wrote:
> >> On 08.01.20 15:40, Michal Hocko wrote:
> >>> On Mon 30-12-19 12:38:28, Kirill A. Shutemov wrote:
> >>>> memmap_init_zone() can be called on the ranges with holes during the
> >>>> boot. It will skip any non-valid PFNs one-by-one. It works fine as long
> >>>> as holes are not too big.
> >>>>
> >>>> But huge holes in the memory map causes a problem. It takes over 20
> >>>> seconds to walk 32TiB hole. x86-64 with 5-level paging allows for much
> >>>> larger holes in the memory map which would practically hang the system.
> >>>>
> >>>> Deferred struct page init doesn't help here. It only works on the
> >>>> present ranges.
> >>>>
> >>>> Skipping non-present sections would fix the issue.
> >>>
> >>> Makes sense to me.
> >>>
> >>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>
> >>> That pfn inc back and forth is quite ugly TBH but whatever.
> >>
> >> Indeed, can we please rewrite the loop to fix that?
> > 
> > Any suggestions?
> > 
> > I don't see an obvious way to not break readablity in another place.
> > 
> 
> I'd probably do it like this (applied some other tweaks, untested)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cb766aac6772..a96b1ad1d74b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5859,6 +5859,22 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>         return false;
>  }
>  
> +static inline __meminit unsigned long next_present_pfn(unsigned long pfn)
> +{
> +#ifdef CONFIG_SPARSEMEM

I would rather keep it around function, but it's matter of taste.

> +       unsigned long section_nr = pfn_to_section_nr(pfn + 1);
> +
> +       /*
> +        * Note: We don't check the subsection bitmap, so this can produce
> +        * false positives when only subsections are present/valid. The
> +        * caller should recheck if the returned pfn is valid.
> +        */
> +       if (!present_section_nr(section_nr))
> +               return section_nr_to_pfn(next_present_section_nr(section_nr));

This won't compile. next_present_section_nr() is static to mm/sparse.c.

> +#endif
> +       return pfn++;
> +}
> +
>  /*
>   * Initially all pages are reserved - free ones are freed
>   * up by memblock_free_all() once the early boot process is
> @@ -5892,18 +5908,22 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>         }
>  #endif
>  
> -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +       pfn = start_pfn;
> +       while (pfn < end_pfn) {
>                 /*
>                  * There can be holes in boot-time mem_map[]s handed to this
>                  * function.  They do not exist on hotplugged memory.
>                  */
>                 if (context == MEMMAP_EARLY) {
> -                       if (!early_pfn_valid(pfn))
> +                       if (!early_pfn_valid(pfn)) {
> +                               pfn = next_present_pfn(pfn, end_pfn);
>                                 continue;
> -                       if (!early_pfn_in_nid(pfn, nid))
> -                               continue;
> -                       if (overlap_memmap_init(zone, &pfn))
> +                       }
> +                       if (!early_pfn_in_nid(pfn, nid) ||
> +                           overlap_memmap_init(zone, &pfn)) {
> +                               pfn++;
>                                 continue;
> +                       }
>                         if (defer_init(nid, pfn, end_pfn))
>                                 break;
>                 }
> @@ -5929,6 +5949,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                         set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>                         cond_resched();
>                 }
> +               pfn++;
>         }
> 
> 
> I played with using a "pfn = next_init_pfn()" in the for loop instead, moving all
> the checks in there, but didn't turn out too well.

Well, it's better than I thought, but... I'm fine either way.

-- 
 Kirill A. Shutemov
