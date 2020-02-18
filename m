Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8CC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1320836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993704;
	bh=XH5iB9f1dmERpE6xdcPaepbwbKEyA9Sq6atMt4Jc9js=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zA7hI5bMYPALlKDuNrE7pUPVW7aCqcKMGyyzKaGivaVZcoyeDi1CkUKr+pyQtUMlX
	 /LQ+fRhe57D0Wfa/RLDFps0LDLDIXHeiiFobNRg3PXMHfjMCww8zsCWxatUkGlGcnE
	 zv4STYHsHJ6yklH/ZUsZ3+0WgDDQlaeCmMuQ7ZSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgBRCln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgBRClm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E26206D5;
        Tue, 18 Feb 2020 02:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993702;
        bh=XH5iB9f1dmERpE6xdcPaepbwbKEyA9Sq6atMt4Jc9js=;
        h=From:To:Cc:Subject:Date:From;
        b=UnY/+E4Ldu8G9sVcA6fZyfX+dYMIySUwAKeiVaVF6gDNz3FdmCLBjd/xgpKLsIJQ4
         zRR0cftWN/TBKIJDT5zSJi/MtQyq9cle3iRO9n7dwz4RtAlC241tW9jpOPZzhU0qaT
         vLMtFekaazLY+MJMG/oY6MFeORvQwsfnnDx2yFb8=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 00/11] Fix up liblockdep for 5.6-rc
Date:   Mon, 17 Feb 2020 21:41:22 -0500
Message-Id: <20200218024133.5059-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I'm sorry for taking so long on this.

This series fixes up most of liblockdep to work with the recent kernel
changes. There is another failure with threaded lockup detection that
I'll work on fixing this week.

Also available via git-pull:

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git liblockdep-fixes

Sasha Levin (11):
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

 tools/include/linux/bitmap.h     | 10 +++++++++
 tools/include/linux/kernel.h     | 13 ++++++++++++
 tools/include/linux/kprobes.h    |  7 +++++++
 tools/include/linux/lockdep.h    |  8 ++++++++
 tools/include/linux/rcupdate.h   | 12 +++++++++++
 tools/include/linux/stacktrace.h |  8 ++++++++
 tools/lib/bitmap.c               | 35 ++++++++++++++++++++++++++++++++
 tools/lib/lockdep/Build          |  2 +-
 tools/lib/lockdep/Makefile       |  2 +-
 tools/lib/lockdep/lockdep.c      |  4 ++--
 tools/lib/lockdep/preload.c      |  4 ++++
 11 files changed, 101 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/linux/kprobes.h
 create mode 100644 tools/include/linux/rcupdate.h

-- 
2.20.1

