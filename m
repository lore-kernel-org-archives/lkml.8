Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C9214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBCPgL3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgDWW7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDWW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:59:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D3C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:59:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so6152153lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymB7zugngWO+i0v75OQaFojbIXokcEX7m4aPDvGIWpA=;
        b=lBCPgL3X0d4c8Vmo0ZuZWTRWW3WIapxdSRAQnvoHI2Sxxv3DtX2hDX2KjZfWH4Trgn
         0rKE6UY1uD5gBMTCJSY6d3fSeOcLWzeabq0kEF6JY/6yyFVsb8UAz9ogDtk2KmsFkQcs
         aZhgr6bUO3xkkIR8udvJdu2N4gGyBGVNOcyOcSgm53FIJ7XX3Tt0vDRUxeTEaC95jixe
         3pHodPB6LWadvt7gTvtDUuM6Y6ko76UoEe6yAAFEZ/ahng/EFnIL58my4FEZUkgJtY7E
         0ohXBKNPdSlRlySgFl283dOIbOgQ/rp21RfU4aAEzmKQFZv3LOaWlsHErKzQCu0r1BId
         Pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymB7zugngWO+i0v75OQaFojbIXokcEX7m4aPDvGIWpA=;
        b=e87vjpruuqIqeWwporqIaYDDlI/TQburVFtTnE8mzl6LZaxzFO0T2jIBC0oqd8i4V4
         ++GCbzKfxknhfbGGSuToaXWt9ZyUzcfjAANbYicPFQLo0aYrd7LcekQU0zxL8B44cL0G
         VzuNYJLMuMSGOwoeatHeSzTx9U/K6NMVrHJspr8X23Q0KeENf7r+0V+2n037QMBJUS+1
         9poAlQjqPK+V5wRLd9V0y29pKakAWlMQhY4lexZQAU4lzq1mL3H3Yfw9DOJv6V9PW+C/
         s9561Tzy9YSAI88ENDkJFED++rqCn038Fp61zB+oVrQ+nsOkrMZ0RP9UfgNMA+p7Sc1z
         8iLA==
X-Gm-Message-State: AGi0PuZSpLb59xKJRBbOxAVn3w/0vJmJRQugKKnoqq8Jw907aHqPBeff
        M7IM6/uQpkJzaf6AARoXE1yNreYAguJsbBSfv3VftQ==
X-Google-Smtp-Source: APiQypLQKfsxTw6oNEQ0/qCrbY9Z9lKEm3CAkv02dnCdQhWbO0Sk1oxdeIuoUcw+Jv233nfZDRqMtu3HZ9BpOGNcM+o=
X-Received: by 2002:ac2:5dcf:: with SMTP id x15mr3861021lfq.3.1587682792002;
 Thu, 23 Apr 2020 15:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200304022058.248270-1-shakeelb@google.com> <20200305204109.be23f5053e2368d3b8ccaa06@linux-foundation.org>
 <CALvZod7W-Qwa4BRKW0_Ts5f68fwkcqD72SF_4NqZRgEMgA_1-g@mail.gmail.com>
In-Reply-To: <CALvZod7W-Qwa4BRKW0_Ts5f68fwkcqD72SF_4NqZRgEMgA_1-g@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Apr 2020 15:59:41 -0700
Message-ID: <CALvZod4R68wNgzOF9dN=i6LwyUYMBhvM7SXaRJGW9Wn_SmeGGA@mail.gmail.com>
Subject: Re: [PATCH] memcg: optimize memory.numa_stat like memory.stat
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 8:54 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Mar 5, 2020 at 8:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  3 Mar 2020 18:20:58 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > Currently reading memory.numa_stat traverses the underlying memcg tree
> > > multiple times to accumulate the stats to present the hierarchical view
> > > of the memcg tree. However the kernel already maintains the hierarchical
> > > view of the stats and use it in memory.stat. Just use the same mechanism
> > > in memory.numa_stat as well.
> > >
> > > I ran a simple benchmark which reads root_mem_cgroup's memory.numa_stat
> > > file in the presense of 10000 memcgs. The results are:
> > >
> > > Without the patch:
> > > $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> > >
> > > real    0m0.700s
> > > user    0m0.001s
> > > sys     0m0.697s
> > >
> > > With the patch:
> > > $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> > >
> > > real    0m0.001s
> > > user    0m0.001s
> > > sys     0m0.000s
> > >
> >
> > Can't you do better than that ;)
> >
> > >
> > > +     page_state = tree ? lruvec_page_state : lruvec_page_state_local;
> > > ...
> > >
> > > +     page_state = tree ? memcg_page_state : memcg_page_state_local;
> > >
> >
> > All four of these functions are inlined.  Taking their address in this
> > fashion will force the compiler to generate out-of-line copies.
> >
> > If we do it the uglier-and-maybe-a-bit-slower way:
> >
> > --- a/mm/memcontrol.c~memcg-optimize-memorynuma_stat-like-memorystat-fix
> > +++ a/mm/memcontrol.c
> > @@ -3658,17 +3658,16 @@ static unsigned long mem_cgroup_node_nr_
> >         struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> >         unsigned long nr = 0;
> >         enum lru_list lru;
> > -       unsigned long (*page_state)(struct lruvec *lruvec,
> > -                                   enum node_stat_item idx);
> >
> >         VM_BUG_ON((unsigned)nid >= nr_node_ids);
> >
> > -       page_state = tree ? lruvec_page_state : lruvec_page_state_local;
> > -
> >         for_each_lru(lru) {
> >                 if (!(BIT(lru) & lru_mask))
> >                         continue;
> > -               nr += page_state(lruvec, NR_LRU_BASE + lru);
> > +               if (tree)
> > +                       nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
> > +               else
> > +                       nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
> >         }
> >         return nr;
> >  }
> > @@ -3679,14 +3678,14 @@ static unsigned long mem_cgroup_nr_lru_p
> >  {
> >         unsigned long nr = 0;
> >         enum lru_list lru;
> > -       unsigned long (*page_state)(struct mem_cgroup *memcg, int idx);
> > -
> > -       page_state = tree ? memcg_page_state : memcg_page_state_local;
> >
> >         for_each_lru(lru) {
> >                 if (!(BIT(lru) & lru_mask))
> >                         continue;
> > -               nr += page_state(memcg, NR_LRU_BASE + lru);
> > +               if (tree)
> > +                       nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
> > +               else
> > +                       nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
> >         }
> >         return nr;
> >  }
> >
> > Then we get:
> >
> >                      text    data     bss     dec     hex filename
> > now:               106705   35641    1024  143370   2300a mm/memcontrol.o
> > shakeel:           107111   35657    1024  143792   231b0 mm/memcontrol.o
> > shakeel+the-above: 106805   35657    1024  143486   2307e mm/memcontrol.o
> >
> > Which do we prefer?  The 100-byte patch or the 406-byte patch?
>
> I would go with the 100-byte one. The for-loop is just 5 iteration, so
> doing a check in each iteration should not be an issue.
>

Andrew, anything more needed for this patch to be merged?

Shakeel
