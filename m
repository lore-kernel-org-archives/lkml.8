Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110AC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71633206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlVZF7Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCMHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:44:47 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:43419 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:44:46 -0400
Received: by mail-qk1-f178.google.com with SMTP id x1so6122977qkx.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1df1m1827GQiqElNsAyvaQKKiylcqSVzC+9hFD0GyD4=;
        b=MlVZF7VkFpIJTLvxRqbE5fdiul9OK220z5YhUZE8BZsYDWwRVeuLR2GjGEKaw6RoDV
         N88OOaAqAh7dwNaK68AN3iwFu+5UP6y/dMKyib6KQbb+y2CL6qAPqm9a65ptPoA2eWC8
         ZAuSGLj2aiKI5NYoGZVApD2NiNUKypk8ZyxrzhEXblOf5Y0o4FlPo2fahcRz9TSMeAiP
         3YyXMLdIzHY4B1RhaxPW23txg/HlVkbUGJzGRUn+tizKupaFaPSfFYVx/VGPYAHhVRdZ
         eIVx/yD7MnFF2GIQJvarxExA7uAZtQjRSnpARYNvWoLakm7f0qk62Jdf+whguoT5+MGE
         iVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1df1m1827GQiqElNsAyvaQKKiylcqSVzC+9hFD0GyD4=;
        b=O66W+7r8Xliu8H8aYQHLQ4GxftH21gXRgyx97KxQZ8/mO+oJ36jcXhQ/spW3aQERS0
         7ZwQzeX+VGaHVo4V0Wbs/0B73sDUafhUZchNFcNNgCCuLVn8eLMqHpq8P54Uxuzp3YKD
         YW9pq4niuhHNulGAfEoiw1LRsp9yDlRS125LzS7or0R9X8OyZihOMEKZtzbfpDE7zmfg
         h2qsUb4nwyKQqF0EEcPmX1kxT4loV89exbRrfsqgeXep/kmScYYYfoPcw76DewGMKz0k
         JpmrJArfENZP3K70YROaL/f7VrXgeWHP5R3ifJcpDzDHwq7/tCUaOqL6Nqcm0UEzrL2E
         SDHg==
X-Gm-Message-State: ANhLgQ3Qpy2aW37oapfdBGX1CrqrHp3S9zhuvAt/XqGwHcgzKljFbiSK
        On3yDSKQnC+MRsnFeMt/bgylvsY95rpBLBKYDlc=
X-Google-Smtp-Source: ADFU+vv8C/PGXBxZ/xpAbC/9cEaLanqnSSkryxQJql/CZJBv8MEy3DuvPiN8p4ofYCkm45HCAjgiIz06arEwQ0IUsrk=
X-Received: by 2002:a37:2c47:: with SMTP id s68mr12032800qkh.452.1584085485770;
 Fri, 13 Mar 2020 00:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com> <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200312023952.GA3040@carbon.lan> <CAAmzW4MMV8jgboSgHizUoH6wuuztCTJRY7AGN95869rrfH++=Q@mail.gmail.com>
 <20200312170715.GA5764@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200312170715.GA5764@carbon.DHCP.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 13 Mar 2020 16:44:34 +0900
Message-ID: <CAAmzW4Pfd72ZPZ_98zue5LAVhb+6s1oAHCTwWTmwMsUK_pbSVQ@mail.gmail.com>
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

2020=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:07, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Mar 12, 2020 at 05:56:34PM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:=
40, Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Thu, Mar 12, 2020 at 10:41:28AM +0900, Joonsoo Kim wrote:
> > > > Hello, Roman.
> > >
> > > Hello, Joonsoo!
> > >
> > > >
> > > > 2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84=
 2:35, Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > > >
> > > > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > > > Posting this one for Roman so I can deal with any upstream fe=
edback and
> > > > > > > create a v2 if needed, while scratching my head over the next=
 piece of
> > > > > > > this puzzle :)
> > > > > > >
> > > > > > > ---8<---
> > > > > > >
> > > > > > > From: Roman Gushchin <guro@fb.com>
> > > > > > >
> > > > > > > Currently a cma area is barely used by the page allocator bec=
ause
> > > > > > > it's used only as a fallback from movable, however kswapd tri=
es
> > > > > > > hard to make sure that the fallback path isn't used.
> > > > > >
> > > > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRAT=
E_CMA corner
> > > > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was r=
everted due to
> > > > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > > > >
> > > > > Hi Vlastimil!
> > > > >
> > > > > Thank you for this reminder! I actually looked at it and also ask=
ed Joonsoo in private
> > > > > about the state of this patch(set). As I understand, Joonsoo plan=
s to resubmit
> > > > > it later this year.
> > > > >
> > > > > What Rik and I are suggesting seems to be much simpler, however i=
t's perfectly
> > > > > possible that Joonsoo's solution is preferable long-term.
> > > > >
> > > > > So if the proposed patch looks ok for now, I'd suggest to go with=
 it and return
> > > > > to this question once we'll have a new version of ZONE_MOVABLE so=
lution.
> > > >
> > > > Hmm... utilization is not the only matter for CMA user. The more
> > > > important one is
> > > > success guarantee of cma_alloc() and this patch would have a bad im=
pact on it.
> > > >
> > > > A few years ago, I have tested this kind of approach and found that=
 increasing
> > > > utilization increases cma_alloc() failure. Reason is that the page
> > > > allocated with
> > > > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by so=
meone.
> > > >
> > > > Until now, cma memory isn't used much so this problem doesn't occur=
 easily.
> > > > However, with this patch, it would happen.
> > >
> > > Sure, but the whole point of cma is to be able to use the cma area
> > > effectively by movable pages. Otherwise we can just reserve it and
> > > have 100% reliability.
> >
> > I agree with that cma area should be used effectively. However, cma_all=
oc()
> > failure is functional failure in embedded system so we need to approach
> > this problem more carefully. At least, to control the behaviour, config=
urable
> > option (default is current behaviour) would be necessary.
>
> Do we know who can test it? Adding a configuration option is a last resor=
t
> measure, I really hope we can avoid it.

I don't know. Agreed that configuration option is a last resort.

> >
> > > So I'd focus on fixing page migration issues, rather than trying
> > > to keep it empty most of the time.
> >
> > Great! Fixing page migration issue is always good thing!
> >
> > > Btw, I've fixed two issues, which dramatically increased the success
> > > rate of 1 GB page allocation in my case:
> > >
> > > https://patchwork.kernel.org/patch/11420997/
> > > https://lore.kernel.org/patchwork/patch/1202868/
> > >
> > > (They both are on the way to upstream, but not there yet)
> > >
> > > Can you, please, pull them and try?
> >
> > Unfortunately, I lose my test setup for this problem so cannot try it n=
ow.
> > I will try it as soon as possible.
>
> Thanks! Looking forward to it...
>
> >
> > Anyway, AFAIR, I saw the problem while journal is continually working
> > on ext4. Have you checked this case?
>
> My ext4 fix sounds very similar to what you're describing, but it's hard =
to
> say for sure.

Okay, I will test it.

Thanks.
