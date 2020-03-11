Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9D2C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F1206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgCKSdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:33:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:33:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290011FB;
        Wed, 11 Mar 2020 11:33:31 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29FAB3F6CF;
        Wed, 11 Mar 2020 11:33:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [RFC PATCH 0/3] sched: Instrument sched domain flags
Date:   Wed, 11 Mar 2020 18:33:17 +0000
Message-Id: <20200311183320.19186-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
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

Note that this is based on top of my select_task_rq() series [1], since it
removes SD_LOAD_BALANCE. If that other series dies I can go and rebase this
again on a branch that still has the flag.

Patches
=======

The idea is to associate the flags with a metatype that describes how they
should be set in a sched domain hierarchy - details are in the comments and
commit logs. For now it's just a simple parent/children relationship
description ("if this SD has it, all its {parents, children} have it").

The good thing is that this all goes away when CONFIG_SCHED_DEBUG isn't
set. The bad thing is that replaces SD_* flags definitions with some
unsavoury macros. This is mainly because I wanted to avoid having to
duplicate work between declaring the flags and declaring their types.

Discussion points
=================

I've gone with a flags field so that several behaviours can be associated
with a given SD flag, but right now they only get assigned one. An enum
could fit that job, although it's more constraining.

Naming is also a pain. I'm not really hot on "shared", but that's as
explicit as I managed to be.

I've inserted the reasoning behind the metaflag assignment in
comments. They might be a bit too wordy, so we may want to make them a bit
more broad to lessen the maintenance burden.

Lastly, since this adds an infrastructure to store flag names, we could use
that to pretty-print /proc/sys/kernel/sched_domain/cpu*/domain*/flags.

Some deltas
===========

I get a small codesize increase with SCHED_DEBUG=n due to the first
patch:

$ compare.sh before after vmlinux.o
SYMBOL                   BEFORE     AFTER  DELTA
build_sched_domains      4552       4588   +36

For instance, while my baseline would have this (this is all in sd_init()):

0078    a90c8:	d63f0000 	blr	x0
007c    a90cc:	1284b801 	mov	w1, #0xffffda3f // ~TOPOLOGY_SD_FLAGS
0080    a90d0:	6a010001 	ands	w1, w0, w1
0084    a90d4:	54000c81 	b.ne	a9264 <sd_init+0x214>

The change would have this:

0078    a90c8:	d63f0000 	blr	x0
007c    a90cc:	2a0003e1	mov	w1, w0
0080    a90d0:	1284b800	mov	w0, #0xffffda3f // ~TOPOLOGY_SD_FLAGS
0084    a90d4:	6a00003f	tst	w1, w0
0088    a90d8:	54000c81	b.ne	a9268 <sd_init+0x218>

Sadly, the exact reasons why elude me.

[1]: https://lore.kernel.org/lkml/20200311181601.18314-1-valentin.schneider@arm.com/

Valentin Schneider (3):
  sched/topology: Split out SD_* flags declaration to its own file
  sched/topology: Define and assign sched_domain flag metadata
  sched/topology: Verify SD_* flags setup when sched_debug is on

 include/linux/sched/sd_flags.h | 139 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  29 +++----
 kernel/sched/topology.c        |  16 ++++
 3 files changed, 170 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

--
2.24.0

