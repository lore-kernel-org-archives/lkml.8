Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D772C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A70120780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585575186;
	bh=AWCwbSmbMmPGG3lTZPuqLmtVqyP+ZskXKYbCewm9lxo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tDOePjqa2HteCiLY+L9Ky6ab8ZYEwkxF3ThKdUDi5IEyoN3rl8Y6CHOFY3LkLm89/
	 DxTZVglmIOR99hsYdvedFdegYtHkoXDyAWB94g4yT4u3MbPVWCwcbrSAtP8zL4G+eB
	 Vfo5ozyHxnnqO5Vrj27jjJGI9qcxllAfQY0b4yWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgC3NdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:33:05 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33657 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgC3NdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:33:05 -0400
Received: by mail-wr1-f45.google.com with SMTP id a25so21693375wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zcsN5JCL8b5sRJxnTkUoCqlh6U9596f+R0yHjJpBfeY=;
        b=NtZtGuuWW82zHtm+dgGaiugyeRMLcjaNAS+KrH31EG/CyU0vWXeg9AhHepxXDZjcIx
         ItfxiUAVrXPV0UXFcWzVoC6HyGXQqsOquWI4Bz8RSJKL3NIyNi2M+VwUcUeTYLnNCY3B
         21IeH8GTAOpKtJF8BnQDOfjiozC899oyJQojQJb2VvgkPk+Mw43IofB602ZmWMVEUspB
         ZTaBIZeR8lZD7hr4KsY7oAShwwYRC5x2xk4Ocx/xrcRaxIKeS1FKU5AQPNZjXfEd+DLn
         mo9wFL1wRDlBweNFM1LqMRS3+Hfd/9zR9ry8bAnfxgS4Ude3PtFO3Xe9bEh4Pz79CZGx
         IiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=zcsN5JCL8b5sRJxnTkUoCqlh6U9596f+R0yHjJpBfeY=;
        b=lWVASVMwI71u6QqR+JlRRcABhQJZYp9tuPn8PLHh1PHG2cydxjQMJHvb18UScEZK7j
         o9Te50QlKVfGRudpK0w8XLTLVE5pUQGAn5bH52ktKknOcNFhIJ7hVZ/ni9RUQ5sFBjFi
         bLf/SasZFMdSX5LznuPvJAHZ6+ZHeGnFAiO8SbYyO2W1+zCvFf+fdvfi5egoCu9O+4jD
         UxERPGqYkBG1PihdRWJuvWizFI4YzqT+IJHhWr5VCmuxnyJP2fi09R345q9LgdQNMId1
         qJgEh2QmKANIiI6g3d57pQlm6/4SshxL1HbO32HjLhyAQpmbFUe0p7JpKpqObib9o7r6
         3olg==
X-Gm-Message-State: ANhLgQ15lEcar8zYoIq7T3Ne8LX5H7yHMzR/CW//a34Wmo5yBpB9J/NL
        0ulMkv1c90P5Sbz3Nn3MIDXfrAzJ
X-Google-Smtp-Source: ADFU+vtyIOiZqaCNk75opwhMFG+rRdtri4G3F0aQ68BCs/AZTL3TxYLD8TfQuvoMdT/FEdevOb2iwQ==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr14503110wrn.240.1585575182437;
        Mon, 30 Mar 2020 06:33:02 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p10sm22785319wrm.6.2020.03.30.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:33:01 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:32:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v5.7
Message-ID: <20200330133259.GA113676@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: baf5fe761846815164753d1bd0638fd3696db8fd Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The main changes in this cycle were:

 - Make kfree_rcu() use kfree_bulk() for added performance
 - RCU updates
 - Callback-overload handling updates
 - Tasks-RCU KCSAN and sparse updates
 - Locking torture test and RCU torture test updates
 - Documentation updates
 - Miscellaneous fixes

 Thanks,

	Ingo

------------------>
Amol Grover (1):
      rculist: Add brackets around cond argument in __list_check_rcu macro

Colin Ian King (1):
      rcu: Fix spelling mistake "leval" -> "level"

Eric Dumazet (1):
      timer: Use hlist_unhashed_lockless() in timer_pending()

Joel Fernandes (Google) (2):
      rcuperf: Measure memory footprint during kfree_rcu() test
      doc: Add some more RCU list patterns in the kernel

Jules Irenge (4):
      rcu: Add missing annotation for rcu_nocb_bypass_lock()
      rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()
      rcu: Add missing annotation for exit_tasks_rcu_start()
      rcu: Add missing annotation for exit_tasks_rcu_finish()

Madhuparna Bhowmik (1):
      nfs: Fix nfs_access_get_cached_rcu() sparse error

Paul E. McKenney (54):
      rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf
      rcu: Fix exp_funnel_lock()/rcu_exp_wait_wake() datarace
      rcu: Provide debug symbols and line numbers in KCSAN runs
      rcu: Add WRITE_ONCE() to rcu_node ->qsmask update
      rcu: Add WRITE_ONCE to rcu_node ->exp_seq_rq store
      rcu: Add READ_ONCE() to rcu_node ->gp_seq
      rcu: Add WRITE_ONCE() to rcu_state ->gp_req_activity
      rcu: Add WRITE_ONCE() to rcu_node ->qsmaskinitnext
      locking/rtmutex: rcu: Add WRITE_ONCE() to rt_mutex ->owner
      rcu: Add READ_ONCE() to rcu_segcblist ->tails[]
      rcu: Add *_ONCE() for grace-period progress indicators
      rcu: Add READ_ONCE() to rcu_data ->gpwrap
      rcu: Add *_ONCE() to rcu_data ->rcu_forced_tick
      rcu: Add *_ONCE() to rcu_node ->boost_kthread_status
      rcu: Remove dead code from rcu_segcblist_insert_pend_cbs()
      rcu: Add WRITE_ONCE() to rcu_state ->gp_start
      rcu: Fix rcu_barrier_callback() race condition
      rcu: Don't flag non-starting GPs before GP kthread is running
      rcu: Optimize and protect atomic_cmpxchg() loop
      rcu: Tighten rcu_lockdep_assert_cblist_protected() check
      rcu: Make nocb_gp_wait() double-check unexpected-callback warning
      locktorture: Print ratio of acquisitions, not failures
      locktorture: Allow CPU-hotplug to be disabled via --bootargs
      locktorture: Use private random-number generators
      locktorture: Forgive apparent unfairness if CPU hotplug
      rcu: Clear ->core_needs_qs at GP end or self-reported QS
      rcu: React to callback overload by aggressively seeking quiescent states
      rcu: React to callback overload by boosting RCU readers
      rcu: Update __call_rcu() comments
      rcu-tasks: *_ONCE() for rcu_tasks_cbs_head
      srcu: Fix __call_srcu()/process_srcu() datarace
      srcu: Fix __call_srcu()/srcu_get_delay() datarace
      srcu: Fix process_srcu()/srcu_batches_completed() datarace
      srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq
      rcutorture: Suppress forward-progress complaints during early boot
      torture: Make results-directory date format completion-friendly
      rcutorture: Refrain from callback flooding during boot
      torture: Forgive -EBUSY from boottime CPU-hotplug operations
      rcutorture: Allow boottime stall warnings to be suppressed
      rcutorture: Suppress boottime bad-sequence warnings
      torture: Allow disabling of boottime CPU-hotplug torture operations
      rcutorture: Add 100-CPU configuration
      rcutorture: Summarize summary of build and run results
      rcutorture: Make kvm-find-errors.sh abort on bad directory
      rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race
      rcutorture: Fix stray access to rcu_fwd_cb_nodelay
      rcutorture: Add READ_ONCE() to rcu_torture_count and rcu_torture_batch
      rcutorture: Annotation lockless accesses to rcu_torture_current
      rcutorture: Make rcu_torture_barrier_cbs() post from corresponding CPU
      rcutorture: Manually clean up after rcu_barrier() failure
      rcutorture: Set KCSAN Kconfig options to detect more data races
      doc: Add rcutorture scripting to torture.txt
      rcu: Mark rcu_state.gp_seq to detect concurrent writes
      rcu: Make rcu_barrier() account for offline no-CBs CPUs

SeongJae Park (8):
      rcu: Fix typos in file-header comments
      doc/RCU/Design: Remove remaining HTML tags in ReST files
      doc/RCU/listRCU: Fix typos in a example code snippets
      doc/RCU/listRCU: Update example function name
      doc/RCU/rcu: Use ':ref:' for links to other docs
      doc/RCU/rcu: Use absolute paths for non-rst files
      doc/RCU/rcu: Use https instead of http if possible
      Documentation/memory-barriers: Fix typos

Uladzislau Rezki (Sony) (2):
      rcu: Support kfree_bulk() interface in kfree_rcu()
      rcu: Add a trace event for kfree_rcu() use of kfree_bulk()


 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   8 +-
 Documentation/RCU/listRCU.rst                      | 281 ++++++++++---
 Documentation/RCU/rcu.rst                          |  18 +-
 Documentation/RCU/torture.txt                      | 147 ++++++-
 Documentation/admin-guide/kernel-parameters.txt    |  19 +
 Documentation/memory-barriers.txt                  |   8 +-
 fs/nfs/dir.c                                       |   2 +-
 include/linux/rculist.h                            |   4 +-
 include/linux/rcutiny.h                            |   1 +
 include/linux/rcutree.h                            |   1 +
 include/linux/timer.h                              |   2 +-
 include/trace/events/rcu.h                         |  29 ++
 kernel/locking/locktorture.c                       |  15 +-
 kernel/locking/rtmutex.c                           |   2 +-
 kernel/rcu/Makefile                                |   4 +
 kernel/rcu/rcu.h                                   |  23 +-
 kernel/rcu/rcu_segcblist.c                         |   4 +-
 kernel/rcu/rcuperf.c                               |  14 +-
 kernel/rcu/rcutorture.c                            |  67 ++-
 kernel/rcu/srcutree.c                              |  18 +-
 kernel/rcu/tree.c                                  | 452 +++++++++++++++------
 kernel/rcu/tree.h                                  |   4 +
 kernel/rcu/tree_exp.h                              |  13 +-
 kernel/rcu/tree_plugin.h                           |  25 +-
 kernel/rcu/tree_stall.h                            |  41 +-
 kernel/rcu/update.c                                |  28 +-
 kernel/time/timer.c                                |   7 +-
 kernel/torture.c                                   |  29 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |   2 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  17 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   2 +-
 .../selftests/rcutorture/configs/rcu/CFcommon      |   2 +
 .../selftests/rcutorture/configs/rcu/TREE10        |  18 +
 34 files changed, 1015 insertions(+), 294 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10

