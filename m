Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B819C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6229220706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597749377;
	bh=RkaWdIRJ74DW7InazlkI0xfoVod4o27tb+RinK+bkcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QbT0McdbT0qj2cvrgKIsDQhMxfFXf38FqjOd1TIJktcGMhRB17iuHOmWFclIxrvyd
	 2XO7cUg2AJWeZo1f3X2zGnaMCREU1x4vtDMSTsX+hXJsf+fFPPKXn7npmldTSTwncH
	 lOvYa200sepcbHdM6WGtoJLEB3IX3P+Qsx5GDL2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRLQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:16:16 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29425 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:16:12 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 07IBFmT1011623
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:15:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 07IBFmT1011623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597749349;
        bh=3xAsjfQl6biS+OpSY05Gtj3NIMQfJKQrzLsty+TxA68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UnzgcjNV5ZObh3IsyXoERrX66LHMR2cTPxLRLyVxFGw5OU2m0igYNZrTanK78DeaX
         0znZnzpQRsuuRqhlhAzL9JSt/OjV/WSzMHdnf7kjW+WotYzFs7c+HPSSkO8ktmEDMK
         9QNtyvukwWzQEnujdj2vweJ+pTbLacgLDB+kfT2Hs66aUa2njQfE/I54z6L7bPUw0Y
         NE8aiz3hs1Mhgb8xqH9R3gJZcJQu4bb5LDSXOKEdSSpcbqewWocUqpwFIq09eBs+/j
         TnAFw/5XCd1DQs4gud3TjQ+67KBwhzpA9cLLwL3R0+vnEUBsKm2rTvqfWL/krZ7fyu
         MtPbh2kvl+5cg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id k18so4564247uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:15:48 -0700 (PDT)
X-Gm-Message-State: AOAM532VtR8My42sEg333yB5esVk1Vnu97voqbSElt+6sQlrEk3wAgjK
        gZA8NCJ9qmQ90EYIGJmvfLU0fKJ3PEUZzwqwIAU=
X-Google-Smtp-Source: ABdhPJyBo8cZKiKSnjIo3+W75713+/rnsE3JG8kWKPJM40U/A/MOW3/MuoHjSv90OhzxkMxHendKNKFT3ze5VguBc6I=
X-Received: by 2002:ab0:5b91:: with SMTP id y17mr10696577uae.95.1597749347444;
 Tue, 18 Aug 2020 04:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
 <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
 <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
 <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
 <e5737af8-f38c-659a-9c10-9a106edf81a3@infradead.org> <CAK7LNARc22dcj03=BKYxEi2PxBeNn91LBig-eXOBowXK+oUQoQ@mail.gmail.com>
 <f264c943-2ce0-23ec-f9f4-83ca8bff8785@infradead.org>
In-Reply-To: <f264c943-2ce0-23ec-f9f4-83ca8bff8785@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Aug 2020 20:15:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYYzoOKUtwJ=-2VUHCyv=pNJTuP8gXPwmEiFdTLWKyOA@mail.gmail.com>
Message-ID: <CAK7LNARYYzoOKUtwJ=-2VUHCyv=pNJTuP8gXPwmEiFdTLWKyOA@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 12:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/17/20 6:05 PM, Masahiro Yamada wrote:
> > On Sun, Aug 16, 2020 at 7:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 8/14/20 8:17 PM, Joe Perches wrote:
> >>> On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
> >>>> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
> >>>> <ndesaulniers@google.com> wrote:
> >>>>> What's KAO? Urban dictionary has no entry. :^P
> >>>>
> >>>> It goes back to 2003 and the original keywords.gperf file, see
> >>>>
> >>>>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
> >>>>
> >>>> from the BK history conversion.
> >>>>
> >>>> It might be Kai Germaschewski's tagger name?
> >>>
> >>> I think it was Keith Owens.
> >>
> >> Probably.  A.K.A. kaos.
> >>
> >> --
> >> ~Randy
> >>
> >
> >
> > Perhaps, we can remove "KAO"s ?
>
> Should be OK to do that.
>
> > Anyway, I was trying to pick up this patch.
> >
> >
> > I take patches from patchwork, but it looks like
> > the server (https://lore.kernel.org/patchwork/project/lkml/list/)
> > has been down for a while...
>
> Yes, it is having some issues.
> I have asked for help on that.


Now the patchwork server is working again.


Applied to linux-kbuild/fixes.
Thanks.

-- 
Best Regards
Masahiro Yamada
