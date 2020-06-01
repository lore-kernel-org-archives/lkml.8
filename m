Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F434C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261BE2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591030868;
	bh=9XhMBnft9PNUYfScoUiDwEmjGEvB04ujT0N4bxN+hI0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=n5fD7Wd1EtWUsmIzi7ysrn6DK2Ya7KeYJWqFt7SHYp6NWsFijwRAKcaxBiM2gWLUc
	 hcoJDp80zr8/kegpc+hbwnrERea4gCJMRCqjB3I1dWbq1CgHsLYDxO1wnI34CofXZQ
	 IavMNaPfaagqOuoJMZS1622LZwwuInd2HzEjOO/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFARBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFARBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:01:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C075C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:01:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so560086wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dMJI99syFcDXnjlLWeh/ATxeuHMh9xNyI+PPoM1IAi0=;
        b=bxVXpvxXM7v51hN4+KvcomayuLpjGzsMTzP9Ais7BLwBcjrGpluccUup6Zob5fYOhx
         I6vyaCPpUfT6WosIqMM/P7vdrvrHFB8FHOq6dH1QV9UovgTrKKmjsV3IVYpeXumLIGrP
         VOZP+ygYOHbROIvQ7rse1XAmrpEmkWVal5Yaf5ND3XjbSB5Hua551hkebxMwcppssy2d
         jkGkrjidOJcuVCH3hlqOBiSWZEtfGFeWBWCKxFgdtGepPvOHEJe5wcntpsbolWmtw2Qs
         +mf3NT+f8VJAdzDASAwSu+qG4/TsuFP0SJRgb5SSHTagvDxciebvsPtKCD7zyws8+n+T
         AJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=dMJI99syFcDXnjlLWeh/ATxeuHMh9xNyI+PPoM1IAi0=;
        b=CdbyFUcTZTiF23KCrdO7sEb3DNKYruD9SlH99IOI4HnAQMIhBmQGfs/yx37J6hDVCS
         hzciX1dvOjF2VhqB+f9PYVdC4JNAIz1HdpDTSAuZSbTMJlkGzsitF1IGOJk6sTcFKxtG
         aQBuyo8ESxalfCYsHeJAlVg69WAdKLsUGLoknGHQugaB26uvVKFzxYubkAqYWGZAYK0l
         ZQoqS5E5yNyYkHbgvRTxixIkCReUzdVvE9Abu4aYHZ0azWfa4miazRUX43fj3codVPhy
         r4lvjRkcaMoILzlrYYsHCQnOBeV3J/2vLXcBgJ/Yl70tKNFfYm79nPaYOBTTEg7XRmij
         0wdQ==
X-Gm-Message-State: AOAM532HNQ7bOMdUjE5kY8LE3YhJ03ndx0qzMGM7ibGmPES+zqCT2bPo
        3+vSw/TLrJr6dBzioBpHg1k=
X-Google-Smtp-Source: ABdhPJxvImQzPOQfAIp/i9SaxT7L1MKXmYriPHJ18WHZ20i4Iw21/gSPrS6IX1H12y3V/aAA3SSHcQ==
X-Received: by 2002:adf:f183:: with SMTP id h3mr24542629wro.403.1591030864930;
        Mon, 01 Jun 2020 10:01:04 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p16sm69088wru.27.2020.06.01.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:01:04 -0700 (PDT)
Date:   Mon, 1 Jun 2020 19:01:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86/mm changes for v5.8
Message-ID: <20200601170102.GA1346815@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-06-01

   # HEAD: 0fcfdf55db9e1ecf85edd6aa8d0bc78a448cb96a Documentation: Add L1D flushing Documentation

Misc changes:

 - Unexport various PAT primitives

 - Unexport per-CPU tlbstate

 - Provide an opt-in (prctl driven) mechanism to flush the L1D cache on context switch.
   The goal is to allow tasks that are paranoid due to the recent snoop assisted data
   sampling vulnerabilites, to flush their L1D on being switched out.
   This protects their data from being snooped or leaked via side channels
   after the task has context switched out.

Signed-off-by: Ingo Molnar <mingo@kernel.org>

  out-of-topic modifications in x86/mm:
  ---------------------------------------
  include/uapi/linux/prctl.h         # edf7ce0b231c: prctl: Hook L1D flushing in 

 Thanks,

	Ingo

------------------>
Balbir Singh (7):
      x86/kvm: Refactor L1D flush page management
      x86/kvm: Refactor L1D flush operations
      x86/mm: Refactor cond_ibpb() to support other use cases
      x86/kvm: Refactor L1D flushing
      x86/mm: Optionally flush L1D on context switch
      prctl: Hook L1D flushing in via prctl
      Documentation: Add L1D flushing Documentation

Borislav Petkov (1):
      x86/tlb/uv: Add a forward declaration for struct flush_tlb_info

Christoph Hellwig (5):
      x86/mm: Add a x86_has_pat_wp() helper
      x86/mm: Move pgprot2cachemode out of line
      x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()
      x86/mm: Unexport __cachemode2pte_tbl
      x86/mm: Use pgprotval_t in protval_4k_2_large() and protval_large_2_4k()

Thomas Gleixner (17):
      x86/tlb: Uninline __get_current_cr3_fast()
      x86/cpu: Uninline CR4 accessors
      x86/cr4: Sanitize CR4.PCE update
      x86/alternatives: Move temporary_mm helpers into C
      x86/tlb: Move __flush_tlb() out of line
      x86/tlb: Move __flush_tlb_global() out of line
      x86/tlb: Move __flush_tlb_one_user() out of line
      x86/tlb: Move __flush_tlb_one_kernel() out of line
      x86/tlb: Move flush_tlb_others() out of line
      x86/tlb: Move __flush_tlb_all() out of line
      x86/tlb: Move paravirt_tlb_remove_table() to the usage site
      x86/tlb: Move cr4_set_bits_and_update_boot() to the usage site
      x86/tlb: Uninline nmi_uaccess_okay()
      x86/tlb: Move PCID helpers where they are used
      xen/privcmd: Remove unneeded asm/tlb.h include
      x86/tlb: Restrict access to tlbstate
      x86/cpu: Export native_write_cr4() only when CONFIG_LKTDM=m


 Documentation/admin-guide/hw-vuln/index.rst     |   1 +
 Documentation/admin-guide/hw-vuln/l1d_flush.rst |  51 +++
 Documentation/userspace-api/spec_ctrl.rst       |   7 +
 arch/x86/events/core.c                          |  11 +-
 arch/x86/include/asm/cacheflush.h               |   8 +
 arch/x86/include/asm/memtype.h                  |   3 +
 arch/x86/include/asm/mmu_context.h              |  88 +----
 arch/x86/include/asm/paravirt.h                 |  12 +-
 arch/x86/include/asm/pgtable_32.h               |   2 +-
 arch/x86/include/asm/pgtable_types.h            |  44 +--
 arch/x86/include/asm/thread_info.h              |   9 +-
 arch/x86/include/asm/tlbflush.h                 | 443 +++-------------------
 arch/x86/include/asm/uv/uv.h                    |   1 +
 arch/x86/kernel/Makefile                        |   1 +
 arch/x86/kernel/alternative.c                   |  55 +++
 arch/x86/kernel/cpu/bugs.c                      |  28 ++
 arch/x86/kernel/cpu/common.c                    |  25 +-
 arch/x86/kernel/cpu/mtrr/generic.c              |   4 +-
 arch/x86/kernel/l1d_flush.c                     | 120 ++++++
 arch/x86/kernel/paravirt.c                      |  21 +-
 arch/x86/kernel/process.c                       |  11 +
 arch/x86/kvm/vmx/vmx.c                          |  62 +---
 arch/x86/mm/init.c                              |  44 ++-
 arch/x86/mm/init_64.c                           |   4 +-
 arch/x86/mm/ioremap.c                           |  10 +-
 arch/x86/mm/kmmio.c                             |   2 +-
 arch/x86/mm/mem_encrypt.c                       |   2 +-
 arch/x86/mm/pat/set_memory.c                    |   7 +-
 arch/x86/mm/pgtable.c                           |  16 +-
 arch/x86/mm/pgtable_32.c                        |   2 +-
 arch/x86/mm/tlb.c                               | 471 ++++++++++++++++++++++--
 arch/x86/platform/uv/tlb_uv.c                   |   4 +-
 drivers/xen/privcmd.c                           |   1 -
 include/uapi/linux/prctl.h                      |   1 +
 34 files changed, 899 insertions(+), 672 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
 create mode 100644 arch/x86/kernel/l1d_flush.c
