Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3620771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6mVErwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGXDqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXDqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:46:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF2C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:46:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so6713842wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4J07zWXl7gx9PKEYJvn7EJ3LUQ854Vz+YTl+3vbqAY=;
        b=C6mVErwtomReoITMugJNqU569a7mg+Mi54NW0KTPb/ek0WcdjBImAYVsJZ2NBfpOnm
         FQ2wlSJFDFOO4d94T1hhmkXW1fbi8S9p483YWzMyqu3r+bGBngERW+C3Qs0na7MrVh8q
         NEAhrF6u90fodX0dCPFOkyQIsOtoWnTwdUogV0qsCccR3Gks+GEl963pMUuVe9Y7WI5r
         RTIcvOruSfzxiiVFKse6/NG8dKh73Yo06eev8NgFCbtZBAGSXZBaTMp5YfknP80pISK/
         LxHrhby0G1lFReM4GpTz0kiL7D7eg08mRnRS8Vw/ShtKLC4Yp/MqsTizbqvq4seR+MZT
         KaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4J07zWXl7gx9PKEYJvn7EJ3LUQ854Vz+YTl+3vbqAY=;
        b=A6Vgg06nd7fBfNec9QZy87veiR26MBa/JH0ljAUmEgzY53Y17BWyBVlKvV5HCgTJSN
         HLXT/VAFQJ9zhvqWJEOiI8k4cn38ue9V0eTyX+MBB7KmmKqfksDNvabusZILBVPGJteD
         myZJ69oledaSxBmm89asmD/vSKOttY1GccdPBK1Af2gWYmWQG5pXXfESYv4IJ+nfBqHQ
         r5kh/ysnOk+5gZ8i9v1HDI7P9tN9gbC4nR3FKiUH5w+S1ZRMY4VgkPTZhmjPcKitgrlz
         A82cgtZ6mNXqr+sNRqIm7OW0t5ansNxqyLOZ8AqU/iboEtbKIdpBPMbSYPxUe4CBwOXa
         MEnQ==
X-Gm-Message-State: AOAM532CZeG3IaDjUao/2pcyVPZSLvuzMMaYABy+WcJzuMrGP0PBq6RB
        KkflFbpACSxgeMOamjUkCxG6eqLDx6tGqSE/dC98iNUG
X-Google-Smtp-Source: ABdhPJz9rZ1cUR8D93W8V+89NR+0UPp92dpRf7lfMX0mGUeNHm3QfgxO0pABEBPSxzCG4U/YTKFZ3eh1g+OkV4dnWYk=
X-Received: by 2002:a1c:9650:: with SMTP id y77mr6597593wmd.101.1595562373681;
 Thu, 23 Jul 2020 20:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <alpine.LSU.2.11.2007231650170.1281@eggly.anvils> <CAHk-=wgptprCsM9Vv7wvBF6q23rR5WA94pBGD5kfS2sPwgNVyA@mail.gmail.com>
In-Reply-To: <CAHk-=wgptprCsM9Vv7wvBF6q23rR5WA94pBGD5kfS2sPwgNVyA@mail.gmail.com>
From:   Hugh Dickins <hughd@google.com>
Date:   Thu, 23 Jul 2020 20:45:34 -0700
Message-ID: <CANsGZ6YBf+JCPYa_QOhO-uauebK5HVmacaGCQmvNSsws3-ca-g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 5:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 23, 2020 at 5:07 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I say that for full disclosure, so you don't wrack your brains
> > too much, when it may still turn out to be a screwup on my part.
>
> Sounds unlikely.
>
> If that patch applied even reasonably closely, I don't see how you'd
> see a list corruption that wasn't due to the patch.
>
> You'd have had to use the wrong spinlock by mistake due to munging it,
> or something crazy like that.
>
> The main list-handling change is
>
>  (a) open-coding of that finish_wait()
>
>  (b) slightly different heuristics for removal in the wakeup function
>
> where (a) was because my original version of finishing the wait needed
> to do that return code checking.
>
> So a normal "finish_wait()" just does
>
>         list_del_init(&wait->entry);
>
> where-as my open-coded one replaced that with
>
>         if (!list_empty(&wait->entry)) {
>                 list_del(&wait->entry);
>                 ret = -EINTR;
>         }
>
> and apart from that "set return to -EINTR because nobody woke us up",
> it also uses just a regular "list_del()" rather than a
> "list_del_init()". That causes the next/prev field to be poisoned
> rather than re-initialized. But that second change was because the
> list entry is on the stack, and we're not touching it any more and are
> about to return, so I removed the "init" part.
>
> Anyway, (a) really looks harmless. Unless the poisoning now triggers
> some racy debug test that had been hidden by the "init". Hmm.
>
> In contrast, (b) means that the likely access patterns of irqs
> removing the wait entry from the list might be very different from
> before. The old "autoremove" semantics would only remove the entry
> from the list when try_to_wake_up() actually woke things up. Now, a
> successful bit state _always_ removes it, which was kind of the point.
> But it might cause very different list handling patterns.
>
> All the actual list handling looks "obviously safe" because it's
> protected by the spinlock, though...
>
> If you do get oopses with the new patch too, try to send me a copy,
> and maybe I'll stare at exactly where it happens register contents and
> go "aah".

This new version is doing much better: many hours to go, but all
machines have got beyond the danger point where yesterday's version
was crashing - phew!

Hugh
