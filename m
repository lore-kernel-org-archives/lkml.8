Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E41C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2D20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id+LAlt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgDBFoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:44:04 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38818 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBFoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:44:03 -0400
Received: by mail-qk1-f178.google.com with SMTP id h14so2793862qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=erlJ9BiPK98HSbML/OVD/782ON3A5u24EUc7eHkRs6Q=;
        b=id+LAlt93CSAdgB3MXxHQzvKKRofEZUH6Z9iKxB7VMrFw/dQIZS8Ae9yVO+EChSQ+K
         90oT4C+IHTbS+m1fCTZMk/orxFJ5WoEOR31boS4vls5NqdQhL0D2tVxIG1qZr64rAFqn
         8Ww2QunjU4NMloJHCK2dt87E8AAdCVNTz49ZLKaoEB+ppscjkiTVPrXLME+N7Uduxs8Y
         zttoSOI88MSp4mm74jIQIACVMAAzqI71kY4NUJWC00zCngXIE05/j7MLBDOhAnd355l/
         whPrT5KyXaYrWd/rX85ijEzf7tss4draTaDjSbvXQIZln48LWE9rqStEOBwbnYYKtqih
         gj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=erlJ9BiPK98HSbML/OVD/782ON3A5u24EUc7eHkRs6Q=;
        b=HA3MB8TEJ8FUkG/NUh53XZcctRzvlo3cwMk4tAk2bWWIqOJsUh2Uuh0H0MVpdBm+x6
         cwTNGVi0ca9dVanQp4zNO4wAaKwyzg4dFRI2UYhLuPoMaz5Y9KWfFaeQsnNx50894TuS
         fO4KOl6XKv1n4eVcOcrr0o1tYr8llkeM3ZhsGghVC3ajDFHkYLBighj3gyuk6mzDDvXF
         zODgam8iPwNfeEz1ji2L9HaIJXcbK9tru/BduqKj1HZm7mjK7k1nQfAT1DJSC2acHnnA
         Mvcv2aEq0ULyFcSVy0RBhLKinkfebeyDblTKwiMv1EvgctFHVhj6+xKwCzPE2gmRmqHW
         fD9Q==
X-Gm-Message-State: AGi0PuZApVyxJrYN8mdKIRzin1Kp3dQCSyN74SU2eR8vu1Re8PBBNBGh
        c73Bgr5wP+DoB+BdbCIcFEyM39AvnYR6BWz6ez0=
X-Google-Smtp-Source: APiQypLCJaUnKMnno5qVuPneB/GNmjEHhNB+msDw4ATI/HnlFXaERo7iJRZCV2ZEDXD5YyxwZ9m/rdNUsiZQfuPlSGY=
X-Received: by 2002:ae9:e858:: with SMTP id a85mr1692048qkg.343.1585806240246;
 Wed, 01 Apr 2020 22:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com> <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org> <20200402025335.GB69473@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200402025335.GB69473@carbon.DHCP.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 2 Apr 2020 14:43:49 +0900
Message-ID: <CAAmzW4PF1AXcZnQpWmqWgTShu+5v7B=nv8waRv+vk-0Bd78cZw@mail.gmail.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:54, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Apr 01, 2020 at 07:13:22PM -0700, Andrew Morton wrote:
> > On Thu, 12 Mar 2020 10:41:28 +0900 Joonsoo Kim <js1304@gmail.com> wrote=
:
> >
> > > Hello, Roman.
> > >
> > > 2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2=
:35, Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > >
> > > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > > Posting this one for Roman so I can deal with any upstream feed=
back and
> > > > > > create a v2 if needed, while scratching my head over the next p=
iece of
> > > > > > this puzzle :)
> > > > > >
> > > > > > ---8<---
> > > > > >
> > > > > > From: Roman Gushchin <guro@fb.com>
> > > > > >
> > > > > > Currently a cma area is barely used by the page allocator becau=
se
> > > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > > hard to make sure that the fallback path isn't used.
> > > > >
> > > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_=
CMA corner
> > > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was rev=
erted due to
> > > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > > >
> > > > Hi Vlastimil!
> > > >
> > > > Thank you for this reminder! I actually looked at it and also asked=
 Joonsoo in private
> > > > about the state of this patch(set). As I understand, Joonsoo plans =
to resubmit
> > > > it later this year.
> > > >
> > > > What Rik and I are suggesting seems to be much simpler, however it'=
s perfectly
> > > > possible that Joonsoo's solution is preferable long-term.
> > > >
> > > > So if the proposed patch looks ok for now, I'd suggest to go with i=
t and return
> > > > to this question once we'll have a new version of ZONE_MOVABLE solu=
tion.
> > >
> > > Hmm... utilization is not the only matter for CMA user. The more
> > > important one is
> > > success guarantee of cma_alloc() and this patch would have a bad impa=
ct on it.
> > >
> > > A few years ago, I have tested this kind of approach and found that i=
ncreasing
> > > utilization increases cma_alloc() failure. Reason is that the page
> > > allocated with
> > > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by some=
one.
> > >
> > > Until now, cma memory isn't used much so this problem doesn't occur e=
asily.
> > > However, with this patch, it would happen.
> >
> > So I guess we keep Roman's patch on hold pending clarification of this
> > risk?
>
> The problem here is that we can't really find problems if we don't use CM=
A as intended
> and just leave it free. Me and Rik are actively looking for page migratio=
n problems
> in our production, and we've found and fixed some of them. Our setup is l=
ikely different
> from embedded guys who are in my understanding most active cma users, so =
even if we
> don't see any issues I can't guarantee it for everybody.
>
> So given Joonsoo's ack down in the thread (btw, I'm sorry I've missed a g=
ood optimization
> he suggested, will send a patch for that), I'd go with this patch at leas=
t until

Looks like you mean Minchan's ack. Anyway, I don't object this one.

In fact, I've tested this patch and your fixes for migration problem
and found that there is
still migration problem and failure rate is increased by this patch.
However, given that
there is no progress on this area for a long time, I think that
applying the change aggressively
is required to break the current situation.

Thanks.
