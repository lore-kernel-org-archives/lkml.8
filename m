Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DF2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgC3OuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:50:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgC3OuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:50:00 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIvji-0006ub-0C; Mon, 30 Mar 2020 16:49:58 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 84CBC1040EC;
        Mon, 30 Mar 2020 16:49:57 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:47:15 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/splitlock for v5.7
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
Message-ID: <158557963557.22376.16443742264836974381.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/splitlock branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2020-03-30

up to:  a6a60741035b: x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR

Support for "split lock" detection:

  - Atomic operations (lock prefixed instructions) which span two cache
    lines have to acquire the global bus lock. This is at least 1k cycles
    slower than an atomic operation within a cache line and disrupts
    performance on other cores. Aside of performance disruption this is
    a unpriviledged form of DoS.

    Some newer CPUs have the capability to raise an #AC trap when such an
    operation is attempted. The detection is by default enabled in warning
    mode which will warn once when a user space application is caught. A
    command line option allows to disable the detection or to select fatal
    mode which will terminate offending applications with SIGBUS.

Thanks,

	tglx

------------------>
Peter Zijlstra (Intel) (1):
      x86/split_lock: Enable split lock detection by kernel

Xiaoyao Li (2):
      x86/split_lock: Rework the initialization flow of split lock detection
      x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR


 Documentation/admin-guide/kernel-parameters.txt |  22 +++
 arch/x86/include/asm/cpu.h                      |  12 ++
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/msr-index.h                |   9 ++
 arch/x86/include/asm/thread_info.h              |   4 +-
 arch/x86/kernel/cpu/common.c                    |   2 +
 arch/x86/kernel/cpu/intel.c                     | 183 ++++++++++++++++++++++++
 arch/x86/kernel/process.c                       |   3 +
 arch/x86/kernel/traps.c                         |  24 +++-
 9 files changed, 258 insertions(+), 3 deletions(-)


