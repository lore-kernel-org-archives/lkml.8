Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73610C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CC2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBVH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:28:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:51178 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgBVH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:28:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 23:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; 
   d="gz'50?scan'50,208,50";a="236800973"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2020 23:27:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5PCf-00049A-Gv; Sat, 22 Feb 2020 15:27:57 +0800
Date:   Sat, 22 Feb 2020 15:27:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next 110/168] kernel/rcu/tree.c:3401:2: error: implicit
 declaration of function 'ASSERT_EXCLUSIVE_WRITER'
Message-ID: <202002221501.6Iz5kP2U%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
head:   8aa63de65a79bd8c5c1c2b19452e35f58b043ac7
commit: e70e4b3e69ce8d3fdfc1f4bfe6ed27187e1a9016 [110/168] rcu: Mark rcu_state.ncpus to detect concurrent writes
config: arc-defconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e70e4b3e69ce8d3fdfc1f4bfe6ed27187e1a9016
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: the rcu/rcu/next HEAD 8aa63de65a79bd8c5c1c2b19452e35f58b043ac7 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_cpu_starting':
>> kernel/rcu/tree.c:3401:2: error: implicit declaration of function 'ASSERT_EXCLUSIVE_WRITER' [-Werror=implicit-function-declaration]
    3401 |  ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ASSERT_EXCLUSIVE_WRITER +3401 kernel/rcu/tree.c

  3364	
  3365	/*
  3366	 * Mark the specified CPU as being online so that subsequent grace periods
  3367	 * (both expedited and normal) will wait on it.  Note that this means that
  3368	 * incoming CPUs are not allowed to use RCU read-side critical sections
  3369	 * until this function is called.  Failing to observe this restriction
  3370	 * will result in lockdep splats.
  3371	 *
  3372	 * Note that this function is special in that it is invoked directly
  3373	 * from the incoming CPU rather than from the cpuhp_step mechanism.
  3374	 * This is because this function must be invoked at a precise location.
  3375	 */
  3376	void rcu_cpu_starting(unsigned int cpu)
  3377	{
  3378		unsigned long flags;
  3379		unsigned long mask;
  3380		int nbits;
  3381		unsigned long oldmask;
  3382		struct rcu_data *rdp;
  3383		struct rcu_node *rnp;
  3384	
  3385		if (per_cpu(rcu_cpu_started, cpu))
  3386			return;
  3387	
  3388		per_cpu(rcu_cpu_started, cpu) = 1;
  3389	
  3390		rdp = per_cpu_ptr(&rcu_data, cpu);
  3391		rnp = rdp->mynode;
  3392		mask = rdp->grpmask;
  3393		raw_spin_lock_irqsave_rcu_node(rnp, flags);
  3394		WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
  3395		oldmask = rnp->expmaskinitnext;
  3396		rnp->expmaskinitnext |= mask;
  3397		oldmask ^= rnp->expmaskinitnext;
  3398		nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
  3399		/* Allow lockless access for expedited grace periods. */
  3400		smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> 3401		ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
  3402		rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
  3403		rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
  3404		rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
  3405		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
  3406			rcu_disable_urgency_upon_qs(rdp);
  3407			/* Report QS -after- changing ->qsmaskinitnext! */
  3408			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
  3409		} else {
  3410			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
  3411		}
  3412		smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
  3413	}
  3414	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--
