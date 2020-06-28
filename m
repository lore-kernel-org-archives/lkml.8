Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8859B20720
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgF1Oin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:38:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:38080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgF1Oin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:38:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01529ACBD;
        Sun, 28 Jun 2020 14:38:42 +0000 (UTC)
Date:   Sun, 28 Jun 2020 16:38:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] rcu/urgent for 5.8-rc3
Message-ID: <20200628143835.GC18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent RCU, KCSAN-related fixes.

Thx.

---

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/rcu_urgent_for_5.8_rc3

for you to fetch changes up to b58e733fd774f3f4b49d9e7640d172a57e35200e:

  rcu: Fixup noinstr warnings (2020-06-25 08:24:32 -0700)

----------------------------------------------------------------
Paul E. McKenney says:

A single commit that uses "arch_" atomic operations to avoid the
instrumentation that comes with the non-"arch_" versions. In preparation
for that commit, it also has another commit that makes these "arch_"
atomic operations available to generic code.

Without these commits, KCSAN uses can see pointless errors.

Both from Peter Zijlstra.

----------------------------------------------------------------
Peter Zijlstra (2):
      locking/atomics: Provide the arch_atomic_ interface to generic code
      rcu: Fixup noinstr warnings

 include/linux/atomic-fallback.h       | 236 +++++++++++++++++++++++++++++++++-
 include/linux/compiler.h              |   2 +-
 kernel/rcu/tree.c                     |  32 ++++-
 scripts/atomic/gen-atomic-fallback.sh |  31 +++++
 4 files changed, 292 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
