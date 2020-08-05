Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D020C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1BB22CB1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586248;
	bh=hPh9a5K+JO7FZ24OQs/uYtDg+z8Ao/yDHMZel4HeRn4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Yl4cw69ptotQ9kZNV4oYD/6HfYCPFzzECH9LmnYa4GaSsmLA8B/wP5eB+hHIMsK0I
	 YLYVsAArAx4IAQycE2fDrhi0fP7PlVGhF3PdR2C0brCOQ4FimUE/eLqoWL2A8ojuCs
	 yA8kOyn+8TZSF5gdpUqQOILgW9s2URZDZ0/o9LJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHEAKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgHEAKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9136D206DA;
        Wed,  5 Aug 2020 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586246;
        bh=hPh9a5K+JO7FZ24OQs/uYtDg+z8Ao/yDHMZel4HeRn4=;
        h=From:To:Cc:Subject:Date:From;
        b=TI7oOxA34oduENBe0/J7nfhBE1OcbWqcA+c31ByfqYZCJFCJC6Eb+DgA6WABOI8pL
         hb32EiuPvhjLVZ7CizPTd7ZEe0xr1blWQMrsIqkV3GgFvqslx0Du+OxprOY2ouNUBd
         e2edSs6o0DwA4MsuqbiwBheNeFeIkOeMyiQ2mo2s=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 00/14] liblockdep fixes for 5.9-rc1
Date:   Tue,  4 Aug 2020 20:10:29 -0400
Message-Id: <20200805001043.3331907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider applying these patches for liblockdep, or alternatively
pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git tags/liblockdep-fixes-040820

The patches fix up compilation and functionality of liblockdep on 5.8,
they were tested using liblockdep's internal testsuite.

I was unable to get the x86 folks to pull these fixes for the past few
months:

 - https://lkml.org/lkml/2020/2/17/1089
 - https://lkml.org/lkml/2020/4/18/817
 - https://lkml.org/lkml/2020/6/22/1262

Which is why this pull request ends up going straight to you.


Sasha Levin (14):
  tools headers: Add kprobes.h header
  tools headers: Add rcupdate.h header
  tools/kernel.h: extend with dummy RCU functions
  tools bitmap: add bitmap_andnot definition
  tools/lib/lockdep: add definition required for IRQ flag tracing
  tools bitmap: add bitmap_clear definition
  tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
  tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
  tools/lib/lockdep: New stacktrace API
  tools/lib/lockdep: call lockdep_init_task on init
  tools/lib/lockdep: switch to using lockdep_init_map_waits
  tools/kernel.h: hide noinstr
  tools/lib/lockdep: explicitly declare lockdep_init_task()
  tools/kernel.h: hide task_struct.hardirq_chain_key

 tools/include/linux/bitmap.h                  | 10 ++++++
 tools/include/linux/kernel.h                  | 11 ++++++
 tools/include/linux/kprobes.h                 |  7 ++++
 tools/include/linux/lockdep.h                 | 10 ++++++
 tools/include/linux/rcupdate.h                | 12 +++++++
 tools/include/linux/stacktrace.h              |  8 +++++
 tools/lib/bitmap.c                            | 35 +++++++++++++++++++
 tools/lib/lockdep/Build                       |  2 +-
 tools/lib/lockdep/Makefile                    |  2 +-
 tools/lib/lockdep/include/liblockdep/common.h |  4 +--
 tools/lib/lockdep/include/liblockdep/mutex.h  |  2 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h |  2 +-
 tools/lib/lockdep/lockdep.c                   |  4 +--
 tools/lib/lockdep/preload.c                   |  8 ++++-
 14 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 tools/include/linux/kprobes.h
 create mode 100644 tools/include/linux/rcupdate.h

-- 
2.25.1

