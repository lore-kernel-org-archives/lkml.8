Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BF820724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2wcRAlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHTOHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbgHTN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:58:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:58:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so1534370otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27PMKVLomMz0Eib+Dl+VjSzpCmC6idgXY425VL4EzdY=;
        b=M2wcRAlVkK9M9njr7QiaUuZJLX5lZmAkOrlqu7uqeuzHSvjoRX/QK6sLcI41BdZHqX
         adfeZZdTjN5tKoJ8S9NL8OLNtJTBmDfHim9j4PE4/4m4g3DTi03Eeoz4wOLJSwN46KSY
         U/Qq0YxnCNPqTAv16cjFqAKIiyzcuDSHWkPQHgSTehmzEE8X3w3oknQU+24dH4k0u75W
         5d6X8YqY27jV4bi+qKzfZz468u0fCCaMcTsGBKBuI2xJ844d/bmOb9GbxjMnLrZcVgIo
         ORP/W0k0Qc20HotT+GqHnoxIGBtzpC6Ygx/6nyrFTOMlpaJNkyaKlsHoSpBPxoF12ba3
         eNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27PMKVLomMz0Eib+Dl+VjSzpCmC6idgXY425VL4EzdY=;
        b=V1eDyMnAgY1AzjIZM8leL9fq5kzoCZHUG9jgqr/2hR+3molWjM3q5Bi7wqI9Nqc8av
         kNE00wVRDVXj7AtCDOmsI3lfq5EExGsxpSIkyIDMcc3X4EijxXGZAVnKuSgNY3h3/Zb1
         wL2XUUOJbDhQCFFP3PpL/l83h8ZxnvP6JuNgOktBkbgBpc/xnOxRMpRCtIzylHY+K5lk
         alLg3lVAC+7jx5FBrucmITCEg4j+gKmmRZxmA4GJLZ8yp0TfSSAJb+8xughXGULMZyWR
         LG4AcrzxOVvdjSKJYxv6p+rIJwIxyw4QF7WMpHVQfR3lsPKfJzIKoB0aSC/WfEUPMBPT
         6H1g==
X-Gm-Message-State: AOAM531FdnfTJwnvsL7+0nq78myUHYQB1h+cX+Nq5cBym1vpisaybNco
        JHrqlC4M7qaOF9a+H8bFLH++D4dh3IO39Y0sZU8A9Va/MIQk0g==
X-Google-Smtp-Source: ABdhPJwqvL4OhDofNZ/5JPAe+gfNClhvEzue3JbT/tcL6lw/ipaETweV616UF1C5h//wOUw6+lqcmUjY8xXC+NYLVuk=
X-Received: by 2002:a9d:20c4:: with SMTP id x62mr2027505ota.99.1597931929160;
 Thu, 20 Aug 2020 06:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz> <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
 <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com> <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2008111250170.86069@www.lameter.com>
In-Reply-To: <alpine.DEB.2.22.394.2008111250170.86069@www.lameter.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 20 Aug 2020 16:58:31 +0300
Message-ID: <CAOJsxLHnTDjY3X69zVVaZ0MbpRab-1+Rk3L5AnZD3oQEceHD7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial objects
To:     Christopher Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

On Tue, Aug 11, 2020 at 3:52 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Fri, 7 Aug 2020, Pekka Enberg wrote:
>
> > Why do you consider this to be a fast path? This is all partial list
> > accounting when we allocate/deallocate a slab, no? Just like
> > ___slab_alloc() says, I assumed this to be the slow path... What am I
> > missing?
>
> I thought these were per object counters? If you just want to count the
> number of slabs then you do not need the lock at all. We already have a
> counter for the number of slabs.

The patch attempts to speed up count_partial(), which holds on to the
"n->list_lock" (with IRQs off) for the whole duration it takes to walk
the partial slab list:

        spin_lock_irqsave(&n->list_lock, flags);
        list_for_each_entry(page, &n->partial, slab_list)
                x += get_count(page);
        spin_unlock_irqrestore(&n->list_lock, flags);

It's counting the number of *objects*, but the counters are only
updated in bulk when we add/remove a slab to/from the partial list.
The counter updates are therefore *not* in the fast-path AFAICT.

Xunlei, please correct me if I'm reading your patches wrong.

On Tue, Aug 11, 2020 at 3:52 PM Christopher Lameter <cl@linux.com> wrote:
> > No objections to alternative fixes, of course, but wrapping the
> > counters under CONFIG_DEBUG seems like just hiding the actual issue...
>
> CONFIG_DEBUG is on by default. It just compiles in the debug code and
> disables it so we can enable it with a kernel boot option. This is because
> we have had numerous issues in the past with "production" kernels that
> could not be recompiled with debug options. So just running the prod
> kernel with another option will allow you to find hard to debug issues in
> a full scale producton deployment with potentially proprietary modules
> etc.

Yeah, it's been too long since I last looked at the code and did not
realize even count_partial() is wrapped in CONFIG_DEBUG. So by all
means, let's also wrap the counters with that too.

- Pekka
