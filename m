Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F484C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A222072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifx83egn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgC0RrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:47:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39769 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0RrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:47:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so12268961edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl6M74fDKYNuH8RGWdOOCCv6ZP4dyjZ70PvCE1aC7GQ=;
        b=ifx83egnh61+hG/1a0lKBCQCmLlYS9+TKE+Yo3jgRE3LY7l7hLz+snpkDi/TJfnVSo
         tozJDHdlNGXlcu4jyUPuBaxB6Le71WOzFH6gUuhaj+D5ulqcJwDOZ/SvwNYbBfzYsMel
         OWTo+1fWpuyt+QKJzDVCvTfHemqcIeZZ1x2ajI2q3YDrc+5NAwXCxbE8rHylR2Ku+rGp
         CBU8rEnP3WuDCbrzGRxD/Fslrkh0syCkk4Pt6KVofOhljNAZJAXXxPnS4Z+1rwecUeOu
         9JK1d8Fg0FHBN27uz7b7z181nfV9IwQPLyLjlhMp/hN8AiL3Uf/8EDDkg+WA4g6FTfHu
         5cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl6M74fDKYNuH8RGWdOOCCv6ZP4dyjZ70PvCE1aC7GQ=;
        b=kUPLt+0bpfGMk0b82tb8z196vRj/4MA4cdwb5jFxbE/Ib+VquEmrfU6ACV6R7av7AY
         cyY1usHPovlqCondFJBxdXIrCdxRWJmnx4dftvEpm5sDpgW+mLbRoAmxyGa4JvZcz8NW
         F7MI9Ui648UjOOJrepueKoka0SBWs6x10xGDNGbUGjKajLWc1kAvFZowETC0kS2slZM5
         MwQbJmyJ/M1hEy7Sn623/kiQK38yDXXnF76/8vOwy5vNIzRYL1DJALDVIXm3HFAfvBxt
         s0dHX1jclN6nBveEkJScksKk7p8ow5lKhYZh7DTOgjlM6J9/AXmeqqh7kKauUiYsYV9+
         QCiw==
X-Gm-Message-State: ANhLgQ397rJLVD1kFBB81WqeL/ay3fr97MfSU7s7IsHia1k9J75jMYYW
        7Omd0aI8gFBq8f66lDHJJXdfIBp3udWm0I4kte7I6g==
X-Google-Smtp-Source: ADFU+vuNz8LGvg20VvbIcfg5Bu1FdbJR4PiA5lO7bRTDYECiX0Vg2LO3/1kSphKCavJm3xzTDVkEBGFdri5vVYruHgc=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr245921edf.372.1585331229996;
 Fri, 27 Mar 2020 10:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com> <20200327170601.18563-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200327170601.18563-3-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 10:46:55 -0700
Message-ID: <CAHbLzkom4C0qBdMouJF4U+C2my6qySyS6oM3v3Pihx68jfmUzQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] khugepaged: Do not stop collapse if less than half
 PTEs are referenced
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> __collapse_huge_page_swapin() check number of referenced PTE to decide
> if the memory range is hot enough to justify swapin.
>
> The problem is that it stops collapse altogether if there's not enough
> refereced pages, not only swappingin.

s/refereced/referenced

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
> ---
>  mm/khugepaged.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 99bab7e4d05b..14d7afc90786 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>         /* we only decide to swapin, if there is enough young ptes */
>         if (referenced < HPAGE_PMD_NR/2) {
>                 trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -               return false;
> +               /* Do not block collapse, only skip swapping in */
> +               return true;
>         }
>         vmf.pte = pte_offset_map(pmd, address);
>         for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
> --
> 2.26.0
>
>
