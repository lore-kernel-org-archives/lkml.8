Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDBAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 15:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE6520708
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 15:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgF1PXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 11:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgF1PXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 11:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26B78AC50;
        Sun, 28 Jun 2020 15:23:48 +0000 (UTC)
Date:   Sun, 28 Jun 2020 17:23:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 5.8-rc3
Message-ID: <20200628152342.GE18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the sched/urgent pile. I had to rebase it last-minute ontop
of -rc2 because it was based on a random merge commit after -rc2 and I
know you don't like pull requests based on random commits if there's not
a real reason for that.

Peter and I did try to look for a real reason but the commits
which were between the -rc2 tag and the merge commit were three
regulator/regmap/spi pulls which don't have anything to do with sched.
Which led us to conclude that those patches were erroneously rebased on
the state of your master branch at the time.

A quick build and boot smoke tests showed too that those changes are
unrelated.

 ( Btw, the rebase was done to fix up the SOB chain in a commit and trim
   a commit message. )

So yeah, I know, we should not rebase stuff but considering the above,
I guess that's ok in this case as the history cleanliness is more
important here. I could be missing an important aspect, though...

Thx.

---

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_5.8_rc3

for you to fetch changes up to e21cf43406a190adfcc4bfe592768066fb3aaa9b:

  sched/cfs: change initial value of runnable_avg (2020-06-28 17:01:20 +0200)

----------------------------------------------------------------
Peter Zijlstra says:

The most anticipated fix in this pull request is probably the horrible build
fix for the RANDSTRUCT fail that didn't make -rc2. Also included is the cleanup
that removes those BUILD_BUG_ON()s and replaces it with ugly unions.

Also included is the try_to_wake_up() race fix that was first triggered by
Paul's RCU-torture runs, but was independently hit by Dave Chinner's fstest
runs as well.

----------------------------------------------------------------
Juri Lelli (2):
      sched/deadline: Initialize ->dl_boosted
      sched/core: Fix PI boosting between RT and DEADLINE tasks

Peter Zijlstra (4):
      sched/core: Fix CONFIG_GCC_PLUGIN_RANDSTRUCT build fail
      sched/core: Fix ttwu() race
      sched/core: s/WF_ON_RQ/WQ_ON_CPU/
      smp, irq_work: Continue smp_call_function*() and irq_work*() integration

Scott Wood (1):
      sched/core: Check cpus_mask, not cpus_ptr in __set_cpus_allowed_ptr(), to fix mask corruption

Vincent Guittot (1):
      sched/cfs: change initial value of runnable_avg

 include/linux/irq_work.h  | 26 ++++++-------------
 include/linux/sched.h     |  3 +--
 include/linux/smp.h       | 23 ++++++-----------
 include/linux/smp_types.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c       | 44 ++++++++++++++++++++++++-------
 kernel/sched/deadline.c   |  1 +
 kernel/sched/fair.c       |  2 +-
 kernel/sched/sched.h      |  2 +-
 kernel/smp.c              | 18 -------------
 9 files changed, 120 insertions(+), 65 deletions(-)
 create mode 100644 include/linux/smp_types.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
