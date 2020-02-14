Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D028C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266D2217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581693986;
	bh=cI43QToW0rheWH4+4zHAIgLsrAKOLZHrFyGcS2/lDds=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XO7/J1VEN7phSe2FirtzPodVw+SnF52prg4PtpdC+lDcnJ2vHTD7hBMmANvUQ5It2
	 djpwiyhYyEuhbYsnQ/dzA1JgmzKVF6lPXydfJcs7wlvcIu3lSmxGu+UzXf2nfvQd9L
	 LZ1Wka1vhSDHqZKzS9Lqzj0h/08yUwKS/Fw2j0UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgBNP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgBNP0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:25 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A1C52168B;
        Fri, 14 Feb 2020 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581693984;
        bh=cI43QToW0rheWH4+4zHAIgLsrAKOLZHrFyGcS2/lDds=;
        h=From:To:Cc:Subject:Date:From;
        b=O7jHVBI6xRY4D8Ul0sNkQJPtfqqN/WJakl5yeHEQIgVjXoxWHbgD5Bktu6/in7aLi
         gR3qEBHLJvf/dxZBifbb8g45JNCBEuqP7zmsUmx7odtAxBYj+U3KlQjDE1RP5a0n00
         JlgfEFtVHDL/CFv9MfvzsnDk0bpAfdUpznBbzCec=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/5] context_tracking: Remove TIF_NOHZ from 3 archs 
Date:   Fri, 14 Feb 2020 16:26:10 +0100
Message-Id: <20200214152615.25447-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIF_NOHZ is getting deprecated by static keys which avoid to invoke
syscall slow path on every syscall. So remove that flag from
architectures that don't need it anymore (or worse yet: that spuriously
triggered syscall slow path when it's not needed anymore).

We hope to remove TIF_NOHZ entirely in the long run (PPC, MIPS, SPARC).
If we want to be able to enable/disable nohz full dynamically on runtime,
freezing all tasks and iterating through the whole tasklist to set/clear
TIF_NOHZ doesn't sound very appealing.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	arch/nohz
	
WARNING: untested on ARM 32

HEAD: 92502ebbf06ac37858694ed8f9d16fdb13ed0fe3

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      context-tracking: Introduce CONFIG_HAVE_TIF_NOHZ
      x86: Remove TIF_NOHZ
      arm: Remove TIF_NOHZ
      arm64: Remove TIF_NOHZ

Thomas Gleixner (1):
      x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY


 arch/Kconfig                         | 16 +++++++++++-----
 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm64/include/asm/thread_info.h |  4 +---
 arch/mips/Kconfig                    |  1 +
 arch/powerpc/Kconfig                 |  1 +
 arch/sparc/Kconfig                   |  1 +
 arch/x86/include/asm/thread_info.h   | 10 ++--------
 kernel/context_tracking.c            |  2 ++
 8 files changed, 19 insertions(+), 17 deletions(-)
