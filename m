Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB0C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E5621D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDRLLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 07:11:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40974 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:11:46 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jPlNw-00011i-6h; Sat, 18 Apr 2020 11:11:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes for v5.7-rc2
Date:   Sat, 18 Apr 2020 13:09:49 +0200
Message-Id: <20200418110945.1518581-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a few fixes and minor improvements:
- Correctly validate the cgroup file descriptor when clone3() is used
  with CLONE_INTO_CGROUP.

- Check that a new enough version of struct clone_args is passed which
  supports the cgroup file descriptor argument when CLONE_INTO_CGROUP is
  set in the flags argument.

- Catch nonsensical struct clone_args layouts at build time.

- Catch extensions of struct clone_args without updating the uapi visible
  size definitions at build time.

- Check whether the signal is valid early in kill_pid_usb_asyncio()
  before doing further work.

- Replace open-coded rcu_read_lock()+kill_pid_info()+rcu_read_unlock()
  sequence in kill_something_info() with kill_proc_info() which is a
  dedicated helper to do just that.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.7-rc1.
No regressions or build warning have been reported to me and I haven't seen
any new ones in my own build with gcc 7.5.0.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-04-18

for you to fetch changes up to a966dcfe153ab0a3d8d79cd971a079411a489be7:

  clone3: add build-time CLONE_ARGS_SIZE_VER* validity checks (2020-04-15 09:56:32 +0200)

Please consider pulling these changes from the signed for-linus-2020-04-18 tag.

(Btw, about two weeks ago chatting with Konstantin we realized that my gpg
 hadn't been up-to-date in
 https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git. Unlikely that this
 would've affected you but just in case it did it's now fixed.

 And last, after having played with Konstantin's b4 attestation feature for
 some patchsets I've sent out I've also used it for this pr here. So if you
 wanted to try you could use b4 on this thing to get the new shiny.)

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-04-18

----------------------------------------------------------------
Eugene Syromiatnikov (3):
      clone3: fix cgroup argument sanity check
      clone3: add a check for the user struct size if CLONE_INTO_CGROUP is set
      clone3: add build-time CLONE_ARGS_SIZE_VER* validity checks

Zhiqiang Liu (2):
      signal: check sig before setting info in kill_pid_usb_asyncio
      signal: use kill_proc_info instead of kill_pid_info in kill_something_info

 kernel/fork.c   | 11 ++++++++++-
 kernel/signal.c | 14 +++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)
