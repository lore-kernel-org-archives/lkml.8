Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9512EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768B206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7zd2Dte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCLI4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:56:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLI4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:56:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so4862659qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8QYpsneXIoe9SovMOA/4KYyhICquWAkxvuswu2VpYA=;
        b=K7zd2DteqUO5g7aR+aRrrm0Jbhe409/ADCbKZRgd72XlAkaruAry8JOi3BpK0iXmUZ
         nPP+ApreG4y7od9f5fDSO3m22keq0+lZ8PtPdqIl5nKQiyQCuzg1H7ydtPbyeaK65fD+
         RYgGsa59vfpe4V3yM6/gHuPnfdfvopWqUcCh3fnM5Q3dSuCXk8gJ+mUjlRga2Nj5Z4uO
         BZvdDTNnesOKeqz0x8c8+TwgtwjHQopQa91nt+cWzyawlRFEw/SMTaJiayknq3uQ+WSx
         SX2hiPxtpWfBGCVZnlXl+LDa/dqC6a3WJrN9GBOE48t2BCsYVD2lHC+fXQWlAuYg7BYx
         Gt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8QYpsneXIoe9SovMOA/4KYyhICquWAkxvuswu2VpYA=;
        b=sAPZINFElGoEgbwRcS8p7v+ZbapGZDR9NdilDVTSDMsrt8Wzf3rtINUTiuCJjnJLtg
         G3gCnHXuNun7eZ7KUj83dr7EZUFDQvKpAoEz+h86thdIkhMgNMmm1o12Afdjqr+AGg2v
         fJ5C2deuxUX22dzwUMQc2m+IA3EtLePk4iC3pFc8iRbwyPt/g4nEmSIQYUZdtCcH3c4C
         HGnMCF7dxNLoe3LC4duxDxj75n8NYFRperYwc78wQCdwog16Bk6VeEePusmzN2GkOv7X
         GXtddBQf1MC7HTYTAiA6EMQY4tRB31TigmdVLzeMhGPnLcaJF/wGX9mmE3pmvyS7iDm7
         d0Sw==
X-Gm-Message-State: ANhLgQ0nQluR+lv51jobiPqtE2P45kRYQMPmAo6xEezVRt9HLPRYS7FF
        /dbqNcongiUQKJTVCw+J4bmcSu3DuhrrLmKvLBE=
X-Google-Smtp-Source: ADFU+vuOtg68aR/K0fY5ljCf9+n8BXGTay/Svcnm+kjMq3CAhhBM8ymLsXxE/F3yxssT/VXlzGO6x/ZbUFU9o45QLsw=
X-Received: by 2002:a37:6388:: with SMTP id x130mr6638952qkb.429.1584003405724;
 Thu, 12 Mar 2020 01:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com> <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200312023952.GA3040@carbon.lan>
In-Reply-To: <20200312023952.GA3040@carbon.lan>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 12 Mar 2020 17:56:34 +0900
Message-ID: <CAAmzW4MMV8jgboSgHizUoH6wuuztCTJRY7AGN95869rrfH++=Q@mail.gmail.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:40, =
Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Mar 12, 2020 at 10:41:28AM +0900, Joonsoo Kim wrote:
> > Hello, Roman.
>
> Hello, Joonsoo!
>
> >
> > 2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:3=
5, Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > Posting this one for Roman so I can deal with any upstream feedba=
ck and
> > > > > create a v2 if needed, while scratching my head over the next pie=
ce of
> > > > > this puzzle :)
> > > > >
> > > > > ---8<---
> > > > >
> > > > > From: Roman Gushchin <guro@fb.com>
> > > > >
> > > > > Currently a cma area is barely used by the page allocator because
> > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > hard to make sure that the fallback path isn't used.
> > > >
> > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CM=
A corner
> > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was rever=
ted due to
> > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > >
> > > Hi Vlastimil!
> > >
> > > Thank you for this reminder! I actually looked at it and also asked J=
oonsoo in private
> > > about the state of this patch(set). As I understand, Joonsoo plans to=
 resubmit
> > > it later this year.
> > >
> > > What Rik and I are suggesting seems to be much simpler, however it's =
perfectly
> > > possible that Joonsoo's solution is preferable long-term.
> > >
> > > So if the proposed patch looks ok for now, I'd suggest to go with it =
and return
> > > to this question once we'll have a new version of ZONE_MOVABLE soluti=
on.
> >
> > Hmm... utilization is not the only matter for CMA user. The more
> > important one is
> > success guarantee of cma_alloc() and this patch would have a bad impact=
 on it.
> >
> > A few years ago, I have tested this kind of approach and found that inc=
reasing
> > utilization increases cma_alloc() failure. Reason is that the page
> > allocated with
> > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someon=
e.
> >
> > Until now, cma memory isn't used much so this problem doesn't occur eas=
ily.
> > However, with this patch, it would happen.
>
> Sure, but the whole point of cma is to be able to use the cma area
> effectively by movable pages. Otherwise we can just reserve it and
> have 100% reliability.

I agree with that cma area should be used effectively. However, cma_alloc()
failure is functional failure in embedded system so we need to approach
this problem more carefully. At least, to control the behaviour, configurab=
le
option (default is current behaviour) would be necessary.

> So I'd focus on fixing page migration issues, rather than trying
> to keep it empty most of the time.

Great! Fixing page migration issue is always good thing!

> Btw, I've fixed two issues, which dramatically increased the success
> rate of 1 GB page allocation in my case:
>
> https://patchwork.kernel.org/patch/11420997/
> https://lore.kernel.org/patchwork/patch/1202868/
>
> (They both are on the way to upstream, but not there yet)
>
> Can you, please, pull them and try?

Unfortunately, I lose my test setup for this problem so cannot try it now.
I will try it as soon as possible.

Anyway, AFAIR, I saw the problem while journal is continually working
on ext4. Have you checked this case?

Thanks.
