Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A84C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B085120738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UmD7fc2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGKrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:47:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC7C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:47:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so49288590ljm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c4zOWiMBuWKCpqZ8aPumcYsriKbLm4Jn2DFC1mwxSck=;
        b=UmD7fc2iwqZvLp+mmy6hm1H1iy5fOh6zRn3plNJA0N+5enc5vvVBHa0goK3om+m4LN
         Ly+gbAsZMoDog/wUCKONcXjrfajynNEHyQ5he3BjP2frL3wdvei6oNKCjkQ7hpjyPJXR
         6RgxkI2uGqCVL9XTIlPUFf8I5eltNBTGM8fypDSzPJnckPAs4E9y7s7oujAsedQXUN9F
         oxoI3DACRsjiUy0tfUS9lP5EP9vpU77vQ01k61I9VZB0O5NTPcIvI10UEGVv1FUXrcm2
         WD9gywLW4BhvXQti2ujNKV15NTjBkwWVT5Mg6bQk8Ce1zUJRE0jGPwy1Wwg6OZ0I5AyY
         umyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4zOWiMBuWKCpqZ8aPumcYsriKbLm4Jn2DFC1mwxSck=;
        b=EI/dBKoGXt6lXk7aRYxDGvDn/i8i+F3qZBYCAoTkjm+wFfCRruX+Bc3rHocgtn2jUl
         5gbsazOsZ5FHHetX7eHQhkEmnhEMwsGbeRPS5dk7Maq+UVUowVpd9tvmYMdV6JZkWof2
         8jjIDJsIIZQCrmp+hxvi9eelk+/2cQk9wrd8zDQBNIjB/3njxUpMPECl1s2lTm5EZW9c
         OeDQFgxNqh4MpXvB6jFpqPJ7ok/lr1kC6UVKiZiSj/aq4r4uY6FYSePYb91wPDkgIlzx
         U/I4Iix74JdYcJVbgPMhU/pxVURCNeajNrlSsTi03ZbTXWeoLN/V1fS/jHQaK/tBJ8Sk
         QZ6w==
X-Gm-Message-State: AOAM532IdEwFwfxBfOvg4jA0CoTC8y0uIX+4eudFrP/IxR6tOkTWKElm
        07g+X+b7Xhh+V454MchkK6GrXQ==
X-Google-Smtp-Source: ABdhPJwc4iENCWbSc2RIqe5Z1KqMPSDm7uBllx/G5+oNqQXVXy0ErJmRPMCZKcejjGcxtpkAQaW+iQ==
X-Received: by 2002:a05:651c:c5:: with SMTP id 5mr5817285ljr.9.1594118842865;
        Tue, 07 Jul 2020 03:47:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i197sm9490917lfi.58.2020.07.07.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:47:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A857D10117C; Tue,  7 Jul 2020 13:47:22 +0300 (+03)
Date:   Tue, 7 Jul 2020 13:47:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 3/4] mm/mremap: calculate extent in one place
Message-ID: <20200707104722.j3awgkz4ncgm2bss@box>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200626135216.24314-4-richard.weiyang@linux.alibaba.com>
 <20200706100729.y2wbkpc4tyvjojzg@box>
 <20200707013856.GA27805@L-31X9LVDL-1304.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707013856.GA27805@L-31X9LVDL-1304.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:38:56AM +0800, Wei Yang wrote:
> On Mon, Jul 06, 2020 at 01:07:29PM +0300, Kirill A. Shutemov wrote:
> >On Fri, Jun 26, 2020 at 09:52:15PM +0800, Wei Yang wrote:
> >> Page tables is moved on the base of PMD. This requires both source
> >> and destination range should meet the requirement.
> >> 
> >> Current code works well since move_huge_pmd() and move_normal_pmd()
> >> would check old_addr and new_addr again. And then return to move_ptes()
> >> if the either of them is not aligned.
> >> 
> >> In stead of calculating the extent separately, it is better to calculate
> >> in one place, so we know it is not necessary to try move pmd. By doing
> >> so, the logic seems a little clear.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  mm/mremap.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/mm/mremap.c b/mm/mremap.c
> >> index de27b12c8a5a..a30b3e86cc99 100644
> >> --- a/mm/mremap.c
> >> +++ b/mm/mremap.c
> >> @@ -258,6 +258,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >>  		extent = next - old_addr;
> >>  		if (extent > old_end - old_addr)
> >>  			extent = old_end - old_addr;
> >> +		next = (new_addr + PMD_SIZE) & PMD_MASK;
> >
> >Please use round_up() for both 'next' calculations.
> >
> 
> I took another close look into this, seems this is not a good suggestion.
> 
>    round_up(new_addr, PMD_SIZE)
> 
> would be new_addr when new_addr is PMD_SIZE aligned, which is not what we
> expect.

Maybe round_down(new_addr + PMD_SIZE, PMD_SIZE)?

-- 
 Kirill A. Shutemov
