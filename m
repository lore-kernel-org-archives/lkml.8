Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB6C2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzRs3ha+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCQEww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:52:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42053 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgCQEww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:52:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so16368650qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HmNBZ2Fb6XAr6Ve5H1ieEf9RVZQcVNun5fBa1AuybTA=;
        b=RzRs3ha+V9ZJfk/lfquDxIObbYW7Ye830mzWa4TgY+JG0vg/QVno6YT0tVj7Ny2ciw
         yTV3CpcXfx0yBGgUjhZm4hsg6xVS41DLPvKsRhIquBtlxDAO0zjcOZMtBa7fqrbxiuN0
         6Wl3ZtcO/OGJXTQOorrIkGm1OQdtSIEF4i4LlBvS5AGMVK9aLwZ/ouNh/dfzOn4CMknk
         fPXqePjtL8nJSfYs/vGDZRA1g5ROivtPrQ9vOtX/pGvSUKOL3Hp/Nn3pEGzzRMmxFbRL
         BRFnolx0GL6zW6/sLP5fMkjdkO7K8fFYxS3kfGdLvhUPyGTOijCPMRPkGDnPxz4HPfzd
         OcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HmNBZ2Fb6XAr6Ve5H1ieEf9RVZQcVNun5fBa1AuybTA=;
        b=mSfY03N/lROAdLxtZ9PIY+VId65Crv+qSHbZAR4owDNaGydlBO2/ODWNULHlceofXL
         lOEzunrjODkTD/pXerqy2ArJUwfh3HU7npXo1A+QfEZbDlQ1noYqQ+zBQ3wpRqDDev1o
         F6seTMQlQ7EpwhKp2rdbjmYktV/40sMuVink4qbixi4DGjiaYdHdRNnTOxyQxhFe98zM
         50dSgbH9epKkWPWOonp0jXNNtZM8fZgCrZitjpcjb1XPNyiPNXqO/ibeUz8K322XLP72
         L+N/TuLfMdss6zL3yMTgZrAivJAUtqAag+vhc6MGljEPaL5l80lHS4vO769jNmlOmUBY
         RhBw==
X-Gm-Message-State: ANhLgQ0YyBRMfV8qTXZ1b2HrJb0xaC0CbcV0RE4tGubMDLzPaLaopKxt
        VGyF1wN8H+Tj/TlY3M9YA8H9mAvXT0b4kO55uLw=
X-Google-Smtp-Source: ADFU+vvpXxTgkHktukI3njVQwYIA+0aosdP4+TCG0/z1yf3lf29Xcigey0ElHXy5Kyj4rR2X1a84WG94Y4FH9A0CQus=
X-Received: by 2002:aed:3346:: with SMTP id u64mr3395904qtd.333.1584420771409;
 Mon, 16 Mar 2020 21:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20200312151423.GH29835@cmpxchg.org> <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
 <20200313195510.GA67986@cmpxchg.org> <CAAmzW4PgTeRsr6jZZpvgb85e1xVBa8g17kvVFQGm7=WPXwHK_g@mail.gmail.com>
 <20200316161208.GB67986@cmpxchg.org>
In-Reply-To: <20200316161208.GB67986@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 17 Mar 2020 13:52:40 +0900
Message-ID: <CAAmzW4NZ1vBPFDv7CkbCXBjyNbT1HKHEJo1Np-Uop0kf+buN8w@mail.gmail.com>
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

2020=EB=85=84 3=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 1:12, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Mar 16, 2020 at 04:05:30PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 3=EC=9B=94 14=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 4:5=
5, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > The problem with executables is that when they are referenced, they
> > > get a *lot* of references compared to data pages. Think about an
> > > instruction stream and how many of those instructions result in data
> > > references. So when you see an executable page that is being accessed=
,
> > > it's likely being accessed at a high rate. They're much hotter, and
> > > that's why reference bits from VM_EXEC mappings carry more weight.
> >
> > Sound reasonable.
> >
> > But, now, I have another thought about it. I think that the root of the=
 reason
> > of this check is that there are two different reference tracking models
> > on file LRU. If we assume that all file pages are mapped ones, this spe=
cial
> > check isn't needed. If executable pages are accessed more frequently th=
an
> > others, reference can be found more for them at LRU cycle. No need for =
this
> > special check.
> >
> > However, file pages includes syscall-ed pages and mapped pages, and,
> > reference tracking models for mapped page has a disadvantage to
> > one for syscall-ed page. Several references for mapped page would be
> > considered as one at LRU cycle. I think that this check is to mitigate
> > this disadvantage, at least, for executable file mapped page.
>
> Hm, I don't quite understand this reasoning. Yes, there are two models
> for unmapped and mapped file pages. But both types of pages get
> activated with two or more references: for unmapped it's tracked
> through mark_page_accessed(), and for mapped it's the two LRU cycles
> with the referenced bit set (unmapped pages don't get that extra trip
> around the LRU with one reference). With that alone, mapped pages and
> unmapped pages should have equal chances, no?
>

Think about following example.

Assume that the size of inactive list for file page is 100.

1. start the new page, A, and access to A happens
2. 50 inactive pages are reclaimed due to 50 new pages
3. second access to A happens
4. 50 inactive pages are reclaimed due to 50 new pages
5. 100 inactive pages are reclaimed due to 100 new pages

If A is:
unmapped page: the page is activated at #3 and lives after #5
mapped page: the page reference is checked at #4 and re-attached
to the inactive list with PageReferenced() but is eventually reclaimed at #=
5

Even they are referenced by the same pattern, mapped page is reclaimed
but unmapped isn't. This is, what I said before, the disadvantage of
the mapped page than unmapped page. My guess is that to mitigate this
disadvantage on mapped file page, VM_EXEC test is needed since
VM_EXEC is the most important case for mapped file page.

Thanks.
