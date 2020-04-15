Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD80C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A2420775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634918AbgDOGkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:40:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393565AbgDOGkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:40:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FFDD31B;
        Tue, 14 Apr 2020 23:40:12 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3062E3F73D;
        Tue, 14 Apr 2020 23:44:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.com, mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64/hotplug: Process MEM_OFFLINE and MEM_CANCEL_OFFLINE events
Date:   Wed, 15 Apr 2020 12:09:42 +0530
Message-Id: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves arm64 memory event notifier (hot remove) robustness by
enabling it to detect potential problems (if any) in the future. But first
it enumerates memory isolation failure reasons that can be sent across a
notifier. This series does not go beyond arm64 to explore if these failure
reason codes could be used in other existing registered memory notifiers.
Please do let me know if there is any other potential use cases, will be
happy to incorporate next time around. Also should we add similar failure
reasons for online_pages() as well ?

This series has been tested on arm64, boot tested on x86 and build tested
on multiple other platforms.

This series applies on v5.7-rc1.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  mm/hotplug: Enumerate memory range offlining failure reasons
  arm64/hotplug: Process MEM_OFFLINE and MEM_CANCEL_OFFLINE

 arch/arm64/mm/mmu.c    | 52 ++++++++++++++++++++++++++++++++++++++----
 drivers/base/memory.c  |  9 ++++++++
 include/linux/memory.h | 27 ++++++++++++++++++++++
 mm/memory_hotplug.c    | 24 ++++++++++++-------
 4 files changed, 99 insertions(+), 13 deletions(-)

-- 
2.20.1

