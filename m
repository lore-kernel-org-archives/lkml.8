Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A9CC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4B20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SyhzjwkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgBKUPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:15:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42464 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgBKUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:15:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so11446479otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r5sdmKSui2jkFEssHxa47Vgdv1m3DYrrp63QiGVUWU=;
        b=SyhzjwkHErCbUOCJB9v+V0MEyf0YZslhfgemR1Wa7kQ/cQl+D3o+iJmTJ74y0V6b3B
         DhL5v0UbHmtsVa71tU1V2ntxYCvkzXwbCgEnYcdO/V4WP9QeBWumIlpFYYnInEBkejt4
         QJEzkMGfatMxdKGl8BJWsQVq7Fxn0M2WOUHjuPIAavC0fBiiLTPf8CYG08yiL8LOh1b5
         KlV7fV9/+AN1CccpIcHfSBk3gC0658VEQuQ757ZKtWsEJqgbuIi222Pid0cZoGRWaebY
         cKT6uVEDXfH654iGowix3kTK5hcaNdZ0Zkwt9ZG9uY6oOgoR4UGNF5dWnqv2g50eKnhm
         Lj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r5sdmKSui2jkFEssHxa47Vgdv1m3DYrrp63QiGVUWU=;
        b=Pes37ikf1Zg9psQ1Mtqlxy1/t0P8g73ylmxtGImKENlnXuofEuqDU70aPjH5Iv2yfz
         grMrM/HbuJcyGGOyDwRrJ0Tn7mupm5gVQMEdwn/BBQcOFv2cD2Y5gmLlK3YtpNwpipSW
         ZyAIp9ZSWmv7UITmSz7fr7rX8WTgc+5b4PylFP7i4QWu8GZSi4rdMaKePjb5gAa6odwA
         bBbgfBAztm0QphYRFyK63BOl3Y4kDwucirUjHgRAgjffQMvqkxGCYbkdFQynFwNfg3Pz
         oPP2/FPtU/z+4PKBH5FjRqQOX6ejXRJtD+T2+u2roxzVxqnHtXL+2/INPtV1f1llhYjJ
         yoNQ==
X-Gm-Message-State: APjAAAXJ55nGJflO2zr9hr7uozr0WpfeWfwPhDQtz1KAt2zUOW/SyjJd
        XxtbWGOT0iixReXhH3Gy4yUt0gltprskLodBBrXpkw==
X-Google-Smtp-Source: APXvYqxCO2vjDzqg2Wf3u7DvKpzrHIpdZMTKL+99aibgNhoImTuE5JpfK7MjgzVTYjQBRysk97bJ/nW+lq+4JImGTFo=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr6540670otq.126.1581452105359;
 Tue, 11 Feb 2020 12:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20200209104826.3385-1-bhe@redhat.com> <20200209104826.3385-4-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-4-bhe@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Feb 2020 12:14:54 -0800
Message-ID: <CAPcyv4hh5PmF8qU+p7Q903PhX+ho9yHMzLFncmh6psW5YOLU_w@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 2:48 AM Baoquan He <bhe@redhat.com> wrote:
>
> Currently, subsection map is used when SPARSEMEM is enabled, including
> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> and misleading. Let's adjust code to only allow subsection map being
> used in SPARSEMEM|VMEMMAP case.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/mmzone.h |   2 +
>  mm/sparse.c            | 231 ++++++++++++++++++++++-------------------
>  2 files changed, 124 insertions(+), 109 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..fc0de3a9a51e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>  #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
>
>  struct mem_section_usage {
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>         DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> +#endif

This was done deliberately so that the SPARSEMEM_VMEMMAP=n case ran as
a subset of the SPARSEMEM_VMEMMAP=y case.

The diffstat does not seem to agree that this is any clearer:

    124 insertions(+), 109 deletions(-)
