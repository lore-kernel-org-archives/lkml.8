Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FBC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 17:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8D20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 17:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBBRfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 12:35:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:3923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBBRfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 12:35:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 09:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,394,1574150400"; 
   d="scan'208";a="224088797"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2020 09:35:41 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iyJ9p-000FXu-0p; Mon, 03 Feb 2020 01:35:41 +0800
Date:   Mon, 3 Feb 2020 01:35:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     kbuild-all@lists.01.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, olsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        frextrite@gmail.com, joel@joelfernandes.org, paulmck@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: Re: [PATCH] perf_event.h: Add RCU Annotation to struct ring_buffer
 in perf_event
Message-ID: <202002030113.6DzKgSt8%lkp@intel.com>
References: <20200130144728.24072-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130144728.24072-1-madhuparnabhowmik10@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on v5.5]
[cannot apply to next-20200130]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/madhuparnabhowmik10-gmail-com/perf_event-h-Add-RCU-Annotation-to-struct-ring_buffer-in-perf_event/20200202-163053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 0cc4bd8f70d1ea2940295f1050508c663fe9eff9
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-154-g1dc00f87-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/events/core.c:571:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
   kernel/events/core.c:1384:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1384:15: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:1384:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1397:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1397:28: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:1397:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3221:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3221:18: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3221:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3222:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3222:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3222:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3264:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3264:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3264:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3265:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3265:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4340:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4340:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:4340:25: sparse:    struct perf_event_context *
   kernel/events/core.c:5563:24: sparse: sparse: incorrect type in assignment (different address spaces)
>> kernel/events/core.c:5563:24: sparse:    expected struct ring_buffer *old_rb
>> kernel/events/core.c:5563:24: sparse:    got struct ring_buffer [noderef] <asn:4> *rb
   kernel/events/core.c:5070:12: sparse: sparse: incorrect type in assignment (different address spaces)
>> kernel/events/core.c:5070:12: sparse:    expected struct ring_buffer *rb
   kernel/events/core.c:5070:12: sparse:    got struct ring_buffer [noderef] <asn:4> *rb
   kernel/events/core.c:5072:24: sparse: sparse: incorrect type in assignment (different base types)
   kernel/events/core.c:5072:24: sparse:    expected restricted __poll_t [usertype] events
   kernel/events/core.c:5072:24: sparse:    got int
   kernel/events/core.c:5652:26: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> kernel/events/core.c:5652:26: sparse:    expected struct atomic_t [usertype] *v
>> kernel/events/core.c:5652:26: sparse:    got struct atomic_t [noderef] <asn:4> *
   kernel/events/core.c:5655:34: sparse: sparse: incorrect type in argument 1 (different address spaces)
   kernel/events/core.c:5655:34: sparse:    expected struct atomic_t [usertype] *v
   kernel/events/core.c:5655:34: sparse:    got struct atomic_t [noderef] <asn:4> *
   kernel/events/core.c:7212:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/events/core.c:7212:9: sparse:    struct list_head *
>> kernel/events/core.c:7212:9: sparse:    struct list_head [noderef] <asn:4> *
   kernel/events/core.c:5749:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5749:31: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5749:31: sparse:    struct ring_buffer *
   kernel/events/core.c:5835:20: sparse: sparse: incorrect type in assignment (different address spaces)
   kernel/events/core.c:5835:20: sparse:    expected struct ring_buffer *rb
   kernel/events/core.c:5835:20: sparse:    got struct ring_buffer [noderef] <asn:4> *rb
   kernel/events/core.c:5896:48: sparse: sparse: incorrect type in argument 1 (different address spaces)
   kernel/events/core.c:5896:48: sparse:    expected struct atomic_t [usertype] *v
   kernel/events/core.c:5896:48: sparse:    got struct atomic_t [noderef] <asn:4> *
   kernel/events/internal.h:204:1: sparse: sparse: incorrect type in argument 2 (different address spaces)
   kernel/events/internal.h:204:1: sparse:    expected void const [noderef] <asn:1> *from
   kernel/events/internal.h:204:1: sparse:    got void const *buf
   kernel/events/core.c:6302:6: sparse: sparse: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?
   kernel/events/core.c:7091:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7091:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:7091:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7192:32: sparse: sparse: incorrect type in initializer (different address spaces)
   kernel/events/core.c:7192:32: sparse:    expected struct ring_buffer *rb
   kernel/events/core.c:7192:32: sparse:    got struct ring_buffer [noderef] <asn:4> *rb
   kernel/events/core.c:7870:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7870:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:7870:23: sparse:    struct perf_event_context *
   kernel/events/core.c:8600:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8600:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8600:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:8620:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8620:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8620:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:8740:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:8751:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8751:9: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8751:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:8740:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:8790:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8790:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8790:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:8971:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8971:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:8971:23: sparse:    struct perf_event_context *
   kernel/events/core.c:10142:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:11865:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:11865:9: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:11865:9: sparse:    struct perf_event_context *
   kernel/events/core.c:11975:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:11975:17: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:11975:17: sparse:    struct perf_event_context *
   kernel/events/core.c:8740:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8740:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:12399:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12399:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:12399:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:155:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:163:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c:1404:17: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1431:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2651:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4312:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c:5891:26: sparse: sparse: dereference of noderef expression

vim +5563 kernel/events/core.c

fa7315871046b9 kernel/events/core.c  Peter Zijlstra      2013-09-19  5453  
c1317ec2b90644 kernel/events/core.c  Andy Lutomirski     2014-10-24 @5454  void __weak arch_perf_update_userpage(
c1317ec2b90644 kernel/events/core.c  Andy Lutomirski     2014-10-24  5455  	struct perf_event *event, struct perf_event_mmap_page *userpg, u64 now)
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5456  {
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5457  }
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5458  
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5459  /*
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5460   * Callers need to ensure there can be no nesting of this function, otherwise
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5461   * the seqlock logic goes bad. We can not serialize this because the arch
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5462   * code calls this from NMI context.
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5463   */
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5464  void perf_event_update_userpage(struct perf_event *event)
37d81828385f8f kernel/perf_counter.c Paul Mackerras      2009-03-23  5465  {
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5466  	struct perf_event_mmap_page *userpg;
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5467  	struct ring_buffer *rb;
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5468  	u64 enabled, running, now;
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5469  
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5470  	rcu_read_lock();
5ec4c599a52362 kernel/events/core.c  Peter Zijlstra      2013-08-02  5471  	rb = rcu_dereference(event->rb);
5ec4c599a52362 kernel/events/core.c  Peter Zijlstra      2013-08-02  5472  	if (!rb)
5ec4c599a52362 kernel/events/core.c  Peter Zijlstra      2013-08-02  5473  		goto unlock;
5ec4c599a52362 kernel/events/core.c  Peter Zijlstra      2013-08-02  5474  
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5475  	/*
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5476  	 * compute total_time_enabled, total_time_running
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5477  	 * based on snapshot values taken when the event
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5478  	 * was last scheduled in.
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5479  	 *
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5480  	 * we cannot simply called update_context_time()
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5481  	 * because of locking issue as we can be called in
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5482  	 * NMI context
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5483  	 */
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5484  	calc_timer_values(event, &now, &enabled, &running);
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5485  
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5486  	userpg = rb->user_page;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5487  	/*
9d2dcc8fc66087 kernel/events/core.c  Michael O'Farrell   2018-07-30  5488  	 * Disable preemption to guarantee consistent time stamps are stored to
9d2dcc8fc66087 kernel/events/core.c  Michael O'Farrell   2018-07-30  5489  	 * the user page.
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5490  	 */
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5491  	preempt_disable();
37d81828385f8f kernel/perf_counter.c Paul Mackerras      2009-03-23  5492  	++userpg->lock;
92f22a3865abe8 kernel/perf_counter.c Peter Zijlstra      2009-04-02  5493  	barrier();
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5494  	userpg->index = perf_event_index(event);
b5e58793c7a8ec kernel/perf_event.c   Peter Zijlstra      2010-05-21  5495  	userpg->offset = perf_event_count(event);
365a4038486b57 kernel/events/core.c  Peter Zijlstra      2011-11-21  5496  	if (userpg->index)
e78505958cf123 kernel/perf_event.c   Peter Zijlstra      2010-05-21  5497  		userpg->offset -= local64_read(&event->hw.prev_count);
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5498  
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5499  	userpg->time_enabled = enabled +
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5500  			atomic64_read(&event->child_total_time_enabled);
7f8b4e4e0988da kernel/perf_counter.c Peter Zijlstra      2009-06-22  5501  
0d6412085b7ff5 kernel/events/core.c  Eric B Munson       2011-06-24  5502  	userpg->time_running = running +
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5503  			atomic64_read(&event->child_total_time_running);
7f8b4e4e0988da kernel/perf_counter.c Peter Zijlstra      2009-06-22  5504  
c1317ec2b90644 kernel/events/core.c  Andy Lutomirski     2014-10-24  5505  	arch_perf_update_userpage(event, userpg, now);
e3f3541c19c89a kernel/events/core.c  Peter Zijlstra      2011-11-21  5506  
92f22a3865abe8 kernel/perf_counter.c Peter Zijlstra      2009-04-02  5507  	barrier();
37d81828385f8f kernel/perf_counter.c Paul Mackerras      2009-03-23  5508  	++userpg->lock;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5509  	preempt_enable();
38ff667b321b00 kernel/perf_counter.c Peter Zijlstra      2009-03-30  5510  unlock:
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5511  	rcu_read_unlock();
37d81828385f8f kernel/perf_counter.c Paul Mackerras      2009-03-23  5512  }
82975c46da8275 kernel/events/core.c  Suzuki K Poulose    2018-01-02  5513  EXPORT_SYMBOL_GPL(perf_event_update_userpage);
37d81828385f8f kernel/perf_counter.c Paul Mackerras      2009-03-23  5514  
9e3ed2d7597ccb kernel/events/core.c  Souptick Joarder    2018-05-21  5515  static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5516  {
11bac80004499e kernel/events/core.c  Dave Jiang          2017-02-24  5517  	struct perf_event *event = vmf->vma->vm_file->private_data;
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5518  	struct ring_buffer *rb;
9e3ed2d7597ccb kernel/events/core.c  Souptick Joarder    2018-05-21  5519  	vm_fault_t ret = VM_FAULT_SIGBUS;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5520  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5521  	if (vmf->flags & FAULT_FLAG_MKWRITE) {
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5522  		if (vmf->pgoff == 0)
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5523  			ret = 0;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5524  		return ret;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5525  	}
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5526  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5527  	rcu_read_lock();
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5528  	rb = rcu_dereference(event->rb);
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5529  	if (!rb)
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5530  		goto unlock;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5531  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5532  	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5533  		goto unlock;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5534  
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5535  	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5536  	if (!vmf->page)
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5537  		goto unlock;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5538  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5539  	get_page(vmf->page);
11bac80004499e kernel/events/core.c  Dave Jiang          2017-02-24  5540  	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5541  	vmf->page->index   = vmf->pgoff;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5542  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5543  	ret = 0;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5544  unlock:
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5545  	rcu_read_unlock();
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5546  
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5547  	return ret;
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5548  }
906010b2134e14 kernel/perf_event.c   Peter Zijlstra      2009-09-21  5549  
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5550  static void ring_buffer_attach(struct perf_event *event,
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5551  			       struct ring_buffer *rb)
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5552  {
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5553  	struct ring_buffer *old_rb = NULL;
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5554  	unsigned long flags;
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5555  
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5556  	if (event->rb) {
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5557  		/*
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5558  		 * Should be impossible, we set this when removing
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5559  		 * event->rb_entry and wait/clear when adding event->rb_entry.
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5560  		 */
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5561  		WARN_ON_ONCE(event->rcu_pending);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5562  
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14 @5563  		old_rb = event->rb;
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5564  		spin_lock_irqsave(&old_rb->event_lock, flags);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5565  		list_del_rcu(&event->rb_entry);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5566  		spin_unlock_irqrestore(&old_rb->event_lock, flags);
2f993cf093643b kernel/events/core.c  Oleg Nesterov       2015-05-30  5567  
2f993cf093643b kernel/events/core.c  Oleg Nesterov       2015-05-30  5568  		event->rcu_batches = get_state_synchronize_rcu();
2f993cf093643b kernel/events/core.c  Oleg Nesterov       2015-05-30  5569  		event->rcu_pending = 1;
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5570  	}
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5571  
2f993cf093643b kernel/events/core.c  Oleg Nesterov       2015-05-30  5572  	if (rb) {
2f993cf093643b kernel/events/core.c  Oleg Nesterov       2015-05-30  5573  		if (event->rcu_pending) {
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5574  			cond_synchronize_rcu(event->rcu_batches);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5575  			event->rcu_pending = 0;
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5576  		}
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5577  
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5578  		spin_lock_irqsave(&rb->event_lock, flags);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5579  		list_add_rcu(&event->rb_entry, &rb->event_list);
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5580  		spin_unlock_irqrestore(&rb->event_lock, flags);
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5581  	}
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5582  
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5583  	/*
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5584  	 * Avoid racing with perf_mmap_close(AUX): stop the event
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5585  	 * before swizzling the event::rb pointer; if it's getting
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5586  	 * unmapped, its aux_mmap_count will be 0 and it won't
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5587  	 * restart. See the comment in __perf_pmu_output_stop().
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5588  	 *
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5589  	 * Data will inevitably be lost when set_output is done in
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5590  	 * mid-air, but then again, whoever does it like this is
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5591  	 * not in for the data anyway.
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5592  	 */
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5593  	if (has_aux(event))
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5594  		perf_event_stop(event, 0);
767ae08678c2c7 kernel/events/core.c  Alexander Shishkin  2016-09-06  5595  
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5596  	rcu_assign_pointer(event->rb, rb);
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5597  
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5598  	if (old_rb) {
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5599  		ring_buffer_put(old_rb);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5600  		/*
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5601  		 * Since we detached before setting the new rb, so that we
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5602  		 * could attach the new rb, we could have missed a wakeup.
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5603  		 * Provide it now.
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5604  		 */
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5605  		wake_up_all(&event->waitq);
b69cf53640da2b kernel/events/core.c  Peter Zijlstra      2014-03-14  5606  	}
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5607  }
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5608  
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5609  static void ring_buffer_wakeup(struct perf_event *event)
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5610  {
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5611  	struct ring_buffer *rb;
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5612  
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5613  	rcu_read_lock();
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5614  	rb = rcu_dereference(event->rb);
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra      2013-06-04  5615  	if (rb) {
44b7f4b98d8877 kernel/events/core.c  Will Deacon         2011-12-13  5616  		list_for_each_entry_rcu(event, &rb->event_list, rb_entry)
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5617  			wake_up_all(&event->waitq);
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra      2013-06-04  5618  	}
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5619  	rcu_read_unlock();
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5620  }
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5621  
fdc2670666f40a kernel/events/core.c  Alexander Shishkin  2015-01-14  5622  struct ring_buffer *ring_buffer_get(struct perf_event *event)
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5623  {
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5624  	struct ring_buffer *rb;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5625  
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5626  	rcu_read_lock();
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5627  	rb = rcu_dereference(event->rb);
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5628  	if (rb) {
fecb8ed2ce7010 kernel/events/core.c  Elena Reshetova     2019-01-28  5629  		if (!refcount_inc_not_zero(&rb->refcount))
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5630  			rb = NULL;
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5631  	}
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5632  	rcu_read_unlock();
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5633  
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5634  	return rb;
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5635  }
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5636  
fdc2670666f40a kernel/events/core.c  Alexander Shishkin  2015-01-14  5637  void ring_buffer_put(struct ring_buffer *rb)
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5638  {
fecb8ed2ce7010 kernel/events/core.c  Elena Reshetova     2019-01-28  5639  	if (!refcount_dec_and_test(&rb->refcount))
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra      2010-05-27  5640  		return;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5641  
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra      2013-06-04  5642  	WARN_ON_ONCE(!list_empty(&rb->event_list));
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra      2011-11-26  5643  
76369139ceb955 kernel/events/core.c  Frederic Weisbecker 2011-05-19  5644  	call_rcu(&rb->rcu_head, rb_free_rcu);
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5645  }
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5646  
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5647  static void perf_mmap_open(struct vm_area_struct *vma)
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5648  {
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5649  	struct perf_event *event = vma->vm_file->private_data;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5650  
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar         2009-09-21  5651  	atomic_inc(&event->mmap_count);
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra      2013-06-04 @5652  	atomic_inc(&event->rb->mmap_count);
1e0fb9ec679c92 kernel/events/core.c  Andy Lutomirski     2014-10-24  5653  
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra      2015-01-14  5654  	if (vma->vm_pgoff)
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra      2015-01-14  5655  		atomic_inc(&event->rb->aux_mmap_count);
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra      2015-01-14  5656  
1e0fb9ec679c92 kernel/events/core.c  Andy Lutomirski     2014-10-24  5657  	if (event->pmu->event_mapped)
bfe334924ccd9f kernel/events/core.c  Peter Zijlstra      2017-08-02  5658  		event->pmu->event_mapped(event, vma->vm_mm);
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5659  }
7b732a75047738 kernel/perf_counter.c Peter Zijlstra      2009-03-23  5660  

:::::: The code at line 5563 was first introduced by commit
:::::: b69cf53640da2b86439596118cfa95233154ee76 perf: Fix a race between ring_buffer_detach() and ring_buffer_attach()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
