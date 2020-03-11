Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DABC3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E97D222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHdNeY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgCKKNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:13:51 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37707 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:13:50 -0400
Received: by mail-qv1-f67.google.com with SMTP id l17so585848qvu.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNy84MgESpiRbPO7UsnzsAbi4JbCFJOrChNCECasnNs=;
        b=NFHdNeY0ermmot/V4n92JOwd8v5V9HOgj5tS0/w3TX6MDm4X4yH0XVq4B7kK0gYGyu
         O369UYRrbamMy1Hz/k0BMYtV7JHUh40lMKGgxaQ9dgJO9mEoY9ytI3TNc0m5vZsmz1Ym
         GDUU8sYmvBHCV4c86HrolJLnsKoCHfCzJlHu8HqL5sJE4jsZnmozF9lo/xWYua5EmbMl
         4wNEQ2Tmki3o5ZRtL4KxAU/IXTev3j1CL4qSk/VCZi9CDX92mVPImJVDkV5dfMlKkyEz
         k9X95o/QMMH9Prqavt/PucNXpu5n4u4xV0LQTWqMxiPpYXqX+QiJ5lEQgnkgBWPvGNe+
         AvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNy84MgESpiRbPO7UsnzsAbi4JbCFJOrChNCECasnNs=;
        b=EF2ZA0x/zHw6Sydaxy3J49TPbhSD8UwjnldXgb5FYL174Ea2P13/KwkZFexHSyodOc
         37v7poeC8yCx3DceBYFIMN4icXLqkZLpKXW5/cvC/YUzSEBwJdb9yUKaOiGc/yxjSbS2
         jgV8+VeMZE8Q/YABstmmTvGzI/Y6xHCDlriSm457W9jMx+p/pjcMgQlrKjitTv3QUAQi
         LnWCwbflqYltWdl2ceRlFvybPBY0Wuo4AF5XRjXbC+hUpuDZzpr8JsBlgjkNcxyiIUbV
         F+SoyvYqlcLvNLjDPczljrdYo+twYZoA3osnZfhpd84JbkTKMfjI02XUEaMsj5McnlhA
         6yGA==
X-Gm-Message-State: ANhLgQ03gKBABfe/HQnguWwFKLdgwjJtgV/cdsXCz4Xz/4JfonPehpaX
        TKp2Y03l4JkJDhpH+w+jjWNyDrJccJGV0oTLmHs=
X-Google-Smtp-Source: ADFU+vs4KJwsST82aw3fpeMIbTCUbEf/5iu1Kc3a80fk7WILbrHZhTggrTvjVDcCiUi0ENADmsE54uHoeZ9hUZ2NivY=
X-Received: by 2002:a0c:f688:: with SMTP id p8mr2080691qvn.208.1583921629700;
 Wed, 11 Mar 2020 03:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
In-Reply-To: <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 11 Mar 2020 19:13:38 +0900
Message-ID: <CAAmzW4P6+3O_RLvgy_QOKD4iXw+Hk3HE7Toc4Ky7kvQbCozCeA@mail.gmail.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:51, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 3/6/20 9:01 PM, Rik van Riel wrote:
> > Posting this one for Roman so I can deal with any upstream feedback and
> > create a v2 if needed, while scratching my head over the next piece of
> > this puzzle :)
> >
> > ---8<---
> >
> > From: Roman Gushchin <guro@fb.com>
> >
> > Currently a cma area is barely used by the page allocator because
> > it's used only as a fallback from movable, however kswapd tries
> > hard to make sure that the fallback path isn't used.
>
> Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corn=
er
> cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted du=
e to
> unresolved bugs. Perhaps the idea could be resurrected now?
>
> [1]
> https://lore.kernel.org/linux-mm/1512114786-5085-1-git-send-email-iamjoon=
soo.kim@lge.com/

Thanks for ccing, Vlastimil.

Recently, I'm working for resurrecting this idea.
I will send the preparation patches in this or next week.

Unresolved bugs of my patchset comes from the fact that ZONE_MOVABLE
which is used for
serving CMA memory in my patchset could have both lowmem(direct mapped) and
highmem(no direct mapped) pages on CONFIG_HIGHMEM enabled system.

For someone to use this memory, PageHighMem() should be called to
check if there is direct
mapping or not. Current PageHighMem() implementation is:

#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))

Since ZONE_MOVABLE has both typed pages, ZONE_MOVABLE should be considered
as highmem zone. In this case, PageHighMem() always returns TRUE for
all pages on
ZONE_MOVABLE and lowmem pages on ZONE_MOVABLE could make some troubles.

My plan to fix this problem is to change the PageHighMem() implementation.

#define PageHighMem(__p) (page_to_pfn(__p) >=3D max_low_pfn)

In fact, PageHighMem() is used to check whether direct mapping exists or no=
t.
With this new implementation, regardless of the zone type of the page, we c=
an
correctly check if the page is direct mapped or not. Changing the
name, PageHighMem(),
to !PageDirectMapped() is also planned but it will be done after
everything have settle down.

Unfortunately, before changing the implementation, I should check the
all call-sites
of PageHighMem() since there is some callers who use PageHighMem() to check
the zone type.

What my preparation patch will does is to correct this PageHighMem() usage.
After fixing it, I will try to merge the patchset [1].

Thanks.
