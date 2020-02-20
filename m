Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F51C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30162208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582211654;
	bh=Seg2LhjjPAxqOZnI9OgrKZh0kE8TcZAm7iss4ZsKB3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gh9icnws2qzmzKthmeIB6G7Ps7MPgWH6Q6LMMXZr9EkmdSynI3PNtXQHFu2/WbdMj
	 XaBiYekKfbX3lBDYL6Wlzi62lA6HlBYJX6JTa/1PRrR3TT8oDfVR+hkr3tXlJvaoBl
	 Dej1UiqlbrT0wkqPYpNdgJbOLAN3m4Uxg7eMDIGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgBTPOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgBTPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:14:10 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADB4208CD;
        Thu, 20 Feb 2020 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582211650;
        bh=Seg2LhjjPAxqOZnI9OgrKZh0kE8TcZAm7iss4ZsKB3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u4eH2lJ5NovDucny4gD3ssoatiKK2wn2YlK7Y60orzKkpKJOoxVyrVkih/bcOmtM
         RWu/Rp49efHgNugTWvYDTfpUQmJwR1iaoc7mNMlrr4jDEeVGLWUIfJhSZSIrHLRV3D
         CiVTq6eoV1/2GVviLdIgOB71YqCAOw2PDUMSIfyU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [GIT PULL] context_tracking: Remove TIF_NOHZ from 3 archs
Date:   Thu, 20 Feb 2020 16:13:56 +0100
Message-Id: <20200220151356.17637-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214152615.25447-1-frederic@kernel.org>
References: <20200214152615.25447-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Thomas,

Please pull the arch/nohz branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	arch/nohz

HEAD: 320a4fc2d1b0c2314342dfdd3348270f126196a4

---
TIF_NOHZ is getting deprecated by static keys which avoid to invoke
syscall slow path on every syscall. So remove that flag from
architectures that don't need it anymore (or worse yet: that spuriously
triggered syscall slow path when it's not needed anymore).

We hope to remove TIF_NOHZ entirely in the long run (PPC, MIPS, SPARC).
If we want to be able to enable/disable nohz full dynamically on runtime,
freezing all tasks and iterating through the whole tasklist to set/clear
TIF_NOHZ doesn't sound very appealing.

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
