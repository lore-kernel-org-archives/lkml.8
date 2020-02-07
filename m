Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34EC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F4F21927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="repA3BNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGCT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:19:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45179 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBGCT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:19:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so675644otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 18:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bNX4611c68uTPwlDqh0AwoeptlDyMNJDpCMpisti+U=;
        b=repA3BNU8ntMmnv8TjrpEXQJYxL5dZe64rkBCGIJiTUOpJ30PucDwFrQHjkbWbbVlh
         kqj6hAN1Lr47QyPyFDBvom55wVefzJhj3bqFR88zHyhMbXA8o+7Ea2swJ3cRaHyyvWtu
         GRqE5Xo2lNjzlVFpVsEfSuJz1hJ191Yi6GjOwxCjb7VS2gz4y0L9G3EjLZsyQRuJNdOJ
         2ItaiJQ0m/06GVvsSbh88b/NL8TVu2WC5WGBEnpqY+UR7Ao3RpDX/yVcntNwTKnLFd1n
         8UJjUT8W3xFhVWHiutMllEoPZA6f992LvEcG8CBWTBch6lTqsbxHf4OivobD8SG9sKfU
         72zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bNX4611c68uTPwlDqh0AwoeptlDyMNJDpCMpisti+U=;
        b=aTxtWjZxp9So/lHYeS4Kw/Cwj/S6YO0w2v00L9LR9wFX08iivovRccvj1T9wthzKS8
         PEkkZW6nEKAcis0LjXuFA1uBX7PJIg/SbBRibF3CEKoNkg+iThiMKkoh4Kl1wQV/6fbp
         KGB0dYeTuw3+poQv1CfVYrM5MVqODKs8thwZVAikYzT8yR+Me+DHnjKboxhIaWK9Bd52
         qXKeunrqb9iy3UnONnKlGHrTTKR++vTnpCj8nec6e21LEovppOqtf5NpLGbTQIORkDkY
         +J23rozGbjDcD6gjKAHXavbNdEQYTGWmOn1rBhbimtiFqAoeeyrPZYs1EEcix6zmIKXs
         1tig==
X-Gm-Message-State: APjAAAWpkGFU7OQTuiBzcVz4lVz2kRwzG7gIxMvBABnVdYiXWiLy9E5S
        xyftexuf3wsICeK+qCW2URtcm/P/BFl0enmSxEZhIw==
X-Google-Smtp-Source: APXvYqyjoEgUDaBh2BqyNmMSzARPpTofPD+BGuupmiBWVJWPiaG8w1TxuQ92MR5Hbrrp+mGIzwdhfnHJwud8ycxi84g=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr865991otl.71.1581041997813;
 Thu, 06 Feb 2020 18:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com> <20200206231629.14151-3-richardw.yang@linux.intel.com>
In-Reply-To: <20200206231629.14151-3-richardw.yang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Feb 2020 18:19:46 -0800
Message-ID: <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> memmap should be the physical address to page struct instead of virtual
> address to pfn.
>
> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
> this point.
>
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b5da121bdd6e..56816f653588 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>         /* Align memmap to section boundary in the subsection case */
>         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>                 section_nr_to_pfn(section_nr) != start_pfn)
> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));

Yes, this looks obviously correct. This might be tripping up
makedumpfile. Do you see any practical effects of this bug? The kernel
mostly avoids ->section_mem_map in the vmemmap case and in the
!vmemmap case section_nr_to_pfn(section_nr) should always equal
start_pfn.
