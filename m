Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C50C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDFA2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVotjq4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgFPGJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:09:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A137C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:09:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so18155522qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xQrKnqNY8YWa/i+4MF5O3eRlM9y+wtH44CbGAy+PoHk=;
        b=tVotjq4qq3a32BaZerSQVRwVqFKl9B1YnTx0VRCsnEI83cvUSMUjNiim47pPbYnW7r
         QgvWAgL1+r5bFzxPNpPRZ72VUze7YwlanWuhgLXKhXQQYqiK021cajzIen8tqhDGF38B
         ++QD8aI/SqJ2fnmZ+EYMthMczmcRtc6PbppwGDT0FxOHF5yJ2Xbo+/XDYyBX7Wq7ZwRH
         gDvdTq/v+8QvNZEYTKoud3Hj9rbTq1ZDtScNRYq+htX6E1L35ST/SLp+7KJw+ieROL2e
         xi0uQrPucFKinRcpTv9K+/9xy95ppNlWldQGCi8t+WSfM+QNVb7wqqliHpquu86KRP3R
         7K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xQrKnqNY8YWa/i+4MF5O3eRlM9y+wtH44CbGAy+PoHk=;
        b=WF1AeQYvcKAWu77Ufg7dnwN5iS91eyCwo8igK3RDkQO3hWcDT/FqpdyPoHM1jbt/Ab
         ztSYCackSs/vpkZV5635BNozM89xPLroZGIjGXbIPT2q62oP9VkYzUrLeq9FtD+YgsST
         Gtq8pnOZMffJfUtYHBr4/5bBz9ikuC63fqkr+g1VdKMQ+ZIx1o1iMyovuUd2lby0KaJ5
         f3nQN3k8rIyTBaKBuDfx5Vlc4YuOvc4CAKNk/35RAwucLUpKBwaoa+L7BzqF/tLOCAn1
         ju71p31CQwRGifGs0cArv2wWsWdXCP9rg6sTTMQKtkg2UnssPMHxah8Lb1w8/hiXZikH
         xGDw==
X-Gm-Message-State: AOAM533HwVU7kPzQaLI2UlKj/g/FKiPmgrt6Mhds2tjtXUSwNKtUQLKK
        S2Qh2pqqwCV9oNLff0C2QthJKEh+r4GKOL84cVAgjA==
X-Google-Smtp-Source: ABdhPJwrDaLbDAn97BON7FPq+nGmP4z2joGZypd8t9hrGro+gICs/dMmjvmrCQmlcpce4SCyZPhMsTRrtdHG0l+WdCg=
X-Received: by 2002:a05:620a:a4a:: with SMTP id j10mr17973441qka.272.1592287797711;
 Mon, 15 Jun 2020 23:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org> <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org> <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org> <20200601204424.GA212944@cmpxchg.org>
 <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz> <20200604150539.GA322130@cmpxchg.org>
 <CAAmzW4NVoViiGzDx_7fFi-ShhbkB8PXHHSK=Eaa3D7vfZGGFNw@mail.gmail.com> <20200615134104.GA567172@cmpxchg.org>
In-Reply-To: <20200615134104.GA567172@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 16 Jun 2020 15:09:46 +0900
Message-ID: <CAAmzW4MLAtPyLUbYRZJv5=kcbYRj3jH5MHzx-PkU51OqEt3b+g@mail.gmail.com>
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 10:41, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Jun 12, 2020 at 12:19:58PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 5=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:0=
6, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > On Thu, Jun 04, 2020 at 03:35:27PM +0200, Vlastimil Babka wrote:
> > > > On 6/1/20 10:44 PM, Johannes Weiner wrote:
> > > > > From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00=
 2001
> > > > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Date: Mon, 1 Jun 2020 14:04:09 -0400
> > > > > Subject: [PATCH] mm: workingset: let cache workingset challenge a=
non fix
> > > >
> > > > Looks like the whole series is now in mainline (that was quick!) wi=
thout this
> > > > followup? As such it won't be squashed so perhaps the subject shoul=
d be more
> > > > "standalone" now, description referencing commit 34e58cac6d8f ("mm:=
 workingset:
> > > > let cache workingset challenge anon"), possibly with Fixes: tag etc=
...
> > >
> > > Yep, I'll send a stand-alone version of this. It was a bit fat to get
> > > squashed last minute anyway, and I don't mind having a bit of extra
> > > time to quantify the actual impact of this delta.
> >
> > Hello, Johannes.
> >
> > Now, a week has passed. I hope that this patch is merged as soon as pos=
sible,
> > since my WIP patchset depends on this patch. How about trying to merge
> > this patch now? If you don't mind, I could send it on your behalf.
>
> I didn't realize you directly depended on it, my apologies.

No problem.

> Do you depend on it code-wise or do you have test case that shows a
> the difference?

Code-wise. My patchset also requires activation counting for the anon
pages and conflict could occur in this case.

> Here is the latest version again, you can include it in your patch
> series until we get it merged. But I think we should be able to merge
> it as a follow-up fix into 5.8 still.

Yes. I will send it separately for 5.8. And, I will send some minor fixes, =
too.
It's appreciated if you review them.

Thanks.
