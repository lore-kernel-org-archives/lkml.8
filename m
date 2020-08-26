Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954202075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:03:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:53823 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHZAv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:51:58 -0400
IronPort-SDR: JpRGeHUMEUkynm70Xv6gtK7nNZkOEaDXv2yqyapddI+HSBD4q2Zl+iVcVxYdUdb8/l+iXxT619
 gZMbFd+tlO4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="136277786"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="gz'50?scan'50,208,50";a="136277786"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 17:25:54 -0700
IronPort-SDR: qZQRlwLm7IN9TgPdVSzLQT0UDzwqpWdwxGKQvX9u8HPgO3/jXJoFNZb49EWolbGL4JHVP0GQte
 ppLDNMJsbfJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="gz'50?scan'50,208,50";a="299291648"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2020 17:25:52 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAjGB-0001Dz-Dk; Wed, 26 Aug 2020 00:25:51 +0000
Date:   Wed, 26 Aug 2020 08:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: include/linux/spinlock_api_smp.h:90:3: error: implicit declaration
 of function 'spin_acquire'; did you mean
Message-ID: <202008260806.fEtZDCnT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   abb3438d69fb6dd5baa4ae23eafbf5b87945eff1
commit: 0cd39f4600ed4de859383018eb10f0f724900e1b locking/seqlock, headers: Untangle the spaghetti monster
date:   3 weeks ago
config: sh-j2_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0cd39f4600ed4de859383018eb10f0f724900e1b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:318,
                    from arch/sh/include/asm/smp.h:11,
                    from include/linux/smp.h:82,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/core.c:9:
   include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
>> include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
      90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~
         |   xchg_acquire
   include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
      90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                     ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irqsave':
   include/linux/spinlock_api_smp.h:110:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     110 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irq':
   include/linux/spinlock_api_smp.h:128:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     128 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
>> include/linux/spinlock_api_smp.h:129:2: error: implicit declaration of function 'LOCK_CONTENDED' [-Werror=implicit-function-declaration]
     129 |  LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
         |  ^~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_bh':
   include/linux/spinlock_api_smp.h:135:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     135 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock':
   include/linux/spinlock_api_smp.h:142:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     142 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock':
>> include/linux/spinlock_api_smp.h:150:2: error: implicit declaration of function 'spin_release'; did you mean 'xchg_release'? [-Werror=implicit-function-declaration]
     150 |  spin_release(&lock->dep_map, _RET_IP_);
         |  ^~~~~~~~~~~~
         |  xchg_release
   include/linux/spinlock_api_smp.h:150:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     150 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_irqrestore':
   include/linux/spinlock_api_smp.h:158:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     158 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_irq':
   include/linux/spinlock_api_smp.h:166:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     166 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_bh':
   include/linux/spinlock_api_smp.h:174:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     174 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock_bh':
   include/linux/spinlock_api_smp.h:183:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     183 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                     ^~
   In file included from include/linux/spinlock_api_smp.h:190,
                    from include/linux/spinlock.h:318,
                    from arch/sh/include/asm/smp.h:11,
                    from include/linux/smp.h:82,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/core.c:9:
   include/linux/rwlock_api_smp.h: In function '__raw_read_trylock':
>> include/linux/rwlock_api_smp.h:121:3: error: implicit declaration of function 'rwlock_acquire_read' [-Werror=implicit-function-declaration]
     121 |   rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:121:28: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     121 |   rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
         |                            ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_trylock':
>> include/linux/rwlock_api_smp.h:132:3: error: implicit declaration of function 'rwlock_acquire' [-Werror=implicit-function-declaration]
     132 |   rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:132:23: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     132 |   rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                       ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock':
   include/linux/rwlock_api_smp.h:149:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     149 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:150:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     150 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:150:23: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/rwlock_api_smp.h:150:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     150 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_irqsave':
   include/linux/rwlock_api_smp.h:159:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     159 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
>> include/linux/rwlock_api_smp.h:160:2: error: implicit declaration of function 'LOCK_CONTENDED_FLAGS' [-Werror=implicit-function-declaration]
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:160:29: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |                             ^~~~~~~~~~~~~~~~~~~
         |                             _raw_read_trylock
   include/linux/rwlock_api_smp.h:160:50: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |                                                  ^~~~~~~~~~~~~~~~
         |                                                  _raw_read_lock
>> include/linux/rwlock_api_smp.h:161:9: error: 'do_raw_read_lock_flags' undeclared (first use in this function); did you mean 'do_raw_spin_lock_flags'?
     161 |         do_raw_read_lock_flags, &flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         do_raw_spin_lock_flags
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_irq':
   include/linux/rwlock_api_smp.h:169:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     169 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:170:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     170 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:170:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     170 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_bh':
   include/linux/rwlock_api_smp.h:176:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     176 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:177:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     177 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:177:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     177 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_irqsave':
   include/linux/rwlock_api_smp.h:186:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     186 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:187:29: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     187 |  LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
         |                             ^~~~~~~~~~~~~~~~~~~~
         |                             _raw_write_trylock
   include/linux/rwlock_api_smp.h:187:51: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     187 |  LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
         |                                                   ^~~~~~~~~~~~~~~~~
         |                                                   _raw_write_lock
>> include/linux/rwlock_api_smp.h:188:9: error: 'do_raw_write_lock_flags' undeclared (first use in this function); did you mean 'do_raw_spin_lock_flags'?
     188 |         do_raw_write_lock_flags, &flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         do_raw_spin_lock_flags
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_irq':
   include/linux/rwlock_api_smp.h:196:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     196 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:197:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     197 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:197:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     197 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_bh':
   include/linux/rwlock_api_smp.h:203:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     203 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:204:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     204 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:204:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     204 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock':
   include/linux/rwlock_api_smp.h:210:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     210 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:211:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     211 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:211:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     211 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock':
>> include/linux/rwlock_api_smp.h:218:2: error: implicit declaration of function 'rwlock_release' [-Werror=implicit-function-declaration]
     218 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |  ^~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:218:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     218 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock':
   include/linux/rwlock_api_smp.h:225:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     225 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_irqrestore':
   include/linux/rwlock_api_smp.h:233:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     233 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_irq':
   include/linux/rwlock_api_smp.h:241:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     241 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_bh':
   include/linux/rwlock_api_smp.h:249:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     249 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_irqrestore':
   include/linux/rwlock_api_smp.h:257:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     257 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_irq':
   include/linux/rwlock_api_smp.h:265:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     265 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_bh':
   include/linux/rwlock_api_smp.h:273:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     273 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   kernel//sched/core.c: At top level:
   kernel//sched/core.c:2111:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    2111 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/spinlock.h:318,
                    from arch/sh/include/asm/smp.h:11,
                    from include/linux/smp.h:82,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/loadavg.c:9:
   include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
>> include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
      90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~
         |   xchg_acquire
   include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
      90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                     ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irqsave':
   include/linux/spinlock_api_smp.h:110:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     110 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irq':
   include/linux/spinlock_api_smp.h:128:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     128 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
>> include/linux/spinlock_api_smp.h:129:2: error: implicit declaration of function 'LOCK_CONTENDED' [-Werror=implicit-function-declaration]
     129 |  LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
         |  ^~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_bh':
   include/linux/spinlock_api_smp.h:135:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     135 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock':
   include/linux/spinlock_api_smp.h:142:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     142 |  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock':
>> include/linux/spinlock_api_smp.h:150:2: error: implicit declaration of function 'spin_release'; did you mean 'xchg_release'? [-Werror=implicit-function-declaration]
     150 |  spin_release(&lock->dep_map, _RET_IP_);
         |  ^~~~~~~~~~~~
         |  xchg_release
   include/linux/spinlock_api_smp.h:150:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     150 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_irqrestore':
   include/linux/spinlock_api_smp.h:158:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     158 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_irq':
   include/linux/spinlock_api_smp.h:166:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     166 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_unlock_bh':
   include/linux/spinlock_api_smp.h:174:20: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     174 |  spin_release(&lock->dep_map, _RET_IP_);
         |                    ^~
   include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock_bh':
   include/linux/spinlock_api_smp.h:183:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
     183 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                     ^~
   In file included from include/linux/spinlock_api_smp.h:190,
                    from include/linux/spinlock.h:318,
                    from arch/sh/include/asm/smp.h:11,
                    from include/linux/smp.h:82,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/loadavg.c:9:
   include/linux/rwlock_api_smp.h: In function '__raw_read_trylock':
>> include/linux/rwlock_api_smp.h:121:3: error: implicit declaration of function 'rwlock_acquire_read' [-Werror=implicit-function-declaration]
     121 |   rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:121:28: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     121 |   rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
         |                            ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_trylock':
>> include/linux/rwlock_api_smp.h:132:3: error: implicit declaration of function 'rwlock_acquire' [-Werror=implicit-function-declaration]
     132 |   rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |   ^~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:132:23: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     132 |   rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
         |                       ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock':
   include/linux/rwlock_api_smp.h:149:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     149 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:150:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     150 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:150:23: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/rwlock_api_smp.h:150:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     150 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_irqsave':
   include/linux/rwlock_api_smp.h:159:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     159 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
>> include/linux/rwlock_api_smp.h:160:2: error: implicit declaration of function 'LOCK_CONTENDED_FLAGS' [-Werror=implicit-function-declaration]
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:160:29: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |                             ^~~~~~~~~~~~~~~~~~~
         |                             _raw_read_trylock
   include/linux/rwlock_api_smp.h:160:50: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     160 |  LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
         |                                                  ^~~~~~~~~~~~~~~~
         |                                                  _raw_read_lock
>> include/linux/rwlock_api_smp.h:161:9: error: 'do_raw_read_lock_flags' undeclared (first use in this function); did you mean 'do_raw_spin_lock_flags'?
     161 |         do_raw_read_lock_flags, &flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         do_raw_spin_lock_flags
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_irq':
   include/linux/rwlock_api_smp.h:169:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     169 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:170:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     170 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:170:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     170 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_read_lock_bh':
   include/linux/rwlock_api_smp.h:176:27: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     176 |  rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
         |                           ^~
   include/linux/rwlock_api_smp.h:177:23: error: 'do_raw_read_trylock' undeclared (first use in this function); did you mean '_raw_read_trylock'?
     177 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       _raw_read_trylock
   include/linux/rwlock_api_smp.h:177:44: error: 'do_raw_read_lock' undeclared (first use in this function); did you mean '_raw_read_lock'?
     177 |  LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
         |                                            ^~~~~~~~~~~~~~~~
         |                                            _raw_read_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_irqsave':
   include/linux/rwlock_api_smp.h:186:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     186 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:187:29: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     187 |  LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
         |                             ^~~~~~~~~~~~~~~~~~~~
         |                             _raw_write_trylock
   include/linux/rwlock_api_smp.h:187:51: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     187 |  LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
         |                                                   ^~~~~~~~~~~~~~~~~
         |                                                   _raw_write_lock
>> include/linux/rwlock_api_smp.h:188:9: error: 'do_raw_write_lock_flags' undeclared (first use in this function); did you mean 'do_raw_spin_lock_flags'?
     188 |         do_raw_write_lock_flags, &flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         do_raw_spin_lock_flags
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_irq':
   include/linux/rwlock_api_smp.h:196:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     196 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:197:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     197 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:197:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     197 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock_bh':
   include/linux/rwlock_api_smp.h:203:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     203 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:204:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     204 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:204:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     204 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_lock':
   include/linux/rwlock_api_smp.h:210:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     210 |  rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h:211:23: error: 'do_raw_write_trylock' undeclared (first use in this function); did you mean '_raw_write_trylock'?
     211 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       _raw_write_trylock
   include/linux/rwlock_api_smp.h:211:45: error: 'do_raw_write_lock' undeclared (first use in this function); did you mean '_raw_write_lock'?
     211 |  LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
         |                                             ^~~~~~~~~~~~~~~~~
         |                                             _raw_write_lock
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock':
>> include/linux/rwlock_api_smp.h:218:2: error: implicit declaration of function 'rwlock_release' [-Werror=implicit-function-declaration]
     218 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |  ^~~~~~~~~~~~~~
   include/linux/rwlock_api_smp.h:218:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     218 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock':
   include/linux/rwlock_api_smp.h:225:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     225 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_irqrestore':
   include/linux/rwlock_api_smp.h:233:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     233 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_irq':
   include/linux/rwlock_api_smp.h:241:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     241 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_read_unlock_bh':
   include/linux/rwlock_api_smp.h:249:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     249 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_irqrestore':
   include/linux/rwlock_api_smp.h:257:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     257 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_irq':
   include/linux/rwlock_api_smp.h:265:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     265 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   include/linux/rwlock_api_smp.h: In function '__raw_write_unlock_bh':
   include/linux/rwlock_api_smp.h:273:22: error: 'rwlock_t' {aka 'struct <anonymous>'} has no member named 'dep_map'
     273 |  rwlock_release(&lock->dep_map, _RET_IP_);
         |                      ^~
   cc1: some warnings being treated as errors
..

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cd39f4600ed4de859383018eb10f0f724900e1b
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 0cd39f4600ed4de859383018eb10f0f724900e1b
vim +90 include/linux/spinlock_api_smp.h

892a7c67c12da63 Heiko Carstens  2009-08-31   85  
9c1721aa4994f66 Thomas Gleixner 2009-12-03   86  static inline int __raw_spin_trylock(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31   87  {
69d0ee7377eef80 Heiko Carstens  2009-08-31   88  	preempt_disable();
9828ea9d75c38fe Thomas Gleixner 2009-12-03   89  	if (do_raw_spin_trylock(lock)) {
69d0ee7377eef80 Heiko Carstens  2009-08-31  @90  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
69d0ee7377eef80 Heiko Carstens  2009-08-31   91  		return 1;
69d0ee7377eef80 Heiko Carstens  2009-08-31   92  	}
69d0ee7377eef80 Heiko Carstens  2009-08-31   93  	preempt_enable();
69d0ee7377eef80 Heiko Carstens  2009-08-31   94  	return 0;
69d0ee7377eef80 Heiko Carstens  2009-08-31   95  }
69d0ee7377eef80 Heiko Carstens  2009-08-31   96  
69d0ee7377eef80 Heiko Carstens  2009-08-31   97  /*
69d0ee7377eef80 Heiko Carstens  2009-08-31   98   * If lockdep is enabled then we use the non-preemption spin-ops
27972765bd0410f Thomas Gleixner 2019-07-26   99   * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
69d0ee7377eef80 Heiko Carstens  2009-08-31  100   * not re-enabled during lock-acquire (which the preempt-spin-ops do):
69d0ee7377eef80 Heiko Carstens  2009-08-31  101   */
69d0ee7377eef80 Heiko Carstens  2009-08-31  102  #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
69d0ee7377eef80 Heiko Carstens  2009-08-31  103  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  104  static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31  105  {
69d0ee7377eef80 Heiko Carstens  2009-08-31  106  	unsigned long flags;
69d0ee7377eef80 Heiko Carstens  2009-08-31  107  
69d0ee7377eef80 Heiko Carstens  2009-08-31  108  	local_irq_save(flags);
69d0ee7377eef80 Heiko Carstens  2009-08-31  109  	preempt_disable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  110  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
69d0ee7377eef80 Heiko Carstens  2009-08-31  111  	/*
69d0ee7377eef80 Heiko Carstens  2009-08-31  112  	 * On lockdep we dont want the hand-coded irq-enable of
9828ea9d75c38fe Thomas Gleixner 2009-12-03  113  	 * do_raw_spin_lock_flags() code, because lockdep assumes
69d0ee7377eef80 Heiko Carstens  2009-08-31  114  	 * that interrupts are not re-enabled during lock-acquire:
69d0ee7377eef80 Heiko Carstens  2009-08-31  115  	 */
69d0ee7377eef80 Heiko Carstens  2009-08-31  116  #ifdef CONFIG_LOCKDEP
9828ea9d75c38fe Thomas Gleixner 2009-12-03  117  	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31  118  #else
9828ea9d75c38fe Thomas Gleixner 2009-12-03  119  	do_raw_spin_lock_flags(lock, &flags);
69d0ee7377eef80 Heiko Carstens  2009-08-31  120  #endif
69d0ee7377eef80 Heiko Carstens  2009-08-31  121  	return flags;
69d0ee7377eef80 Heiko Carstens  2009-08-31  122  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  123  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  124  static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31  125  {
69d0ee7377eef80 Heiko Carstens  2009-08-31  126  	local_irq_disable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  127  	preempt_disable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  128  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
9828ea9d75c38fe Thomas Gleixner 2009-12-03 @129  	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31  130  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  131  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  132  static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31  133  {
9ea4c380066fbe2 Peter Zijlstra  2013-11-19  134  	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
69d0ee7377eef80 Heiko Carstens  2009-08-31  135  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
9828ea9d75c38fe Thomas Gleixner 2009-12-03  136  	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31  137  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  138  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  139  static inline void __raw_spin_lock(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31  140  {
69d0ee7377eef80 Heiko Carstens  2009-08-31  141  	preempt_disable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  142  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
9828ea9d75c38fe Thomas Gleixner 2009-12-03  143  	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31  144  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  145  
ae58403f15888da Chen Gang       2013-06-19  146  #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
69d0ee7377eef80 Heiko Carstens  2009-08-31  147  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  148  static inline void __raw_spin_unlock(raw_spinlock_t *lock)
69d0ee7377eef80 Heiko Carstens  2009-08-31  149  {
5facae4f3549b5c Qian Cai        2019-09-19 @150  	spin_release(&lock->dep_map, _RET_IP_);
9828ea9d75c38fe Thomas Gleixner 2009-12-03  151  	do_raw_spin_unlock(lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31  152  	preempt_enable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  153  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  154  

:::::: The code at line 90 was first introduced by commit
:::::: 69d0ee7377eef808e34ba5542b554ec97244b871 locking: Move spinlock function bodies to header file

:::::: TO: Heiko Carstens <heiko.carstens@de.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZPt4rx8FFjLCG7dd--
