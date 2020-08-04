Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1146EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB02208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHDLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:32:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:32:06 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2vAp-0002Fi-Tt; Tue, 04 Aug 2020 11:32:04 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] checkpoint/restore changes for v5.9
Date:   Tue,  4 Aug 2020 13:32:02 +0200
Message-Id: <20200804113202.72667-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This pull request contains the changes to enable unprivileged
checkpoint/restore of processes. Given that this work has been going on for
quite some time the first sentence in this summary is hopefully more exciting
than the actual final code changes required.
Unprivileged checkpoint/restore has seen a frequent increase in interest over
the last two years and has thus been one of the main topics for the combined
containers & checkpoint/restore microconference since at least 2018 (cf. [1]).

Here are just the three most frequent use-cases that were brought forward:
1. The JVM developers are integrating checkpoint/restore into a Java VM to
   significantly decrease the startup time.
2. In high-performance computing environment a resource manager will typically
   be distributing jobs where users are always running as non-root.
   Long-running and "large" processes with significant startup times are
   supposed to be checkpointed and restored with CRIU.
3. Container migration as a non-root user.

In all of these scenarios it is either desirable or required to run without
CAP_SYS_ADMIN. The userspace implementation of checkpoint/restore CRIU already
has the pull request for supporting unprivileged checkpoint/restore up (cf. [2]).

To enable unprivileged checkpoint/restore a new dedicated capability
CAP_CHECKPOINT_RESTORE is introduced. This solution has last been discussed in
2019 in a talk by Google at Linux Plumbers (cf. [1] "Update on Task Migration
at Google Using CRIU") with Adrian and Nicolas providing the implementation now
over the last months. In essence, this allows the CRIU binary to be installed
with the CAP_CHECKPOINT_RESTORE vfs capability set thereby enabling
unprivileged users to restore processes.

To make this possible the following permissions are altered:
1. Selecting a specific PID via clone3() set_tid
   - Relaxed from userns CAP_SYS_ADMIN to CAP_CHECKPOINT_RESTORE.
2. Selecting a specific PID via /proc/sys/kernel/ns_last_pid
   - Relaxed from userns CAP_SYS_ADMIN to CAP_CHECKPOINT_RESTORE.
3. Accessing /proc/pid/map_files
   - Relaxed from init userns CAP_SYS_ADMIN to init userns
     CAP_CHECKPOINT_RESTORE.
4. Changing /proc/self/exe
   - Relaxed from userns CAP_SYS_ADMIN to userns CAP_CHECKPOINT_RESTORE.

Of these four changes the /proc/self/exe change deserves a few words because
the reasoning behind even restricting /proc/self/exe changes in the first place
is just full of historical quirks and tracking this down was a questionable
version of fun that I'd like to spare others.
In short, it is trivial to change /proc/self/exe as an unprivileged user, i.e.
without userns CAP_SYS_ADMIN right now. Either via ptrace() or by simply
intercepting the elf loader in userspace during exec. Nicolas was nice enough
to even provide a POC for the latter (cf. [3]) to illustrate this fact.
The original patchset which introduced PR_SET_MM_MAP had no permissions around
changing the exe link. They too argued that it is trivial to spoof the exe link
already which is true. The argument brought up against this was that the Tomoyo
LSM uses the exe link in tomoyo_manager() to detect whether the calling process
is a policy manager. This caused changing the exe links to be guarded by userns
CAP_SYS_ADMIN. All in all this rather seems like a "better guard it with
something rather than nothing" argument which imho doesn't qualify as a great
security policy. Again, because spoofing the exe link is possible for the
calling process so even if this were security relevant it was broken back then
and would be broken today. So technically, dropping all permissions around
changing the exe link would probably be possible and would send a clearer
message to any userspace that relies on /proc/self/exe for security reasons
that they should stop doing this but for now we're only relaxing the exe link
permissions from userns CAP_SYS_ADMIN to userns CAP_CHECKPOINT_RESTORE.

There's a final uapi change in here. Changing the exe link used to accidently
return EINVAL when the caller lacked the necessary permissions instead of
the more correct EPERM. This pr contains a commit fixing this. I assume that
userspace won't notice or care and if they do I will revert this commit. But
since we are changing the permissions anyway it seems like a good opportunity
to try this fix.

With these changes merged unprivileged checkpoint/restore will be possible and
has already been tested by various users.

[1]: LPC 2018
     1. "Task Migration at Google Using CRIU"
        https://www.youtube.com/watch?v=yI_1cuhoDgA&t=12095
     2. "Securely Migrating Untrusted Workloads with CRIU"
        https://www.youtube.com/watch?v=yI_1cuhoDgA&t=14400
     LPC 2019
     1. "CRIU and the PID dance"
         https://www.youtube.com/watch?v=LN2CUgp8deo&list=PLVsQ_xZBEyN30ZA3Pc9MZMFzdjwyz26dO&index=9&t=2m48s
     2. "Update on Task Migration at Google Using CRIU"
        https://www.youtube.com/watch?v=LN2CUgp8deo&list=PLVsQ_xZBEyN30ZA3Pc9MZMFzdjwyz26dO&index=9&t=1h2m8s
[2]: https://github.com/checkpoint-restore/criu/pull/1155
[3]: https://github.com/nviennot/run_as_exe

/* Testing */
All patches are based on v5.8-rc5 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline bcf876870b95 ("Linux 5.8").

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cap-checkpoint-restore-v5.9

for you to fetch changes up to 1d27a0be16d6c95fd71deef34e94b40cb4411cc9:

  selftests: add clone3() CAP_CHECKPOINT_RESTORE test (2020-07-20 15:47:42 +0200)

Please consider pulling these changes from the signed cap-checkpoint-restore-v5.9 tag.

Thanks!
Christian

----------------------------------------------------------------
cap-checkpoint-restore-v5.9

----------------------------------------------------------------
Adrian Reber (5):
      capabilities: Introduce CAP_CHECKPOINT_RESTORE
      pid: use checkpoint_restore_ns_capable() for set_tid
      pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
      proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
      selftests: add clone3() CAP_CHECKPOINT_RESTORE test

Nicolas Viennot (2):
      prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
      prctl: exe link permission error changed from -EINVAL to -EPERM

 fs/proc/base.c                                     |   8 +-
 include/linux/capability.h                         |   6 +
 include/uapi/linux/capability.h                    |   9 +-
 kernel/pid.c                                       |   2 +-
 kernel/pid_namespace.c                             |   2 +-
 kernel/sys.c                                       |  13 +-
 security/selinux/include/classmap.h                |   5 +-
 tools/testing/selftests/clone3/.gitignore          |   1 +
 tools/testing/selftests/clone3/Makefile            |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c         | 182 +++++++++++++++++++++
 10 files changed, 217 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
