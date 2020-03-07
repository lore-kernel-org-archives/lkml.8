Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E254AC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E22070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgCGKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:32:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:25512 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgCGKcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:32:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 02:32:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="442223560"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2020 02:31:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAWkO-0007A5-T3; Sat, 07 Mar 2020 18:31:56 +0800
Date:   Sat, 7 Mar 2020 18:31:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202003071817.YoAjfxH6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63849c8f410717eb2e6662f3953ff674727303e7
commit: 913292c97d750fe4188b4f5aa770e5e0ca1e5a91 sched.h: Annotate sighand_struct with __rcu
date:   6 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-174-g094d5a94-dirty
        git checkout 913292c97d750fe4188b4f5aa770e5e0ca1e5a91
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/ptrace.c:53:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:53:22: sparse:    struct task_struct *
   kernel/ptrace.c:53:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:72:23: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct task_struct [noderef] <asn:4> *parent @@    got  [noderef] <asn:4> *parent @@
   kernel/ptrace.c:72:23: sparse:    expected struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:72:23: sparse:    got struct task_struct *new_parent
   kernel/ptrace.c:73:29: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cred const [noderef] <asn:4> *ptracer_cred @@    got [noderef] <asn:4> *ptracer_cred @@
   kernel/ptrace.c:73:29: sparse:    expected struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:73:29: sparse:    got struct cred const *
   kernel/ptrace.c:127:18: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cred const *old_cred @@    got struct cred const struct cred const *old_cred @@
   kernel/ptrace.c:127:18: sparse:    expected struct cred const *old_cred
   kernel/ptrace.c:127:18: sparse:    got struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:131:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:131:25: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:131:25: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:169:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:169:27: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:169:27: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:181:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:181:28: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:181:28: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:186:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:186:30: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:186:30: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:196:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:196:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:196:9: sparse:    struct task_struct *
   kernel/ptrace.c:241:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:241:44: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:241:44: sparse:    struct task_struct *
   kernel/ptrace.c:416:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:416:24: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:416:24: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:439:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:439:26: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:439:26: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:475:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *parent @@    got struct task_structstruct task_struct *parent @@
   kernel/ptrace.c:475:54: sparse:    expected struct task_struct *parent
   kernel/ptrace.c:475:54: sparse:    got struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:483:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct task_struct *new_parent @@    got struct task_structstruct task_struct *new_parent @@
   kernel/ptrace.c:483:53: sparse:    expected struct task_struct *new_parent
   kernel/ptrace.c:483:53: sparse:    got struct task_struct [noderef] <asn:4> *real_parent
   kernel/ptrace.c:531:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *p1 @@    got struct task_structstruct task_struct *p1 @@
   kernel/ptrace.c:531:41: sparse:    expected struct task_struct *p1
   kernel/ptrace.c:531:41: sparse:    got struct task_struct [noderef] <asn:4> *real_parent
   kernel/ptrace.c:533:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct sighand_struct *sigh @@    got struct sighand_strstruct sighand_struct *sigh @@
   kernel/ptrace.c:533:50: sparse:    expected struct sighand_struct *sigh
   kernel/ptrace.c:533:50: sparse:    got struct sighand_struct [noderef] <asn:4> *sighand
   kernel/ptrace.c:735:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:735:37: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:735:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:743:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:743:39: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:743:39: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:848:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:848:37: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:848:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:852:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:852:39: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:852:39: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:1082:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:1082:37: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1082:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:1084:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/ptrace.c:1084:39: sparse:    expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1084:39: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:481:38: sparse: sparse: dereference of noderef expression
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:682:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/ptrace.c:698:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:854:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
--
   kernel/signal.c:2058:17: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct sighand_struct *sighand @@    got struct sighand_strstruct sighand_struct *sighand @@
   kernel/signal.c:2058:17: sparse:    expected struct sighand_struct *sighand
   kernel/signal.c:2058:17: sparse:    got struct sighand_struct [noderef] <asn:4> *sighand
   kernel/signal.c:2133:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2133:41: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2133:41: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2135:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2135:39: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2135:39: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2183:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2183:33: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2183:33: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2238:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2238:31: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2238:31: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2272:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2272:31: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2272:31: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2274:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2274:33: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2274:33: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2371:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2371:41: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2371:41: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2456:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2456:41: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2456:41: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2468:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2468:33: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2468:33: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2506:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *tsk @@    got struct task_structstruct task_struct *tsk @@
   kernel/signal.c:2506:52: sparse:    expected struct task_struct *tsk
   kernel/signal.c:2506:52: sparse:    got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2508:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile *p @@    got struct cred const [noderef] <asn:4>void const volatile *p @@
   kernel/signal.c:2508:49: sparse:    expected void const volatile *p
   kernel/signal.c:2508:49: sparse:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:2508:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile *p @@    got struct cred const [noderef] <asn:4>void const volatile *p @@
   kernel/signal.c:2508:49: sparse:    expected void const volatile *p
   kernel/signal.c:2508:49: sparse:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:2523:49: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct sighand_struct *sighand @@    got struct sighand_strstruct sighand_struct *sighand @@
   kernel/signal.c:2523:49: sparse:    expected struct sighand_struct *sighand
   kernel/signal.c:2523:49: sparse:    got struct sighand_struct [noderef] <asn:4> *sighand
   kernel/signal.c:2827:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2827:27: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2827:27: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2847:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2847:29: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2847:29: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2914:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2914:27: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2914:27: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:2916:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:2916:29: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:2916:29: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3067:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3067:31: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3067:31: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3070:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3070:33: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3070:33: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3453:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3453:27: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3453:27: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3465:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3465:37: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3465:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3470:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3470:35: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3470:35: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3475:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3475:29: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3475:29: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3676:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct siginfo const [noderef] [usertype] <asn:1> *from @@    got deref] [usertype] <asn:1> *from @@
   kernel/signal.c:3676:46: sparse:    expected struct siginfo const [noderef] [usertype] <asn:1> *from
   kernel/signal.c:3676:46: sparse:    got struct siginfo [usertype] *info
   kernel/signal.c:3928:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3928:31: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3928:31: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3940:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3940:33: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3940:33: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3958:11: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct k_sigaction *k @@    got struct k_sigactionstruct k_sigaction *k @@
   kernel/signal.c:3958:11: sparse:    expected struct k_sigaction *k
   kernel/signal.c:3958:11: sparse:    got struct k_sigaction [noderef] <asn:4> *
   kernel/signal.c:3960:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3960:25: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3960:25: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:3990:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/signal.c:3990:27: sparse:    expected struct spinlock [usertype] *lock
   kernel/signal.c:3990:27: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c:523:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:551:52: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1025:13: sparse: sparse: dereference of noderef expression
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct wait_queue_head *wq_head @@    got struct wait_queue_struct wait_queue_head *wq_head @@
   include/linux/signalfd.h:21:13: sparse:    expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:    got struct wait_queue_head [noderef] <asn:4> *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct wait_queue_head *wq_head @@    got struct wait_queue_struct wait_queue_head *wq_head @@
   include/linux/signalfd.h:22:17: sparse:    expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:    got struct wait_queue_head [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:1289:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   include/linux/rcupdate.h:669:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/signal.c:1645:35: sparse: sparse: dereference of noderef expression
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct wait_queue_head *wq_head @@    got struct wait_queue_struct wait_queue_head *wq_head @@
   include/linux/signalfd.h:21:13: sparse:    expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:    got struct wait_queue_head [noderef] <asn:4> *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct wait_queue_head *wq_head @@    got struct wait_queue_struct wait_queue_head *wq_head @@
   include/linux/signalfd.h:22:17: sparse:    expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:    got struct wait_queue_head [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
   include/linux/rcupdate.h:667:9: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:1929:47: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1949:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1949:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1949:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1949:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2088:13: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *p1 @@    got struct task_structstruct task_struct *p1 @@
   include/linux/ptrace.h:99:40: sparse:    expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:    got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct task_struct *p2 @@    got struct task_structstruct task_struct *p2 @@
   include/linux/ptrace.h:99:60: sparse:    expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:    got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2299:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2508:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2508:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2508:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2508:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:99:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *p1 @@    got struct task_structstruct task_struct *p1 @@
   include/linux/ptrace.h:99:40: sparse:    expected struct task_struct *p1
   include/linux/ptrace.h:99:40: sparse:    got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:99:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct task_struct *p2 @@    got struct task_structstruct task_struct *p2 @@
   include/linux/ptrace.h:99:60: sparse:    expected struct task_struct *p2
   include/linux/ptrace.h:99:60: sparse:    got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2591:69: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c:3736:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct siginfo [usertype] *info @@    got struct siginfo [nostruct siginfo [usertype] *info @@
   kernel/signal.c:3736:58: sparse:    expected struct siginfo [usertype] *info
   kernel/signal.c:3736:58: sparse:    got struct siginfo [noderef] [usertype] <asn:1> *info
   kernel/signal.c:3929:33: sparse: sparse: dereference of noderef expression
--
   kernel/sys.c:1864:19: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct file [noderef] <asn:4> *__ret @@    got file [noderef] <asn:4> *__ret @@
   kernel/sys.c:1864:19: sparse:    expected struct file [noderef] <asn:4> *__ret
   kernel/sys.c:1864:19: sparse:    got struct file *[assigned] file
   kernel/sys.c:1864:17: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct file *old_exe @@    got struct file [noderef] <asn:4>struct file *old_exe @@
   kernel/sys.c:1864:17: sparse:    expected struct file *old_exe
   kernel/sys.c:1864:17: sparse:    got struct file [noderef] <asn:4> *[assigned] __ret
   kernel/sys.c:1035:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct task_struct *p1 @@    got struct task_structstruct task_struct *p1 @@
   kernel/sys.c:1035:32: sparse:    expected struct task_struct *p1
   kernel/sys.c:1035:32: sparse:    got struct task_struct [noderef] <asn:4> *real_parent
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
--
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
--
   kernel/time/posix-cpu-timers.c:42:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/time/posix-cpu-timers.c:42:28: sparse:    expected struct spinlock [usertype] *lock
   kernel/time/posix-cpu-timers.c:42:28: sparse:    got struct spinlock [noderef] <asn:4> *
   kernel/time/posix-cpu-timers.c:44:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   kernel/time/posix-cpu-timers.c:44:30: sparse:    expected struct spinlock [usertype] *lock
   kernel/time/posix-cpu-timers.c:44:30: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *
>> include/linux/sched/signal.h:681:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct spinlock [usertype] *lock @@    got struct struct spinlock [usertype] *lock @@
   include/linux/sched/signal.h:681:37: sparse:    expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:681:37: sparse:    got struct spinlock [noderef] <asn:4> *

vim +681 include/linux/sched/signal.h

c3edc4010e9d10 Ingo Molnar  2017-02-02  677  
9e9291c71eb92b Andrei Vagin 2019-05-14  678  static inline void unlock_task_sighand(struct task_struct *task,
c3edc4010e9d10 Ingo Molnar  2017-02-02  679  						unsigned long *flags)
c3edc4010e9d10 Ingo Molnar  2017-02-02  680  {
9e9291c71eb92b Andrei Vagin 2019-05-14 @681  	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
c3edc4010e9d10 Ingo Molnar  2017-02-02  682  }
c3edc4010e9d10 Ingo Molnar  2017-02-02  683  

:::::: The code at line 681 was first introduced by commit
:::::: 9e9291c71eb92b457eb798501e210dec3d12e795 include/linux/sched/signal.h: replace `tsk' with `task'

:::::: TO: Andrei Vagin <avagin@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
