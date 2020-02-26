Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861BBC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC0C2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WEj7yOV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBZTk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:40:29 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:34657 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgBZTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:40:29 -0500
Received: by mail-qk1-f182.google.com with SMTP id 11so715683qkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=82BmcmIVU/khlxiiYLp8kss4jd0AD0u0A2zzeUS4+kw=;
        b=WEj7yOV9SDW39LsGpGcXtu4EXCsXQZqx+4Ofd8PWITH80J16ytU6qapFwuTqcwcLNb
         vCXFym+WS7inLUTrgz7QI0EaJuLjT7HQRP/QAblVFLjMClW5mLBLmnxaZ4m0pQ80OcOk
         vXFZ3mHk9v47818QjdvLM4zepljBKzCNfMrzZMI3CUlVfYAm3HRd6XY6n+2NaDTGI26g
         +k01NPC4NLEbl7ruddjxdoJgnGvsgArEemcZ6TUGlSGiYw/dpd6q5FRUqa/mo/NvZ/C6
         Uo/XN+iJPNnoCUwrPzn1xeDTsGfyWm2O2BGwNWyYaBVmjZp96ZEN4nEUFu2hg85iCWVS
         kSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=82BmcmIVU/khlxiiYLp8kss4jd0AD0u0A2zzeUS4+kw=;
        b=Kwseq1o/iTZs5DJy+reP8XJNNAlV79QI32RFp/WvzEGAwc6YnDas5QOuEMu7qcmhoy
         aKAlrxzCes3ZGx5uSyxFBvovqbxeSENyKe/GJ1tgGoIrSRXzWoc290/BC+bgBCx7C+jN
         JlnDpPJGkxIVTKkcuJdsvxFmWTJJhqg380zUIwxkokmJuHLJo1WArz6z6r3YZ8Lgda4Q
         hPP2Ba2zAlEjQxNEN6fMh4osklr5pCk0Rf/vEhMOWQnHqcGE++HryjTMk5Z9mn9Gwhb8
         fZ83L7C9Yy741+VQpqzREvuiUPndBXwT15AYoprqugOp6wErdW4a3xiS0MR/YtbQd3Op
         Meww==
X-Gm-Message-State: APjAAAXB7r+EpcKHJLsgZruQoaZ8uUCCL8LtzMyax9dLn3Q9D+g3T4JB
        HVbGqJ8jw1z9va6nbyexwHsGLQ7ZpUs=
X-Google-Smtp-Source: APXvYqw1Qg29Rp2e1xoil2ffgYTFbTfdMcnhwA+5u9lbxZwXh7m+OC+9QUEkTfp74CvksCMrvkukmA==
X-Received: by 2002:ae9:e8c4:: with SMTP id a187mr759785qkg.243.1582746028036;
        Wed, 26 Feb 2020 11:40:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:6048])
        by smtp.gmail.com with ESMTPSA id p92sm1628907qtd.14.2020.02.26.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:40:26 -0800 (PST)
Date:   Wed, 26 Feb 2020 14:40:25 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] mm: memcontrol: clean up and document effective
 low/min calculations
Message-ID: <20200226194025.GA30206@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-3-hannes@cmpxchg.org>
 <20200221171024.GA23476@blackbody.suse.cz>
 <20200225184014.GC10257@cmpxchg.org>
 <20200226164632.GL27066@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226164632.GL27066@blackbody.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:46:32PM +0100, Michal Koutný wrote:
> On Tue, Feb 25, 2020 at 01:40:14PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Hm, this example doesn't change with my patch because there is no
> > "floating" protection that gets distributed among the siblings.
> Maybe it had changed even earlier and the example obsoleted.
> 
> > In my testing with the above parameters, the equilibrium still comes
> > out to roughly this distribution.
> I'm attaching my test (10-times smaller) and I'm getting these results:
> 
> > /sys/fs/cgroup/test.slice/memory.current:838750208
> > /sys/fs/cgroup/test.slice/pressure.service/memory.current:616972288
> > /sys/fs/cgroup/test.slice/test-A.slice/memory.current:221782016
> > /sys/fs/cgroup/test.slice/test-A.slice/B.service/memory.current:123428864
> > /sys/fs/cgroup/test.slice/test-A.slice/C.service/memory.current:93495296
> > /sys/fs/cgroup/test.slice/test-A.slice/D.service/memory.current:4702208
> > /sys/fs/cgroup/test.slice/test-A.slice/E.service/memory.current:155648
> 
> (I'm running that on 5.6.0-rc2 + first two patches of your series.)
> 
> That's IMO closer to the my simulation (1.16:0.84)
> than the example prediction (1.3:0.6)

I think you're correct about the moving points of equilibrium. I'm
going to experiment more with your script. I had written it off as
noise from LRU rotations, reclaim concurrency etc. but your script
shows that these points do shift around as the input parameters
change. This is useful, thanks.

But AFAICS, my patches here do not change or introduce this behavior
so it's a longer-standing issue.

> > It's just to illustrate the pressure weight, not to reflect each
> > factor that can influence the equilibrium.
> But it's good to have some idea about the equilibrium when configuring
> the values. 

Agreed.

> > > > @@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys = {
> > > >   * for next usage. This part is intentionally racy, but it's ok,
> > > >   * as memory.low is a best-effort mechanism.
> > > Although it's a different issue but since this updates the docs I'm
> > > mentioning it -- we treat memory.min the same, i.e. it's subject to the
> > > same race, however, it's not meant to be best effort. I didn't look into
> > > outcomes of potential misaccounting but the comment seems to miss impact
> > > on memory.min protection.
> > 
> > Yeah I think we can delete that bit.
> Erm, which part?
> Make the racy behavior undocumented or that it applies both memory.low
> and memory.min?

I'm honestly not sure what it's trying to say. Reclaim and charging
can happen concurrently, so the protection enforcement, whether it's
min or low, has always been racy. Even OOM itself is racy.

Caching the parental value while iterating over a group of siblings
shouldn't fundamentally alter that outcome. We do enough priority
iterations and reclaim loops from the allocator that we shouldn't see
premature OOMs or apply totally incorrect balances because of that.

So IMO the statement that "this is racy, but low is best-effort
anyway, so it's okay" is misleading. I think more accurate would be to
say that reclaim is fundamentally racy, so a bit of additional noise
here doesn't matter.

Either way, I don't find this paragraph all that useful. If you think
it's informative, could you please let me know which important aspect
it communicates? Otherwise, I'm inclined to delete it.
