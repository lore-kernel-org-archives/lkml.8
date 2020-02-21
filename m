Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E081C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720DF20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272468;
	bh=vMDkeuMrKjIwXw4QVoXIC4iBfAfkAdXVDJZR1nep80I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pTC+vluGyJ6vAs3fy5L00vJ/yrk9VRcg4PfCHhQg1kjocXCV/L9e8rzJityyYXd8+
	 Y9m256ksnIFq5cOf+oK1Do2n6uyj0rw4Gi85CTLnQR9qEbhvPambFGtXwXo7Z1Z3Lq
	 V+Jitw6cOnmqhbWhJBu4MsemVuNqrSo/qx2YjZa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgBUIHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:07:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35691 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbgBUIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:07:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so680749wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cysc8WybqA+6iLQKtzIKvfkV0Kx+q50i1DwFjUaNCxc=;
        b=nbfaoweRNh1hxlMuEDm5wsHt/d9Uhf7h6iHujRQaWwVJKQmJVB2cV5tWzjRn6eGD31
         BUv0fjwpLHhVfEPr6IMJOtYkqzDsM0yiirmGx/Y1SqJiN9iJxQORtq2hJoMKE32xg3Dz
         phdZPqFZyXAa++m7t3jVHsm1bqIIZ2mkTf/XsbzbiGgVF0gHYeI6Vuvhn7fIqh6PdI4u
         IpC9Wsnypxr5sJcFlMnk98v5TKOifgRfAGqzleTst8dJZSdYlLAMK2EptBex5S5D2Y3D
         ae4UTL9ELF2hTKftRZxfB5mYxtNr+PhJ6mvnjKFj40TuX33BaxevuteIWBUPssZ/m7Ky
         fsaA==
X-Gm-Message-State: APjAAAUeZtNYw0qBIWDwoca7sbcOdfcjMhJAHtk9emGIvBAA9DTyQUM+
        dz8ZsmFdxfRaqrDjtPCIaXbBwKV9
X-Google-Smtp-Source: APXvYqwDheYHMjqMHpWAL4r/JI0cxbLpWleWXIKtFRaZ75cj+tI343oEviInrqQycuCkp9x0yMXKfw==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr2217812wmd.91.1582272459539;
        Fri, 21 Feb 2020 00:07:39 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g17sm3121780wru.13.2020.02.21.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 00:07:38 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:07:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Mel Gorman <mgorman@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200221080737.GK20509@dhcp22.suse.cz>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221042232.GA2197@sultan-book.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-02-20 20:22:32, Sultan Alsawaf wrote:
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

Could you provide regular (e.g. each second) snapshots of /proc/vmstat,
ideally started before and finished after the observed behavior?
Something like
while true
do
	cp /proc/vmstat vmstat.$(date +%s)
done

If you can perf record and see where the kernel spends time during that
time period then it would be really helpful as well.

> Then I tried again with my patch applied (albeit a correct version that doesn't
> use the refcount API). Upon starting the same YouTube video in chromium, my
> laptop didn't freeze or stutter at all. The cursor was responsive and there was
> no stuttering, or choppy audio.
> 
> I tested this multiple times with reproducible results each time.

Your patch might be simply papering over a real problem.

> I will attach a functional v2 of the patch that I used.
> 
> Sultan

-- 
Michal Hocko
SUSE Labs
