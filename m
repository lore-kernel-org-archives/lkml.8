Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F31C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B00C2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BeX6rgmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBGCHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:07:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:07:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so653563otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 18:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvCOMTEZ/7iStxJtrD6tPP6xJ8Vye04ExaeRhOxsh7Y=;
        b=BeX6rgmG81vvCZ0nexPUUfbwEJgSXrjahRwqQ+nN+qyiSOiRp9PDYDBdOJb8AetnzE
         bD0CCpw+fG7Xyke43KqqqAUCqTq4ajrAqN6FBIRq7RY3ae2cY2WSmsOMcEsWVt8TsHWe
         7zFyxe/67QIsyrBHmyVAwZkTv7JxynLvwiVZGlMBatb7h6CwaUfYwW548/FUpcqU7yOm
         H+PB93h8nLAKHUke67jROUqxWc9vU+RZAogHknDerNbgometmHC89V/E8S6oCOJuX5bT
         5nLJW8q0UZi2+MzOBMPg15ZMZ5bkVL6d6QbQqf25YgztL5H1yRclFDw0CLacHe/ElT/j
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvCOMTEZ/7iStxJtrD6tPP6xJ8Vye04ExaeRhOxsh7Y=;
        b=sFJTqdr7QYprJzkYcGDoCjHnMX9cHw4glVFEV+KOGYA1/vQf0RBKz7Yzu1V1ldeitS
         MfAlUfsalQPEb7Y0jxP2VUH56yrcqBogMGTteOjJS0hWQGNaR3lDGhqU53iD7vC1Ywc9
         o232UAzqPugPMRzshJcnSZsFpCiHuJOUtPZ0ohLheqisufN5tAaI0xST7NIfM8Bfk6KJ
         Xoy9lypvp5isz1Uk4I3X/FSI5+y8uRozddAZgiS9Z0iFoQ36olFhwM32HiiMdEjb0B1y
         1DpbZXZYGZKlzQ2rokugknBVq6518VbJCsc7vxXWcPGIIQZP9wJRolhdJ3HWpxljShnh
         inFA==
X-Gm-Message-State: APjAAAXljMofQeoMOsaxxolPT7y4zaHUVyW3CiRvcSboqZdTy30suS+Z
        Kyj8Vr98r+I6CpuA4lQniyUexKKpnws1b7hTAj1hKg==
X-Google-Smtp-Source: APXvYqwbTeacTYp1FbbIjMHBoZ1uDlonyrMow/mDR6g1bLe0ShvKRNOXYAS5lwwul3iXnid6bcVNyv8aj2WLf8fRC50=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr838353otl.71.1581041225376;
 Thu, 06 Feb 2020 18:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20200206231629.14151-1-richardw.yang@linux.intel.com> <20200206231629.14151-4-richardw.yang@linux.intel.com>
In-Reply-To: <20200206231629.14151-4-richardw.yang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Feb 2020 18:06:54 -0800
Message-ID: <CAPcyv4hLW5Ww1Bo0MmNi8fzUNQEvudtWpGOK23MWaiqQ+MemfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/sparsemem: avoid memmap overwrite for non-SPARSEMEM_VMEMMAP
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
> In case of SPARSEMEM, populate_section_memmap() would allocate memmap
> for the whole section, even we just want a sub-section. This would lead
> to memmap overwrite if we a sub-section to an already populated section.
>
> Just return the populated memmap for non-SPARSEMEM_VMEMMAP case.
>
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 56816f653588..c75ca40db513 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -836,6 +836,16 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>         if (nr_pages < PAGES_PER_SECTION && early_section(ms))
>                 return pfn_to_page(pfn);
>
> +       /*
> +        * If it is not SPARSEMEM_VMEMMAP, we always populate memmap for the
> +        * whole section, even for a sub-section.
> +        *
> +        * Return its memmap if already populated to avoid memmap overwrite.
> +        */
> +       if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> +               valid_section(ms))
> +               return __section_mem_map_addr(ms);

Again, is check_pfn_span() failing to prevent this path?
