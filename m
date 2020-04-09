Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0482DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D6420857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN9bpb8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDIAyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:54:12 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34727 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIAyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:54:11 -0400
Received: by mail-qv1-f66.google.com with SMTP id s18so4748068qvn.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J9ZemQiFWGsfMWPldp5QKBMKNYMMZinRnYJeMxAKRQM=;
        b=dN9bpb8pfU8byZSrixWq3Kv0mxxA25dUnMe8pPGKg69WFoiB6zg7Q3JO4Q5NJrnbRo
         IKypobdgiceAqzlC+qsTMZKbqst1KQAVcsuqLalBh42j/0jH6IAqthwMJk+Vq2kZHydN
         yVUPRDZDoDgyQFIHrF7e5QZwXASKVnrtljndr0qGNNhKbGl+pSZX5BTNxWhY05jUsIf2
         5mZfO15tfQYN8BoASLHztE0inUG4CJqUJwA812paJYgn50YSRxCupQ9JXRbciNGmijCP
         Bhj76cOjpjH0FxeeKQexMAmKFIlAe1WrB5l4u1uXdXOfWxY85dkx+JGvJYNat5gd7tw2
         eGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J9ZemQiFWGsfMWPldp5QKBMKNYMMZinRnYJeMxAKRQM=;
        b=gHFYLnNmoU/7TAyBD7qhQC49+2SYh8SbCBsuttMijBHTzBU7+q95reZNG2GWp3e09u
         sM/R/W3wapoyIth6Rmagj36MoQDrtJPY8AjzVxx1o6UyvfkFZwaeglzkBHsPmLIJpDlL
         +LIalHx0dwThDHmKDxAlZscp9l1NaGXDqT9/O24kSxdxB6Tnumj7eu9a8S4Aj83MlUef
         yw7hOa/u60Zism9iyBskJqGDgatn3X9TekhEraxSsViEc25ezw5yYZ9+P56PaOofaeec
         gv5Hx4A4ZO5fiRfge541G1diBq6E9hhiI9FGR5Tpc/74lWLZcBr0XS7x3ufCjLOrVbjo
         l/oQ==
X-Gm-Message-State: AGi0PuYtEAdVLFhFMZ/MINIWwnuEhVZiLCWV3R71PLDjIDny9nGyfJvg
        pm7a62wyQAuI26/2czsg1kwxUJS+qY1jU7I/ckM=
X-Google-Smtp-Source: APiQypLotMAy0bbszGNimqOa7muZH2bnF2Un4RKY3qBFMk53l/gdC/gkclCYkXpzku7IVWiMQVQNoHVJWusgAR93lEc=
X-Received: by 2002:ad4:5244:: with SMTP id s4mr5019325qvq.88.1586393650767;
 Wed, 08 Apr 2020 17:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200406115804.4440-1-hdanton@sina.com> <20200407022144.11164-1-hdanton@sina.com>
In-Reply-To: <20200407022144.11164-1-hdanton@sina.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Apr 2020 09:53:59 +0900
Message-ID: <CAAmzW4MANwv6OS646Tkbvs1Db+kn6f2=WDJHi9EAXsz0vp1sXA@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 11:21, H=
illf Danton <hdanton@sina.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On Tue, 7 Apr 2020 09:42:54 +0900 Joonsoo Kim wrote:
> >
> > 2020=3DEB=3D85=3D84 4=3DEC=3D9B=3D94 6=3DEC=3D9D=3DBC (=3DEC=3D9B=3D94)=
 =3DEC=3D98=3DA4=3DED=3D9B=3D84 8:58, Hi=3D
> > llf Danton <hdanton@sina.com>=3DEB=3D8B=3D98=3DEC=3D9D=3DB4 =3DEC=3D9E=
=3D91=3DEC=3D84=3DB1:
> > >
> > >
> > > On Fri,  3 Apr 2020 14:40:43 +0900 Joonsoo Kim wrote:
> > > >
> > > > @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_=
entr=3D
> > y_t entry,
> > > >               xas_unlock_irq(&xas);
> > > >       } while (xas_nomem(&xas, gfp));
> > > >
> > > > -     if (!xas_error(&xas))
> > > > +     if (!xas_error(&xas)) {
> > > > +             mem_cgroup_commit_charge(page, memcg, false, compound=
);
> > >
> > > Add a tp
> > >                 trace_mm_add_to_swap_cache(page);
> >
> > Please let me know the reason of this comment.
>
> It is derived from
>
>         trace_mm_filemap_add_to_page_cache(page);
>
> in __add_to_page_cache_locked().

Maybe, it has it's own purpose and it would not be applied here. If
someone want to add
a tp here, it can be done with a justification, after this patchset.

Thanks.
