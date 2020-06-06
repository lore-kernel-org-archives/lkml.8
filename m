Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D446C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2C02074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591402757;
	bh=FIVVKPgSSc3Sm52VmjhE3KrCJmFJksE36WsPsA712FU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DE6br6fvRp3KbGQm4ORgTVGfd+4024HgrT0naYt5J0FY9nROb9A0R5nGJZQamaGzk
	 +lsFaEy0XT+AaSqfejgd2Yqk0hdIK0UHcMDBNPgwLapjTo6I4oez7PPt/s5/Y4O+rD
	 xNEu69PHdN4uEn2eU+rQrebUokF3g2/rPJhVkLvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgFFATQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgFFATQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:19:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33425206DB;
        Sat,  6 Jun 2020 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591402755;
        bh=FIVVKPgSSc3Sm52VmjhE3KrCJmFJksE36WsPsA712FU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HMzoJcM6kYnj+ONRCGbtGKrJWXSbp1ZqNGgE4Hr3EiHN86GhGPnVrUFvhJDsqoedF
         YWhuHITfDLgIsgoCJRmp/PXAiOo7uYnwfGJU+82lLdppRQff1D6VoK63IndogeJmOh
         B744knXHdAXOwQ/BXxYYC0yE4z2lcMjtaASRYY1w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ECEAF3522B47; Fri,  5 Jun 2020 17:19:14 -0700 (PDT)
Date:   Fri, 5 Jun 2020 17:19:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com
Subject: Re: [rcu:dev.2020.06.02a 67/90] kernel/rcu/rcuperf.c:727:38:
 warning: format specifies type 'size_t' (aka 'unsigned int') but the
 argument has type 'unsigned long'
Message-ID: <20200606001914.GE4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202006060704.dM7SxfSK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006060704.dM7SxfSK%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 07:07:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.02a
> head:   5216948905dd07a84cef8a7dc72c2ec076802efd
> commit: 7d16add62717136b1839f0b3d7ea4cbb98f38c2a [67/90] rcuperf: Fix kfree_mult to match printk() format
> config: arm-randconfig-r004-20200605 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 6dd738e2f0609f7d3313b574a1d471263d2d3ba1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         git checkout 7d16add62717136b1839f0b3d7ea4cbb98f38c2a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Adding Kefeng on CC.  Kefeng, thoughts?

							Thanx, Paul

> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> kernel/rcu/rcuperf.c:727:38: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
> pr_alert("kfree object size=%zun", kfree_mult * sizeof(struct kfree_obj));
> ~~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> %lu
> include/linux/printk.h:295:35: note: expanded from macro 'pr_alert'
> printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> ~~~     ^~~~~~~~~~~
> 1 warning generated.
> 
> vim +727 kernel/rcu/rcuperf.c
> 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  709) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  710) static int __init
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  711) kfree_perf_init(void)
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  712) {
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  713) 	long i;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  714) 	int firsterr = 0;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  715) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  716) 	kfree_nrealthreads = compute_real(kfree_nthreads);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  717) 	/* Start up the kthreads. */
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  718) 	if (shutdown) {
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  719) 		init_waitqueue_head(&shutdown_wq);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  720) 		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  721) 						  shutdown_task);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  722) 		if (firsterr)
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  723) 			goto unwind;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  724) 		schedule_timeout_uninterruptible(1);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  725) 	}
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  726) 
> b3e2d20973db3e Kefeng Wang             2020-04-17 @727  	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
> f87dc808009ac8 Joel Fernandes (Google  2020-03-16  728) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  729) 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  730) 			       GFP_KERNEL);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  731) 	if (kfree_reader_tasks == NULL) {
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  732) 		firsterr = -ENOMEM;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  733) 		goto unwind;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  734) 	}
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  735) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  736) 	for (i = 0; i < kfree_nrealthreads; i++) {
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  737) 		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  738) 						  kfree_reader_tasks[i]);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  739) 		if (firsterr)
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  740) 			goto unwind;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  741) 	}
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  742) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  743) 	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  744) 		schedule_timeout_uninterruptible(1);
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  745) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  746) 	torture_init_end();
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  747) 	return 0;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  748) 
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  749) unwind:
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  750) 	torture_init_end();
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  751) 	kfree_perf_cleanup();
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  752) 	return firsterr;
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  753) }
> e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  754) 
> 
> :::::: The code at line 727 was first introduced by commit
> :::::: b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61 rcuperf: Fix printk format warning
> 
> :::::: TO: Kefeng Wang <wangkefeng.wang@huawei.com>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


