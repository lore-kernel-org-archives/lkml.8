Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20341C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E854A22518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594747975;
	bh=zyZEA+TmaYx9HIH4TKfXi4hIG1sMV22qo4R5bh/s0e4=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=iwg4s3dT7S9aK4xo6IjqvAPrrtnnh5FZk1/EpftvqH1Sas4dsTPyIN+Ciw4CAtMgf
	 ja3eil1VmFgR5yHWeLZQto5yTrGvfHkeNtBwsNymaSmRje/S6CekmqBkK/bW8s4GqM
	 IXv6r9IIn9qK40nc3a34JNBWRgI2Oo5z+74HBibE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgGNRcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgGNRcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:32:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18AB22450;
        Tue, 14 Jul 2020 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594747972;
        bh=zyZEA+TmaYx9HIH4TKfXi4hIG1sMV22qo4R5bh/s0e4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tux0jxNthNtq9o2fuXzgxnq27EFg1a+hfPyEw+mL7e8RWGUuwd/BtmJG1FzvhA6Jk
         xxhP6/NVPQ8bIfrcrEwddf/egH/42naepoICJYkAhcTnrJuNHoEbwlRY5+fgIe8Pq1
         Ug0HADccu05FqQpYVBywxXHO/rkvKK8YJpd6YzUM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9A8C9352262C; Tue, 14 Jul 2020 10:32:52 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:32:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, cai@lca.pw, elver@google.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.9
Message-ID: <20200714173252.GA32057@paulmck-ThinkPad-P72>
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

This pull request contains KCSAN updates for v5.9.  These have been
subjected to LKML review, most recently here:

	https://lore.kernel.org/lkml/20200623004310.GA26995@paulmck-ThinkPad-P72/

All of these have also been subjected to the kbuild test robot and
-next testing.  The following changes since v5.8-rc3 are available in
the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan

for you to fetch changes up to 61d56d7aa5eca3b909bce51ba8125b0fa44d7e17:

  kcsan: Disable branch tracing in core runtime (2020-06-29 12:04:48 -0700)

----------------------------------------------------------------
Marco Elver (9):
      kcsan: Add test suite
      kcsan: Prefer '__no_kcsan inline' in test
      kcsan: Silence -Wmissing-prototypes warning with W=1
      kcsan: Rename test.c to selftest.c
      kcsan: Remove existing special atomic rules
      kcsan: Add jiffies test to test suite
      kcsan: Re-add GCC as a supported compiler
      kcsan: Simplify compiler flags
      kcsan: Disable branch tracing in core runtime

Paul E. McKenney (1):
      rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu()

Qian Cai (3):
      fork: Annotate a data race in vm_area_dup()
      x86/mm/pat: Mark an intentional data race
      locking/osq_lock: Annotate a data race in osq_lock

 Documentation/dev-tools/kcsan.rst   |    3 +-
 arch/x86/mm/pat/set_memory.c        |    2 +-
 include/linux/rculist.h             |    2 +
 kernel/fork.c                       |    8 +-
 kernel/kcsan/Makefile               |    9 +-
 kernel/kcsan/atomic.h               |    6 +-
 kernel/kcsan/core.c                 |    9 +
 kernel/kcsan/kcsan-test.c           | 1107 +++++++++++++++++++++++++++++++++++
 kernel/kcsan/{test.c => selftest.c} |    0
 kernel/locking/osq_lock.c           |    6 +-
 lib/Kconfig.kcsan                   |   26 +-
 scripts/Makefile.kcsan              |    2 +-
 12 files changed, 1166 insertions(+), 14 deletions(-)
 create mode 100644 kernel/kcsan/kcsan-test.c
 rename kernel/kcsan/{test.c => selftest.c} (100%)
