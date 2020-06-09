Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6551207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724671;
	bh=+yJJrS6f/w3XIG46YQKL+jlhy1JoGG/F40tY3Dp8vZ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QI27FsCa2XEauhaRihjIaaH6H/3SasZTR5694wKsnQj7QI5/lhdYncjP4ayxIeGPS
	 EcDQS08VZ7Vq9aZ87o7XgNFnNbFVlEy1Rrp2uZZGts9zX7GEfCgVY/dP6D+mziJiW7
	 ouBH0r8dBhXRAW8CACMXCgHRF/N5zfLrqYmiBL8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgFIRoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFIRo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:44:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6EB207ED;
        Tue,  9 Jun 2020 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724669;
        bh=+yJJrS6f/w3XIG46YQKL+jlhy1JoGG/F40tY3Dp8vZ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lDYH8mccyWzxHN9DFp1dhy7lbUDZoGrar7241LUfL5HMYo7IIW76NuGsHn3e9P5cA
         rqaPh4jUNLq8mMz181kFj0BhhMa0AfSPpexGQky0f/QHZXTHVJjg9icPeLIewyZqsw
         m0MjxOeQM3XC6q1BA1wl6KT5p4Wd2ndiAAnQZN6Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 083BA35229D0; Tue,  9 Jun 2020 10:44:29 -0700 (PDT)
Date:   Tue, 9 Jun 2020 10:44:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.06.05a 85/92] powerpc-linux-ld: kernel/smp.c:128:
 undefined reference to `__udivdi3'
Message-ID: <20200609174428.GQ4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006090518.ePllEE1U%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006090518.ePllEE1U%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:21AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.05a
> head:   c5432e18c8bfe9283bf5e0bc5e2460ae8f39a7ee
> commit: 3f8c62d29ead7c3213a4af7c433ec6fbf8457f37 [85/92] EXP kernel/smp: Provide CSD lock timeout diagnostics
> config: powerpc64-randconfig-c024-20200607 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Alleged fixes squashed into original with attribution, thank you!

						Thanx, Paul

> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> powerpc-linux-ld: kernel/smp.o: in function `csd_lock_wait':
> kernel/smp.c:122: undefined reference to `__udivdi3'
> >> powerpc-linux-ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> powerpc-linux-ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> powerpc-linux-ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:122: undefined reference to `__udivdi3'
> >> powerpc-linux-ld: kernel/smp.c:128: undefined reference to `__udivdi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__umoddi3'
> powerpc-linux-ld: kernel/smp.c:136: undefined reference to `__udivdi3'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


