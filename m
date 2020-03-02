Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C250C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB6324681
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghUc23XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCBXbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:31:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40520 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:31:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id m2so1611114qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LfEjI0hAoE9B82/6Z0q5Bb5fihjTPDQQQvYu1xjHN2c=;
        b=ghUc23XKmujuq8C48Jy+mQxsTdVzke3AlaPts945PKwU9Xf5sR/OrN/cEg1QWIcbmH
         W/zNMBCVkqpSVXx8w5LNG/JObdnKDRu+k/qywKyrpzJhWCIjcG1ISNYRhC4rzhdrvYEk
         zp4pXSniwCBO+7zaMpjNUM570397o7P9sKuskpt7qNg32Ap7/D6jMXGqaVQg401PyoAX
         gcLx6Q20Y9B+d0bRmD6UhlhggGbtWZkPjYd+xMNCe85hPUmiWgyQ01I6sFxoTc/+RaBQ
         1NOwdu5z5VSrpJLJTIsPxpSapMqFARCRoW0PrrMcm7bEQwwgbjEoS3sGapjtsBamHGIJ
         Z0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LfEjI0hAoE9B82/6Z0q5Bb5fihjTPDQQQvYu1xjHN2c=;
        b=MxVbXoU7Wev/G6ahpy/2c2Qnp7fFotHkWm7ZoKTJEMuxYvpBxan0cKsqkVTCpylebE
         pataf2gloFhGFaE8I/r/PHfv0d+0piNxNrQbPoZzaU7AkmLl7CA+QT7SEMy54CoU9Q3H
         9dDSnYFXq862ZU1e7bSsdvuFTmom/MxrMZ95eT1u2Q++YMNsOh+OUMJsGeMHwmjC1Gl9
         0Iys3XBnIYPtlICmrk9KhQwnladtwq07yD0HLfT/JY9SfbWgJIXrLBgf1siY8aAGNoJn
         f49+S6DcfV8VOtoFFjQeXM27HbHvrhjWN2MiqB0u2V+AKETAn0qi4b3nucfGsf34y3DM
         4FNQ==
X-Gm-Message-State: ANhLgQ0n1YPHh2mx71yKaIz+O54DJgkbfIt8vVYSzuArHHp3VLxK6QmH
        bZEr0Vb9OCxHhua1FIOtEpRIeLUPl/zAkRRhHiw=
X-Google-Smtp-Source: ADFU+vugI1LhoilnSjySYvq7x6RcSLviSCgVaTa0JbdIchRxtWljlKbE9obvNPBVrrkDQmIUsm99VDq8FO5tg4icRj4=
X-Received: by 2002:a37:aa88:: with SMTP id t130mr1660455qke.452.1583191896818;
 Mon, 02 Mar 2020 15:31:36 -0800 (PST)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org> <20200227153639.951d6a42080e8d4227872e64@linux-foundation.org>
In-Reply-To: <20200227153639.951d6a42080e8d4227872e64@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 3 Mar 2020 08:31:25 +0900
Message-ID: <CAAmzW4MCi9xqMCvFVRT6=SUjJgzprOoFhZe4BdXa7wH6jPYqBg@mail.gmail.com>
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

2020=EB=85=84 2=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:36, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Thu, 27 Feb 2020 08:48:06 -0500 Johannes Weiner <hannes@cmpxchg.org> w=
rote:
>
> > > It sounds like the above simple aging changes provide most of the
> > > improvement, and that the workingset changes are less beneficial and =
a
> > > bit more risky/speculative?
> > >
> > > If so, would it be best for us to concentrate on the aging changes
> > > first, let that settle in and spread out and then turn attention to t=
he
> > > workingset changes?
> >
> > Those two patches work well for some workloads (like the benchmark),
> > but not for others. The full patchset makes sure both types work well.
> >
> > Specifically, the existing aging strategy for anon assumes that most
> > anon pages allocated are hot. That's why they all start active and we
> > then do second-chance with the small inactive LRU to filter out the
> > few cold ones to swap out. This is true for many common workloads.
> >
> > The benchmark creates a larger-than-memory set of anon pages with a
> > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> > first two patches allow the VM to usher those pages in and out of
> > memory very quickly, which explains the throughput boost. But it comes
> > at the cost of reducing space available to hot anon pages, which will
> > regress others.
> >
> > Joonsoo's full patchset makes the VM support both types of workloads
> > well: by putting everything on the inactive list first, one-off pages
> > can move through the system without disturbing the hot pages. And by
> > supplementing the inactive list with non-resident information, he can
> > keep it tiny without the risk of one-off pages drowning out new hot
> > pages. He can retain today's level of active page protection and
> > detection, while allowing one-off pages to move through quickly.
>
> Helpful, thanks.
>
> At v2 with no evident review input I'd normally take a pass at this
> stage.  But given all the potential benefits, perhaps I should be more
> aggressive here?

I hope so. It would boost the review. :)

Thanks.
