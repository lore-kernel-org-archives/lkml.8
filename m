Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB3420737
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVJhVenJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgFJDWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:22:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC9C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:22:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so610803otv.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hHH9e/LiOW5H3k9fW9AUTTMwkhJh6YJBdmz/N3uFEuo=;
        b=XVJhVenJbge0EJlY/D27dtJq6OjTVaxc3kSV5ZZZCuWVDJpXLNUEQ09Zo/uvIh2X/i
         4JmhwPMUkfBrnVCqR9BsXP0zqduoCC9+kBisKz0cpZSDuOTQQjVGH7C25YVzb9uq1zfk
         XKftOKeOXeyho8NhPGubvDBR4gDvLo5kPwkZ5K6wPvoxlCuPlv1GmoqrnsFrl3+53FEH
         o0StwJIYUD9o9Ib2hY/MgLOUGXZ4tZZPOTjL7jt3oYX+OoqoxGlh9wgJMnyduIMCdwQc
         lH9RGelXuLRj+tHiaCkPH3qD8HA09k3u2LqXxxt8eVFX6kRR0RoQ9ry94ViruOtngRsF
         ESJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hHH9e/LiOW5H3k9fW9AUTTMwkhJh6YJBdmz/N3uFEuo=;
        b=J8CW14+73/mR2E6PvOgAAo+EKUnyG8bzOgoXGaCMWUSVkNEEFn6pjTRxqGA3dBBeDA
         WzQOnsmHxFrUBVs7aP5oJwP8bIsIXTPtQFAhspLaTvTfLJbPdPGZiM7RZy+4UoxmxYvy
         LP5DDqsLStX5+4S5R+nws9rC2E/8cIJioQEAzSlmkWQC+4BMIdGKNol0J388F/1RfsGI
         cP/XBPdr4lIoSHwIHtna4VZVZhbneGNtltS1QzVH/rqETDwWl8xJHZPVCtEQF49pJSbQ
         LQOQL6KgxTE0MQsmOrU9X5bCvBnlJuW6JJrx/skp/wlGOvwkol0vS1gzg5ryxKwl83ia
         h0sg==
X-Gm-Message-State: AOAM533wszWbZybNopmB4xQLdHKqevBryfOCFYe1RAKY52UjR8QBdK64
        pWedgFUIlzQMhZPeSfyKDb/BEw==
X-Google-Smtp-Source: ABdhPJx8TFQhzDmzqiHaHJXj5Ts880eSan4PQLvc/01qOh7b7uB2a7s9lFYXfIyLy3HCZo2Jr4jC8g==
X-Received: by 2002:a9d:220c:: with SMTP id o12mr1128942ota.155.1591759357385;
        Tue, 09 Jun 2020 20:22:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a64sm3622078oib.43.2020.06.09.20.22.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 09 Jun 2020 20:22:36 -0700 (PDT)
Date:   Tue, 9 Jun 2020 20:22:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v11 00/16] per memcg lru lock
In-Reply-To: <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2006091904530.2779@eggly.anvils>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com> <alpine.LSU.2.11.2006072100390.2001@eggly.anvils> <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-761195576-1591759355=:2779"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-761195576-1591759355=:2779
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Jun 2020, Alex Shi wrote:
> =E5=9C=A8 2020/6/8 =E4=B8=8B=E5=8D=8812:15, Hugh Dickins =E5=86=99=E9=81=
=93:
> >>  24 files changed, 487 insertions(+), 312 deletions(-)
> > Hi Alex,
> >=20
> > I didn't get to try v10 at all, waited until Johannes's preparatory
> > memcg swap cleanup was in mmotm; but I have spent a while thrashing
> > this v11, and can happily report that it is much better than v9 etc:
> > I believe this memcg lru_lock work will soon be ready for v5.9.
> >=20
> > I've not yet found any flaw at the swapping end, but fixes are needed
> > for isolate_migratepages_block() and mem_cgroup_move_account(): I've
> > got a series of 4 fix patches to send you (I guess two to fold into
> > existing patches of yours, and two to keep as separate from me).
> >=20
> > I haven't yet written the patch descriptions, will return to that
> > tomorrow.  I expect you will be preparing a v12 rebased on v5.8-rc1
> > or v5.8-rc2, and will be able to include these fixes in that.
>=20
> I am very glad to get your help on this feature!=20
>=20
> and looking forward for your fixes tomorrow. :)
>=20
> Thanks a lot!
> Alex

Sorry, Alex, the news is not so good today.

You'll have noticed I sent nothing yesterday. That's because I got
stuck on my second patch: could not quite convince myself that it
was safe.

I keep hinting at these patches, and I can't complete their writeups
until I'm convinced; but to give you a better idea of what they do:

1. Fixes isolate_fail and isolate_abort in isolate_migratepages_block().
2. Fixes unsafe use of trylock_page() in __isolate_lru_page_prepare().
3. Reverts 07/16 inversion of lock ordering in split_huge_page_to_list().
4. Adds lruvec lock protection in mem_cgroup_move_account().

In the second, I was using rcu_read_lock() instead of trylock_page()
(like in my own patchset), but could not quite be sure of the case when
PageSwapCache gets set at the wrong moment. Gave up for the night, and
in the morning abandoned that, instead just shifting the call to
__isolate_lru_page_prepare() after the get_page_unless_zero(),
where that trylock_page() becomes safe (no danger of stomping on page
flags while page is being freed or newly allocated to another owner).

I thought that a very safe change, but best to do some test runs with
it in before finalizing. And was then unpleasantly surprised to hit a
VM_BUG_ON_PAGE(lruvec_memcg(lruvec) !=3D page->mem_cgroup) from
lock_page_lruvec_irqsave < relock_page_lruvec < pagevec_lru_move_fn <
pagevec_move_tail < lru_add_drain_cpu after 6 hours on one machine.
Then similar but < rotate_reclaimable_page after 8 hours on another.

Only seen once before: that's what drove me to add patch 4 (with 3 to
revert the locking before it): somehow, when adding the lruvec locking
there, I just took it for granted that your patchset would have the
appropriate locking (or TestClearPageLRU magic) at the other end.

But apparently not. And I'm beginning to think that TestClearPageLRU
was just to distract the audience from the lack of proper locking.

I have certainly not concluded that yet, but I'm having to think about
an area of the code which I'd imagined you had under control (and I'm
puzzled why my testing has found it so very hard to hit). If we're
lucky, I'll find that pagevec_move_tail is a special case, and
nothing much else needs changing; but I doubt that will be so.

There's one other unexplained and unfixed bug I've seen several times
while exercising mem_cgroup_move_account(): refcount_warn_saturate()
from where __mem_cgroup_clear_mc() calls mem_cgroup_id_get_many().
I'll be glad if that goes away when the lruvec locking is fixed,
but don't understand the connection. And it's quite possible that
this refcounting bug has nothing to do with your changes: I have
not succeeded in reproducing it on 5.7 nor on 5.7-rc7-mm1,
but I didn't really try long enough to be sure.

(I should also warn, that I'm surprised by the amount of change
11/16 makes to mm/mlock.c: I've not been exercising mlock at all.)

Taking a break for the evening,
Hugh
--0-761195576-1591759355=:2779--
