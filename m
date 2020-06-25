Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B51D20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593056756;
	bh=xVmErKmOnlogNcB9+zanlMw4Gz2VSkhqUiPZ56bitO0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dBPCPKKJJFzjS3daLsUIcI/Lv3xZLWp6dsvhr2PCTwEoofCHJMgzCTPpoQOoeVOIK
	 HnewwUDv3rTfm8dniRMTDs4a8bzPidrfC/kEoL9kPAxSwoBobT62dm4vBqpDlNxkjC
	 BS2OyBta+sanV0c7J0/DdvgVQDYEWrQb+3Th8riY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbgFYDpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 23:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbgFYDpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 23:45:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457AB20781;
        Thu, 25 Jun 2020 03:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593056754;
        bh=xVmErKmOnlogNcB9+zanlMw4Gz2VSkhqUiPZ56bitO0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e2kSDruzvpcVAyIz+zdpTPnBDCVLhoXrUx/5E/FSuW+6sum936UuUudDbBvMUnr68
         4ApBcFXSJ+jd1mRBwLtoA20ZtXas5JSQVrPomJIwnUihzIifp28k0324XRF1dA/n/z
         jeWTEXjJpZSVqm1c2jz8oJGaiYaueO5R0S07WKNU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2E9F7352327F; Wed, 24 Jun 2020 20:45:54 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:45:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20200625034554.GO9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200625125753.6ec44d50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625125753.6ec44d50@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 12:57:53PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_enter':
> kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
>   251 |  seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>       |        ^~~~~~~~~~~~~~~~~~~~~~
>       |        atomic_add_return
> kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_exit':
> kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
>   281 |   arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
>       |   ^~~~~~~~~~~~~~~~~~
>       |   atomic_andnot
> kernel/rcu/tree.c: In function 'rcu_dynticks_curr_cpu_in_eqs':
> kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
>   314 |  return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
>       |           ^~~~~~~~~~~~~~~~
>       |           atomic_read
> 
> Caused by commit
> 
>   d2f8491368e5 ("rcu: Fixup noinstr warnings")
> 
> I reverted that commit for today.

MIPS doesn't much like it, either.  I hope to get an update tomorrow.

Apologies for the hassle!

							Thanx, Paul
