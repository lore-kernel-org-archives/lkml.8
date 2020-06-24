Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0196AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1B920857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cfiXxz18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgFXWVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgFXWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:21:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:21:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d15so2654305edm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oC+NYQSkrU/82u5pefwOvMnMpYXJEhra5n0Gd74+VNk=;
        b=cfiXxz18UcsUTtVYkPxudOrKjkJS3D/mypjmZqYytbt9vncI2FXTSlS91xmOg2/noq
         K7aCdTDolXEdHYwtYlWGG/ksuTbpfrhn6hcoGxTR82oQg5YVMHGycPcewwrPZmBVGnOT
         FAO1owuI463UjQxq2o4Wtr+UTo6ccMNxp4s4ok4omAPcpGqVnx02uhvcZvp/OgbQuvxl
         gIVJzA5UfssFUGx4/PAFLu3Yzp1Xkd8EBFYCx8q7605czBMdzklNgeBIoYeTBkFfdt3d
         0o0aTNHwdbE+6dQZyiaQ7KQd3Z+2eYz6p8hBJT9Xr/+W+gZSM6Nz9rSohUj/THUpNsJT
         2cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oC+NYQSkrU/82u5pefwOvMnMpYXJEhra5n0Gd74+VNk=;
        b=E6AYfPDI+h7I0iqtTJRyFgjJS8PrGcDR9oiCIoOE9UUhfb8h0luGLBzQtyN/mGYAhT
         9XRzkYQMQIHskzu/voR83idojfxqxvRJRQ9CIs//dQhuHdhow1tHHk50p90GcE8dOKsS
         G4j6XCmBWlVAAyGBKkH1UEXz3M2iozm2KiH4cXh++OykKQpWsezOxNsuQP4c8W4/VoMc
         q2qBjjNlcKOXpByKdeBuEguzSXy5eSloYvIWIfi3RDZknq0z0bmAQ6PMrNjAlK+k7cdA
         e9geg4KnClZcxFG7EKR9G0cR1YTgUYrn9eOtZAyZX987pv9ZIBKsFNE7Ove99tljpO0o
         D4MA==
X-Gm-Message-State: AOAM531dOalb5XU/1FYfNp+/wf2vkWIwdL+S0iHdbU2qGJHbbST5+AMW
        DBqfICRcxU5/TL3+KBjcPVR5nwphSyqpZCu6jrETFw==
X-Google-Smtp-Source: ABdhPJwkiTjqv/XIlHUqP0Lo2kCyx8fwyWb01W72Bo9PErcyKDCrN1JTm81ExY2Pc/Gcfzgj5uNopA9koNiNuXA35yI=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr28750955edb.296.1593037270081;
 Wed, 24 Jun 2020 15:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz> <20200624061340.GA11552@L-31X9LVDL-1304.local>
 <CAPcyv4gEUq0yyz00AbQQSyo_acj1wUCZPse5vEff_Bq7GmeksQ@mail.gmail.com> <20200624220552.GA15016@L-31X9LVDL-1304.local>
In-Reply-To: <20200624220552.GA15016@L-31X9LVDL-1304.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 15:20:59 -0700
Message-ID: <CAPcyv4iHM2d0qZFsznwv20Z+rTcj-8CZTDBQv1kJ50FwZuM90Q@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:06 PM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> On Wed, Jun 24, 2020 at 09:10:09AM -0700, Dan Williams wrote:
> >On Tue, Jun 23, 2020 at 11:14 PM Wei Yang
> ><richard.weiyang@linux.alibaba.com> wrote:
> >>
> >> On Tue, Jun 23, 2020 at 05:18:28PM +0200, Michal Hocko wrote:
> >> >On Tue 23-06-20 17:42:58, Wei Yang wrote:
> >> >> For early sections, we assumes its memmap will never be partially
> >> >> removed. But current behavior breaks this.
> >> >>
> >> >> Let's correct it.
> >> >>
> >> >> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> >> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> >
> >> >Can a user trigger this or is this a theoretical bug?
> >>
> >> Let me rewrite the changelog a little. Look forward any comments.
> >>
> >>    For early sections, its memmap is handled specially even sub-section is
> >>    enabled. The memmap could only be populated as a whole.
> >>
> >>    Quoted from the comment of section_activate():
> >>
> >>        * The early init code does not consider partially populated
> >>        * initial sections, it simply assumes that memory will never be
> >>        * referenced.  If we hot-add memory into such a section then we
> >>        * do not need to populate the memmap and can simply reuse what
> >>        * is already there.
> >>
> >>    While current section_deactivate() breaks this rule. When hot-remove a
> >>    sub-section, section_deactivate() would depopulate its memmap. The
> >>    consequence is if we hot-add this subsection again, its memmap never get
> >>    proper populated.
> >
> >Ok, forgive the latency as re-fetched this logic into my mental cache.
> >So what I was remembering was the initial state of the code that
> >special cased early sections, and that still seems to be the case in
> >pfn_valid(). IIRC early_sections / bootmem are blocked from being
> >removed entirely. Partial / subsection removals are ok.
>
> Would you mind giving more words? Partial subsection removal is ok, so no need
> to fix this?

Early sections establish a memmap for the full section. There's
conceptually nothing wrong with unplugging the non-system-RAM portion
of the memmap, but it would need to be careful, at least on x86, to
map the partial section with PTEs instead of PMDs.

So, you are right that there is a mismatch here, but I think the
comprehensive fix is to allow early sections to be partially
depopulated/repopulated rather than have section_activate() and
section_deacticate() special case early sections. The special casing
is problematic in retrospect as section_deactivate() can't be
maintained without understand special rules in section_activate().
