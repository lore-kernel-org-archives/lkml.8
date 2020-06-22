Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A981C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4FF20776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865787;
	bh=adOZdv3SYieL9hgLbbyrBQ4+44f+L6BK/R5WYMPBOGI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GKxrw5tGVRoEjZv4zoSm3agRLHC2mz5pLuSBRqfgAwkqZt77XIvinZTtmMx2KtQKw
	 B3MQc5pdlG4BFfjm+0IJ6vNZI2jKyE2VcPe/2VjdE0KUQgWC3bHlJrawanatFI90ff
	 MK/pA93J8CyY7s3JgLkSPj6gpwPpEemdDWKgzyds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFVWnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbgFVWnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121DC2075A;
        Mon, 22 Jun 2020 22:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865782;
        bh=adOZdv3SYieL9hgLbbyrBQ4+44f+L6BK/R5WYMPBOGI=;
        h=From:To:Cc:Subject:Date:From;
        b=dKQ2UGXx2lqVnP12zlv3VXZHNqo8KJuNP4jza47Kp2uR8y0sRpSrB5kC7azBwJH1F
         doLMCpyMs0AVsMdKmHYroNojUrHY4sPvPtIcKeW0XPN4hW9UCPzOpgC/eMzpDJo+1w
         9+cBUeWoVfFhymY+6uN4BF4isDc1n8lpbaa1YIZA=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 00/14] Fix up liblockdep for 5.8-rc
Date:   Mon, 22 Jun 2020 18:42:44 -0400
Message-Id: <20200622224258.1208588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This series fixes up most of liblockdep to work with the current kernel
tree.

Change in v3:

 - Rebase on top of the 5.8 merge window work.

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

