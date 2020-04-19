Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF3C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766F2221E9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261479;
	bh=kh7WcQjNju4Y8PEW2fTP4OcZ/v4VFf1B63b0MM8xKXE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FBhmEx/bwq55of/BStvR/UoeZ6kNf2vS+VJ6/0Wpo9tFr+iKx4UqXysfp2/89pvGk
	 xY4JSPboPlBYcLL2WT8HyzhGlynkL1XTwxw4mSkpcj6BLL16CGVf1YOFBwqgL3mCyO
	 jBMEMxLPhG2qgK4Jqa7CuPOTM0mt2Q3Va7QAsSCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSB56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgDSB56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:57:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30BB21924;
        Sun, 19 Apr 2020 01:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261477;
        bh=kh7WcQjNju4Y8PEW2fTP4OcZ/v4VFf1B63b0MM8xKXE=;
        h=From:To:Cc:Subject:Date:From;
        b=FrXePC6rLf0z8wJmQ67dnSh6jpH/TXqBBmndx/15wuCz9DDPqWMpHZWJDcF6hR2+6
         UqHz4mQK/ZxgR3VTf3s/vLvijIsNuB/wiVR0pt7NFbHVrZ2PEuaIjMmXSiEjRbRD+k
         EIfpiihqH8r2HunGrMCEzXD+uSHQ9tyzGXdk6Slg=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 00/12] Fix up liblockdep for 5.7-rc
Date:   Sat, 18 Apr 2020 21:57:42 -0400
Message-Id: <20200419015754.24456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

This series fixes up most of liblockdep to work with the current kernel
tree.

Change in v2:

 - Rebase on top of the 5.7 merge window work.

Sasha Levin (12):
  tools headers: Add kprobes.h header
  tools headers: Add rcupdate.h header
  tools/kernel.h: extend with dummy RCU functions
  tools bitmap: add bitmap_andnot definition
  tools/lib/lockdep: add definition required for IRQ flag tracing
  tools/kernel.h: add BUILD_BUG_ON_NOT_POWER_OF_2 macro
  tools bitmap: add bitmap_clear definition
  tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
  tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
  tools/lib/lockdep: New stacktrace API
  tools/lib/lockdep: call lockdep_init_task on init
  tools/lib/lockdep: switch to using lockdep_init_map_waits

 tools/include/linux/bitmap.h                  | 10 ++++++
 tools/include/linux/kernel.h                  | 15 ++++++++
 tools/include/linux/kprobes.h                 |  7 ++++
 tools/include/linux/lockdep.h                 |  9 +++++
 tools/include/linux/rcupdate.h                | 12 +++++++
 tools/include/linux/stacktrace.h              |  8 +++++
 tools/lib/bitmap.c                            | 35 +++++++++++++++++++
 tools/lib/lockdep/Build                       |  2 +-
 tools/lib/lockdep/Makefile                    |  2 +-
 tools/lib/lockdep/include/liblockdep/common.h |  4 +--
 tools/lib/lockdep/include/liblockdep/mutex.h  |  2 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h |  2 +-
 tools/lib/lockdep/lockdep.c                   |  4 +--
 tools/lib/lockdep/preload.c                   |  6 +++-
 14 files changed, 109 insertions(+), 9 deletions(-)
 create mode 100644 tools/include/linux/kprobes.h
 create mode 100644 tools/include/linux/rcupdate.h

-- 
2.20.1

