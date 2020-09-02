Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C955B208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CnUkh8v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIBPmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgIBPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:41:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F6C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:41:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so5381928edk.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhnslE1OLag0DHeK+euiqo3OG83b3GpgX9BAplu24c8=;
        b=CnUkh8v0k49RXvbWi1K7UXlLEVymEr3QK8zgyoIZRHlnSVMXyv/agG4kSnsqloTOMo
         qATIvnRA+rEtkHvSVfp6OorCYIKJNQxlEarTX6Y8x+kbgmFtLnbroBShdZKZD2pjBTys
         7U5YQC5ltRh0IZCB5vjTTF9WA2Nec3QN1iuCj4Ma3qUQgMcei284L1Jon8ULiDGfZEk8
         2D92SuDyP/6rrqZhhbA6kRmE4jNUAbFGlLwTnmJbz6QU0dL135Bh9P3L5bsFvvrzKmyu
         JqIa3aU1V7bpXRA9HtKzQrCrizmxg1A2+ueahLYpSzBUC27CH7Ot3NnP7M/n1KRrqI0+
         34MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhnslE1OLag0DHeK+euiqo3OG83b3GpgX9BAplu24c8=;
        b=ORDA6HZpkC2VWeS08qLZonnolZLEv8x8IE3Hg5ujX/OvH5REssom3Cv1kx/uEqpMuH
         MLmVCTUiOCUSx8FtspDGWNFCNv3Eio5Q+M3g2Wj79O+y3NyvRabpD16iM5ydnJO7fxAP
         FrVpB7bCXTE1dQ7AxaQ/Qo12NXwAFXZoaRN91fCmbeSXaae0F+ejgE8I4LHpMdL3Jgyp
         TxEceESdKuh4njHlsYzfR94V65U2HywnmwwWQFAyTPBfQlrtXfRakLXXBAK8ZUgHy5q4
         AWb7qFd3BZp1iGsonCXSeYiaHgTvk76KYR7/LsDRQOJ7fQlWu7aWyuVPdfrsuDCdvuTg
         6tTA==
X-Gm-Message-State: AOAM530sk+JKUkkOMNAJzrBgV34gqBDoUqkG1YWsm9cDidRb+Yisrp89
        uBvHO3MSMM2e/Xn9GtB3+3lJgaX+IdgGQJQQOyPAuyJKYW66ZQ==
X-Google-Smtp-Source: ABdhPJzS3/Y2wZVi6sOOyA5MepX0s8tx2YjOOIPDoaQ2guEabmxZNcLw7pZtzCptADfNCUBLLTTpQ113qGsuNrrTBco=
X-Received: by 2002:a50:8f44:: with SMTP id 62mr690167edy.3.1599061289177;
 Wed, 02 Sep 2020 08:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz> <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz> <20200902151306.GL4617@dhcp22.suse.cz>
In-Reply-To: <20200902151306.GL4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 11:40:53 -0400
Message-ID: <CA+CK2bDVq5UTJfgFuhzPrAGbrFOMcR=Cm1A0nue7M2z+yMac3Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> But this means that the page is not isolated and so it could be reused
> > >> for something else. No?
> > >
> > > The page is in a movable zone, has zero references, and the section is
> > > isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
> > > set. The page should be offlinable, but it is lost in a pcp list as
> > > that list is never drained again after the first failure to migrate
> > > all pages in the range.
> >
> > Yeah. To answer Michal's "it could be reused for something else" - yes, somebody
> > could allocate it from the pcplist before we do the extra drain. But then it
> > becomes "visible again" and the loop in __offline_pages() should catch it by
> > scan_movable_pages() - do_migrate_range(). And this time the pageblock is
> > already marked as isolated, so the page (freed by migration) won't end up on the
> > pcplist again.
>
> So the page block is marked MIGRATE_ISOLATE but the allocation itself
> could be used for non migrateable objects. Or does anything prevent that
> from happening?

Vlastimil is right, we could allocate from pcplist, if someone
requests allocation, nothing from what I can tell prevents that, and
we will immediately migrate that page in do_migrate_range().

> We really do depend on isolation to not allow reuse when offlining.

Once a page is isolated it is not re-used but here this page is not
isolated because of the race between adding to pcp and isolation.
Draining the second time on a failure fixes the race.

Pasha
