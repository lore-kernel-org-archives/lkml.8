Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149892076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563688;
	bh=UhWUiz4i2ua+ePQnkwga76Is6IlUX/kwGgzY/Tlf9Rw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XNol+uPPwLwuoyH8SS/Dtu6lfT0n6u25L6Y5T71qNchIh6NUgZO6Gfy75uE6RoB3T
	 RcSyzE6GnI43Jijq/N/5JaCqKoaOT+mRda/z9jjNktq8dNShw5olpLIbodnvky8Gha
	 11hW1nwfPlcbjP6/e0UCsXnw8wzGIiBz0glBM1Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEOR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:07 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BE120727;
        Fri, 15 May 2020 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563686;
        bh=UhWUiz4i2ua+ePQnkwga76Is6IlUX/kwGgzY/Tlf9Rw=;
        h=From:To:Cc:Subject:Date:From;
        b=i7R/upiPvB13dzbce/7FCK5QI3Jiq/Z5T2Q3J68Qd/A3slV4cLoCuhd4eSBpgVDkD
         jZPNla3o9j8LB1rbB4PwVdTjs6EUjsgfTY3EU4SZPCJWbH1LVmbOBD5BZyO2+sqwxd
         mC+6RXA6dCAuCzZFdOkyHgziEbwGcl+65c0hEz6E=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 0/6] Clean up Shadow Call Stack patches for 5.8
Date:   Fri, 15 May 2020 18:27:50 +0100
Message-Id: <20200515172756.27185-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a series of cleanups I hacked together on top of a modified v13
of the Shadow Call Stack patches from Sami:

  https://lore.kernel.org/r/20200515172355.GD23334@willie-the-truck

The main changes are:

  * Move code out of arch/arm64 and into the core implementation
  * Store the full SCS stack pointer instead of the offset
  * Code simplification and general style things

I'd like to queue this on top early next week so that it can spend some
quality time in linux-next.

Cheers,

Will

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@am.com>
Cc: Jann Horn <jannh@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <kernel-team@android.com>

--->8

Will Deacon (6):
  arm64: scs: Store absolute SCS stack pointer value in thread_info
  scs: Move accounting into alloc/free functions
  arm64: scs: Use 'scs_sp' register alias for x18
  scs: Move scs_overflow_check() out of architecture code
  scs: Remove references to asm/scs.h from core code
  scs: Move DEFINE_SCS macro into core code

 arch/Kconfig                         |  4 +--
 arch/arm64/include/asm/scs.h         | 29 ++++------------
 arch/arm64/include/asm/thread_info.h |  4 +--
 arch/arm64/kernel/asm-offsets.c      |  2 +-
 arch/arm64/kernel/entry.S            | 10 +++---
 arch/arm64/kernel/head.S             |  2 +-
 arch/arm64/kernel/process.c          |  2 --
 arch/arm64/kernel/scs.c              |  6 +---
 include/linux/scs.h                  | 16 +++++----
 kernel/sched/core.c                  |  3 ++
 kernel/scs.c                         | 52 +++++++++++++---------------
 11 files changed, 55 insertions(+), 75 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

