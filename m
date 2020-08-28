Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E2DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDF820825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3It3OAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgH1GsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1GsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:48:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD604C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:48:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so74991ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oydfEDC6u3iLPJyfxYWLejhiNpsHmSRRREzeNSIlIRg=;
        b=C3It3OAMIxBXfjvtUb92LHDBEbsc8n58DTyxKK9cDKU4Ye4zVK5uS/JCPFRogMVJHX
         o//Kwj5VcD6LPAzrUumD3SiTTfifFbbv/fKOC6A8VbktoBVdxwXroyokYvzPJ4Bri+fT
         JHgeX8pk5ruqmApjgkqBuX5vGnhKWLzHq+oqAakhK08W6rHs4f8RXtHzJZ6exzENkJE6
         0UcvJrQYM1w0y2gs2i9/7asXNxCjwwc6jLGFRjvV9CMiMZz0q8XN4++Y9/1fYSs+KGe/
         TGPkGsas5qil/QezclbRSTBYphwu23e+x4KxLcldPEZNcG6omF3ucX9JNe68U2eXn4ky
         SA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oydfEDC6u3iLPJyfxYWLejhiNpsHmSRRREzeNSIlIRg=;
        b=G4ryJZGI+s93KafofUTlvRk7izU85o/TdY6vIyWwhuRZd+MuCW96emPD+ngdCgpIgM
         v3tgbj6qo8fSsX7pt7Y9+7Yen8vlQIv3z51DOqAfpLi/XxfiRGCyVCPqrRqfAhHCwe9s
         sdXwAQOF5rkm1gfLqOq66zodmMyppcsbqGqEImWbFwnful7XK5W1J8eNRnpdlqipq77J
         SmKHCIOXHumjbK04fIREB2ZztItnr4Tz3b0TViNCC1Y50th/nr+DOcH1nkbM/Vr9Kqv5
         wfTjVlUA3vItTu1MrTapjZdCS06MPNUyecV+H6d9/wItqhoPyxpmeTq/xw3jAz4YMm8L
         yXjA==
X-Gm-Message-State: AOAM531joO/zvHVeCXK/z8vxEZD5COg23d6Eoi650PMYeqZnLVCAboVi
        aie3Lr65mtq5V2j2aRSdh9WGIgDOCSVNbPgDdFrmLZdKEG8=
X-Google-Smtp-Source: ABdhPJz9D0alYTdnFqLYQJf4VVhnGovaO4fFvjApYM8uFElaR82ulVJpdJ9fv+pCi/o85KyTPHk4MX7Y261OxNOKT/0=
X-Received: by 2002:a2e:9812:: with SMTP id a18mr194440ljj.25.1598597283126;
 Thu, 27 Aug 2020 23:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825121818.30260-1-vincent.guittot@linaro.org>
 <20200827153534.GF3033@suse.de> <CAKfTPtCRmts+qH+hexKbhZ7595zGs1U3Q5V4-XzHgpU0dJd+1Q@mail.gmail.com>
 <20200827182221.GG3033@suse.de>
In-Reply-To: <20200827182221.GG3033@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Aug 2020 08:47:51 +0200
Message-ID: <CAKfTPtD1oV5t7p6dVkQpYZNXqgwXS-SNZ-=Mv-qEfbFVmkOc3Q@mail.gmail.com>
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 20:22, Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Aug 27, 2020 at 05:43:11PM +0200, Vincent Guittot wrote:
> > > The testing was a mixed bag of wins and losses but wins more than it
> > > loses. Biggest loss was a 9.04% regression on nas-SP using openmp for
> > > parallelisation on Zen1. Biggest win was around 8% gain running
> > > specjbb2005 on Zen2 (with some major gains of up to 55% for some thread
> > > counts). Most workloads were stable across multiple Intel and AMD
> > > machines.
> > >
> > > There were some oddities in changes in NUMA scanning rate but that is
> > > likely a side-effect because the locality over time for the same loads
> > > did not look obviously worse. There was no negative result I could point
> > > at that was not offset by a positive result elsewhere. Given it's not
> > > a univeral win or loss, matching numa and lb balancing as closely as
> > > possible is best so
> > >
> > > Reviewed-by: Mel Gorman <mgorman@suse.de>
> >
> > Thanks.
> >
> > I will try to reproduce the nas-SP test on my setup to see what is going one
> >
>
> You can try but you might be chasing ghosts. Please note that this nas-SP
> observation was only on zen1 and only for C-class and OMP. The other
> machines tested for the same class and OMP were fine (including zen2). Even
> D-class on the same machine with OMP was fine as was MPI in both cases. The
> bad result indicated that NUMA scanning and faulting was higher but that
> is more likely to be a problem with NUMA balancing than your patch.
>
> In the five iterations, two iterations showed a large spike in scan rate
> towards the end of an iteration but not the other three. The scan rate
> was also not consistently high so there is a degree of luck involved with
> SP specifically and there is not a consistently penalty as a result of
> your patch.
>
> The only thing to be aware of is that this patch might show up in
> bisections once it's merged for both performance gains and losses.

Thanks for the detailed explanation. I will save my time and continue
on the fairness problem in this case.

Vincent

>
> --
> Mel Gorman
> SUSE Labs
