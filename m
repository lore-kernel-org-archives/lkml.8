Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA702085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGATHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:07:21 -0400
Received: from foss.arm.com ([217.140.110.172]:39768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgGATHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48DFE1FB;
        Wed,  1 Jul 2020 12:07:20 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48AAF3F68F;
        Wed,  1 Jul 2020 12:07:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 0/7] sched: Instrument sched domain flags
Date:   Wed,  1 Jul 2020 20:06:48 +0100
Message-Id: <20200701190656.10126-1-valentin.schneider@arm.com>
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

o Patches 1-2 set up the SD flag definition groundwork
o Patch 3 enables the hierarchy debugging
o Patch 4 is a derelict SD flag removal
o Patches 5-7 tweak the SD degeneration to leverage metaflags as well (suggested
  by Peter).

  Note that this builds a compile-time mask using the single most horrendous
  macro I have ever presented to the public eye. It might end up being much
  better to explicitely build the mask in topology.h, but to be honest I felt
  like I had to show that monster around out of morbid fascination.

Revisions
=========

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

Valentin Schneider (7):
  sched/topology: Split out SD_* flags declaration to its own file
  sched/topology: Define and assign sched_domain flag metadata
  sched/topology: Verify SD_* flags setup when sched_debug is on
  arm, sched/topology: Remove SD_SHARE_POWERDOMAIN
  sched/topology: Add more flags to the SD degeneration mask
  sched/topology: Introduce SD metaflag for flags needing > 1 groups
  sched/topology: Use prebuilt SD flag degeneration mask

 arch/arm/kernel/topology.c     |   2 +-
 include/linux/sched/sd_flags.h | 153 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  36 +++++---
 kernel/sched/topology.c        |  40 +++++----
 4 files changed, 197 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

--
2.27.0

