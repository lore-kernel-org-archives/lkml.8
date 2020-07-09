Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20011C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C342078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGIP6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgGIP6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:58:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1E72077D;
        Thu,  9 Jul 2020 15:58:20 +0000 (UTC)
Date:   Thu, 9 Jul 2020 11:58:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200709115818.36a956a4@oasis.local.home>
In-Reply-To: <20200709124505.GT597537@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 14:45:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jun 19, 2020 at 10:15:51PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/fifo
> > head:   8b700983de82f79e05b2c1136d6513ea4c9b22c4
> > commit: 616d91b68cd56bcb1954b6a5af7d542401fde772 [44/45] sched: Remove sched_setscheduler*() EXPORTs
> > config: x86_64-rhel (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce (this is a W=1 build):
> >         git checkout 616d91b68cd56bcb1954b6a5af7d542401fde772
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >   
> > >> ERROR: modpost: "sched_setscheduler" [kernel/trace/ring_buffer_benchmark.ko] undefined!  
> 
> Steve, do you have any preference on how to go about fixing this one?

Well, I use to manually set the priority of the test, but I guess we
can switch the parameters to accepting a "high, medium, and low" that
will correspond to your setting of the other sched_setscheduler() calls
that were replaced.

-- Steve
