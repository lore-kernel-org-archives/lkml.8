Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92206C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C11206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uTMKkCv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1AUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:20:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35457 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1AUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:20:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id t16so8501572lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/PGvAdlDpTAvB7KdpnM6fLatQ14ogwNqTHuTCTj8vrc=;
        b=uTMKkCv4mPz+vxre39ZpG3ohbpZ1KSoepLIPrRvYKRYwR9XSD/vNYjdkqMT4BRGGjU
         9kwBn0UH+Ms6hId660N1sBAHuAPWxzAWeugMJAHkFjWNNdtOpgD98XeKD5LVPJf2Q5pL
         TpDAqUaxR9EzteQ6zOn+BhK0CDJZc+PY5FWWFd6yZZVAx1ndv2/sSaUITY4D1b4ycADF
         jcFAZvwzA96l/3pHOnviyMV1atk9eVoMtI/kdtsZ+Juy2X0/uo6zUVVtt2cu4gkMSF8i
         wLs61ABuzTLDxQN5Q9YnxeGJa0Bc5y2K2ThKrRD8EUC2nXQx2EXKVqFuPP6zo73fuvw+
         dnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PGvAdlDpTAvB7KdpnM6fLatQ14ogwNqTHuTCTj8vrc=;
        b=NH814w7VtaQ8L7LXapi0yVVToQd43GeIjbkAD4hSVMw9byvXQdZcDdAlmemJ1lvOQX
         O3aEOFn/GYrVHlx7abxS9AFmYthXNB3Tq9PzEwdfOxYQcoJ4U4dffsOnjqKpLo8bwKpA
         CZU7kTHjXGx/HsWHKB+M4yLlw6cQBBjO2nLa+8dnkSXP3o7xmJlG3yI6bkGNmXoNciwT
         zsEUpQVjfEgfATEdLZDcSU/f2eK7iXFRS+TH7l+jRBjXNV84KOxs1oNwSoAGWmirbvIx
         aFDQYe35A8p5fgB5yo0uQ+owN2b8hQ8VEbLxabgRKWjLdWcA5M4eCEPb9UU8XRMUJg5T
         kDGw==
X-Gm-Message-State: AGi0PuYn2iCQe8BIccokU+YJkzEAeRetuw1NZWEA9qy6vFCH5500k8M4
        oNeNwANb2GLV2ZUV4ZaA0DmleA==
X-Google-Smtp-Source: APiQypI1dzxazGJf2mdV8Y25k+HN8OAvP36U5psGaYtZEqO0MsDmIh5lsZTOXJ7ykFOGzeBdPWB0fQ==
X-Received: by 2002:a19:6445:: with SMTP id b5mr1052563lfj.187.1585354837656;
        Fri, 27 Mar 2020 17:20:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h10sm3570540lfc.42.2020.03.27.17.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:20:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 62DE3100D24; Sat, 28 Mar 2020 03:20:41 +0300 (+03)
Date:   Sat, 28 Mar 2020 03:20:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of
 extra pins
Message-ID: <20200328002041.5tnoy67ruw7lavwx@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
 <D4EBA00D-BD65-4B7A-8C39-75DE43BD8CB8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4EBA00D-BD65-4B7A-8C39-75DE43BD8CB8@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 01:34:20PM -0400, Zi Yan wrote:
> On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:
> 
> > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > pagevec. It's petty common for swapin case: we swap in pages just to
> > fail due to the extra pin.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/khugepaged.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 14d7afc90786..39e0994abeb8 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >  		 * The page must only be referenced by the scanned process
> >  		 * and page swap cache.
> >  		 */
> > +		if (page_count(page) != 1 + PageSwapCache(page)) {
> > +			/*
> > +			 * Drain pagevec and retry just in case we can get rid
> > +			 * of the extra pin, like in swapin case.
> > +			 */
> > +			lru_add_drain();
> > +		}
> >  		if (page_count(page) != 1 + PageSwapCache(page)) {
> >  			unlock_page(page);
> >  			result = SCAN_PAGE_COUNT;
> >  			goto out;
> >  		}
> > +
> >  		if (pte_write(pteval)) {
> >  			writable = true;
> >  		} else {
> > -- 
> > 2.26.0
> 
> Looks good to me. Is the added empty line intentional?

Yes. It groups try and retry together.

-- 
 Kirill A. Shutemov
