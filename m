Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AFC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DA8208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGAuB3hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgCKH15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:27:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42005 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKH14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:27:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so833908qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pc5Mex9AXuwKMivPB0YyFAGUk6142KI+to63osSlbss=;
        b=eGAuB3hcNFclDpWz208wpYv2cT7ROTyL84UMBISbVQ/QAcsOFMLoNvZqI3NGZIgS+O
         qOrWSnIVkqKCwGUmn7XodtfoDG0lykRQQY10GHT9KHQFd6X0nWPpgOw287B2CILvlt0f
         KBeB2fcS7ZLy8MLvk5vWy7uCek6ROWhmZVcTApk6A72+jpqQLYLDhxlFs6YVEfSk9jEl
         0++GuYV3d1Gw8WU6xhB5mHjiaWwBi2/9c8aKPBG0+jezbqINWFrVKkEa37u6C+QpuMdc
         PQ9BstwvcDSsD8Bb+MNYw8joMEsDPkWm1gR83hqvXO5JWp4io8eVOw4PC9BEeUr0Xh6f
         CbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pc5Mex9AXuwKMivPB0YyFAGUk6142KI+to63osSlbss=;
        b=OEQX0LIzIQsE9u/b547R1FkIXvs+arhckviCMCYkOvl4f4MrOZ5ozqwOKPDyw3Wun9
         2RKxp6RWeFJKTdnD7qASCuNxoqkYd4DfFeJdbaYGunQEDyUX1cbtB+duIwj3Oi+oWmV4
         KXYxwmvw0HU8HleZLNpT6ndXnSfD5fdyiZzTmbIBjr3eW9vFpBu77lHqL6U89I0OrMIN
         faVMdGRJaa5yo0ehG4G6Cut65mNIP/6uVXelRJEpcr7pQYNKugM60RkFNk+Svjo4D5FI
         Fn6OFWIINpn3gQcbFneEugu1knoj4m08oQbyNC8zgPryLX8d6H7eIkIijVIwZarIWoyP
         gV3g==
X-Gm-Message-State: ANhLgQ39/bYfYfB/GUgGs8g8w00UC9cbh0nHB1qCPqlShNTjwdWJ49p0
        F2t1rVxZ9KW354FghPm0/5a24JAsO3eTBT4Zj9yVhqzf7UM=
X-Google-Smtp-Source: ADFU+vsWDWVbIaf2kP232v4inTgsCNKdyKnggSQsjRlDfqtJmfCtGuo/lWsY9qjj5ub6nNwjIc6MGo5EzJIlTRCWrvo=
X-Received: by 2002:ac8:2648:: with SMTP id v8mr1436779qtv.65.1583911675112;
 Wed, 11 Mar 2020 00:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org> <20200227153639.951d6a42080e8d4227872e64@linux-foundation.org>
 <CAAmzW4MCi9xqMCvFVRT6=SUjJgzprOoFhZe4BdXa7wH6jPYqBg@mail.gmail.com>
In-Reply-To: <CAAmzW4MCi9xqMCvFVRT6=SUjJgzprOoFhZe4BdXa7wH6jPYqBg@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 11 Mar 2020 16:27:44 +0900
Message-ID: <CAAmzW4PO1QeSpP=5S9AwVMc4NMnzkcB=2TgB3FSrttOVRWBxKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

2020=EB=85=84 3=EC=9B=94 3=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:31, Jo=
onsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2020=EB=85=84 2=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:36,=
 Andrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >
> > On Thu, 27 Feb 2020 08:48:06 -0500 Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
> >
> > > > It sounds like the above simple aging changes provide most of the
> > > > improvement, and that the workingset changes are less beneficial an=
d a
> > > > bit more risky/speculative?
> > > >
> > > > If so, would it be best for us to concentrate on the aging changes
> > > > first, let that settle in and spread out and then turn attention to=
 the
> > > > workingset changes?
> > >
> > > Those two patches work well for some workloads (like the benchmark),
> > > but not for others. The full patchset makes sure both types work well=
.
> > >
> > > Specifically, the existing aging strategy for anon assumes that most
> > > anon pages allocated are hot. That's why they all start active and we
> > > then do second-chance with the small inactive LRU to filter out the
> > > few cold ones to swap out. This is true for many common workloads.
> > >
> > > The benchmark creates a larger-than-memory set of anon pages with a
> > > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > > first two patches allow the VM to usher those pages in and out of
> > > memory very quickly, which explains the throughput boost. But it come=
s
> > > at the cost of reducing space available to hot anon pages, which will
> > > regress others.
> > >
> > > Joonsoo's full patchset makes the VM support both types of workloads
> > > well: by putting everything on the inactive list first, one-off pages
> > > can move through the system without disturbing the hot pages. And by
> > > supplementing the inactive list with non-resident information, he can
> > > keep it tiny without the risk of one-off pages drowning out new hot
> > > pages. He can retain today's level of active page protection and
> > > detection, while allowing one-off pages to move through quickly.
> >
> > Helpful, thanks.
> >
> > At v2 with no evident review input I'd normally take a pass at this
> > stage.  But given all the potential benefits, perhaps I should be more
> > aggressive here?
>
> I hope so. It would boost the review. :)

Hello, Andrew.

Would you like to tell me your plan about this patchset?
Merging it into the next tree would accelerate the review and test. :)

Thanks.
