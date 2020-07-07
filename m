Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F129C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143E020708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ie5U4BIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGEwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGEwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:52:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF9C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:52:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so22772272otw.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KHZlRSI+5CNL5CqTzNRG6K++ofxZi2qsI5xp62BEST4=;
        b=Ie5U4BIeZl2VIBxCKeRtfjbvltwphRbfChayVeJPr3EEMrR+huqI3OlNmuWY+NDB5J
         72jlIaEuPw+J7noorqfokzCp+Bs/fPOJEDm3+WsIsr9YiB+k4CrA3jlSDI7zGh4QPo/p
         vRieHzUvlDC26r1ZJRyMD6jjg0tL82hVVcl6KOPPskYkdGqtZI4yXvWDUA3DjSy+nav3
         mkJ34Ae23N2q8AJ3xV9pRF1+x5mJTRlWGZviPsi6N4uc1xfaFLBz/svKMA00sGsDzb1g
         /BXGOe0xflGBDFmi65AnB+cLQ5Xd/ORU3XlacIR9Tt0Jz+R7qXP8gtQBBQ4ZBd76iNpG
         BXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KHZlRSI+5CNL5CqTzNRG6K++ofxZi2qsI5xp62BEST4=;
        b=iy+UZAoh+tMTiLjEBZfzkTAveErhVysMdCs6hyFqu+kneBmU2YriVkWkH98tgtQ+gV
         0ESoy37K7EpZEnxyQY6eRJ0j2vBkk73EyNkaaf7pVqfgDtJL8BpHjurrfktet80IPcfv
         TStNHAcIsF4/8HnVTshnQP1Pp5uVHkuENIWJQjubT2BMDZsHTC2aszzmUaPSTICLQY+4
         j6oZS4sLGWPdndtXHojR6eNi6AksMAK9VSeYiezruSER6tEU1g259McrqLwy6fKrEL+f
         p+2SrHqrle10y9awB+N9y//iT7E5NStZK8nQvR83M7dSrhqxNyzTSUielv5KIp+AElH3
         ggtQ==
X-Gm-Message-State: AOAM5312EsrcgN2FxtgNgSztsMnszSJTwN5AIcj+k3gMNAPFkUQmmgYx
        sfKu6M0doc0+TDHqoF8OpkPDq6SquT0=
X-Google-Smtp-Source: ABdhPJzk2+Ii217M/o/8WQf9gyL4sN7inGPmtwbEjOry4qwY8kr+eF1ThkMK23ovKt+YOB5PN7R0cA==
X-Received: by 2002:a9d:2c62:: with SMTP id f89mr21357843otb.148.1594097569050;
        Mon, 06 Jul 2020 21:52:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l18sm5763137ooe.32.2020.07.06.21.52.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2020 21:52:47 -0700 (PDT)
Date:   Mon, 6 Jul 2020 21:52:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
In-Reply-To: <20200706113513.GY25523@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com> <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com> <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com> <20200706113513.GY25523@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1390346354-1594097567=:2793"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1390346354-1594097567=:2793
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 6 Jul 2020, Matthew Wilcox wrote:
> On Mon, Jul 06, 2020 at 05:15:09PM +0800, Alex Shi wrote:
> > Hi Kirill & Johannes & Matthew,

Adding Kirill, who was in patch's Cc list but not mail's Cc list.

I asked Alex to direct this one particularly to Kirill and Johannes
and Matthew because (and I regret that the commit message still does
not make this at all clear) this patch changes the lock ordering:
which for years has been lru_lock outside memcg move_lock outside
i_pages lock, but here inverted to lru_lock inside i_pages lock.

I don't see a strong reason to have them one way round or the other,
and think Alex is right that they can safely be reversed here: but
he doesn't actually give any reason for doing so (if cleanup, then
I think the cleanup should have been taken further), and no reason
for doing so as part of this series.

I had more need to know which way round they should go, when adding
lru_lock into mem_cgroup_move_account (inside or outside move_lock?):
but Alex's use of TestClearPageLRU appears to have successfully
eliminated the need for that; so I only need to know for the final
Doc patch in the series (credited to my name), where mm/rmap.c
documents the lock ordering.

I'm okay with leaving this patch in the series (and the final patch
currently documents this new order); but wondered if someone else
(especially Kirill or Johannes or Matthew) sees a reason against it?

And I have to admit that, in researching this, I discovered that
actually we unconsciously departed from the supposed lock ordering
years ago: back in 3.18's 8186eb6a799e, Johannes did a cleanup which
moved a clear_page_mlock() call to inside memcg move_lock, and in
principle clear_page_mlock() can take lru_lock. But we have never
seen a lockdep complaint about this, so I suspect that the page is
(almost?) always already isolated from lru when that is called,
and the issue therefore hypothetical.

My vote, for dispatch of the series, is to leave this patch in;
but cannot object if consensus were that it should be taken out.

Hugh

> >=20
> > Would you like to give some comments or share your concern of this patc=
hset,
> > specialy for THP part?=20
>=20
> I don't have the brain space to understand this patch set fully at
> the moment.  I'll note that the realtime folks are doing their best to
> stamp out users of local_irq_disable(), so they won't be pleased to see
> you adding a new one.  Also, you removed the comment explaining why the
> lock needed to be taken.
>=20
> > Many Thanks
> > Alex
> >=20
> > =E5=9C=A8 2020/7/3 =E4=B8=8B=E5=8D=881:07, Alex Shi =E5=86=99=E9=81=93:
> > > lru_lock and page cache xa_lock have no reason with current sequence,
> > > put them together isn't necessary. let's narrow the lru locking, but
> > > left the local_irq_disable to block interrupt re-entry and statistic =
update.
> > >=20
> > > Hugh Dickins point: split_huge_page_to_list() was already silly,to be
> > > using the _irqsave variant: it's just been taking sleeping locks, so
> > > would already be broken if entered with interrupts enabled.
> > > so we can save passing flags argument down to __split_huge_page().
> > >=20
> > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  mm/huge_memory.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index b18f21da4dac..607869330329 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2433,7 +2433,7 @@ static void __split_huge_page_tail(struct page =
*head, int tail,
> > >  }
> > > =20
> > >  static void __split_huge_page(struct page *page, struct list_head *l=
ist,
> > > -=09=09pgoff_t end, unsigned long flags)
> > > +=09=09=09      pgoff_t end)
> > >  {
> > >  =09struct page *head =3D compound_head(page);
> > >  =09pg_data_t *pgdat =3D page_pgdat(head);
> > > @@ -2442,8 +2442,6 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
> > >  =09unsigned long offset =3D 0;
> > >  =09int i;
> > > =20
> > > -=09lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
> > > -
> > >  =09/* complete memcg works before add pages to LRU */
> > >  =09mem_cgroup_split_huge_fixup(head);
> > > =20
> > > @@ -2455,6 +2453,11 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
> > >  =09=09xa_lock(&swap_cache->i_pages);
> > >  =09}
> > > =20
> > > +=09/* lock lru list/PageCompound, ref freezed by page_ref_freeze */
> > > +=09spin_lock(&pgdat->lru_lock);
> > > +
> > > +=09lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
> > > +
> > >  =09for (i =3D HPAGE_PMD_NR - 1; i >=3D 1; i--) {
> > >  =09=09__split_huge_page_tail(head, i, lruvec, list);
> > >  =09=09/* Some pages can be beyond i_size: drop them from page cache =
*/
> > > @@ -2474,6 +2477,8 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
> > >  =09}
> > > =20
> > >  =09ClearPageCompound(head);
> > > +=09spin_unlock(&pgdat->lru_lock);
> > > +=09/* Caller disabled irqs, so they are still disabled here */
> > > =20
> > >  =09split_page_owner(head, HPAGE_PMD_ORDER);
> > > =20
> > > @@ -2491,8 +2496,7 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
> > >  =09=09page_ref_add(head, 2);
> > >  =09=09xa_unlock(&head->mapping->i_pages);
> > >  =09}
> > > -
> > > -=09spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> > > +=09local_irq_enable();
> > > =20
> > >  =09remap_page(head);
> > > =20
> > > @@ -2631,12 +2635,10 @@ bool can_split_huge_page(struct page *page, i=
nt *pextra_pins)
> > >  int split_huge_page_to_list(struct page *page, struct list_head *lis=
t)
> > >  {
> > >  =09struct page *head =3D compound_head(page);
> > > -=09struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
> > >  =09struct deferred_split *ds_queue =3D get_deferred_split_queue(head=
);
> > >  =09struct anon_vma *anon_vma =3D NULL;
> > >  =09struct address_space *mapping =3D NULL;
> > >  =09int count, mapcount, extra_pins, ret;
> > > -=09unsigned long flags;
> > >  =09pgoff_t end;
> > > =20
> > >  =09VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> > > @@ -2697,9 +2699,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
> > >  =09unmap_page(head);
> > >  =09VM_BUG_ON_PAGE(compound_mapcount(head), head);
> > > =20
> > > -=09/* prevent PageLRU to go away from under us, and freeze lru stats=
 */
> > > -=09spin_lock_irqsave(&pgdata->lru_lock, flags);
> > > -
> > > +=09local_irq_disable();
> > >  =09if (mapping) {
> > >  =09=09XA_STATE(xas, &mapping->i_pages, page_index(head));
> > > =20
> > > @@ -2729,7 +2729,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
> > >  =09=09=09=09__dec_node_page_state(head, NR_FILE_THPS);
> > >  =09=09}
> > > =20
> > > -=09=09__split_huge_page(page, list, end, flags);
> > > +=09=09__split_huge_page(page, list, end);
> > >  =09=09if (PageSwapCache(head)) {
> > >  =09=09=09swp_entry_t entry =3D { .val =3D page_private(head) };
> > > =20
> > > @@ -2748,7 +2748,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
> > >  =09=09spin_unlock(&ds_queue->split_queue_lock);
> > >  fail:=09=09if (mapping)
> > >  =09=09=09xa_unlock(&mapping->i_pages);
> > > -=09=09spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> > > +=09=09local_irq_enable();
> > >  =09=09remap_page(head);
> > >  =09=09ret =3D -EBUSY;
> > >  =09}
--0-1390346354-1594097567=:2793--
