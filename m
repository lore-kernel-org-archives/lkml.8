Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F7B206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coOtS2xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbgDOGyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393646AbgDOGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:54:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA761C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:54:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l21so2358673otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rWdc9gaGPCk9QCXukH9E1qM52p5x9nsGOzCdcUvsmcc=;
        b=coOtS2xku/PjBRcqrWFIPqUAAN3n17jaQLKkjcuRVTcvGQviZHLMO3Rnhl/bBUApwb
         N43SP7JbKMxJro1YvzhvTqMsUlu14Vvn8+0w1xp9wBXrRGYGdVi1oRSQBjZ8OHYHvKt3
         Q3MhX9wsJFgCuxehXmo2xHDaSkQmizpd3nMHJFCk8pZcwGy0JBPjXNfy7r3g2MKSuFkk
         PbbUa39aPIduU2SbTIYBn03Iv89f9cIO6B6B8/j+ycwKAEBE6sVjzxOL7NkrjSUXBNhA
         /mpQ0b1S5nn9noHcXKuvgBDMv2beUESWyWjLk1DUHfrzhtqHPcBn/Ev2MD1n/M7gcZUJ
         e8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rWdc9gaGPCk9QCXukH9E1qM52p5x9nsGOzCdcUvsmcc=;
        b=CoJzd5KQmojgFqBtiYPdGr9QYzyXMxsuzDu3zgskacqYu1dMOFtd8yFyCyQPALkFHo
         9QemGoBOOdpUW82xkwBOcloLtZltUjFEUK5/G7BquefuJ+vQaYmbQMfF8Vx3ExD7OPr8
         ClOpn5TcLv3ikvKEzormrAgp4QF7O8ZZ5nKYCSgiHvKKwidKEJT/JaKO5xstUMF/PEYr
         Cxflck8uOK5IAxPGZRzFKnbK7bSZ5XOF+y6yPKBjM1xB9GjcsJr1/WaDq8/T7+3xXgM+
         7K6fKKuz4H689ECV7ykWuCh01GjX5rjGHm6x0Ah7XRaW1HrhA2j7eP33v5hd3g5krAYF
         LPrA==
X-Gm-Message-State: AGi0Pua6ty/c5fE8meqSzDBsAe6zNK/LrrjR15V7wt7EVlQwUBp98a/T
        BGG5llI177/1VnsjlgtS29AOJQ==
X-Google-Smtp-Source: APiQypKmxH3z9EyIWxa4J53d/b4K7nH1J03FHQY4dRsSkgsUsRGL15eV4bMbPRWzrZaOZwWQKZ/9kA==
X-Received: by 2002:a4a:848e:: with SMTP id n14mr18764636oog.44.1586933689752;
        Tue, 14 Apr 2020 23:54:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 10sm6056280oin.42.2020.04.14.23.54.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 14 Apr 2020 23:54:49 -0700 (PDT)
Date:   Tue, 14 Apr 2020 23:54:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>
Subject: Re: linux-next: Tree for Apr 14 (mm/shmem.c)
In-Reply-To: <20200414182430.c5af29ddb1735f5fd0083983@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2004142339170.10035@eggly.anvils>
References: <20200414123900.4f97a83f@canb.auug.org.au> <200c608a-8159-18ce-b44e-cad2022e23e2@infradead.org> <20200414182430.c5af29ddb1735f5fd0083983@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-6116103-1586933689=:10035"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-6116103-1586933689=:10035
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Apr 2020, Andrew Morton wrote:
> On Tue, 14 Apr 2020 07:18:01 -0700 Randy Dunlap <rdunlap@infradead.org> w=
rote:
> > On 4/13/20 7:39 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > Changes since 20200413:
> > >=20
> > > New tree: mhi
> > >=20
> > > My fixes tree contains:
> > >=20
> > >   6b038bdcd3d1 sh: mm: Fix build error
> > >=20
> > > Non-merge commits (relative to Linus' tree): 1154
> > >  1160 files changed, 31764 insertions(+), 13498 deletions(-)
> > >=20
> > > ---------------------------------------------------------------------=
-------
> >=20
> > on x86_64:
> > # CONFIG_TRANSPARENT_HUGEPAGE is not set
>=20
> Thanks.  hm, this took a long time to be discovered.
>=20
> > In file included from ../include/linux/export.h:43:0,
> >                  from ../include/linux/linkage.h:7,
> >                  from ../include/linux/fs.h:5,
> >                  from ../mm/shmem.c:24:
> > ../mm/shmem.c: In function =E2=80=98shmem_undo_range=E2=80=99:
=2E..
> > ../mm/shmem.c:961:26: note: in expansion of macro =E2=80=98HPAGE_PMD_NR=
=E2=80=99
> >           round_up(start, HPAGE_PMD_NR))
> >                           ^~~~~~~~~~~~
>=20
> That's
> =09=09=09=09=09if (index <
> =09=09=09=09=09    round_up(start, HPAGE_PMD_NR))
> =09=09=09=09=09=09start =3D index + 1;
>=20
> from Hugh's 71725ed10c40696 ("mm: huge tmpfs: try to split_huge_page()
> when punching hole").

Sorry about that.  Yes, odd that it should only hit now: the false
PageTransCompound in shmem_punch_compound() has always been good
enough to handle it for me, but maybe Randy is trying a less able
compiler, or maybe unrelated changes in linux-next have just made
it harder for the compiler to see the optimization.

I hope the patch below fixes it?

[PATCH] mm/shmem: fix build without THP

Some optimizers don't notice that shmem_punch_compound() is always true
(PageTransCompound() being false) without CONFIG_TRANSPARENT_HUGEPAGE=3Dy:
use IS_ENABLED to help them to avoid the BUILD_BUG inside HPAGE_PMD_NR.

Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punchin=
g hole")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 5.7-rc1/mm/shmem.c=092020-04-11 12:58:26.415524805 -0700
+++ linux/mm/shmem.c=092020-04-14 23:20:25.517656174 -0700
@@ -952,7 +952,7 @@ static void shmem_undo_range(struct inod
 =09=09=09=09VM_BUG_ON_PAGE(PageWriteback(page), page);
 =09=09=09=09if (shmem_punch_compound(page, start, end))
 =09=09=09=09=09truncate_inode_page(mapping, page);
-=09=09=09=09else {
+=09=09=09=09else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 =09=09=09=09=09/* Wipe the page and don't get stuck */
 =09=09=09=09=09clear_highpage(page);
 =09=09=09=09=09flush_dcache_page(page);
--0-6116103-1586933689=:10035--
