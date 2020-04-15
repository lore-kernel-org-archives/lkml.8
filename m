Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A34C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E59206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586978320;
	bh=WtjKxO5VEr0mf7bV2OUqDFxSVxzx7tYfmxjZmdpf1ZI=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=PQNwe7cLs+b4EQ1sBv9kuPS2uCQXzXvIySJM82w9PiWyHZukZ93rJ6rEjMGxOVwbU
	 /fzESTNfuKBmgapiiC7SsTFQvoTkLxj6N1e2RxgurKYoPYTbrLeRP7i4sPNc92ISaZ
	 qxftqq87lg9diIa8yRHFWMf+LU5H4cDPb1fH1/Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgDOTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416781AbgDOSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:33:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6DF20771;
        Wed, 15 Apr 2020 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975624;
        bh=WtjKxO5VEr0mf7bV2OUqDFxSVxzx7tYfmxjZmdpf1ZI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=2bKf75KC94YT83PyuPmY7GgR+gC5o3S7kIL0b0afa3jibkcC0pjBSfvhXiJtJAUJs
         9hO1rrpxJs0MjNbegjfOiMlS3i+aVDVreLmtOUhLO8cc1Nccqs1AHeDn7vn62Hn8QI
         8wjFmySZAkQZvK91tXj96eXzmbOMHWi9Fq+uPnv8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DE0FA3522AD1; Wed, 15 Apr 2020 11:33:43 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:33:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/15] KCSAN updates for v5.8
Message-ID: <20200415183343.GA12265@paulmck-ThinkPad-P72>
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

This series contains KCSAN updates.  Unless otherwise noted, these are
all courtesy of Marco Elver.

1.	Add option to allow watcher interruptions.

2.	Add option for verbose reporting.

3.	Add current->state to implicitly atomic accesses.

4.	Fix a typo in a comment, courtesy of Qiujun Huang.

5.	Update Documentation/dev-tools/kcsan.rst.

6.	Update API documentation in kcsan-checks.h.

7.	Introduce report access_info and other_info.

8.	Avoid blocking producers in prepare_report().

9.	Add support for scoped accesses.

10.	objtool, kcsan: Add explicit check functions to uaccess whitelist.

11.	Introduce scoped ASSERT_EXCLUSIVE macros.

12.	Move kcsan_{disable,enable}_current() to kcsan-checks.h.

13.	Change data_race() to no longer require marking racing accesses.

14.	Fix function matching in report.

15.	Make reporting aware of KCSAN tests.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst |  230 ++++++++++------
 include/linux/compiler.h          |    4 
 include/linux/kcsan-checks.h      |  244 ++++++++++++++---
 include/linux/kcsan.h             |   19 -
 init/init_task.c                  |    1 
 kernel/kcsan/atomic.h             |   21 -
 kernel/kcsan/core.c               |  182 ++++++++----
 kernel/kcsan/debugfs.c            |   43 ++-
 kernel/kcsan/kcsan.h              |    8 
 kernel/kcsan/report.c             |  543 +++++++++++++++++++++++---------------
 lib/Kconfig.kcsan                 |   24 +
 tools/objtool/check.c             |    2 
 12 files changed, 887 insertions(+), 434 deletions(-)
