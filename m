Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F162088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608601;
	bh=L/KO5yVFOEuH17AbpSijDrxYCXQi8X7ApgmUy9GthUc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KgMPbvp1Co9Ur7iIa62rxtP3Se7UB/3Yb1OXu7Vyz7XJq5TDnt1ySF4r5cT5EYzPj
	 efhVMdvbc24O+W6BRYxGDeJqhzF7J9VrV2SHF3GbB1L9rvSjQfmuHTv+xch+KLi1oJ
	 zsMyRNZHmMmJ8tUxiSQe7IKWnDtWIaL58BU88Clg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgE0TnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0TnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:43:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9C52088E;
        Wed, 27 May 2020 19:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590608600;
        bh=L/KO5yVFOEuH17AbpSijDrxYCXQi8X7ApgmUy9GthUc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z9BrtiM1ychzUVqZ3Ov/VVjldBDH+wUDMJ8sFEFVIz6fv9vuu0euFcMSJAs0M4G1p
         HQB5Le3ABZtIBr9WWEINDdaipNMd2WTQT4M9FVINW9W+BpFnSvk2/KqBzy2AsbbG3O
         ivNny1lRyOMDU7tSM2pk1oTFPOg2rhDbaZkxCT4g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D1117352283B; Wed, 27 May 2020 12:43:19 -0700 (PDT)
Date:   Wed, 27 May 2020 12:43:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.05.26b 51/70] powerpc64-linux-ld:
 kernel/rcu/refperf.o:(.discard+0x0): multiple definition of
 `__pcpu_unique_srcu_ctl_perf_srcu_data';
 kernel/rcu/rcuperf.o:(.discard+0x0): first defined here
Message-ID: <20200527194319.GX2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202005280021.c7upVLgc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005280021.c7upVLgc%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:17:23AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.26b
> head:   795279db1396bf66621fa3f343fa990fe543b89e
> commit: 786a25497743696d79592b864cafbfe48787e6e1 [51/70] refperf: Add a test to measure performance of read-side synchronization
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 786a25497743696d79592b864cafbfe48787e6e1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> powerpc64-linux-ld: kernel/rcu/refperf.o:(.discard+0x0): multiple definition of `__pcpu_unique_srcu_ctl_perf_srcu_data'; kernel/rcu/rcuperf.o:(.discard+0x0): first defined here

Ah, yes, despite the "static" keyword, the names must be unique throughout
the kernel.  Will fix!

							Thanx, Paul
