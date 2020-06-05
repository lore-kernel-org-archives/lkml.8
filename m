Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA010C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A290206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMZ2Cwe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFEHGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:06:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB32DC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:06:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a25so10429394ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tirMeNPjo7L/TwblFao2toFDMh4oaclxGT8/aioAtp8=;
        b=wMZ2Cwe/5y7UwH9LOZ+fb+pGlOW4VqAD6+b+HnYqMW0Nirj0OjrP1d5yPUGoW3axGv
         GKBgfnd1laJGbbHMmfBFFiKXTf2VGu6p4NcXV9YLHJo70v4JrWVfSx9/YMPRLZ5oY/wr
         zZ7wlkACF7EpbPwPmKA+UCtdsJMLFw/GuGF64xLt5cebaCQYmnO+js/f9vrKRwg+zfiz
         sSf0+zy8R7XrgdphDW2nEVxtuGf2nmFDbiUZYrLhNZySyBO5k1sYk03mNIHgOehAJiuD
         DG4JU0FH57k4soZiqWN5j6aPIuRbx9DIQcQvIH26faxSoGOJ+OsZ6G7CCKUK1mHMiKZA
         t78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tirMeNPjo7L/TwblFao2toFDMh4oaclxGT8/aioAtp8=;
        b=gcPqCYd8fCHD3M1xZ/daN0+MVV+F9CqAvvU3sODFbafypo0QTg8e6dFkZZOWJGTpiO
         8ROQQNrb0v/E5tqtzgSqxEelrVW5KyFOmLD9/yD6I0yR21k32J/Lw7O0SGPESP2Xtf3k
         qMcxUO0Pxvza6wv4kBREfU2ombraukg7JElezTlmINUkc8cogNYutXval9Q2CWlqPnWz
         GJIdkame6hygFFbI49hGCFnBMIKOOIaJzoeHLYG8/NUvqLTMrftXIvRf6WbBjXDKtg+I
         UloQUkt5/ev5Zdv3/Y6JMHjk4ovuohH3998hxo8/mSPf9vXLvKxE45A2G7YTn7rD7ngF
         ueEw==
X-Gm-Message-State: AOAM533bHTxslV1Fsnc3++EPuRLRSTHr+ReOcLnsb1maG8VWvYSZOJy4
        6P4pEUmlX6F9+TaNmZp5WDva2Oq9977EAp6xCvdtMw==
X-Google-Smtp-Source: ABdhPJy0Mi2fTbzup2ooNf36hRJABK9wQ4XbtXPe83cDm/uWc02tgulvjQt2I2dpFMLFBbikxePM/AiOvSuTZZ9MdOU=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr4101058ljp.177.1591340782481;
 Fri, 05 Jun 2020 00:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141526.GA30976@xsang-OptiPlex-9020> <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020> <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
 <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
 <20200602052319.GA24856@xsang-OptiPlex-9020> <20200602142305.GA31901@xsang-OptiPlex-9020>
 <CAKfTPtBLKUBF_p-LxfRce2nJQFqGj95KZ+yisAN_qrMq5VxW=w@mail.gmail.com> <20200604085656.GI3070@suse.de>
In-Reply-To: <20200604085656.GI3070@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Jun 2020 09:06:11 +0200
Message-ID: <CAKfTPtApE09vGpEt=jTJk2yY9Lmy5tjNsRUNdqpRJV0_SvgZvg@mail.gmail.com>
Subject: Re: [sched/fair] 0b0695f2b3: phoronix-test-suite.compress-gzip.0.seconds
 19.8% regression
To:     Mel Gorman <mgorman@suse.de>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Si, Beibei" <beibei.si@intel.com>,
        "Du, Julie" <julie.du@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, Rui Zhang <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 10:57, Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, Jun 03, 2020 at 07:06:18PM +0200, Vincent Guittot wrote:
> > > still exists, just the gap becomes smaller -
> > > release         run1    run2
> > > v5.4            4.32    4.3     <-- little change comparing to above
> > > v5.5            5.04    5.06    <-- improves
> > > v5.7-rc7        4.79    4.78
> > > v5.7            4.77    4.77
> > >
> > > I also attached turbostat data as attached.
> >
> > Thanks for the test results and the turbo stats figures.
> > The outcomes are not as obvious as I would have expected. The
> > performance difference for v5.5 and v5.7 when C6 and above are
> > disabled tends to confirm that the idle state is impacting the
> > performance but the difference still remain.
> > Regarding turbostat output, the 1st main difference is the number of
> > time the CPUs entered idle state:
> > v5.4 run1 : 587252+905317+367732+859828+108+332436+110+217=3053000
> > v5.7 run1 : 807623+639635+466723+1298557+108+283548+63+156=3496413
> > which is +14% of entering idle.
> > This is even more obvious on v5.5 run1:
> > 761950+1320362+1681750+682042+91+304755+79+243=4751272 which is +55%
> > of entering idle
> >
> > We have a similar ratio without c6 and above c-state between v5.4 and
> > v5.7 and the ratio has decreased to +22% between v5.4 and v5.5.
> >
> > So this tends to confirm my assumption that tasks are more spread and
> > this generates more enter/leave cpuidle. I still need to think about
> > how to balance this
> >
>
> I have not looked into the data in depth but it's worth noting that
> cpuidle changed the time a CPU spent polling before entering a C state
> within the same window.  See 36fcb4292473 ("cpuidle: use first valid target
> residency as poll time") as an example where poll time went from hundreds
> of nanoseconds to single digits depending on the machine. We used to poll
> for up to a tick before entering idle. I'm not saying whether it's good
> or bad but it certainly can have a big impact on how often a CPU enters
> "true idle in a C state" as opposed to switching to the idle task (swapper)
> for some house keeping.

Thanks. I will have a look

>
> Where things get fun is that the scheduler can make this more or less
> obvious depending on its decisions. If tasks are bouncing like crazy around
> a socket, the load balancer is shifting tasks like crazy or the scheduler
> is stacking tasks when it should not then it can potentially perform
> better in a benchmark if it prevents tasks entering a deep idle state.

That's also my idea for the difference in performance

Thanks
>
> --
> Mel Gorman
> SUSE Labs
