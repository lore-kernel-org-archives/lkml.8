Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B76C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F39208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgGaMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:05 -0400
Received: from foss.arm.com ([217.140.110.172]:56156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbgGaMFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF3D91FB;
        Fri, 31 Jul 2020 05:05:03 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C538F3F71F;
        Fri, 31 Jul 2020 05:05:02 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v4 00/10] sched: Instrument sched domain flags
Date:   Fri, 31 Jul 2020 12:54:52 +0100
Message-Id: <20200731115502.12954-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've repeatedly stared at an SD flag and asked myself "how should that be
set up in the domain hierarchy anyway?". I figured that if we formalize our
flags zoology a bit, we could also do some runtime assertions on them -
this is what this series is all about.

Patches
=======

The idea is to associate the flags with metaflags that describes how they
should be set in a sched domain hierarchy ("if this SD has it, all its {parents,
children} have it") or how they behave wrt degeneration - details are in the
comments and commit logs. 

The good thing is that the debugging bits go away when CONFIG_SCHED_DEBUG isn't
set. The bad thing is that this replaces SD_* flags definitions with some
unsavoury macros. This is mainly because I wanted to avoid having to duplicate
work between declaring the flags and declaring their metaflags.

o Patches 1-3 are topology cleanups / fixes
o Patches 4-6 instrument SD flags and add assertions
o Patches 7-10 leverage the instrumentation to factorize domain degeneration

Revisions
=========

v3 -> v4
--------

o Reordered the series to have fixes / cleanups first

o Added SD_ASYM_CPUCAPACITY propagation (Quentin)
o Made ARM revert back to the default sched topology (Dietmar)
o Removed SD_SERIALIZE degeneration special case (Peter)

o Made SD_NUMA and SD_SERIALIZE have SDF_NEEDS_GROUPS

  As discussed on v3, I thought this wasn't required, but thinking some more
  about it there can be cases where that changes the current behaviour. For
  instance, in the following wacky triangle:

      0\ 30
      | \
  20  |  2
      | /
      1/ 30

  there are two unique distances thus two NUMA topology levels, however the
  first one for node 2 would have the same span as its child domain and thus
  should be degenerated. If we don't give SD_NUMA and SD_SERIALIZE
  SDF_NEEDS_GROUPS, this domain wouldn't be denegerated since its child
  *doesn't* have either SD_NUMA or SD_SERIALIZE (it's the first NUMA domain),
  and we'd have this weird NUMA domain lingering with a single group.

v2 -> v3
--------

o Reworded comment for SD_OVERLAP (it's about the groups, not the domains)

o Added more flags to the SD degeneration mask
o Added generation of an SD flag mask for the degeneration functions (Peter)

RFC -> v2
---------

o Rebased on top of tip/sched/core
o Aligned wording of comments between flags
o Rectified some flag descriptions (Morten)
o Added removal of SD_SHARE_POWERDOMAIN (Morten)

Valentin Schneider (10):
  ARM, sched/topology: Remove SD_SHARE_POWERDOMAIN
  ARM: Revert back to default scheduler topology.
  sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
  sched/topology: Split out SD_* flags declaration to its own file
  sched/topology: Define and assign sched_domain flag metadata
  sched/topology: Verify SD_* flags setup when sched_debug is on
  sched/topology: Add more flags to the SD degeneration mask
  sched/topology: Remove SD_SERIALIZE degeneration special case
  sched/topology: Introduce SD metaflag for flags needing > 1 groups
  sched/topology: Use prebuilt SD flag degeneration mask

 arch/arm/kernel/topology.c     |  26 ------
 include/linux/sched/sd_flags.h | 156 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  36 +++++---
 kernel/sched/topology.c        |  54 ++++++------
 4 files changed, 204 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

--
2.27.0

