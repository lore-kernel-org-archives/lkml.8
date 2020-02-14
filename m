Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04087C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D264C24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgBNS34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:29:56 -0500
Received: from foss.arm.com ([217.140.110.172]:43462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbgBNS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:29:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B98328;
        Fri, 14 Feb 2020 10:29:55 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5CEF3F68E;
        Fri, 14 Feb 2020 10:29:53 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [RFC PATCH v2 0/2] x86/resctrl: Start abstraction for a second arch
Date:   Fri, 14 Feb 2020 18:29:45 +0000
Message-Id: <20200214182947.39194-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

These two patches are the tip of the MPAM iceberg.

Arm have some CPU support for dividing caches into portions, and
applying bandwidth limits at various points in the SoC. The collective term
for these features is MPAM: Memory Partitioning and Monitoring.

MPAM is similar enough to Intel RDT, that it should use the defacto linux
interface: resctrl. This filesystem currently lives under arch/x86, and is
tightly coupled to the architecture.
Ultimately, my plan is to split the existing resctrl code up to have an
arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
MPAM can be wired up.


These two patches are step one: Split the two structs that resctrl uses
to have an arch<->fs split. These sit on top of the cleanup posted here:
lore.kernel.org/r/20200214182401.39008-1-james.morse@arm.com

I'm after strong opinions like "No! struct mbm_state is obviously arch
specific.". Making the hardware configuration belong to the arch code
instead of resctrl is so that it can be scaled on arm64, where MPAM
allows terrifyingly large portion bitmaps for the caches.



Last time these were posted, the request was for the spec, and to see
the whole fully assembled iceberg.

The spec is here:
https://static.docs.arm.com/ddi0598/ab/DDI0598A_b_MPAM_supp_armv8a.pdf

For a slightly dated view of the whole tree:
1. Don peril sensitive sunglasses
2. https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/feb

The tree is generally RFC-quality. It gets more ragged once you get out of
the x86 code. I anticipate all the arm64 code being rewritten before its
considered for merging.

(I haven't reposted the CDP origami as before, as I think that series
will be clearer if I re-order the patches ... it may even be shorter)


Does it all work? Almost. Monitor groups are proving to be a problem, I
can't see a way of getting these working without a user-visible change of
behaviour.
MPAMs counters aren't 1:1 with RMIDs, so supporting MBM_* on
any likely hardware will have to be via something other than resctrl.


Thanks,

James Morse (2):
  x86/resctrl: Split struct rdt_resource
  x86/resctrl: Split struct rdt_domain

 arch/x86/kernel/cpu/resctrl/core.c        | 257 +++++++++++++---------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  16 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 157 +++----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  29 ++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  77 ++++---
 include/linux/resctrl.h                   | 133 +++++++++++
 7 files changed, 389 insertions(+), 284 deletions(-)

-- 
2.24.1

