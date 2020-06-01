Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD012C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959592073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591029266;
	bh=oR6prYktqYSbC8rXxvKTLgFGKN0zEgefjVu1Xn9Slb0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vQa0s08NUvWJ/SiyHFW5Vo+b9dLEaX29W2AEnd6WRhM7gZuG1LCmZvnZXPO28HZtR
	 UkPCDSfA8hlQviBgHK3bnbxVD5sY4xvqTphKf3aOHy+bSV2kgEJhKRGzKK8rWIADdY
	 lDhLb52XQg62ynfubCWvjqo46Ihm3dle+bCXJUqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFAQe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:34:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E8C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:34:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so153480wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5s6oGg+lK9xAHbxDWCV+jDGI3+fgOjIVtvP8VYehpeI=;
        b=ALjfKh0bkpkZp/6AhqqFqBGc5OYA+fNXtxvhx8UgT98k1dQZJQ4bTlv95+zCDMi8/s
         0F+2fadJ2ahpzmK3RO7dka0Byq/yIg8sDuAdqnWgv5AYa0heni6Q+8MV9zAOzPnMu8KA
         AxqoZghOm3zDdU6z3joDLbnnpBcj/Ul+C+7lTK+es2eg2OLH/qoc4DYNHk1Uuor3cLY0
         0gXVLfqLdkDoBPyLLjhvYOxgcnaNoB9Blfu4ZbF3dUC5fMoEm5bCRxG0qe0bK/vcr+Oi
         SvArY2IlUyofh+e13T3Wc1MDukgjbUK5s8zTknWh/KWityMIW+HaMO+meAJjLkiA2zW+
         XpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=5s6oGg+lK9xAHbxDWCV+jDGI3+fgOjIVtvP8VYehpeI=;
        b=WvWERghvx39Wf06YhPj525e9Z93ANKz1wqhSeVQ6MC2NY1xzhDg6EdF5MHT2s6tXTu
         KSi4rujdulcTcEGKLzgfiNMd3Em99Xjfq9M3m/S+G+4Qvz+c0W49nBuke7zAA8FjrEXR
         V1xZbN81ZzjrgUvUi1uZ53RZPKdiRhmqSYPeBTJB3OSYws+lJ+BBTeaMifWlO/dZZmbQ
         WUN3AVPJR8Y7UBiBGBjuuA+1va2pywBjHlhq7KuQ3GJMc1heoMXoAspBsv8/S+TMYRJ+
         9dEx0v6jcL3WF+D4IvbluTgnu3FAbi7w55z/xoGTzWoorxZN1SyXFijDidRUGQPQPCgl
         B+HQ==
X-Gm-Message-State: AOAM531H1GsYZ+iLhv2LYi3HjsnsHWqR77M93gpcZmMbo5SjKp3dw4+5
        dLbLtF4lQufBqvg5+y78oA8=
X-Google-Smtp-Source: ABdhPJx5t5UOuIdizH3eRJXAQDMZfTnBZxjF4IUgmjKDemKnyF9s6NWwuaGLGY22lkB7u/hSzur2Fg==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr179214wma.102.1591029261417;
        Mon, 01 Jun 2020 09:34:21 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t14sm22670446wrb.94.2020.06.01.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:34:20 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:34:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.8
Message-ID: <20200601163418.GA1220330@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2020-06-01

   # HEAD: 2ca41f555e857ec5beef6063bfa43a17ee76d7ec x86/spinlock: Remove obsolete ticket spinlock macros and types

Misc cleanups, with an emphasis on removing obsolete/dead code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>

  out-of-topic modifications in x86/cleanups:
  ---------------------------------------------
  fs/proc/task_mmu.c                 # 66648766ef38: mm: Remove MPX leftovers
  include/linux/crash_dump.h         # 4c5b566c2193: crash_dump: Remove no longer
  include/linux/mm.h                 # 66648766ef38: mm: Remove MPX leftovers
  kernel/crash_dump.c                # 4c5b566c2193: crash_dump: Remove no longer

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      x86/early_printk: Remove unused includes

Arvind Sankar (1):
      x86/mm: Stop printing BRK addresses

Benjamin Thiel (2):
      x86/mm/mmap: Fix -Wmissing-prototypes warnings
      x86/audit: Fix a -Wmissing-prototypes warning for ia32_classify_syscall()

Borislav Petkov (2):
      x86/smpboot: Remove the last ICPU() macro
      x86/nmi: Remove edac.h include leftover

Jimmy Assarsson (1):
      mm: Remove MPX leftovers

Johan Hovold (2):
      x86/apb_timer: Drop unused TSC calibration
      x86/apb_timer: Drop unused declaration and macro

Kairui Song (1):
      crash_dump: Remove no longer used saved_max_pfn

Mike Rapoport (1):
      x86/mm: Drop deprecated DISCONTIGMEM support for 32-bit

Waiman Long (1):
      x86/spinlock: Remove obsolete ticket spinlock macros and types

YueHaibing (1):
      x86/io_apic: Remove unused function mp_init_irq_at_boot()


 arch/x86/Kconfig                      |  9 ------
 arch/x86/ia32/audit.c                 |  1 +
 arch/x86/include/asm/apb_timer.h      |  5 ----
 arch/x86/include/asm/audit.h          |  7 +++++
 arch/x86/include/asm/mmzone_32.h      | 39 --------------------------
 arch/x86/include/asm/pgtable_32.h     |  3 +-
 arch/x86/include/asm/spinlock_types.h | 22 ---------------
 arch/x86/kernel/apb_timer.c           | 53 -----------------------------------
 arch/x86/kernel/apic/io_apic.c        | 13 ---------
 arch/x86/kernel/audit_64.c            |  2 +-
 arch/x86/kernel/e820.c                |  8 ------
 arch/x86/kernel/early_printk.c        |  3 --
 arch/x86/kernel/nmi.c                 |  4 ---
 arch/x86/kernel/smpboot.c             | 17 +++++------
 arch/x86/mm/init.c                    |  2 --
 arch/x86/mm/mmap.c                    |  2 ++
 arch/x86/mm/numa_32.c                 | 34 ----------------------
 fs/proc/task_mmu.c                    |  3 --
 include/linux/crash_dump.h            |  2 --
 include/linux/mm.h                    |  7 -----
 kernel/crash_dump.c                   |  6 ----
 21 files changed, 21 insertions(+), 221 deletions(-)
 create mode 100644 arch/x86/include/asm/audit.h
