Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E11C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B0220675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGFVVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:21:06 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 14:21:05 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1jsYXp-0000fW-NF; Mon, 06 Jul 2020 17:20:57 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 72F08560110; Mon,  6 Jul 2020 17:20:57 -0400 (EDT)
Date:   Mon, 6 Jul 2020 17:20:57 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, valentin.schneider@arm.com
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200706212057.GA18637@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, valentin.schneider@arm.com
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706145952.GB597537@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:59:52PM +0200, Peter Zijlstra wrote:
 > On Fri, Jul 03, 2020 at 04:51:53PM -0400, Dave Jones wrote:
 > > On Fri, Jul 03, 2020 at 12:40:33PM +0200, Peter Zijlstra wrote:
 > >  
 > > looked promising the first few hours, but as soon as it hit four hours
 > > of uptime, loadavg spiked and is now pinned to at least 1.00
 > 
 > OK, lots of cursing later, I now have the below...
 > 
 > The TL;DR is that while schedule() doesn't change p->state once it
 > starts, it does read it quite a bit, and ttwu() will actually change it
 > to TASK_WAKING. So if ttwu() changes it to WAKING before schedule()
 > reads it to do loadavg accounting, things go sideways.
 > 
 > The below is extra complicated by the fact that I've had to scrounge up
 > a bunch of load-store ordering without actually adding barriers. It adds
 > yet another control dependency to ttwu(), so take that C standard :-)

Man this stuff is subtle. I could've read this a hundred times and not
even come close to approaching this.

Basically me reading scheduler code:
http://www.quickmeme.com/img/96/9642ed212bbced00885592b39880ec55218e922245e0637cf94db2e41857d558.jpg

 > I've booted it, and build a few kernels with it and checked loadavg
 > drops to 0 after each build, so from that pov all is well, but since
 > I'm not confident I can reproduce the issue, I can't tell this actually
 > fixes anything, except maybe phantoms of my imagination.

Five hours in, looking good so far.  I think you nailed it.

	Dave

