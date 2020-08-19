Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B13C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC79204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgHSNfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:35:50 -0400
Received: from foss.arm.com ([217.140.110.172]:36864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgHSNda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:33:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6421FB;
        Wed, 19 Aug 2020 06:33:28 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1710E3F71F;
        Wed, 19 Aug 2020 06:33:26 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, swboyd@chromium.org, sumit.garg@linaro.org
Subject: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
Date:   Wed, 19 Aug 2020 14:34:12 +0100
Message-Id: <20200819133419.526889-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series makes the arm_pmu driver use NMIs for the perf interrupt when
NMIs are available on the platform (currently, only arm64 + GICv3). To make
it easier to play with the patches, I've pushed a branch at [1]:

$ git clone -b pmu-nmi-v6 git://linux-arm.org/linux-ae

I've tested the series on an espressobin v7*. These are the results of
running perf record -a -- sleep 60:

1. Without the patches:

    16.73%  [k] arch_local_irq_enable
    12.20%  [k] arch_cpu_idle
     8.61%  [k] _raw_spin_unlock_irqrestore
     4.09%  [k] arch_local_irq_enable
     2.25%  [k] arch_local_irq_enable
     1.82%  [k] arch_counter_get_cntpct
     [..]

2. Using NMIs:

     3.37%  [k] arch_counter_get_cntpct
     2.62%  [.] _IO_fwrite
     1.62%  [.] __gconv_transform_ascii_internal
     1.49%  [.] __mbrtowc
     1.44%  [k] el0_svc_common
     1.31%  [.] strchr
     [..]

When running perf record -a -- iperf3 -c 127.0.0.1 -t 60:

1. Without the patches:
    24.25%  [k] __arch_copy_from_user
    20.94%  [k] __arch_copy_to_user
     5.71%  [k] arch_local_irq_enable
     3.12%  [k] _raw_spin_unlock_irqrestore
     2.01%  [k] __free_pages_ok
     1.48%  [k] arch_cpu_idle
     [..]

2. Using NMIs:

    23.15%  [k] __arch_copy_from_user
    21.68%  [k] __arch_copy_to_user
     1.23%  [k] tcp_ack
     1.08%  [k] tcp_sendmsg_locked
     0.97%  [k] rmqueue
     0.91%  [k] __free_pages_ok
     [..]

I've ran the same tests in a VM when both host+guest use NMIs, and when
neither use them. All of these tests were also ran on the model.  Similar
results in all cases.

* All the firmware versions for espressobin v7 that I've tried clear
SCR_EL3.FIQ, which means that NMIs don't work. To make them work on the
board, I modified the GICv3 driver. That's why I would really appreciate
someone testing this series on a board where NMIs work without any GIC
changes. For people who want to test the series, but don't have a board
with firmware that sets SCR_EL3.FIQ, I've pushed a branch [2] with the
GICv3 drivers changes necessary to make NMIs work:

$ git clone -b pmu-nmi-v6-nmi-fiq-clear-v2 git://linux-arm.org/linux-ae

Summary of the patches:
* Patch 1 is a fix for a bug that Julien found during the review for v4.
* Patches 2 and 3 remove locking from arm64 perf event code.
* Patches 4 and 5 makes the arm64 PMU interrupt handler NMI safe.
* Patches 6 and 7 enable the use of NMIs on arm64 with a GICv3 irqchip.

Changes since v5 [3]:
- Rebased on top of v5.9-rc1.
- Typo fixes.
- Added comments to the ISB added by patches #1 and #2.
- Reworded message for patch #4, as per Mark's excellent suggestion.

Changes since v4 [4]:
- Rebased on top of v5.8-rc1 and dropped the Tested-by tags because it's
  been almost a year since the series has been tested.
- Dropped patch 3 because I couldn't find any instance where
  armv7pmu_read_counter() was called with interrupts enabled. I've also
  tested this by running several instances of perf for a few hours, and the
  function was called every time with interrupts disabled.
- Dropped patches 4 and 5 because the tradeoff wasn't worth it in my
  opinion: the irq handler was slower all the time (because it
  saved/restored the counter select register), in exchange for being
  slightly faster on the rare ocassions when it triggered at the beginning
  of the critical sections.
- Minor changes here and there to address review comments.

Changes since v3 [5]:
- Added tags
- Fix build issue for perf_event_v6
- Don't disable preemption in pmu->enable()
- Always rely on IPI_IRQ_WORK to run the queued work
- Fixed typos + cleanups

Changes since v2 [6]:
- Rebased on recent linux-next (next-20190708)
- Fixed a number of bugs with indices (reported by Wei)
- Minor style fixes

Changes since v1 [7]:
- Rebased on v5.1-rc1
- Pseudo-NMI has changed a lot since then, use the (now merged) NMI API
- Remove locking from armv7 perf_event
- Use locking only in armv6 perf_event
- Use direct counter/type registers insted of selector register for armv8

[1] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v6
[2] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v6-nmi-fiq-clear-v2
[3] https://www.spinics.net/lists/kernel/msg3554236.html
[4] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/666824.html
[5] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/665339.html
[6] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640536.html
[7] https://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554611.html

Alexandru Elisei (1):
  arm64: perf: Add missing ISB in armv8pmu_enable_event()

Julien Thierry (5):
  arm64: perf: Remove PMU locking
  arm64: perf: Defer irq_work to IPI_IRQ_WORK
  KVM: arm64: pmu: Make overflow handler NMI safe
  arm_pmu: Introduce pmu_irq_ops
  arm_pmu: arm64: Use NMIs for PMU

Mark Rutland (1):
  arm64: perf: Avoid PMXEV* indirection

 arch/arm64/kernel/perf_event.c | 145 +++++++++++++++++++++------------
 arch/arm64/kvm/pmu-emul.c      |  25 +++++-
 drivers/perf/arm_pmu.c         | 142 +++++++++++++++++++++++++++-----
 include/kvm/arm_pmu.h          |   1 +
 4 files changed, 241 insertions(+), 72 deletions(-)

-- 
2.28.0

