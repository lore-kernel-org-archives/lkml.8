Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47F2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gadm/98g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGTVtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgGTVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:49:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5342C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q/pmUl9G9tnIINckX+tsc4ZNDGVpCit7S6QnO2IEd7w=; b=Gadm/98gBnXxEvK0+FpIzGCCvW
        FDiBWH+ibqVz6jGQaLhPole6CbO2mFOmoIxn+F5jveIZNcb7MSBi8u/b49zwggvxfKroIVAbGjjPa
        n5ZHitwtSJFL26qAyZ09T+mjzYf885xBwFFswSVyPR9tnOF++n8z32YVwbp6sPLd+ol/m7T0GLZYt
        SLamz/Fesla3Ozg8zFXPyCkpggBKftZmOVvbroAMoJzO8NqOUc4tRUPkKqxwsuoN199gBpkELsa4W
        3vogAveu0epEF2qsUHs/ZBPNPJ+0O+e0AZfIHihRMFj4m8w7pc3aT98VQuFGpKpKNKMOVYacHXdCU
        pCnAEfhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxdez-0007Qr-I1; Mon, 20 Jul 2020 21:49:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A83A983454; Mon, 20 Jul 2020 23:49:18 +0200 (CEST)
Date:   Mon, 20 Jul 2020 23:49:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200720214918.GM5523@worktop.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709115818.36a956a4@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:58:18AM -0400, Steven Rostedt wrote:
> On Thu, 9 Jul 2020 14:45:05 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jun 19, 2020 at 10:15:51PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/fifo
> > > head:   8b700983de82f79e05b2c1136d6513ea4c9b22c4
> > > commit: 616d91b68cd56bcb1954b6a5af7d542401fde772 [44/45] sched: Remove sched_setscheduler*() EXPORTs
> > > config: x86_64-rhel (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         git checkout 616d91b68cd56bcb1954b6a5af7d542401fde772
> > >         # save the attached .config to linux build tree
> > >         make W=1 ARCH=x86_64 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >   
> > > >> ERROR: modpost: "sched_setscheduler" [kernel/trace/ring_buffer_benchmark.ko] undefined!  
> > 
> > Steve, do you have any preference on how to go about fixing this one?
> 
> Well, I use to manually set the priority of the test, but I guess we
> can switch the parameters to accepting a "high, medium, and low" that
> will correspond to your setting of the other sched_setscheduler() calls
> that were replaced.

Steve, would this work for you, or would you prefer renaming the
parameters as well?

---
 kernel/trace/ring_buffer_benchmark.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 8df0aa810950..0ee3d41ceee4 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -455,21 +455,19 @@ static int __init ring_buffer_benchmark_init(void)
 	 * Run them as low-prio background tasks by default:
 	 */
 	if (!disable_reader) {
-		if (consumer_fifo >= 0) {
-			struct sched_param param = {
-				.sched_priority = consumer_fifo
-			};
-			sched_setscheduler(consumer, SCHED_FIFO, &param);
-		} else
+		if (consumer_fifo > 1)
+			sched_set_fifo(consumer);
+		else if (consumer_fifo >= 0)
+			sched_set_fifo_low(consumer);
+		else
 			set_user_nice(consumer, consumer_nice);
 	}
 
-	if (producer_fifo >= 0) {
-		struct sched_param param = {
-			.sched_priority = producer_fifo
-		};
-		sched_setscheduler(producer, SCHED_FIFO, &param);
-	} else
+	if (producer_fifo > 1)
+		sched_set_fifo(producer);
+	else if (producer_fifo >= 0)
+		sched_set_fifo_low(producer);
+	else
 		set_user_nice(producer, producer_nice);
 
 	return 0;

