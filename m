Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D6C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449A120679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/06LKsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgCPHFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:05:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43321 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:05:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id l13so13249257qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfp7PcgeB2GWjSel9suwPHc+OAml4Kc4zwkxhddj5vI=;
        b=r/06LKsqnbxAzhTZh7xwP/1PPC+RKklxfGT4Itm6dEnNvSNHA+vJo2A9DVcD2+8FYf
         XamrNFGKBa9TwRwKLcFwIRT+yfMhluxnTniut279AbBVFt4uFcerSUPv7OzetRP41vI7
         ebv1slvozp3VD5+XaW5nlX1agqzkGAJ2HRBwzh0k6CXEjmqETGf3jVxpR+rPkUiPNeHI
         Navo2mIzjasY6CXZC0kQWjRUSulsb65FQeKMurzqToJoO4026PwK1/Y+w7LPyfzu8wL/
         OQftvzTcVl09rg5gaQX0YgDyGOEsm9mUgm3qn+x6LY9ysUFB0gU2tUU/TGe9Ofq0gXTz
         3U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfp7PcgeB2GWjSel9suwPHc+OAml4Kc4zwkxhddj5vI=;
        b=DEw21caj2QqSOANCk2GRjufIZi9+2HIOxwVNGb2hcM+zAOKUm4k5vqC2vP4H8uaP31
         tTmnWdyAc+I74F/CT8AQjxpp6rnL/MCIWbraaEQ1O18EqPc2aoGfX6t7hog6KG0/GGtx
         VoTSAfW3CsCs9CFG2gKB7/lrRaqk3FF0nIxxupdTRc562fWz/REJrxACxzK1ptnHpUeF
         G6P8j6gpxSE/DU1gZs4OgsWIIlMexLGxTw5QjOEHYn4nbkuUC0wBwQhkHO+owPA0JNVI
         kqJ5qdbz8RmeY7Ql/IYt8Vax2s/Myu87ylroZV1I+I2mpn6WqnsEIZt2blCzsJiKqx8o
         EcBA==
X-Gm-Message-State: ANhLgQ3XyBdhCBlseNR4ceNHxeywbwSbLpKhos2jcbQT/Dee+U0iLRa3
        JMMKRjVcV+J97/+Hu32NfEUqltYyZdoUMFWT214=
X-Google-Smtp-Source: ADFU+vs0+Voali1P4fd8tAwX1tMqg4NoM+29m2e9g+Jl1c8wR1oZN9yb7xphhMNDcgPPpoTauBylGQu8AnizAGQDUr0=
X-Received: by 2002:aed:3346:: with SMTP id u64mr16483501qtd.333.1584342341305;
 Mon, 16 Mar 2020 00:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20200312151423.GH29835@cmpxchg.org> <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
 <20200313195510.GA67986@cmpxchg.org>
In-Reply-To: <20200313195510.GA67986@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 16 Mar 2020 16:05:30 +0900
Message-ID: <CAAmzW4PgTeRsr6jZZpvgb85e1xVBa8g17kvVFQGm7=WPXwHK_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: protect the workingset on anonymous LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 14=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 4:55, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Mar 13, 2020 at 04:40:18PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:=
14, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > On Thu, Feb 20, 2020 at 02:11:46PM +0900, js1304@gmail.com wrote:
> > > > @@ -1010,8 +1010,15 @@ static enum page_references page_check_refer=
ences(struct page *page,
> > > >               return PAGEREF_RECLAIM;
> > > >
> > > >       if (referenced_ptes) {
> > > > -             if (PageSwapBacked(page))
> > > > -                     return PAGEREF_ACTIVATE;
> > > > +             if (PageSwapBacked(page)) {
> > > > +                     if (referenced_page) {
> > > > +                             ClearPageReferenced(page);
> > > > +                             return PAGEREF_ACTIVATE;
> > > > +                     }
> > >
> > > This looks odd to me. referenced_page =3D TestClearPageReferenced()
> > > above, so it's already be clear. Why clear it again?
> >
> > Oops... it's just my fault. Will remove it.
> >
> > > > +
> > > > +                     SetPageReferenced(page);
> > > > +                     return PAGEREF_KEEP;
> > > > +             }
> > >
> > > The existing file code already does:
> > >
> > >                 SetPageReferenced(page);
> > >                 if (referenced_page || referenced_ptes > 1)
> > >                         return PAGEREF_ACTIVATE;
> > >                 if (vm_flags & VM_EXEC)
> > >                         return PAGEREF_ACTIVATE;
> > >                 return PAGEREF_KEEP;
> > >
> > > The differences are:
> > >
> > > 1) referenced_ptes > 1. We did this so that heavily shared file
> > > mappings are protected a bit better than others. Arguably the same
> > > could apply for anon pages when we put them on the inactive list.
> >
> > Yes, these check should be included for anon.
> >
> > > 2) vm_flags & VM_EXEC. This mostly doesn't apply to anon pages. The
> > > exception would be jit code pages, but if we put anon pages on the
> > > inactive list we should protect jit code the same way we protect file
> > > executables.
> >
> > I'm not sure that this is necessary for anon page. From my understandin=
g,
> > executable mapped file page is more precious than other mapped file pag=
e
> > because this mapping is usually used by *multiple* thread and there is
> > no way to check it by MM. If anon JIT code has also such characteristic=
, this
> > code should be included for anon, but, should be included separately. I=
t
> > seems that it's beyond of this patch.
>
> The sharing is what the referenced_ptes > 1 check is for.

Sharing between processes can be checked by referenced_ptes,
but, sharing between threads cannot be checked by it. I guess that
VM_EXEC check is for thread case since most of executable is usually
shared by thread. But, from below your comment, I re-consider the
reason of VM_EXEC check. See below.

> The problem with executables is that when they are referenced, they
> get a *lot* of references compared to data pages. Think about an
> instruction stream and how many of those instructions result in data
> references. So when you see an executable page that is being accessed,
> it's likely being accessed at a high rate. They're much hotter, and
> that's why reference bits from VM_EXEC mappings carry more weight.

Sound reasonable.

But, now, I have another thought about it. I think that the root of the rea=
son
of this check is that there are two different reference tracking models
on file LRU. If we assume that all file pages are mapped ones, this special
check isn't needed. If executable pages are accessed more frequently than
others, reference can be found more for them at LRU cycle. No need for this
special check.

However, file pages includes syscall-ed pages and mapped pages, and,
reference tracking models for mapped page has a disadvantage to
one for syscall-ed page. Several references for mapped page would be
considered as one at LRU cycle. I think that this check is to mitigate
this disadvantage, at least, for executable file mapped page.

> IMO this applies to executable file and anon equally.

anon LRU consist of all mapped pages, so, IMHO,  there is no need for
special handling for executable pages on anon LRU. Although reference
is just checked at LRU cycle, it would correctly approximate reference
frequency.

Moreover, there is one comment in shrink_active_list() that explains one
reason about omission of this check for anon pages.

"Anon pages are not likely to be evicted by use-once streaming IO, plus JVM
can create lots of anon VM_EXEC pages, so we ignore them here."

Lastly, as I said before, at least, it is done separately with appropriate
investigation.

> > > Seems to me you don't need to add anything. Just remove the
> > > PageSwapBacked branch and apply equal treatment to both types.
> >
> > I will rework the code if you agree with my opinion.
> >
> > > > @@ -2056,6 +2063,15 @@ static void shrink_active_list(unsigned long=
 nr_to_scan,
> > > >                       }
> > > >               }
> > > >
> > > > +             /*
> > > > +              * Now, newly created anonymous page isn't appened to=
 the
> > > > +              * active list. We don't need to clear the reference =
bit here.
> > > > +              */
> > > > +             if (PageSwapBacked(page)) {
> > > > +                     ClearPageReferenced(page);
> > > > +                     goto deactivate;
> > > > +             }
> > >
> > > I don't understand this.
> > >
> > > If you don't clear the pte references, you're leaving behind stale
> > > data. You already decide here that we consider the page referenced
> > > when it reaches the end of the inactive list, regardless of what
> > > happens in between. That makes the deactivation kind of useless.
> >
> > My idea is that the pages newly appended to the inactive list, for exam=
ple,
> > a newly allocated anon page or deactivated page, start at the same line=
.
> > A newly allocated anon page would have a mapping (reference) so I
> > made this code to help for deactivated page to have a mapping (referenc=
e).
> > I think that there is no reason to devalue the page accessed on active =
list.
>
> I don't think that leads to desirable behavior, because it causes an
> age inversion between deactivated and freshly instantiated pages.
>
> We know the new page was referenced when it entered the head of the
> inactive list. However, the old page's reference could be much, much
> longer in the past. Hours ago. So when they both reach the end of the
> list, we treat them as equally hot even though the new page has been
> referenced very recently and the old page might be completely stale.
>
> Keep in mind that we only deactivate in the first place because the
> inactive list is struggling and we need to get rid of stale active
> pages. We're in a workingset transition and *should* be giving old
> pages the chance to move out quickly.

You're right. I will fix it.

> > Before this patch is applied, all newly allocated anon page are started
> > at the active list so clearing the pte reference on deactivation is req=
uired
> > to check the further access. However, it is not the case so I skip it h=
ere.
> >
> > > And it blurs the lines between the inactive and active list.
> > >
> > > shrink_page_list() (and page_check_references()) are written with the
> > > notion that any references they look at are from the inactive list. I=
f
> > > you carry over stale data, this can cause more subtle bugs later on.
> >
> > It's not. For file page, PageReferenced() is maintained even if deactiv=
ation
> > happens and it means one reference.
>
> shrink_page_list() doesn't honor PageReferenced as a reference.
>
> PG_referenced is primarily for the mark_page_accessed() state machine,
> which is different from the reclaim scanner's reference tracking: for
> unmapped pages we can detect accesses in realtime and don't need the
> reference sampling from LRU cycle to LRU cycle. The bit carries over a
> deactivation, but it doesn't prevent reclaim from freeing the page.
>
> For mapped pages, we sample references using the LRU cycles, and
> PG_referenced is otherwise unused. We repurpose it to implement
> second-chance tracking of inactive pages with pte refs. It counts
> inactive list cycles, not references.

Okay.

> > > And again, I don't quite understand why anon would need different
> > > treatment here than file.
> >
> > In order to preserve the current behaviour for the file page, I leave t=
he code
> > as is for the file page and change the code for the anon page. There is
> > fundamental difference between them such as how referenced is checked,
> > accessed by mapping and accessed by syscall. I think that some differen=
ce
> > would be admitted.
>
> Right, unmapped pages have their own reference tracking system because
> they can be detected synchronously.
>
> My questions center around this:
>
> We have an existing sampling algorithm for the coarse-grained page
> table referenced bit, where we start pages on inactive, treat
> references a certain way, target a certain inactive:active ratio, use
> refault information to detect workingset transitions etc. Anon used a
> different system in the past, but your patch set switches it over to
> the more universal model we have developed for mapped file pages.
>
> However, you don't switch it over to this exact model we have for
> mapped files, but rather a slightly modified version. And I don't
> quite understand the rationale behind the individual modifications.
>
> So let me turn it around. What would be the downsides of aging mapped
> anon exactly the same way we age mapped files? Can we identify where
> differences are necessary and document them?

Now, I plan to make a next version applied all your comments except
VM_EXEC case. As I said above, fundamental difference between
file mapped page and anon mapped page is that file LRU where file mapped
pages are managed uses two reference tracking model but anon LRU uses
just one. File LRU needs some heuristic to adjust the difference of two mod=
els,
but, anon LRU doesn't need at all. And, I think VM_EXEC check is for this c=
ase.

Please let me know your opinion about VM_EXEC case. I will start to rework
if you agree with my thought.

Anyway, all comments are very helpful to me. Really, thanks Johannes.

Thanks.
