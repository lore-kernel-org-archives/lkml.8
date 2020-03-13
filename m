Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D467320751
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="puBKDSJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCMUNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:13:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nkWFycqpZYJt7ggLqsbJH3T3DjF+vfsv/OvaOnZE3tM=; b=puBKDSJGCExOyIMm7/FV0x5lNv
        79sKZ7deeZ9Isr4e+GswJCa+yRFQnir6tchmzpDS55jss+6sL2UZ5wTfpgAeg+V9Ga1n28Bza01Di
        rM3Rj68oy+HtLHvfjsRFKLZM6WR6oHqwDY4iZkJH4p++RrI+okjY2QrQ7Ly0Km8XoHPNCA3VOy+Bp
        tj6vgZQ+5NABiNUa47lSC1W/PS4T2WUS8nWqS5IeCQxbvrzMeuQGI1TRz4m61WUCRB7uyNewXwghx
        loDcd5b4DMoRmt1Y2swDPVt1jczEVI+4tAFetgAS1Y+9GlcYdjnHj++Ose9fath+Ykt7jtvoDzgkr
        SY4U9CXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCqgG-0006uB-KP; Fri, 13 Mar 2020 20:13:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30EAE980FAC; Fri, 13 Mar 2020 21:13:14 +0100 (CET)
Date:   Fri, 13 Mar 2020 21:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
Message-ID: <20200313201314.GE5086@worktop.programming.kicks-ass.net>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
 <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:32:52PM -0400, Qian Cai wrote:
> Well, in mm/vmstat.c (init_mm_internals) case for example, it was initialized
> as a static,
> 
> static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
> 
> which will not call __debug_object_init(). 

Then fix that.

That is, all of:

  DECLARE_DEFERRABLE_WORK
  KTHREAD_DELAYED_WORK_INIT
  DEFINE_TIMER

are broken and need to go.

Unless of course, you can frob debugobjects such that we can provide the
required storage through is_static_object() and modify the above static
declarators to provide the storage.

Or, fix that random crud to do the wakeup outside of the lock.

Plenty options..
