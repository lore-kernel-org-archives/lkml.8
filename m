Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE81C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17A720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs7YwODt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbgF2UsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgF2TNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD4C08EB40
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:42:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 80so14342590qko.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2cUY6dn/8hM5Fe6/vgpIOBYGaKKOrNbvFVWUTgCzZQ=;
        b=Vs7YwODtzdw0nnL5dB4Bd0RIlci2u3B6noXOgRab6ppKE6A7jRezT7TVbcrQUOLYRY
         mSYHQ9313VtfFpaqCJUqSOmM3NyAk4uOeGSqtTmP6loy9QRx94fliMk2r7+UKJK26jQk
         MzBme0vl0WF1haS0FMA8EQHF13IyO//f7brDudNRT/3PLrvJ8xn6sn9aI8kmHud3GmlU
         waSMIXTzUMlD/BwM5BY2YW0IZAOcYacRRBtm5gR8hUEmFmD23EA8VB6yZqkc18X09o1H
         JUjqtBpZTlw/XJFzBvxgumP78wbUDw2mMOo1InHOcQfdteWj4NAwzTKEO5IA/Do6JFrW
         cbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2cUY6dn/8hM5Fe6/vgpIOBYGaKKOrNbvFVWUTgCzZQ=;
        b=PpuuRTkwFsMsNUVwIA2N8xgQuXePH+1DlEq5hziSSC7O4Pok/4HRKSuOXr8TIkABBj
         idtnXHYbqG8NNEGXvj9QprKXL1AnOILcDA7ydq7KlCnpNEv8LXNoYlBhtRREXyah5vYW
         W54CgO2L3uaxX+bHqjdQY85NnONKoASWScxVLTMXv57SHkY8i3+BP5KyLDBAPxraVZg0
         z5+6R5zv2CjTFBQqooI1KxWCXqoi7AyjQR6zLC5p87F41kLTRWdcam8dVDm/Hjhp2MNp
         geQIWpWvIZXeus2pTr4098bcObfpksZ7e/OQAPxqAgseairrfeN8AZWejILz9u1iW14g
         MVvQ==
X-Gm-Message-State: AOAM533jcbTieKSCAzkeGC35XW2Qsh2Z9DDXI589lE4620Waf25+94e1
        xBZQGJ/aTo8TUfPgETihbMudxeq4t/PeslFxxBM=
X-Google-Smtp-Source: ABdhPJy06spvE0O/+QHN1s639aC0ijZEMrz9WuEYm1H8fxF5KAdsz+aO5ojKo1uKVsFR2ceSNLKEWZswC0rNB1kK1sI=
X-Received: by 2002:ae9:e20c:: with SMTP id c12mr12959301qkc.187.1593412927403;
 Sun, 28 Jun 2020 23:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com> <20200625120550.GF1320@dhcp22.suse.cz>
 <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com> <20200626073342.GU1320@dhcp22.suse.cz>
In-Reply-To: <20200626073342.GU1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 29 Jun 2020 15:41:37 +0900
Message-ID: <CAAmzW4PT+M8mUwXMPhQSKLhz9nkPATivL5D-yLyyfC9SOwPnYQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mm/migrate: make a standard migration target
 allocation function
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:33, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri 26-06-20 14:02:49, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:0=
5, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
> [...]
> > > > -struct page *new_page_nodemask(struct page *page,
> > > > -                             int preferred_nid, nodemask_t *nodema=
sk)
> > > > +struct page *alloc_migration_target(struct page *page, unsigned lo=
ng private)
> > > >  {
> > > > -     gfp_t gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAY=
FAIL;
> > > > +     struct migration_target_control *mtc;
> > > > +     gfp_t gfp_mask;
> > > >       unsigned int order =3D 0;
> > > >       struct page *new_page =3D NULL;
> > > > +     int zidx;
> > > > +
> > > > +     mtc =3D (struct migration_target_control *)private;
> > > > +     gfp_mask =3D mtc->gfp_mask;
> > > >
> > > >       if (PageHuge(page)) {
> > > >               return alloc_huge_page_nodemask(
> > > > -                             page_hstate(compound_head(page)),
> > > > -                             preferred_nid, nodemask, 0, false);
> > > > +                             page_hstate(compound_head(page)), mtc=
->nid,
> > > > +                             mtc->nmask, gfp_mask, false);
> > > >       }
> > > >
> > > >       if (PageTransHuge(page)) {
> > > > +             gfp_mask &=3D ~__GFP_RECLAIM;
> > >
> > > What's up with this gfp_mask modification?
> >
> > THP page allocation uses a standard gfp masks, GFP_TRANSHUGE_LIGHT and
> > GFP_TRANHUGE. __GFP_RECLAIM flags is a big part of this standard mask d=
esign.
> > So, I clear it here so as not to disrupt the THP gfp mask.
>
> Why this wasn't really needed before? I guess I must be missing
> something here. This patch should be mostly mechanical convergence of
> existing migration callbacks but this change adds a new behavior AFAICS.

Before this patch, a user cannot specify a gfp_mask and THP allocation
uses GFP_TRANSHUGE
statically. After this patch, a user can specify a gfp_mask and it
could conflict with GFP_TRANSHUGE.
This code tries to avoid this conflict.

> It would effectively drop __GFP_RETRY_MAYFAIL and __GFP_KSWAPD_RECLAIM

__GFP_RETRY_MAYFAIL isn't dropped. __GFP_RECLAIM is
"___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM".
So, __GFP_KSWAPD_RECLAIM would be dropped for THP allocation.
IIUC, THP allocation doesn't use __GFP_KSWAPD_RECLAIM since it's overhead i=
s
too large and this overhead should be given to the caller rather than
system thread (kswapd)
and so on.

Thanks.
