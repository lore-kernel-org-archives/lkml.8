Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EDB246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYW1mZna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1KVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:21:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43371 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:21:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1484075pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N6TCEHm0t+T1F6MJAG0DPrUF8K05yR9M0Jle2wO7TKU=;
        b=UYW1mZnaWynD7nepJ1HtYW4Enz/baJNzBmKlqs0DUhcTHB1Gdrinr8Tkh6yVLxkz1c
         nM8ODYkCrI1FKN2IansKH/XEFNs8EOZqvjBCArWc7Qut7UhhwUEWZNMDKF3YFqUQy6rQ
         KgVkh2xx3idcy9RW1IToS9PXbIJUhi8faQ1gGSIx0aoMtXnbelIxkxundwpcaFo3HZ14
         MxHH/bMq4btSW+o8TVnk1eYFE4yy0Yu+YP75I3vHbGtzZI6Ymy0eRS9QWaib+gHeFvf3
         Ny/ZLrFTLlbpOQZER44NCh5FqmbZfsdq//rTmHHuH/DtIFMq9HpU/5Wmxx5YD8+yHJr9
         w1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N6TCEHm0t+T1F6MJAG0DPrUF8K05yR9M0Jle2wO7TKU=;
        b=ibmVL6lUEMHSTYsLVSibghYLLtrYz+sD6xOA0mPYeCR1ao1Bs1CORlUZYsVWjIZeFq
         jfllp9c+bzyA+4NEfc1/B6KSLAaquQeg86AwyBpoDf/qsr9VsM25xoKge7ipl0lxGjjO
         DqsVU0jXP5d8dcDVCbEpossbAn/HDf/1LDJYLEpTU0Zb8BZe/EsU3pfLHi6sUKL7/+Ow
         7udfSC6MfwGMr15BmGb/9tDWxPhYY6uWk0fc01fey4sdRPMT3rHZoyYplUEuDr+DnA09
         eXWzIsxW+HtTogm6JXRjq6yY41kmwGbJfDdhdfjVtCj2poJXoM2TmuEiBIEnPJyfnAky
         xdhA==
X-Gm-Message-State: APjAAAUcseXsRKDdaiuWAU0eWLU00lXFLfaAqvpjc5FS6Mjdv7gT84+m
        aVgVSRdz0DUfHV+bRHw4dJ0=
X-Google-Smtp-Source: APXvYqz3FN8m0n1/35+yyffg8jjeLhb5fWZ4W6y5h5Mth7w881chRhjMgNvBAvfyDn3uH7yV9LJZQQ==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr3699325pfh.124.1582885313244;
        Fri, 28 Feb 2020 02:21:53 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id h3sm10552162pfo.102.2020.02.28.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:21:52 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:21:45 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228102145.GA675897@ziqianlu-desktop.localdomain>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
 <20200228040214.GA21040@js1304-desktop>
 <20200228055726.GA674737@ziqianlu-desktop.localdomain>
 <20200228065214.GA17349@js1304-desktop>
 <20200228091700.GA675567@ziqianlu-desktop.localdomain>
 <20200228095534.GA30796@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228095534.GA30796@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 06:56:11PM +0900, Joonsoo Kim wrote:
> On Fri, Feb 28, 2020 at 05:17:00PM +0800, Aaron Lu wrote:
> > I think LKP robot has captured these two metrics but the report didn't
> > show them, which means the number is about the same with or without
> > patch #1.
> 
> robot showed these two metrics. See below.
> 
>   50190319 ± 31%     -35.7%   32291856 ± 14%  proc-vmstat.pswpin
>   56429784 ± 21%     -42.6%   32386842 ± 14%  proc-vmstat.pswpout
> 
> pswpin/out are improved.

Oh yes, I checked the vmstat part, while I should check proc-vmstat
part...Sorry for missing this.

> 
> > > with patch #1. With large inactive list, we can easily find the
> > > frequently referenced page and it would result in less swap in/out.
> > 
> > But with small inactive list, the pages that would be on inactive list
> > will stay on active list? I think the larger inactive list is mainly
> > used to give the anon page a chance to be promoted to active list now
> > that anon pages land on inactive list first, but on reclaim, I don't see
> > how a larger inactive list can cause fewer swap outs.
> 
> Point is that larger inactive LRU helps to find hot pages and these
> hot pages leads to more cache hits.
> 
> When a cache hit happens, no swap outs happens. But, if a cache miss
> happens, a new page is added to the LRU and then it causes the reclaim
> and swap out.

OK, I think I start to get your point. Your explanation makes sense.

> > Forgive me for my curiosity and feel free to ignore my question as I
> > don't want to waste your time on this. Your patchset looks a worthwhile
> > thing to do, it's just the robot's report on patch1 seems er...
> 
> I appreciate your attention. Feel free to ask. :)

Thanks a lot for your patience and nice explanation :-)
