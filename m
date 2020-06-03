Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17E120738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFCOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:51:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57688 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFCOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:51:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgUkA-0006ZY-JD; Wed, 03 Jun 2020 08:51:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgUk9-0005aR-P2; Wed, 03 Jun 2020 08:51:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Jun 2020 09:47:51 -0500
Message-ID: <875zc8kxyg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgUk9-0005aR-P2;;;mid=<875zc8kxyg.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hMjF0oDHJ4xXsPRpWOhyuUU9Uw6OySHE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] proc changes for v5.8-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the proc-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

   HEAD: 9d78edeaec759f997c303f286ecd39daee166f2a proc: proc_pid_ns takes super_block as an argument

This branch has 4 sets of changes:

      proc: modernize proc to support multiple private instances
      proc: Ensure we see the exit of each process tid exactly
      Removing has_group_leader_pid
      posix-cpu-timers: Use pids not tasks in lookup

Alexey updated proc so each mount of proc uses a new superblock.  This
allows people to actually use mount options with proc with no fear of
messing up another mount of proc.  Given the kernel's internal mounts of
proc for things like uml this was a real problem, and resulted in
Android's hidepid mount options being ignored and introducing security
issues.

The rest of the changes are small cleanups and fixes that came out of my
work to allow this change to proc.  In essence it is swapping the pids
in de_thread during exec which revoves a special case the code had to
handle.  Then updating the code to stop handling that special case.

Alexey Gladkov (9):
      proc: modernize proc to support multiple private instances
      proc: rename struct proc_fs_info to proc_fs_opts
      proc: allow to mount many instances of proc in one pid namespace
      proc: instantiate only pids that we can ptrace on 'hidepid=4' mount option
      proc: add option to mount only a pids subset
      docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior
      proc: use human-readable values for hidepid
      proc: use named enums for better readability
      Use proc_pid_ns() to get pid_namespace from the proc superblock
      proc: proc_pid_ns takes super_block as an argument

Eric W. Biederman (14):
      proc: Use PIDTYPE_TGID in next_tgid
      rculist: Add hlists_swap_heads_rcu
      proc: Ensure we see the exit of each process tid exactly once
      proc: Ensure we see the exit of each process tid exactly
      posix-cpu-timer: Tidy up group_leader logic in lookup_task
      posix-cpu-timer:  Unify the now redundant code in lookup_task
      exec: Remove BUG_ON(has_group_leader_pid)
      signal: Remove has_group_leader_pid
      posix-cpu-timers: Extend rcu_read_lock removing task_struct references
      posix-cpu-timers: Replace cpu_timer_pid_type with clock_pid_type
      posix-cpu-timers: Replace __get_task_for_clock with pid_for_clock
      Removing has_group_leader_pid
      posix-cpu-timers: Use pids not tasks in lookup

Oleg Nesterov (1):
      remove the no longer needed pid_alive() check in __task_pid_nr_ns()

 Documentation/filesystems/proc.rst                 |  92 ++++++++++++---
 fs/exec.c                                          |   6 +-
 fs/locks.c                                         |   4 +-
 fs/proc/array.c                                    |   2 +-
 fs/proc/base.c                                     |  74 ++++++------
 fs/proc/generic.c                                  |   9 ++
 fs/proc/inode.c                                    |  30 ++++-
 fs/proc/root.c                                     | 131 ++++++++++++++++-----
 fs/proc/self.c                                     |   8 +-
 fs/proc/thread_self.c                              |   8 +-
 fs/proc_namespace.c                                |  14 +--
 include/linux/pid.h                                |   1 +
 include/linux/pid_namespace.h                      |  12 --
 include/linux/proc_fs.h                            |  32 ++++-
 include/linux/rculist.h                            |  21 ++++
 include/linux/sched/signal.h                       |  11 --
 kernel/fork.c                                      |   2 +-
 kernel/pid.c                                       |  22 +++-
 kernel/time/posix-cpu-timers.c                     | 111 ++++++++---------
 net/ipv6/ip6_flowlabel.c                           |   2 +-
 security/tomoyo/realpath.c                         |   4 +-
 tools/testing/selftests/proc/.gitignore            |   2 +
 tools/testing/selftests/proc/Makefile              |   2 +
 .../testing/selftests/proc/proc-fsconfig-hidepid.c |  50 ++++++++
 .../testing/selftests/proc/proc-multiple-procfs.c  |  48 ++++++++
 25 files changed, 492 insertions(+), 206 deletions(-)

Eric
