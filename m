Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DEA207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIGO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:57:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbgIGOv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:51:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15915106F;
        Mon,  7 Sep 2020 07:51:59 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8AA3F73C;
        Mon,  7 Sep 2020 07:51:57 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:51:55 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     peterz@infradead.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200907145155.fsmeygi4fiypikzk@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
 <20200907111320.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907111320.GP2674@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 13:13, peterz@infradead.org wrote:
> On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
> > IMHO the above is a hack. Out-of-tree modules should rely on public headers and
> > exported functions only. What you propose means that people who want to use
> > these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
> > maybe true for us who work in the embedded world. But users who run normal
> > distro kernels (desktop/servers) will fail to build against
> 
> But this isn't really aimed at regular users. We're aiming this at
> developers (IIUC) so I dont really see this as a problem.
> 
> > FWIW, I did raise this concern with Peter in 2019 OSPM and he was okay with the
> > exports as it's still not a contract and they can disappear anytime we want.
> > Migrating to using BTF is the right way forward IMO. I don't think what we have
> > here is out-of-control yet. Though I agree they're annoying.
> 
> Right, we're hiding behind the explicit lack of ABI for modules.
> 
> Anyway, CTF/BTF/random other crap that isn't DWARFs should work fine to
> replace all this muck. Just no idea what the state of any of that is.

So I was thinking of having a function that allows a module to read member of
struct rq (or any struct for that matters), but I think that's the harder
(though neater) way around.

Just compiled a kernel with CONFIG_DEBUG_INFO_BTF_INFO; and doing

	$ pahole rq
	struct rq {
        raw_spinlock_t             lock;                 /*     0     4 */
        unsigned int               nr_running;           /*     4     4 */
        long unsigned int          last_blocked_load_update_tick; /*     8     8 */
        unsigned int               has_blocked_load;     /*    16     4 */

        /* XXX 12 bytes hole, try to pack */

        call_single_data_t         nohz_csd;             /*    32    32 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        unsigned int               nohz_tick_stopped;    /*    64     4 */
        atomic_t                   nohz_flags;           /*    68     4 */
        unsigned int               ttwu_pending;         /*    72     4 */

        /* XXX 4 bytes hole, try to pack */

        u64                        nr_switches;          /*    80     8 */
	.
	.
	.
	}

dumps the struct rq {...}; which means one can easily use that to autogenerate
a header containing the structs they care about accessing for their running
kernel.

pahole automatically knows how to find /sys/kernel/btf/vmlinux to parse the
debug info btw.

The only caveat is that one has to recompile the module for each running
kernel; but that's acceptable I think. Not sure how many allow loading a module
that's not compiled for that particular kernel version anyway.

Note to try this you'll need pahole v1.16 or newer. And compiling pahole on
Ubuntu is a pain. I had to create a fedora docker image to compile it in.

So I think we have this already solved. Though not sure how to document it..

Thanks

--
Qais Yousef
