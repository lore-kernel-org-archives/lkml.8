Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60532098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bBaItCjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgFPRDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgFPRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:03:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:03:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w7so14864592edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xjk5DzZyjpoB1GSJ8tZz8huXPpW+bXfr81ISG5HVdc=;
        b=bBaItCjyqIeraEzbLMVwYMyHRe013T+gzyWOqvfnQYNP+wnSHONozCb4pfAg4GVN8j
         jxppjlufBxsiv2qc9vo0azuW47QUZMXH3FMxb3RRDIQpQdS9i+KMZcMkJgTuU3D3MYLN
         pKpUjLjoKTz/Ql3auxIlClwJ4AULPwNGuvKd3ClWPx0hH0vjNike46+lF+JdNAkvtrFl
         PGkPOaYR5Y29app4UZHUICuPi2Qf1JlJl5jPUVR9/P/JgF7pi9BbjRcuDDYbBr3NxK06
         BhuUzZnq1dDVgwGzSx2+QrsVEfXtK+GhhRXsOyJvp6T0xA1woV4PjLWS6zWO1RKsPMXp
         B+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xjk5DzZyjpoB1GSJ8tZz8huXPpW+bXfr81ISG5HVdc=;
        b=cj9IjgXxVWJtq3N8Nd6zELLb4/JBtUMrpGM3Rri+qbjVY/4sQtin/4aNeoZzvXhAp+
         lDjMPG95k0+fr5zKoYU1xqJdQe5lEJSO2GxCwPfMduWLl9rZMllAz9+E9oAeTAketaI3
         WycSopUbRJratjakmQEruG10e8rQ5q2gKtktbC+eEbkkJIsG7GqePTUR8gPzcYsaZPwD
         WarD25veUXcHBFS4nQe1/2hJt7AduAtS2EW7VPM8KNhKrqc+dPzzmTIPVi7755UE9MCr
         2S4A+Cxj6IRywPs4DMfifhidVVuuLvwbxWPRvqSgasHIwZFaUtYxq4HQiGnK+QgzQpET
         ceSg==
X-Gm-Message-State: AOAM532tZQd4e7vi7pgK/51Iu+Osab1JsihQLKyMYr6JU+3PiziHBFe0
        Iu/m+L5ci7Xk17WFibpnmFp0U4vq5EMeKnOh8SUULA==
X-Google-Smtp-Source: ABdhPJzJldCKyqNV/8NHFDtnfKWWcbuB+diPaO82MWlkxKKsCb133mLWTtMSKim2glwNE97g5peGu56W8VgQfaSD/Rg=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr1587716edw.383.1592327022502;
 Tue, 16 Jun 2020 10:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200616115213.13109-1-david@redhat.com> <20200616115213.13109-3-david@redhat.com>
 <20200616125051.GH9499@dhcp22.suse.cz> <CAPcyv4hjxyyxVyZbAYoXX2TM3mHF6e4VneVVcmVU+_Q4n9CxzQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hjxyyxVyZbAYoXX2TM3mHF6e4VneVVcmVU+_Q4n9CxzQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jun 2020 10:03:31 -0700
Message-ID: <CAPcyv4gTTVaGAKt91DcgW=t3PgWFioZA7XQrCAU_gAXhcxBe1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone
 when onlining memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jun 16, 2020 at 5:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 16-06-20 13:52:12, David Hildenbrand wrote:
> > > Commit e900a918b098 ("mm: shuffle initial free memory to improve
> > > memory-side-cache utilization") introduced shuffling of free pages
> > > during system boot and whenever we online memory blocks.
> > >
> > > However, whenever we online memory blocks, all pages that will be
> > > exposed to the buddy end up getting freed via __free_one_page(). In the
> > > general case, we free these pages in MAX_ORDER - 1 chunks, which
> > > corresponds to the shuffle order.
> > >
> > > Inside __free_one_page(), we will already shuffle the newly onlined pages
> > > using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
> > > memory hotplug.

This was already explained in the initial patch submission. The
shuffle_pick_tail() shuffling at run time is only sufficient for
maintaining the shuffle. It's not sufficient for effectively
randomizing the free list.

See:

e900a918b098 mm: shuffle initial free memory to improve
memory-side-cache utilization

    This initial randomization can be undone over time so a follow-on patch is
    introduced to inject entropy on page free decisions.  It is reasonable to
    ask if the page free entropy is sufficient, but it is not enough due to
    the in-order initial freeing of pages.  At the start of that process
    putting page1 in front or behind page0 still keeps them close together,
    page2 is still near page1 and has a high chance of being adjacent.  As
    more pages are added ordering diversity improves, but there is still high
    page locality for the low address pages and this leads to no significant
    impact to the cache conflict rate.
