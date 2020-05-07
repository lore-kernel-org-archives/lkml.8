Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4BC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB0220CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588893149;
	bh=W4VuTywsK3umF5q4huqbEAOV3ayvPAX3DEszmqXdOko=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=zwdRAhUiWzNk/Z/Wo1kb9wQCk8qm2NY72Ky9w4qf6cKx6b1FhVkRgAmO2qvjOenrk
	 cYchGNtC4kQmPVM7MgMNQSIyWnEGVp0ulZedsDD3XYty2hz5R9r1uHmu6Lncb+smW1
	 p6P4iPUagzPAb9VFR/e4sJ9tFbgqhh+z9HIsITmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEGXM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgEGXM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:12:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61BF208D6;
        Thu,  7 May 2020 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588893147;
        bh=W4VuTywsK3umF5q4huqbEAOV3ayvPAX3DEszmqXdOko=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TZs79MWzj4zW4vFzY+2hGEhp3zV251x6hiLKBK6nckwzYjEJSZy4ObeE4vrJmRchZ
         DSVveFNJw6ZeuQG5kkEhLXPPgB8Wx/soNyZnf9rI4ZQmyNMm4SPyiOORpQ3iniIpxd
         +oWsEjKxg5ZWMm7V+NbTQK7PwcuE28KcDD5dMzeA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9B55E35233B2; Thu,  7 May 2020 16:12:27 -0700 (PDT)
Date:   Thu, 7 May 2020 16:12:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     kasan-dev@googlegroups.com, elver@google.com,
        linux-kernel@vger.kernel.org, hqjagain@gmail.com,
        weiyongjun1@huawei.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.8
Message-ID: <20200507231227.GA12010@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This pull request contains KCSAN updates for v5.8.  These have been
subject to LKML review:

https://lore.kernel.org/lkml/20200415183343.GA12265@paulmck-ThinkPad-P72
https://lore.kernel.org/lkml/20200417025837.49780-1-weiyongjun1@huawei.com
https://lore.kernel.org/lkml/20200401101714.44781-1-elver@google.com
https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com
https://lore.kernel.org/lkml/20200424154730.190041-2-elver@google.com

All of these have also been subjected to the kbuild test robot and
-next testing.  The following changes since commit f5d2313bd3c5:

  kcsan, trace: Make KCSAN compatible with tracing (2020-03-21 09:44:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan-for-tip

for you to fetch changes up to 50a19ad4b1ec531eb550183cb5d4ab9f25a56bf8:

  objtool, kcsan: Add kcsan_disable_current() and kcsan_enable_current_nowarn() (2020-05-06 13:47:06 -0700)

----------------------------------------------------------------
Ingo Molnar (1):
      Improve KCSAN documentation a bit

Marco Elver (17):
      kcsan: Add option to allow watcher interruptions
      kcsan: Add option for verbose reporting
      kcsan: Add current->state to implicitly atomic accesses
      kcsan: Update Documentation/dev-tools/kcsan.rst
      kcsan: Update API documentation in kcsan-checks.h
      kcsan: Introduce report access_info and other_info
      kcsan: Avoid blocking producers in prepare_report()
      kcsan: Add support for scoped accesses
      objtool, kcsan: Add explicit check functions to uaccess whitelist
      kcsan: Introduce scoped ASSERT_EXCLUSIVE macros
      kcsan: Move kcsan_{disable,enable}_current() to kcsan-checks.h
      kcsan: Change data_race() to no longer require marking racing accesses
      kcsan: Fix function matching in report
      kcsan: Make reporting aware of KCSAN tests
      checkpatch: Warn about data_race() without comment
      kcsan: Add __kcsan_{enable,disable}_current() variants
      objtool, kcsan: Add kcsan_disable_current() and kcsan_enable_current_nowarn()

Qiujun Huang (1):
      kcsan: Fix a typo in a comment

Wei Yongjun (1):
      kcsan: Use GFP_ATOMIC under spin lock

 Documentation/dev-tools/kcsan.rst | 228 ++++++++++++-------
 include/linux/compiler.h          |   4 +-
 include/linux/kcsan-checks.h      | 261 ++++++++++++++++++----
 include/linux/kcsan.h             |  19 +-
 init/init_task.c                  |   1 +
 kernel/kcsan/atomic.h             |  21 +-
 kernel/kcsan/core.c               | 183 ++++++++++-----
 kernel/kcsan/debugfs.c            |  47 +++-
 kernel/kcsan/kcsan.h              |   8 +-
 kernel/kcsan/report.c             | 455 ++++++++++++++++++++++++--------------
 lib/Kconfig.kcsan                 |  39 +++-
 scripts/checkpatch.pl             |   8 +
 tools/objtool/check.c             |   4 +
 13 files changed, 880 insertions(+), 398 deletions(-)
