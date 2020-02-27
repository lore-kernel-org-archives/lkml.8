Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A2C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1D62468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="IE+UfxL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgB0Iqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:46:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38443 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgB0Iqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:46:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so1458520lfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rcCJN5mZnlo1jzA5HXBQb+gnAxrgqgh8cu4CBU1C/98=;
        b=IE+UfxL9scYb16xPi0I/AOr/2TtKR0nozlNtgQh4cx2xCoiAd0ujgGEJhkJ7EncvZV
         paYwzPs4FKAQ3ePUzOQPLsOi80T7pln7WLZuxDS//nBcmfylFayePwrNt7pum3/6EjJM
         brxDn2VSDSDUdCTDeF5flE6yfrboYPyjKDf8XWpYnKEXqPHWh08sKnjfOJE+sBu6sNyI
         9UgjIQy4yu4PwlTQ0rzrtfjZNJGxMKyKWB3ix/GDk57rGWAg4CQC4Wtq8uML069GMXif
         SOxCNlS/p1ZZZWhyMdZUooNG2MZR86WuZMO7js4OQE3g301NaCWWOLSA/Fxebe/XpF/0
         OsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcCJN5mZnlo1jzA5HXBQb+gnAxrgqgh8cu4CBU1C/98=;
        b=q6+f8RxZ+hmr1qViW/8Dyz2649KCwUv/NQWZQBMYsYjmZ8G/6hj0s43DFdWpYExm6j
         z5Fgdy4xoDVxmgf+3eXTsBhU6f8DFk3i/V/gZy6X3mZXPy1t0Hrt1ySYZy0gjx+Jsxap
         66bFRRuWQTqSL20tEun7duQURNVgHV7qYjCbJKIu1KkZJSfPEw60Tp79TJDNwNZKJBuW
         i8cN6bMlPw89XmHOPSuATw88pm7kDssrztVad8jQrP0JLRx6JiaiOZyDHxSF2ARDddVy
         4Ixb+0J5QWL4lyT2Ken8AxaxTiI7uhDy1ivfeNpl0Zh2+vJMMuPxjrxBQt1i5C68QqWq
         rrZg==
X-Gm-Message-State: ANhLgQ0OyR5vegUpBKKn6lDEg3S/LjR1I+7jbjTurgeN7jWl3o9krsYf
        ansYOlV8kM9g6L7ucalEE/jBUQ==
X-Google-Smtp-Source: ADFU+vtPpEh9w/nvwwTfoY3wx4BOMs7yoJlGAzfVaRxJs2/QaScv0S9uwx77oi/Udc9lxVmqk/2lIA==
X-Received: by 2002:a05:6512:10c2:: with SMTP id k2mr1636432lfg.0.1582793188498;
        Thu, 27 Feb 2020 00:46:28 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g18sm1098924ljn.32.2020.02.27.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 00:46:27 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B8C60100FC1; Thu, 27 Feb 2020 11:47:04 +0300 (+03)
Date:   Thu, 27 Feb 2020 11:47:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] huge tmpfs: try to split_huge_page() when punching hole
Message-ID: <20200227084704.aolem5nktpricrzo@box>
References: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 08:06:33PM -0800, Hugh Dickins wrote:
> Yang Shi writes:
> 
> Currently, when truncating a shmem file, if the range is partly in a THP
> (start or end is in the middle of THP), the pages actually will just get
> cleared rather than being freed, unless the range covers the whole THP.
> Even though all the subpages are truncated (randomly or sequentially),
> the THP may still be kept in page cache.
> 
> This might be fine for some usecases which prefer preserving THP, but
> balloon inflation is handled in base page size.  So when using shmem THP
> as memory backend, QEMU inflation actually doesn't work as expected since
> it doesn't free memory.  But the inflation usecase really needs to get
> the memory freed.  (Anonymous THP will also not get freed right away,
> but will be freed eventually when all subpages are unmapped: whereas
> shmem THP still stays in page cache.)
> 
> Split THP right away when doing partial hole punch, and if split fails
> just clear the page so that read of the punched area will return zeroes.
> 
> Hugh Dickins adds:
> 
> Our earlier "team of pages" huge tmpfs implementation worked in the way
> that Yang Shi proposes; and we have been using this patch to continue to
> split the huge page when hole-punched or truncated, since converting over
> to the compound page implementation.  Although huge tmpfs gives out huge
> pages when available, if the user specifically asks to truncate or punch
> a hole (perhaps to free memory, perhaps to reduce the memcg charge), then
> the filesystem should do so as best it can, splitting the huge page.

I'm still uncomfortable with proposition to use truncate or punch a hole
operations to manage memory footprint. These operations are about managing
storage footprint, not memory. This happens to be the same for tmpfs.

I wounder if we should consider limiting the behaviour to the operation
that explicitly combines memory and storage managing: MADV_REMOVE. This
way we can avoid future misunderstandings with THP backed by a real
filesystem.

>  }
>  
>  /*
> + * Check whether a hole-punch or truncation needs to split a huge page,
> + * returning true if no split was required, or the split has been successful.
> + *
> + * Eviction (or truncation to 0 size) should never need to split a huge page;
> + * but in rare cases might do so, if shmem_undo_range() failed to trylock on
> + * head, and then succeeded to trylock on tail.
> + *
> + * A split can only succeed when there are no additional references on the
> + * huge page: so the split below relies upon find_get_entries() having stopped
> + * when it found a subpage of the huge page, without getting further references.
> + */
> +static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
> +{
> +	if (!PageTransCompound(page))
> +		return true;
> +
> +	/* Just proceed to delete a huge page wholly within the range punched */
> +	if (PageHead(page) &&
> +	    page->index >= start && page->index + HPAGE_PMD_NR <= end)
> +		return true;
> +
> +	/* Try to split huge page, so we can truly punch the hole or truncate */
> +	return split_huge_page(page) >= 0;
> +}

I wanted to recommend taking into account khugepaged_max_ptes_none here,
but it will nullify usefulness of the feature for ballooning. Oh, well...

-- 
 Kirill A. Shutemov
