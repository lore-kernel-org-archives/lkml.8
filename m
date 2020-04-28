Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F6AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6972070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD1Xea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:34:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:53034 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgD1Xe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:34:29 -0400
IronPort-SDR: ypMl/f0Jn2ezu5tgfZTSsXHyCl9TJXxQAe9IT+chshqHc8GhsgKy3r9i8kXalyIf02D/wNxHQC
 yZMQuhqL9yMg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 16:34:29 -0700
IronPort-SDR: NPb3Dhzfu5ZsrWqFKoDjGInxp+AZK/YB34dd1DLlkdNXxfuwTUIfzYQJ3mPQsv6Yy/mjtFCeKO
 WjSLx2GMMbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="gz'50?scan'50,208,50";a="247846078"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2020 16:34:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTZkA-0000LT-09; Wed, 29 Apr 2020 07:34:26 +0800
Date:   Wed, 29 Apr 2020 07:34:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, tglx@linutronix.de,
        john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, psodagud@codeaurora.org,
        pkondeti@codeaurora.org
Subject: Re: [PATCH v2 2/2] sched: Add a check for cpu unbound deferrable
 timers
Message-ID: <202004290703.sBFb0L46%lkp@intel.com>
References: <1588104579-8712-3-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1588104579-8712-3-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prasad,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on tip/auto-latest tip/timers/nohz v5.7-rc3 next-20200428]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Prasad-Sodagudi/timer-make-deferrable-cpu-unbound-timers-really-not-bound-to-a-cpu/20200429-060558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 4479730e9263befbb9ce9563a09563db2acb8f7c
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'run_timer_softirq':
>> kernel/time/timer.c:1828:24: error: 'deferrable_pending' undeclared (first use in this function); did you mean 'detach_if_pending'?
      if ((atomic_cmpxchg(&deferrable_pending, 1, 0) &&
                           ^~~~~~~~~~~~~~~~~~
                           detach_if_pending
   kernel/time/timer.c:1828:24: note: each undeclared identifier is reported only once for each function it appears in
   kernel/time/timer.c:1831:18: error: 'timer_base_deferrable' undeclared (first use in this function); did you mean 'timer_base_lock_expiry'?
       __run_timers(&timer_base_deferrable);
                     ^~~~~~~~~~~~~~~~~~~~~
                     timer_base_lock_expiry
   kernel/time/timer.c: In function 'init_timer_deferrable_global':
   kernel/time/timer.c:2073:2: error: 'timer_base_deferrable' undeclared (first use in this function); did you mean 'timer_base_lock_expiry'?
     timer_base_deferrable.cpu = nr_cpu_ids;
     ^~~~~~~~~~~~~~~~~~~~~
     timer_base_lock_expiry

vim +1828 kernel/time/timer.c

  1817	
  1818	/*
  1819	 * This function runs timers and the timer-tq in bottom half context.
  1820	 */
  1821	static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  1822	{
  1823		struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
  1824	
  1825		__run_timers(base);
  1826		if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
  1827			__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
> 1828			if ((atomic_cmpxchg(&deferrable_pending, 1, 0) &&
  1829					tick_do_timer_cpu == TICK_DO_TIMER_NONE) ||
  1830					tick_do_timer_cpu == smp_processor_id())
  1831				__run_timers(&timer_base_deferrable);
  1832		}
  1833	}
  1834	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--zhXaljGHf11kAtnf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--zhXaljGHf11kAtnf--
