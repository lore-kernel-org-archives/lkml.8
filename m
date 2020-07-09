Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CBA206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGIOch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:32:37 -0400
Received: from gentwo.org ([3.19.106.255]:51906 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:32:36 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 026D63F1F2; Thu,  9 Jul 2020 14:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 000053F1EC;
        Thu,  9 Jul 2020 14:32:33 +0000 (UTC)
Date:   Thu, 9 Jul 2020 14:32:33 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pekka Enberg <penberg@gmail.com>
cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
In-Reply-To: <CAOJsxLFnY=4v6UQigyiZKTMTQXKakVOKf6KA+bCkMe-XVY6sqA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2007091429200.24933@www.lameter.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com> <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com> <7374a9fd-460b-1a51-1ab4-25170337e5f2@linux.alibaba.com>
 <CAOJsxLFnY=4v6UQigyiZKTMTQXKakVOKf6KA+bCkMe-XVY6sqA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020, Pekka Enberg wrote:

> On Fri, Jul 3, 2020 at 12:38 PM xunlei <xlpang@linux.alibaba.com> wrote:
> >
> > On 2020/7/2 PM 7:59, Pekka Enberg wrote:
> > > On Thu, Jul 2, 2020 at 11:32 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> > >> The node list_lock in count_partial() spend long time iterating
> > >> in case of large amount of partial page lists, which can cause
> > >> thunder herd effect to the list_lock contention, e.g. it cause
> > >> business response-time jitters when accessing "/proc/slabinfo"
> > >> in our production environments.
> > >
> > > Would you have any numbers to share to quantify this jitter? I have no
> >
> > We have HSF RT(High-speed Service Framework Response-Time) monitors, the
> > RT figures fluctuated randomly, then we deployed a tool detecting "irq
> > off" and "preempt off" to dump the culprit's calltrace, capturing the
> > list_lock cost up to 100ms with irq off issued by "ss", this also caused
> > network timeouts.
>
> Thanks for the follow up. This sounds like a good enough motivation
> for this patch, but please include it in the changelog.


Well this is access via sysfs causing a holdoff. Another way of access to
the same information without adding atomics and counters would be best.

> > I also have no idea what's the standard SLUB benchmark for the
> > regression test, any specific suggestion?
>
> I don't know what people use these days. When I did benchmarking in
> the past, hackbench and netperf were known to be slab-allocation
> intensive macro-benchmarks. Christoph also had some SLUB
> micro-benchmarks, but I don't think we ever merged them into the tree.

They are still where they have been for the last decade or so. In my git
tree on kernel.org. They were also reworked a couple of times and posted
to linux-mm. There are historical posts going back over the years where
individuals have modified them and used them to create multiple other
tests.

