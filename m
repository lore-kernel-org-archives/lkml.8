Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9365C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76C122574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594748606;
	bh=daLXe87+gGS/cotI3VTupP+Y+qDbGBfUc+G6VgIw8cM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=xrgzkmW3wdUDtw4nC/vXf+pTfuEbktQKt1IIPZdIuuBVL2ic0vXwZo5LUf4ymKOvd
	 K2cJD289BpmOhQ7SLwvqA36ZfErf8IKZOhusAA1NXx0daCyXiSGm9n6rLo3AW0CYVF
	 ew6jRb6Q/3m5FoI8J7mmyLlLuJvMBs8QgGwI+yiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgGNRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgGNRnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:43:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B19722518;
        Tue, 14 Jul 2020 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594748604;
        bh=daLXe87+gGS/cotI3VTupP+Y+qDbGBfUc+G6VgIw8cM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bSuiX3AzueHGoneBBm8Kwj1dfdk/F5OQE1EvAJghVgvJdqzHWrB/6IPt8G0BfVabM
         o5gCGUI3zbJG7SZdIhAKoVioS4yjoPOSTQYZgfRQ0OQwg/MP+OW5d0w7b7BOCzaey7
         RU8QN19LCFVNEOvisRw1E26in/HmzAJqYeMVAqp8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DECF2352262C; Tue, 14 Jul 2020 10:43:23 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:43:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, elver@google.com, joel@joelfernandes.org,
        tglx@linutronix.de
Subject: [GIT PULL memory-model] LKMM commits for v5.9
Message-ID: <20200714174323.GA32508@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains Linux-Kernel Memory-Model commits for v5.9.
These have been subjected to LKML review:

	https://lore.kernel.org/lkml/20200623005152.GA27459@paulmck-ThinkPad-P72/

All of these have also been subjected to the kbuild test robot and
-next testing.  The following changes since v5.8-rc3 are available in
the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm

for you to fetch changes up to 5ef0a07a7928539d46fdb163acfad28c6d877a89:

  Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test (2020-06-29 12:05:18 -0700)

----------------------------------------------------------------
Akira Yokosawa (5):
      tools/memory-model: Fix reference to litmus test in recipes.txt
      Documentation/litmus-tests: Merge atomic's README into top-level one
      tools/memory-model/README: Expand dependency of klitmus7
      tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
      Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test

Boqun Feng (4):
      tools/memory-model: Add an exception for limitations on _unless() family
      Documentation/litmus-tests: Introduce atomic directory
      Documentation/litmus-tests/atomic: Add a test for atomic_set()
      Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()

Joel Fernandes (Google) (4):
      Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
      Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
      MAINTAINERS: Update maintainers for new Documentation/litmus-tests
      Documentation/litmus-tests: Cite an RCU litmus test

Marco Elver (1):
      tools/memory-model: Fix "conflict" definition

Paul E. McKenney (1):
      tools/memory-model: Add recent references

 Documentation/atomic_t.txt                         | 24 +++----
 Documentation/litmus-tests/README                  | 35 +++++++++
 ...b__after_atomic-is-stronger-than-acquire.litmus | 32 +++++++++
 ...Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus | 25 +++++++
 .../litmus-tests/rcu/RCU+sync+free.litmus          | 42 +++++++++++
 .../litmus-tests/rcu/RCU+sync+read.litmus          | 37 ++++++++++
 MAINTAINERS                                        |  2 +
 tools/memory-model/Documentation/explanation.txt   | 83 ++++++++++++----------
 tools/memory-model/Documentation/recipes.txt       |  2 +-
 tools/memory-model/Documentation/references.txt    | 21 +++++-
 tools/memory-model/README                          | 40 +++++++++--
 11 files changed, 285 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/litmus-tests/README
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+free.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+read.litmus
