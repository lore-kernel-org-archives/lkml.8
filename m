Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A59AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE19214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580230752;
	bh=Y8gmhpy7aA2x1nJpmgB+C6ZeqfFdLQjHUNsvcu8jou8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VU6uvd40b7RlFVBQEaXDsa8nBwp814dWIWm9xXjx0qeXLaRa6+PJnJF2Y4OI4aFKE
	 6Ud0Orijs3Oj/RLILS3aiOiiCJV09T9YPq7wQvF5F0AYo0VByai8iQJer8pVBNrFQ1
	 dT8lQBZafB0P2pU7jgg1AUjJFhIW8FXrshSslir4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgA1Q7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:59:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35428 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgA1Q7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:59:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id b2so3396490wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cMsku35KnhtsQSwbUm1n8nvP2YJfD1rdyE47G4aUm3g=;
        b=izHDJTgvFVddJUg7MKINWtE6PVAcC7MFKP8ZCvEcc3XPv3W5NLYZeSiyLElstECuwm
         WDRrE5/bS5b0uTC1kJ5t1k0Q4/AotIYIHLm64ryHoSNr6tlkN7nFR7Hjm/y75y4dC9ca
         t7mmOohwD3GUy8V/rlQVaE7lyvYyd9yz5+YQhcKwOBs7mg3Szzu9tVi9jdl4UN2p5E1f
         LBZ63BL/dQyNUWXTZ9UEvns3ucassLa5WZHP8BlK+MA8IeyEjK5SLLqZuplUWsMCjxyh
         2DR3XsYo/KxC0NWTMBxt2SxHT3aNJ2lJtjYaTPcMQxsogREbx/MuxvJ6iLX6wj4AOZcf
         EbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=cMsku35KnhtsQSwbUm1n8nvP2YJfD1rdyE47G4aUm3g=;
        b=PatvOF44cpoX2zDrggNFI6wFwweTKWrvxBihB0vhnhpTqM2AelgmfD592nCSbF6tpr
         9Ww4T8/Dsmgr7YoJPqtsZsY/Hd2bwV70icglqttPzhNL9hNCpEK0LJ750CeEH7oQOIc9
         2c8EVuzvnT0yEDIhSDBmUF3UUOjdLBiWffXT+bHjuMR+ieKJH0LW7m3IB3wMwgP4cg9D
         IgKWWFtVVakJ1faiU3wGGdpvr9TWcEAS/yhliLEE2sp/VUWy79B0FvzIlEayNnJ7gZdZ
         XNxP2jAvFvmR8qv0SgxeHlKPyMbV5pkgCDZXigLQRd7qtjOccbvq54DkJER+BXkIdFcQ
         juYw==
X-Gm-Message-State: APjAAAW96YYkM2xBRZ93yJ21o0WTLiBxHT0D0pCn+0Bw51VtlnnDr+b0
        XDm3IB0ELtlEmJ+9IbZ4NuA=
X-Google-Smtp-Source: APXvYqwIBSXctCjIPEkCWLGqwr95oKrbpHSfUS2I1WdTdYcGuWgf19mwIkPNtQmlG1EO7EBGDGslhA==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr6123052wmm.143.1580230748475;
        Tue, 28 Jan 2020 08:59:08 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d8sm25374041wrx.71.2020.01.28.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 08:59:08 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:59:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200128165906.GA67781@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 183ef7adf4ed638ac0fb0c3c9a71fc00e8512b61 x86/boot: Simplify calculation of output address

Misc updates: 

 - Remove last remaining calls to exception_enter/exception_exit() and 
   simplify the entry code some more.

 - Remove force_iret()

 - Add support for "Fast Short Rep Mov", which is available starting with 
   Ice Lake Intel CPUs - and make the x86 assembly version of memmove() 
   use REP MOV for all sizes when FSRM is available.

 - Micro-optimize/simplify the 32-bit boot code a bit.

 - Use a more future-proof SYSRET instruction mnemonic

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/boot: Simplify calculation of output address

Brian Gerst (1):
      x86: Remove force_iret()

Frederic Weisbecker (2):
      x86/context-tracking: Remove exception_enter/exit() from do_page_fault()
      x86/context-tracking: Remove exception_enter/exit() from KVM_PV_REASON_PAGE_NOT_PRESENT async page fault

Jan Beulich (1):
      x86/entry/64: Add instruction suffix to SYSRET

Tony Luck (1):
      x86/cpufeatures: Add support for fast short REP; MOVSB


 arch/x86/boot/compressed/head_32.S |  8 +++-----
 arch/x86/entry/entry_64.S          |  2 +-
 arch/x86/ia32/ia32_signal.c        |  2 --
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/ptrace.h      | 16 ----------------
 arch/x86/include/asm/thread_info.h |  9 ---------
 arch/x86/kernel/kvm.c              |  4 ----
 arch/x86/kernel/process_32.c       |  1 -
 arch/x86/kernel/process_64.c       |  1 -
 arch/x86/kernel/signal.c           |  2 --
 arch/x86/kernel/vm86_32.c          |  1 -
 arch/x86/lib/memmove_64.S          |  7 ++++---
 arch/x86/mm/fault.c                | 39 ++++++++++++--------------------------
 13 files changed, 21 insertions(+), 72 deletions(-)

