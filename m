Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC4C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F24208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897838;
	bh=nBLCefDFpPRBI7iy+jr3QX4FEPCl6D6hh4uvD48LT1U=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=k7p37kt81jZDfIqlO22ciul+rqK/clz8051UgQxAA9Fa+lnygl3K/8LsNSpnUunfi
	 qm1Po6Db2V0B0QMqT7zEGewwm5Lirb9jUiIe5ph8pl0iCzi7nE2ROXMYZwQj/WjtUK
	 458dAEtFRSZ8fQWoUuzG4GOxcGIWTIln/8Mb2mMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgHaSRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgHaSRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:17:16 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEA22071B;
        Mon, 31 Aug 2020 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897835;
        bh=nBLCefDFpPRBI7iy+jr3QX4FEPCl6D6hh4uvD48LT1U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j1qdUDQmZTatcZAwhBAZpNnAfj2RGdWw+8S8F6wtonS3Avt+OHwaJvj4dXNn1yjb7
         LcYV4UZI4RDKnYIUObS3uTz8BI9ETOD7b6IHIPHH+m4yltVBLzMC1FJ4wU+O+Oxdre
         GU1RscjWvKobMkc/k5ho3SP5T/v1yueHr3BnR+aA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0902835230F1; Mon, 31 Aug 2020 11:17:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:17:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/19] KCSAN updates for v5.10
Message-ID: <20200831181715.GA1530@paulmck-ThinkPad-P72>
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

This series provides KCSAN updates:

1.	Add support for atomic builtins.

2.	Add atomic builtin TSAN instrumentation to uaccess whitelist.

3.	Add atomic builtin test case.

4.	Support compounded read-write instrumentation.

5.	objtool, kcsan: Add __tsan_read_write to uaccess whitelist.

6.	Skew delay to be longer for certain access types.

7.	Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks.

8.	Test support for compound instrumentation.

9.	instrumented.h: Introduce read-write instrumentation hooks.

10.	asm-generic/bitops: Use instrument_read_write() where appropriate.

11.	locking/atomics: Use read-write instrumentation for atomic RMWs.

12.	Simplify debugfs counter to name mapping.

13.	Simplify constant string handling.

14.	Remove debugfs test command.

15.	Show message if enabled early.

16.	Use pr_fmt for consistency.

17.	Optimize debugfs stats counters.

18.	bitops, kcsan: Partially revert instrumentation for non-atomic bitops.

19.	Use tracing-safe version of prandom.

						Thanx, Paul

------------------------------------------------------------------------

 include/asm-generic/atomic-instrumented.h            |  330 +++++++++----------
 include/asm-generic/bitops/instrumented-atomic.h     |    6 
 include/asm-generic/bitops/instrumented-lock.h       |    2 
 include/asm-generic/bitops/instrumented-non-atomic.h |   36 +-
 include/linux/instrumented.h                         |   30 +
 include/linux/kcsan-checks.h                         |   45 +-
 kernel/kcsan/core.c                                  |  238 +++++++++++--
 kernel/kcsan/debugfs.c                               |  136 +------
 kernel/kcsan/kcsan-test.c                            |  128 ++++++-
 kernel/kcsan/kcsan.h                                 |   12 
 kernel/kcsan/report.c                                |   10 
 kernel/kcsan/selftest.c                              |    8 
 lib/Kconfig.kcsan                                    |    5 
 scripts/Makefile.kcsan                               |    2 
 scripts/atomic/gen-atomic-instrumented.sh            |   21 -
 tools/objtool/check.c                                |   55 +++
 16 files changed, 697 insertions(+), 367 deletions(-)
