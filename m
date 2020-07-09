Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645B6207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594305392;
	bh=ICGlWFp9oftqMqwcCIzBqthg+wZlKlhq+++ODcMFf9U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tpMxv2rs7A1uZJUnXbj/yo5YUV7WYTQfG14L00UDUeXO3MCvcmWVYEKuNl5ol3V6I
	 56K7DWFv16K8lg0+C/uM8+TKyUHaX1A5tL30gu5f72yGaSWX07XAMYyHqDpXIwS78y
	 r9CbqABICtYuuEBZ/uunwqxlthq5u6Zf4eg+/zHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGIOgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgGIOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:36:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7276A2073A;
        Thu,  9 Jul 2020 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594305390;
        bh=ICGlWFp9oftqMqwcCIzBqthg+wZlKlhq+++ODcMFf9U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PLhS8zQ6yuuyiPOemZn9nzEARXmDfH0cui/vCHHUbCt6oAMMDDGLqM8r042TdbrRV
         f6KzlyJNdje4zlHVhNNieW4DM+RC0StPgLhVF2j5Ruv42o0NZf1RISQa8qrpBThACT
         BVB852+PMhZZnSfqajnZYwu6hTeZ5D0v7qkBT0U8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C1993522B7F; Thu,  9 Jul 2020 07:36:30 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:36:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel/smp: Fix an off by one in csd_lock_wait_toolong()
Message-ID: <20200709143630.GY9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709104818.GC20875@mwanda>
 <20200709105906.GR597537@hirez.programming.kicks-ass.net>
 <20200709114900.b475kfqz3447zgfg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709114900.b475kfqz3447zgfg@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 01:49:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-09 12:59:06 [+0200], Peter Zijlstra wrote:
> > On Thu, Jul 09, 2020 at 01:48:18PM +0300, Dan Carpenter wrote:
> > > The __per_cpu_offset[] array has "nr_cpu_ids" elements so change the >
> > > >= to prevent a read one element beyond the end of the array.
> > > 
> > > Fixes: 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")
> > 
> > I don't have a copy of that patch in my inbox, even though it says Cc:
> > me.
> > 
> > Paul, where do you expect that patch to go? The version I see from my
> > next tree needs a _lot_ of work.
> 
> There is also
>  
>  https://lkml.kernel.org/r/20200705082603.GX3874@shao2-debian
>  https://lkml.kernel.org/r/00000000000042f21905a991ecea@google.com
> 
> it might be the same thing.

Same commit, different bug, but the fix should be in -next by now.
For these two reports, the problem was that I had debug-recording code
on the wrong side of a csd_unlock().

							Thanx, Paul
