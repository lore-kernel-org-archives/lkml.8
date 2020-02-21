Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CEFC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07CE24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFFQKkRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgBUSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:04:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36663 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:04:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so2458299oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZEsDlM59Sj/RHwGNdew8SDtWtfbg/Uljhkjj++yjlw=;
        b=eFFQKkRW6laZCJHyLGg6Zo/2IoFvqvNVm+8KXB4uMV5RjmShgagGZNNPwO9C/pKrip
         xW8nbsjmSU6ysyqsdm2vFoRbyR4ncl2PXC5xOLTUSUxWZs5f4QV0/iQP1UVsRTxij2mV
         4X31O+iLn1g35sQuw7yGB1yhoq6XUgD7daK4X9BVO1TNUK58lBIiX9D5DfAm5DW0nBvt
         uQgr4uu0BqWfgWWvdDPMehSWqVbYbZyyV5tqJH04ZyGAbOTAd3Dh7SSXTlXKMIpV6WPL
         UxndENg477sLacS0fQBvL/K6qG34V+GnF/PnGFBsFFRGDuWT0gjU13+kzOKgwEScLp31
         34Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZEsDlM59Sj/RHwGNdew8SDtWtfbg/Uljhkjj++yjlw=;
        b=gDVL7cWNYT1Sqcnu2W3DuD4YHnA+4IMnpAPY/Xpc69p2cm41txeoyTXlQzUPb8yZsg
         fH0PxypPuL06sMzEiLQ3m+yaTf1Ak2KykDmrjJvRsqPSVOUtoNN6rtZDC9vAUn4mZ0+p
         NOgQxUpB5lmaT5ygXqL4lkevZCfgTrQim6OxFMtZ5WHhEfhwvdaj1MdJFkF3F9mlQaO1
         +GOY02NWDjHF3XnrxC3NKeQNjnT6L2HhhzhGcckC0YhBlrRC7ZgOboRt16q2T1Hedn/t
         edVkBvweEHtUbGJJAxoOTWcc0vhBs0jxpbGuIolaAzMmSFSJFUxf0IP2eS80fQvuwP49
         jnuA==
X-Gm-Message-State: APjAAAXQu175v5dGCRN3ZVNudC/xSnmgHpt1m2wkFHDqiwqjoN+nD1i7
        vmVzJLvwcbNdTOh8ZKFnKBTk8Ot7ylyirkGvcvH+VQ==
X-Google-Smtp-Source: APXvYqwPr82SHGOD6tIwYJQnM1F9QDK/UIOknhnS75kqQdXkjgSccTvhdsLR47dSe0OCSSE+49+0eGtfQHP6YCIphKU=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr2894335oie.144.1582308289790;
 Fri, 21 Feb 2020 10:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20200219182522.1960-1-sultan@kerneltoast.com> <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain> <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain> <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain> <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
In-Reply-To: <20200221042232.GA2197@sultan-book.localdomain>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Feb 2020 10:04:38 -0800
Message-ID: <CALvZod5zJo186v=-QHGRvap67axexp6oL8=qXEjq670F2yAdSA@mail.gmail.com>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 8:22 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Thu, Feb 20, 2020 at 10:19:45AM +0000, Mel Gorman wrote:
> > I'm not entirely convinced. The reason the high watermark exists is to have
> > kswapd work long enough to make progress without a process having to direct
> > reclaim. The most straight-forward example would be a streaming reader of
> > a large file. It'll keep pushing the zone towards the low watermark and
> > kswapd has to keep ahead of the reader. If we cut kswapd off too quickly,
> > the min watermark is hit and stalls occur. While kswapd could stop at the
> > min watermark, it leaves a very short window for kswapd to make enough
> > progress before the min watermark is hit.
> >
> > At minimum, any change in this area would need to include the /proc/vmstats
> > on allocstat and pg*direct* to ensure that direct reclaim stalls are
> > not worse.
> >
> > I'm not a fan of the patch in question because kswapd can be woken between
> > the low and min watermark without stalling but we really do expect kswapd
> > to make progress and continue to make progress to avoid future stalls. The
> > changelog had no information on the before/after impact of the patch and
> > this is an area where intuition can disagree with real behaviour.
> >
> > --
> > Mel Gorman
> > SUSE Labs
>
> Okay, then let's test real behavior.
>
> I fired up my i5-8265U laptop with vanilla linux-next and passed mem=2G on the
> command line. After boot up, I opened up chromium and played a video on YouTube.
> Immediately after the video started, my laptop completely froze for a few
> seconds; then, a few seconds later, my cursor began to respond again, but moving
> it around was very laggy. The audio from the video playing was choppy during
> this time. About 15-20 seconds after I had started the YouTube video, my system
> finally stopped lagging.
>
> Then I tried again with my patch applied (albeit a correct version that doesn't
> use the refcount API). Upon starting the same YouTube video in chromium, my
> laptop didn't freeze or stutter at all. The cursor was responsive and there was
> no stuttering, or choppy audio.
>
> I tested this multiple times with reproducible results each time.
>
> I will attach a functional v2 of the patch that I used.
>

Can you also attach the /proc/zoneinfo? Maybe the watermarks are too high.
