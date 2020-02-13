Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72CC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565502168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBMWEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:04:01 -0500
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:60460 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727594AbgBMWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:04:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A030618026A0E;
        Thu, 13 Feb 2020 22:03:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toys27_3f8fd5acfc11c
X-Filterd-Recvd-Size: 2705
Received: from XPS-9350 (unknown [172.58.44.42])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 22:03:56 +0000 (UTC)
Message-ID: <c7df22d3f248c784e8960841c79fe2836d7ea8ab.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Replace zero-length array with
 flexible-array member
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 14:02:10 -0800
In-Reply-To: <20200213170639.GK14914@hirez.programming.kicks-ass.net>
References: <20200213151951.GA32363@embeddedor>
         <20200213164518.GI14914@hirez.programming.kicks-ass.net>
         <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
         <20200213170639.GK14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 18:06 +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 10:58:31AM -0600, Gustavo A. R. Silva wrote:
> > > Hurmph, and where are all the other similar changes for kernel/sched/ ?
> > > Because this really isn't the only such usage and I really don't see the
> > > point in having a separate patch for every single one of them.
> > > 
> > 
> > Yeah. I can do that. I'll send a patch for the whole kernel/sched.
> 
> Thanks!
> 
> > > Also; couldn't you've taught the compiler to also warn about [0] ?
> > > There's really no other purpose to having a zero length array.
> > > 
> > 
> > Yeah, this is something we'd like to see in the short future.
> > Unfortunately, for now, the only way for the compiler to warn
> > about zero-length arrays in through the use of "-pedantic".
> > And we definitely don't want to follow this path.
> > 
> > What we can do, in the meantime, is to add a test for it to
> > checkpatch.
> 
> Oh, I means, warn if it isn't the last member of a struct. Not warn on
> any use. Or we mean the same and I'm just confused.

That might be a somewhat difficult thing to add to checkpatch
as it is effectively a per-line scanner:

Try something like:

$ git grep -P -A1 '^\s*(?!return)(\w+\s+){1,3}\w+\[0\];' -- '*.[ch]'

and look at the results.

In checkpatch that could be something like:

	if ($line =~ /^.\s*$Type\s+$Ident\s*\[\s*0\s*\]\s*;/) {
		warn...
	}



