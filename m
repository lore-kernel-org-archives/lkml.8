Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E73B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgCXEqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:46:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgCXEqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:46:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE759AE1C;
        Tue, 24 Mar 2020 04:46:04 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     bigeasy@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -tip 0/4] kvm: Use rcuwait for vcpu blocking
Date:   Mon, 23 Mar 2020 21:44:49 -0700
Message-Id: <20200324044453.15733-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following is an updated revision of the kvm vcpu to rcuwait conversion[0],
following the work on completions using simple waitqueues.

Changes from then:
  - patch 2: Make rcuwait_wake_up() propagate the return value from
    wake_up_process - Sebastian and Peter.

  - patch 3:
      o Added mips changes I missed.
      o Fixed broken compilation on power, adding the vcore bits that
        kvm-hv uses (a vcore blocking when all vcpus are blocked) - Paolo.
      o Use TASK_IDLE instead of TASK_INTERRUPTIBLE - Peter.

  - patch 4: fixed swait function name typo.

This has only been run tested on x86 but compile tested on mips, powerpc
and arm32. 

This series applies on top of current -tip, which has the required rcuwait
api extension.

[0] https://lore.kernel.org/lkml/20200320085527.23861-3-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (4):
  rcuwait: Fix stale wake call name in comment
  rcuwait: Let rcuwait_wake_up() return whether or not a task was awoken
  kvm: Replace vcpu->swait with rcuwait
  sched/swait: Reword some of the main description

 arch/mips/kvm/mips.c                  |  6 ++----
 arch/powerpc/include/asm/kvm_book3s.h |  2 +-
 arch/powerpc/include/asm/kvm_host.h   |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 22 ++++++++--------------
 arch/powerpc/kvm/powerpc.c            |  2 +-
 arch/x86/kvm/lapic.c                  |  2 +-
 include/linux/kvm_host.h              | 10 +++++-----
 include/linux/rcuwait.h               |  2 +-
 include/linux/swait.h                 | 23 +++++------------------
 kernel/exit.c                         |  9 ++++++---
 virt/kvm/arm/arch_timer.c             |  2 +-
 virt/kvm/arm/arm.c                    |  9 +++++----
 virt/kvm/async_pf.c                   |  3 +--
 virt/kvm/kvm_main.c                   | 31 +++++++++++--------------------
 14 files changed, 49 insertions(+), 76 deletions(-)

--
2.16.4

