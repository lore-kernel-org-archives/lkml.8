Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E934208C7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgFOXno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:43:44 -0400
Received: from foss.arm.com ([217.140.110.172]:56734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgFOXnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:43:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24671FB;
        Mon, 15 Jun 2020 16:43:42 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E28253F73C;
        Mon, 15 Jun 2020 16:43:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v2 0/4] sched: Instrument sched domain flags
Date:   Tue, 16 Jun 2020 00:41:50 +0100
Message-Id: <20200615234154.23982-1-valentin.schneider@arm.com>
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

The idea is to associate the flags with a metatype that describes how they
should be set in a sched domain hierarchy - details are in the comments and
commit logs. For now it's just a simple parent/children relationship
description ("if this SD has it, all its {parents, children} have it").

The good thing is that this all goes away when CONFIG_SCHED_DEBUG isn't
set. The bad thing is that replaces SD_* flags definitions with some
unsavoury macros. This is mainly because I wanted to avoid having to
duplicate work between declaring the flags and declaring their metatypes.

There's also the removal of yet another SD flag (SD_SHARE_POWERDOMAIN).

Some deltas
===========

This time around it's a slight size increase (w/o SCHED_DEBUG): 

  $ compare.sh before after vmlinux.o
  cpu_attach_domain                                         996       1000   +4
  build_sched_domains                                      4716       4728   +12

Comparing the objdumps side by side, nothing obvious stands out to me.

Revisions
=========

RFC -> v2
---------

RFC at: https://lkml.kernel.org/r/20200311183320.19186-1-valentin.schneider@arm.com

o Rebased on top of tip/sched/core
o Aligned wording of comments between flags
o Rectified some flag descriptions (Morten)
o Added removal of SD_SHARE_POWERDOMAIN (Morten)

Cheers,
Valentin

Valentin Schneider (4):
  sched/topology: Split out SD_* flags declaration to its own file
  sched/topology: Define and assign sched_domain flag metadata
  sched/topology: Verify SD_* flags setup when sched_debug is on
  arm, sched/topology: Remove SD_SHARE_POWERDOMAIN

 arch/arm/kernel/topology.c     |   2 +-
 include/linux/sched/sd_flags.h | 133 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  29 +++----
 kernel/sched/topology.c        |  27 +++++--
 4 files changed, 169 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

--
2.27.0

