Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B96FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088E6206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="swQL9Vex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBLPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:48:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33232 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:48:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so2382025otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RiyUJRYQDifXthKtqUrBbgC+x2gDb+r3PWtg2ESrB1w=;
        b=swQL9VexYbth8r+D/qtA6NetBD0R3raRgaQ4oy5J6NJ1r+6/nXd5n5NsS5Hy2hWs46
         y4a8JArUVroppmcYoL8ypMTww971R/cBRepn1qFuyDanwF3UgtUNDH/xPxyiD2TA/xXB
         wRVfymO8i5ofcecJopl4yfDjNhh1jEnteA7pIH/r1qB8G6dXghwO0BcuWJiOy4fF++Ra
         z/6AxPB84iuSvaBsLmx00garTeak/2JsWj4e9edNfqTMdBfC807VGvOfmooocARAPoTy
         EjYcgY1AAr32Srv+Idh+nYq+30IOExJq8btsQ33OJLnQTDvo3lUyi176CDrs7JgnejIJ
         olQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RiyUJRYQDifXthKtqUrBbgC+x2gDb+r3PWtg2ESrB1w=;
        b=K4vRqVxo2dllH5NO1MtVpqL/E9mOdF/lYRbkoG1ffHv33IjDZXma9HjJ7i07je5fgX
         lqayFxWcmDDfi9NkGZ1S0LCkkt4jWnzNuUBTRI81A3m5ogdjC94bDXY7aVSyJT4C72nq
         my9WilMPNnhsEVvQY/WdDtt4o1FjCBvweRBohIGaD1oH5R/Hyl4cIDWd5H2rRd6hKtuA
         6y5kiOJWdK2/TRQUKbX3j4ytVlNJvhISSihoM+mJbFmnDWN2DMV+X22yiUK5ZldPHPyA
         7Au+FZtVL1MygV6PVqVGFIL+6B5NJlcTbpmLktVBWp1a8YUG4FhVcr5EzfB1ASt251ty
         oJEw==
X-Gm-Message-State: APjAAAVcqTJE/SuP0rf01dmaCTFUYwUZ1xQNxXhQoRfItl+HRyg8t0/S
        1w1zHMowYfyNgIm+QTH/lRLCMXKae0OXY+DlUO+DcQ==
X-Google-Smtp-Source: APXvYqzkjXbITWirupoZS9AfRvX1l5mT56B21Pa40DgCijG7jRmiXTEZben3bZrT7PiyiNwPqadlBkiDFIntCO68Spg=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr10094670otk.363.1581522506203;
 Wed, 12 Feb 2020 07:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4hh5PmF8qU+p7Q903PhX+ho9yHMzLFncmh6psW5YOLU_w@mail.gmail.com>
 <B23A05D9-40E2-4862-979D-C6DA69DDDC80@redhat.com>
In-Reply-To: <B23A05D9-40E2-4862-979D-C6DA69DDDC80@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Feb 2020 07:48:15 -0800
Message-ID: <CAPcyv4gLL654xtuiLJUwTGAwzZkn1CVT3i_zCjK9N2X=4nsdpw@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 1:40 AM David Hildenbrand <david@redhat.com> wrote:
>
>
>
> > Am 11.02.2020 um 21:15 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Sun, Feb 9, 2020 at 2:48 AM Baoquan He <bhe@redhat.com> wro=
te:
> >>
> >> Currently, subsection map is used when SPARSEMEM is enabled, including
> >> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> >> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unneces=
sary
> >> and misleading. Let's adjust code to only allow subsection map being
> >> used in SPARSEMEM|VMEMMAP case.
> >>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >> include/linux/mmzone.h |   2 +
> >> mm/sparse.c            | 231 ++++++++++++++++++++++-------------------
> >> 2 files changed, 124 insertions(+), 109 deletions(-)
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index 462f6873905a..fc0de3a9a51e 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(un=
signed long sec)
> >> #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
> >>
> >> struct mem_section_usage {
> >> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >>        DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> >> +#endif
> >
> > This was done deliberately so that the SPARSEMEM_VMEMMAP=3Dn case ran a=
s
> > a subset of the SPARSEMEM_VMEMMAP=3Dy case.
> >
> > The diffstat does not seem to agree that this is any clearer:
> >
> >    124 insertions(+), 109 deletions(-)
> >
>
> I don=E2=80=98t see a reason to work with subsections (+store them) if su=
bsections are not supported.
>
> I do welcome this cleanup. Diffstats don=E2=80=98t tell the whole story.

I'll take a look at the final result and see if my opinion changes,
but I just wanted to clarify upfront that making sparsemem run some of
the subsection logic was deliberate.
