Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06419CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9B9206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbgEMJ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:59:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388392AbgEMJ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E941FB;
        Wed, 13 May 2020 02:59:48 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2F03F305;
        Wed, 13 May 2020 02:59:46 -0700 (PDT)
Date:   Wed, 13 May 2020 10:59:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200513095939.GA2719@gaia>
References: <20200512141535.GA14943@gaia>
 <E812E94D-B8B7-4934-965A-3038F56FD980@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E812E94D-B8B7-4934-965A-3038F56FD980@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:09:30PM -0400, Qian Cai wrote:
> 
> 
> > On May 12, 2020, at 10:15 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > In this case it uses kref_get() to increment the refcount. We could add
> > a kmemleak_add_trace() which allocates a new array and stores the stack
> > trace, linked to the original object. Similarly for kref_put().
> > 
> > If we do this for each inc/dec call, I'd leave it off as default and
> > only enable it explicitly by cmdline argument or
> > /sys/kerne/debug/kmemleak when needed. In most cases you'd hope there is
> > no leak, so no point in tracking additional metadata. But if you do hit
> > a problem, just enable the additional tracking to help with the
> > debugging.
> 
> Well, we would like those testing bots to report kmemleak (I knew
> there would be many false positives) with those additional information
> of refcount leaks in case they found ones, albeit never saw one from
> those bots at all yet.

I know the syzkaller guys tried to run the fuzzer with kmemleak enabled
and there were false positives that required human intervention. IIRC
they disabled it eventually. The proposal was for a new feature to
kmemleak to run the scanning under stop_machine() so that no other CPU
messes with linked lists etc. That would make kmemleak more reliable
under heavy load. Another option was to let the system cool down before
running the scanning.

> Since some of those bots will run fuzzers, so it would be difficult to
> reproduce. Thus, the option has to be enabled by default somehow.
> Otherwise, they could easily miss it in the first place. I’ll look
> into the see if we could make it fairly low overhead.

I guess we don't need the full stack trace. About 4 function calls to
the refcount modification should be sufficient to get an idea.

-- 
Catalin
