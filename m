Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D611C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F265220738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584466642;
	bh=5cEQf6gejDY6dEFmQ2dv/KYka2JsriUKRad+mA3Ugkc=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=zqLL63GoaI14Za3uSDK+5izmZb8MA6uaH8SLMZ0V/PKQhKWrm5hLxviMa5zRzEMyu
	 iR+2CJm8HGF7Wccd4HyF7qYWaatsFqQGvbmQPG0sEtmerwodpkYpVEqScS007J2PyJ
	 fqhKpDpw3nWMpn0cDggKo3f6pF2UlphkBLsIBtKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgCQRhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:37:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60B220735;
        Tue, 17 Mar 2020 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584466639;
        bh=5cEQf6gejDY6dEFmQ2dv/KYka2JsriUKRad+mA3Ugkc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=efsecl1dHLRf+QKJXCNxyMIlqWcnoJOLWi8MA3cpXuR0kbhlHWK26EYHMEAOf1aur
         Vt4Fw/Mho48ICLmQqIGdCUSH+c+SGODTJ0p9+rDe2nBKm1n3MFYAPzyeKk6r8oqiBB
         AP9Zc/5jzMYqlZ/wbV8cs8293uulmtmccXO8AMxY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9C68935226E2; Tue, 17 Mar 2020 10:37:19 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:37:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     kasan-dev@googlegroups.com, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL kcsan] KCSAN commits for v5.7
Message-ID: <20200317173719.GA8693@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains KCSAN updates for v5.7.

https://lore.kernel.org/lkml/20200309190359.GA5822@paulmck-ThinkPad-P72/

All of these have been subjected to the kbuild test robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan-for-mingo

for you to fetch changes up to 31bbbb841768f369301d6f65782dffd65d22aa5b:

  kcsan, trace: Make KCSAN compatible with tracing (2020-03-09 13:18:49 -0700)

----------------------------------------------------------------
Marco Elver (25):
      kcsan: Prefer __always_inline for fast-path
      kcsan: Show full access type in report
      kcsan: Rate-limit reporting per data races
      kcsan: Make KCSAN compatible with lockdep
      kcsan: Address missing case with KCSAN_REPORT_VALUE_CHANGE_ONLY
      include/linux: Add instrumented.h infrastructure
      asm-generic, atomic-instrumented: Use generic instrumented.h
      asm-generic, kcsan: Add KCSAN instrumentation for bitops
      iov_iter: Use generic instrumented.h
      copy_to_user, copy_from_user: Use generic instrumented.h
      kcsan: Add option to assume plain aligned writes up to word size are atomic
      kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
      kcsan: Cleanup of main KCSAN Kconfig option
      kcsan: Fix 0-sized checks
      kcsan: Introduce KCSAN_ACCESS_ASSERT access type
      kcsan: Introduce ASSERT_EXCLUSIVE_* macros
      kcsan: Add test to generate conflicts via debugfs
      kcsan: Expose core configuration parameters as module params
      kcsan: Fix misreporting if concurrent races on same address
      kcsan: Move interfaces that affects checks to kcsan-checks.h
      compiler.h, seqlock.h: Remove unnecessary kcsan.h includes
      kcsan: Introduce kcsan_value_change type
      kcsan: Add kcsan_set_access_mask() support
      kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
      kcsan, trace: Make KCSAN compatible with tracing

Paul E. McKenney (1):
      kcsan: Add docbook header for data_race()

 arch/x86/lib/Makefile                              |   5 +
 include/asm-generic/atomic-instrumented.h          | 395 ++++++++++-----------
 include/asm-generic/bitops/instrumented-atomic.h   |  14 +-
 include/asm-generic/bitops/instrumented-lock.h     |  10 +-
 .../asm-generic/bitops/instrumented-non-atomic.h   |  16 +-
 include/linux/compiler.h                           |  16 +-
 include/linux/instrumented.h                       | 109 ++++++
 include/linux/kcsan-checks.h                       | 174 ++++++++-
 include/linux/kcsan.h                              |  46 +--
 include/linux/seqlock.h                            |   2 +-
 include/linux/uaccess.h                            |  14 +-
 init/init_task.c                                   |   1 +
 kernel/kcsan/Makefile                              |   2 +
 kernel/kcsan/atomic.h                              |   2 +-
 kernel/kcsan/core.c                                | 183 ++++++++--
 kernel/kcsan/debugfs.c                             |  65 +++-
 kernel/kcsan/encoding.h                            |  14 +-
 kernel/kcsan/kcsan.h                               |  33 +-
 kernel/kcsan/report.c                              | 255 +++++++++++--
 kernel/kcsan/test.c                                |  10 +
 kernel/locking/Makefile                            |   3 +
 kernel/trace/Makefile                              |   3 +
 lib/Kconfig.kcsan                                  |  70 +++-
 lib/iov_iter.c                                     |   7 +-
 lib/usercopy.c                                     |   7 +-
 scripts/atomic/gen-atomic-instrumented.sh          |  19 +-
 26 files changed, 1068 insertions(+), 407 deletions(-)
 create mode 100644 include/linux/instrumented.h
