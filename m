Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9602C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA0E2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGNLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:11:43 -0400
Received: from foss.arm.com ([217.140.110.172]:48670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:11:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6C20C0A;
        Tue,  7 Jul 2020 06:11:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068DC3F71E;
        Tue,  7 Jul 2020 06:11:40 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:11:38 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] sched: Optionally skip uclamp logic in fast path
Message-ID: <20200707131138.ji7pyxltf342agf6@e107158-lin.cambridge.arm.com>
References: <20200630112123.12076-1-qais.yousef@arm.com>
 <CAKfTPtCjTCBbGN0gN_=7MJdiY3N-PPy0ApZWH5xd7KDQ9=0yMg@mail.gmail.com>
 <20200706104111.yfopcjm3kiqlxhx2@e107158-lin.cambridge.arm.com>
 <CAKfTPtDKb0Co5wEcKu3ZE2cJZs87Pma2oQaNQvRq8da26_xjcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDKb0Co5wEcKu3ZE2cJZs87Pma2oQaNQvRq8da26_xjcg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/20 14:29, Vincent Guittot wrote:
> On Mon, 6 Jul 2020 at 12:41, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 07/03/20 14:09, Vincent Guittot wrote:
> > > I have run the perf bench sched pipe that have have already run
> > > previously with this v6 and the results are similar to my previous
> > > tests:
> > > The impact is -1.61% similarly to v2 which is better compared the
> > > original -3.66% without your patch
> >
> > Thanks Vincent.
> >
> > Can you afford doing a capture of `perf record` and share the resulting
> > perf.dat with vmlinux (with debug symbols)?
> 
> Will try to make it by end of the week

Thanks! If you want a place to drop them let me know.

Cheers

--
Qais Yousef

> 
> >
> > Having a before/after capture would be even better.
> >
> > Not sure if we can do  much about this -1.61% in your case, but it'd be good to
> > understand why if possible. perf bench sched pipe is very sensitive to tiniest
> > of changes which could be due to binary-to-binary differences.
> >
> > Thanks
> >
> > --
> > Qais Yousef
