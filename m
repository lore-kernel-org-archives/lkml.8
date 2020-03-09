Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1804C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7D421655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780642;
	bh=OjqjiRfH2HloYi+ecAKXsWnEex+EbCkptWtQaFFrpkc=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=zGcHjUVzVAKAEPfDIfePCYMR9NhiM2JVhPfCYwHXJfsop59HzCxn98J9ppeycHc0M
	 i7vQqlQFLlm2RxWbUjFvaQfZ+XpsxOPI29NzSlema3RxaWuFOzrdj2vwilWipH/PSh
	 CW0qi3JpeMq3RGQay4szbTGCqGX5fNInphALrvqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCITEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbgCITEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1417420873;
        Mon,  9 Mar 2020 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780640;
        bh=OjqjiRfH2HloYi+ecAKXsWnEex+EbCkptWtQaFFrpkc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=l0sMWuxbr+K422eqYJH9wRNE/QXq6gYYgAOr5oxilRpJ/f4YKsmC+BLyz1QHiEDPz
         fYZxjb6Z6QoIkRCUyhBUh6UrIU8HAZohQA9ZInnukuP2bETxovD2lhSeN+IhkZf0Ai
         EcWfiZjkfD3f4ccjONhx+TlI1WUSNgX6RaejCEM4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D78053522730; Mon,  9 Mar 2020 12:03:59 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:03:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/32] KCSAN commits for v5.7
Message-ID: <20200309190359.GA5822@paulmck-ThinkPad-P72>
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

The patches in this series have already been posted, so this posting
is just to give a heads up as to  which of them are likely to be part
of next week's KCSAN pull request.  Unless otherwise noted, these are
courtesy of Marco Elver.

1.	kcsan: Prefer __always_inline for fast-path.
2.	kcsan: Show full access type in report.
3.	kcsan: Rate-limit reporting per data races.
4.	kcsan: Make KCSAN compatible with lockdep.
5.	kcsan: Address missing case with KCSAN_REPORT_VALUE_CHANGE_ONLY.
6.	include/linux: Add instrumented.h infrastructure.
7.	asm-generic, atomic-instrumented: Use generic instrumented.h.
8.	asm-generic, kcsan: Add KCSAN instrumentation for bitops.
9.	iov_iter: Use generic instrumented.h.
10.	copy_to_user, copy_from_user: Use generic instrumented.h.
11.	kcsan: Add docbook header for data_race(), courtesy of yours truly.
12.	kcsan: Add option to assume plain aligned writes up to word size
	are atomic.
13.	kcsan: Clarify Kconfig option.
14.	kcsan: Cleanup of main KCSAN Kconfig option.
15.	kcsan: Fix 0-sized checks.
16.	kcsan: Introduce KCSAN_ACCESS_ASSERT access type.
17.	kcsan: Introduce ASSERT_EXCLUSIVE_* macros.
18.	kcsan: Add test to generate conflicts via debugfs.
19.	kcsan: Expose core configuration parameters as module params.
20.	kcsan: Fix misreporting if concurrent races on same address.
21.	kcsan: Move interfaces that affects checks to kcsan-checks.h.
22.	compiler.h, seqlock.h: Remove unnecessary kcsan.h includes.
23.	kcsan: Introduce kcsan_value_change type.
24.	kcsan: Add kcsan_set_access_mask() support.
25.	kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask).
26.	kcsan, trace: Make KCSAN compatible with tracing.
27.	kcsan: Add option to allow watcher interruptions.
28.	kcsan: Add option for verbose reporting.
29.	kcsan: Add current->state to implicitly atomic.
30.	kcsan: Fix a typo in a comment, courtesy of Qiujun Huang.
31.	kcsan: Update Documentation/dev-tools/kcsan.rst.
32.	kcsan: Update API documentation in kcsan-checks.h.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst                    |  227 ++++++----
 arch/x86/lib/Makefile                                |    5 
 include/asm-generic/atomic-instrumented.h            |  395 ++++++++----------
 include/asm-generic/bitops/instrumented-atomic.h     |   14 
 include/asm-generic/bitops/instrumented-lock.h       |   10 
 include/asm-generic/bitops/instrumented-non-atomic.h |   16 
 include/linux/compiler.h                             |   16 
 include/linux/instrumented.h                         |  109 +++++
 include/linux/kcsan-checks.h                         |  284 ++++++++++---
 include/linux/kcsan.h                                |   46 --
 include/linux/seqlock.h                              |    2 
 include/linux/uaccess.h                              |   14 
 init/init_task.c                                     |    1 
 kernel/kcsan/Makefile                                |    2 
 kernel/kcsan/atomic.h                                |   23 -
 kernel/kcsan/core.c                                  |  279 ++++++++----
 kernel/kcsan/debugfs.c                               |   94 +++-
 kernel/kcsan/encoding.h                              |   14 
 kernel/kcsan/kcsan.h                                 |   36 +
 kernel/kcsan/report.c                                |  414 ++++++++++++++++---
 kernel/kcsan/test.c                                  |   10 
 kernel/locking/Makefile                              |    3 
 kernel/trace/Makefile                                |    3 
 lib/Kconfig.kcsan                                    |  114 ++++-
 lib/iov_iter.c                                       |    7 
 lib/usercopy.c                                       |    7 
 scripts/atomic/gen-atomic-instrumented.sh            |   19 
 27 files changed, 1517 insertions(+), 647 deletions(-)
