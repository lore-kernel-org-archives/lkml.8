Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1814C206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H468QQ7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgFKQK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:10:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C8C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NljwgDz18R8jKy16NjwvgAJ7W2sWNxXP/LIBeOA0yzM=; b=H468QQ7sN4+Xa71yQQqMg5dAib
        /Gan8mK8wHSOAYH3rmxH7Z7SaK96DdoipFHCKR8CVSMOezqhyzUq4nTzG2M9Sa2WyW72tg00rMOVJ
        BYfTJFztl6FjnaFGiT8UsFxwz8ihsYC7m62RkXrziBE75zUz9iGqLRBKPwBwUmpnYjFYTWeOsp1UL
        qXJV5j3/M5n+Oe4uPcTgrO3Cw3fJJQT+he67fgMdCjZOkPHmYzRjq3uoL5dnxKDXR2PCN2vWOjfoC
        Kwf8LwKJsrmWU62uapzuqqRcL1LIsu++cWPvUuqMkDWUvVh34S5fUeh0NQVy1BcfHpmZgZOsWCOHh
        eCo5lh/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjPmb-0001Zm-8x; Thu, 11 Jun 2020 16:10:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC374303DA8;
        Thu, 11 Jun 2020 18:10:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9140E20E06054; Thu, 11 Jun 2020 18:10:22 +0200 (CEST)
Date:   Thu, 11 Jun 2020 18:10:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [smp] b2a02fc43a: suspend-stress.fail
Message-ID: <20200611161022.GL2531@hirez.programming.kicks-ass.net>
References: <20200610083502.GF12456@shao2-debian>
 <20200610095054.GF2531@hirez.programming.kicks-ass.net>
 <CADjb_WSLpKrkt-Oq_3krGBp8ZLjVZ4caUAd0d0s1_6s1tOHdHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjb_WSLpKrkt-Oq_3krGBp8ZLjVZ4caUAd0d0s1_6s1tOHdHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 04:24:53PM +0800, Chen Yu wrote:
> Hi Peter,
> On Wed, Jun 10, 2020 at 5:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 10, 2020 at 04:35:02PM +0800, kernel test robot wrote:
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: b2a02fc43a1f40ef4eb2fb2b06357382608d4d84 ("smp: Optimize send_call_function_single_ipi()")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: suspend-stress
> > > with following parameters:
> > >
> > >       mode: freeze
> > >       iterations: 10
> > >
> > >
> > >
> > > on test machine: 2 threads Broxton with 4G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >
> > >
> > > the result of this commit:
> > >
> > > test started
> >
> > No dmesg output? No splat?
> This issue was only found on one of the test machines from lkp team.
>  I've borrowed that machine and will try to narrow down and give feedback later.

Thanks! One thing to maybe try is hotplug tests. Suspend does hotplugs,
and it might be easier to debug hotplug than it is to debug suspend.
