Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3881C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB592053B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597712781;
	bh=XH5qWCTe78ytAdgr+mk0chcfZuTKPX1jn5O7wD3s0cM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U+VnL9MWsUEryvlVL1We1vG2X6aL0eM+Eg9Z2Rcvbif4+AlftxV4ywJLgwufVkaNd
	 EcSn+LN6Yo25eyb4t/ZewsGVlj1dHHj1sJZ2T5qI6UUtWc0RPGmrgJDZLXhWlItw/7
	 LecRhxwCK85mEDsv+erTMPMIDHS2dcVvbGaaUQYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgHRBGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:06:19 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48384 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgHRBGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:06:17 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 07I15rDI011007
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:05:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 07I15rDI011007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597712754;
        bh=CmOdlRQAQZduno6SdPSOJiCz1xZWQPk5daVXxKQJVLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UScsT+DGR1V+XcG/iSb5wDjNq4+Xj6wBPDowpd08ytK4urtLCeqPsSpBV52n566Rh
         q7VuOtDBlb2GMfQKr+4dVcgzE1c4hdIJbuAUubpxezCxdG/nWgCS5jsIquNnjiAqZl
         kyHMXJSRaZL9JfjkLh3rNpMYGn/21VOWs7drxnfy3zeYHnCsukS7JivBHKqw7BbPjE
         10RZ8LHp8IkGVlh6XnjBuXfmHZKutNoT+IgkAZD6hQDMcRBbfFEG+LisWJryM36uS8
         PR3M2Wi6YXZqEh1CQK/L1M+fFkL2Um1TPpIGwsmbBSlGthJ30bN08bw6NZ5Nk+utp+
         RNZLRJRmtLuuw==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u15so5315181uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:05:53 -0700 (PDT)
X-Gm-Message-State: AOAM5324+4mKbc6yWWFBPzDLC6caaz4aDsXjOOPxCnsUwGnrDpFbjPT1
        D/54Lq0bW8DxclJ7h0G6otae9UyODpVOuzivnXM=
X-Google-Smtp-Source: ABdhPJyCA/3ntU65+9rCXgxigiM5yIYcdALCxe5tUo+SpV5YxV+LMZnrk8/zztdam4Udmx+tksKq91PVJgF09ADrK3A=
X-Received: by 2002:ab0:60ca:: with SMTP id g10mr8877943uam.109.1597712752805;
 Mon, 17 Aug 2020 18:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
 <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
 <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
 <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com> <e5737af8-f38c-659a-9c10-9a106edf81a3@infradead.org>
In-Reply-To: <e5737af8-f38c-659a-9c10-9a106edf81a3@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Aug 2020 10:05:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARc22dcj03=BKYxEi2PxBeNn91LBig-eXOBowXK+oUQoQ@mail.gmail.com>
Message-ID: <CAK7LNARc22dcj03=BKYxEi2PxBeNn91LBig-eXOBowXK+oUQoQ@mail.gmail.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 7:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/14/20 8:17 PM, Joe Perches wrote:
> > On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
> >> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
> >> <ndesaulniers@google.com> wrote:
> >>> What's KAO? Urban dictionary has no entry. :^P
> >>
> >> It goes back to 2003 and the original keywords.gperf file, see
> >>
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
> >>
> >> from the BK history conversion.
> >>
> >> It might be Kai Germaschewski's tagger name?
> >
> > I think it was Keith Owens.
>
> Probably.  A.K.A. kaos.
>
> --
> ~Randy
>


Perhaps, we can remove "KAO"s ?

Anyway, I was trying to pick up this patch.


I take patches from patchwork, but it looks like
the server (https://lore.kernel.org/patchwork/project/lkml/list/)
has been down for a while...



-- 
Best Regards
Masahiro Yamada
