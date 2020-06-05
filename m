Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1606C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96482075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591373735;
	bh=UwdpKRdlqrxAPQ+pD6xjKA3W+jwOlZ4r03LkFTrY1LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+nvDXUv/vOE+XwgUF2Lqszjws1avgVnl5nOiIZzoQXjvn3hFwLmwONLYN96qnPMn
	 bs4yykQiZVogntepV4ewVOpiAvztxrU+Rarb3FeuYjqwVGduNj+fOKfFhgOdlyuD1i
	 TskmIg9a0V8VdmXZV3mHk/3UxqCKFo23i+JW/vv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFEQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFEQPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:15:34 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D77206DB;
        Fri,  5 Jun 2020 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591373734;
        bh=UwdpKRdlqrxAPQ+pD6xjKA3W+jwOlZ4r03LkFTrY1LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLKsDwLmu6PneMG+VwHwZGHKoOyzHO9TL8dnMZwSDzM56f4c2gTVNNn9RdcetnCyC
         vYZVmspRNN7G+itrwzjpyfg3EA09W5ypfcsrmNcpmucq3faJwn/+LmwwkTKW4f/NHG
         5MGycP4gFgaj6ueu/XoxPOxE9/G0S+ATeGVhNFsE=
Date:   Fri, 5 Jun 2020 09:15:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200605161532.GD1373@sol.localdomain>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605074154.GB2750@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 09:41:54AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 04, 2020 at 05:24:33PM -0700, Eric Biggers wrote:
> > On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
> > > On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> > > > The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> > > > got smp_call_function_single_async() subtly wrong. Even though it will
> > > > return -EBUSY when trying to re-use a csd, that condition is not
> > > > atomic and still requires external serialization.
> > > > 
> > > > The change in ttwu_queue_remote() got this wrong.
> > > > 
> > > > While on first reading ttwu_queue_remote() has an atomic test-and-set
> > > > that appears to serialize the use, the matching 'release' is not in
> > > > the right place to actually guarantee this serialization.
> > > > 
> > > > The actual race is vs the sched_ttwu_pending() call in the idle loop;
> > > > that can run the wakeup-list without consuming the CSD.
> > > > 
> > > > Instead of trying to chain the lists, merge them.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > ...
> > > > +	/*
> > > > +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> > > > +	 * for task_struct to be on the @call_single_queue.
> > > > +	 */
> > > > +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> > > > +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> > > > +
> > > 
> > > There is no guarantee in C that
> > > 
> > > 	type1 a;
> > > 	type2 b;
> > > 
> > > in two different data structures means that offsetof(b) - offsetof(a)
> > > is the same in both data structures unless attributes such as
> > > __attribute__((__packed__)) are used.
> > > 
> > > As result, this does and will cause a variety of build errors depending
> > > on the compiler version and compile flags.
> > > 
> > > Guenter
> > 
> > Yep, this breaks the build for me.
> 
> -ENOCONFIG

For me, the problem seems to be randstruct.  To reproduce, you can use
(on x86_64):

	make defconfig
	echo CONFIG_GCC_PLUGIN_RANDSTRUCT=y >> .config
	make olddefconfig
	make kernel/smp.o
