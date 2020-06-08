Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA482076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591632392;
	bh=dm6VccpRTR1gI7kUqPERR2PbR74WR6VaKZUAB+c2esQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MWIFF5bVz5w4tOceOZ49mscBuAnTwKoPipyZiEjg/Alhib84wP9XnnOTFRHgHyCAw
	 znZ+PLG3fYgF/v7qpUvh+BJ9/EVi2vphK0kvWi+2b3hk/q184ZLSFQvdfwjPhYlU2b
	 kgCJdGHQ8PrHVO1uKH/Is4YJpAZ3osFDxDWRSvW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgFHQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbgFHQGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:06:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6271E2063A;
        Mon,  8 Jun 2020 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591632389;
        bh=dm6VccpRTR1gI7kUqPERR2PbR74WR6VaKZUAB+c2esQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V1bojjCySPFLPUNHBAblR1JQV1Yd0V08M3uj4/5cam+MdvjROUmJG8sxOqOF7hiq8
         GmDVvSYFfe/V13gMKTu+cWriFJo2Fdk8yvLoMpnzpFg6I88+hJjr6Bn191LxzFBHo7
         cYHCN0NOHCRGvl/EPaM+NIN1DTA7GVEJZ0ScLn1s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 451BD3522A6D; Mon,  8 Jun 2020 09:06:29 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:06:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.06.02a 67/90] kernel/rcu/rcuperf.c:727:38:
 warning: format specifies type 'size_t' (aka 'unsigned int') but the
 argument has type 'unsigned long'
Message-ID: <20200608160629.GJ4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006060704.dM7SxfSK%lkp@intel.com>
 <20200606001914.GE4455@paulmck-ThinkPad-P72>
 <20200607190057.GA19362@paulmck-ThinkPad-P72>
 <f6df7c3e-4c43-47eb-4c4f-a5e9de0d332f@huawei.com>
 <20200608032632.GA2618368@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608032632.GA2618368@ubuntu-n2-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 08:26:32PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 08, 2020 at 09:56:16AM +0800, Kefeng Wang wrote:
> > 
> > On 2020/6/8 3:00, Paul E. McKenney wrote:
> > > On Fri, Jun 05, 2020 at 05:19:14PM -0700, Paul E. McKenney wrote:
> > > > On Sat, Jun 06, 2020 at 07:07:10AM +0800, kernel test robot wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.02a
> > > > > head:   5216948905dd07a84cef8a7dc72c2ec076802efd
> > > > > commit: 7d16add62717136b1839f0b3d7ea4cbb98f38c2a [67/90] rcuperf: Fix kfree_mult to match printk() format
> > > > > config: arm-randconfig-r004-20200605 (attached as .config)
> > > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 6dd738e2f0609f7d3313b574a1d471263d2d3ba1)
> > > > > reproduce (this is a W=1 build):
> > > > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >          chmod +x ~/bin/make.cross
> > > > >          # install arm cross compiling tool for clang build
> > > > >          # apt-get install binutils-arm-linux-gnueabi
> > > > >          git checkout 7d16add62717136b1839f0b3d7ea4cbb98f38c2a
> > > > >          # save the attached .config to linux build tree
> > > > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > > > > 
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Adding Kefeng on CC.  Kefeng, thoughts?
> > > Like this, perhaps?
> > 
> > Hi Paul，I check https://lkml.org/lkml/2020/6/2/286 and <https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev.2020.06.02a>
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev.2020.06.02a
> > 
> > There are two different ways to fix the same issue
> > 
> > patch 1:  rcuperf: Fix printk format warning urgent-for-mingo
> > 
> > patch 2:  'rcuperf: Fix kfree_mult to match printk() format' from Ingo 
> > after my patch
> > 
> > since patch1 already merged,  patch2 is not needed, so skip patch2?

Good point, done, and thank you both!

							Thanx, Paul
