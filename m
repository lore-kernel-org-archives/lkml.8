Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E806C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6394920737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BwEQFmFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZDYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32866 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgCZDYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id v7so5139847qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=AKpcaV6bzzbFLn3o3db1WuJ15bS+tekZ+L4LWGp0jsE=;
        b=BwEQFmFSKMUCHgxyFldizxD3zxZVWOK/3JQO/ezmuc8SIDs5SyUMqcWXVaFpBy0aKa
         SYJOBWNAyddKLuqtt8+81fqCgDv8OJ72a/we20FEjBMyRG0j3rAf3gxzYMFMKB6KkMAk
         RBSBrJAizqPCgWFlLdZnWJMxiKfoz9b9XXySFAPWG7HmD/GLerASpnkHTzJ9yvssv2jt
         wFDrhI2kN3ConrizrvyGrxvjsgiw0jDLK/0T6EBTHHho/FIMjgNesp0mRi7B2elx/v6K
         D0ynMVlLKj49Z/2MrX0i+zhXfKqUWGJC+xEVB22Z/jYygAtioAFuR+J8YYovGpp8BHnH
         v/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=AKpcaV6bzzbFLn3o3db1WuJ15bS+tekZ+L4LWGp0jsE=;
        b=MvuZXr9sL8GNWKCYrDlpjxkT2fD9ds5wCkCnALf6R38kuK/+ciBkH0EZTVWn4qB/QU
         iW7ztzveLlFmA5OZlooCubcx513wEOY8rEaEPCN3EB0NjCzNLfkGJoPbvKyT+S/Neb/d
         tfJC3SsYyLm1VJldNlpk0XHAAgm2ED3a5McWGpB1jifg3X42prm2WiIwu0gohx8EN4rs
         6LfhIrm+gzL84LZaKp2TWyBhpgIVE6JFpRvkGS9PaMUeDfcjRe1opRsk9YL/Q74WEFg0
         9rcFv8Lgn2FeD/mUZcQwYuyMoF5STBwYwXlNx/gcymCnngywVhAlk1rzWnp23CxoZzYs
         p+pw==
X-Gm-Message-State: ANhLgQ3qxRA4VzTjhS38rH9kUD2eZQ3R6YaC2CuLU/RJwrLn/GDUTQcL
        pstWP3SO+NQctkMaasSz6R4hjw==
X-Google-Smtp-Source: ADFU+vudusdw7QLjXAaZtqJhk7QqLwkBnNSm7OAXsjHPq3UftbB1cdyBjp8cvXK3yzgA7LCNQ45h9g==
X-Received: by 2002:a37:678b:: with SMTP id b133mr6188744qkc.327.1585193062796;
        Wed, 25 Mar 2020 20:24:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:22 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 00/18] arm64: MMU enabled kexec relocation
Date:   Wed, 25 Mar 2020 23:24:02 -0400
Message-Id: <20200326032420.27220-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog:
v9:	- 9 patches from previous series landed in upstream, so now series
	  is smaller
	- Added two patches from James Morse to address idmap issues for machines
	  with high physical addresses.
	- Addressed comments from Selin Dag about compiling issues. He also tested
	  my series and got similar performance results: ~60 ms instead of ~580 ms
	  with an initramfs size of ~120MB.
v8:
	- Synced with mainline to keep series up-to-date
v7:
	-- Addressed comments from James Morse
	- arm64: hibernate: pass the allocated pgdp to ttbr0
	  Removed "Fixes" tag, and added Added Reviewed-by: James Morse
	- arm64: hibernate: check pgd table allocation
	  Sent out as a standalone patch so it can be sent to stable
	  Series applies on mainline + this patch
	- arm64: hibernate: add trans_pgd public functions
	  Remove second allocation of tmp_pg_dir in swsusp_arch_resume
	  Added Reviewed-by: James Morse <james.morse@arm.com>
	- arm64: kexec: move relocation function setup and clean up
	  Fixed typo in commit log
	  Changed kern_reloc to phys_addr_t types.
	  Added explanation why kern_reloc is needed.
	  Split into four patches:
	  arm64: kexec: make dtb_mem always enabled
	  arm64: kexec: remove unnecessary debug prints
	  arm64: kexec: call kexec_image_info only once
	  arm64: kexec: move relocation function setup
	- arm64: kexec: add expandable argument to relocation function
	  Changed types of new arguments from unsigned long to phys_addr_t.
	  Changed offset prefix to KEXEC_*
	  Split into four patches:
	  arm64: kexec: cpu_soft_restart change argument types
	  arm64: kexec: arm64_relocate_new_kernel clean-ups
	  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
	  arm64: kexec: add expandable argument to relocation function
	- arm64: kexec: configure trans_pgd page table for kexec
	  Added invalid entries into EL2 vector table
	  Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
	  Copy relocation functions and table into separate pages
	  Changed types in kern_reloc_arg.
	  Split into three patches:
	  arm64: kexec: offset for relocation function
	  arm64: kexec: kexec EL2 vectors
	  arm64: kexec: configure trans_pgd page table for kexec
	- arm64: kexec: enable MMU during kexec relocation
	  Split into two patches:
	  arm64: kexec: enable MMU during kexec relocation
	  arm64: kexec: remove head from relocation argument
v6:
	- Sync with mainline tip
	- Added Acked's from Dave Young
v5:
	- Addressed comments from Matthias Brugger: added review-by's, improved
	  comments, and made cleanups to swsusp_arch_resume() in addition to
	  create_safe_exec_page().
	- Synced with mainline tip.
v4:
	- Addressed comments from James Morse.
	- Split "check pgd table allocation" into two patches, and moved to
	  the beginning of series  for simpler backport of the fixes.
	  Added "Fixes:" tags to commit logs.
	- Changed "arm64, hibernate:" to "arm64: hibernate:"
	- Added Reviewed-by's
	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
	  clean-ups
	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
	- Removed "flags" from trans_info
	- Changed .trans_alloc_page assumption to return zeroed page.
	- Simplify changes to trans_pgd_map_page(), by keeping the old
	  code.
	- Simplify changes to trans_pgd_create_copy, by keeping the old
	  code.
	- Removed: "add trans_pgd_create_empty"
	- replace init_mm with NULL, and keep using non "__" version of
	  populate functions.
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
https://lore.kernel.org/lkml/20191016200034.1342308-1-pasha.tatashin@soleen.com
version 7 of this series

https://lore.kernel.org/lkml/20191004185234.31471-1-pasha.tatashin@soleen.com
version 6 of this series

https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
version 5 of this series

https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
version 4 of this series

https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
version 3 of this series

https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
version 2 of this series

https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com
version 1 of this series

https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

James Morse (2):
  arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
  arm64: trans_pgd: hibernate: idmap the single page that holds the copy
    page routines

Pavel Tatashin (16):
  arm64: kexec: make dtb_mem always enabled
  arm64: hibernate: move page handling function to new trans_pgd.c
  arm64: trans_pgd: make trans_pgd_map_page generic
  arm64: trans_pgd: pass allocator trans_pgd_create_copy
  arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
  arm64: kexec: move relocation function setup
  arm64: kexec: call kexec_image_info only once
  arm64: kexec: cpu_soft_restart change argument types
  arm64: kexec: arm64_relocate_new_kernel clean-ups
  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
  arm64: kexec: add expandable argument to relocation function
  arm64: kexec: offset for relocation function
  arm64: kexec: kexec EL2 vectors
  arm64: kexec: configure trans_pgd page table for kexec
  arm64: kexec: enable MMU during kexec relocation
  arm64: kexec: remove head from relocation argument

 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/kexec.h       |  45 +++-
 arch/arm64/include/asm/mmu_context.h |   7 +-
 arch/arm64/include/asm/trans_pgd.h   |  38 ++++
 arch/arm64/kernel/asm-offsets.c      |  15 ++
 arch/arm64/kernel/cpu-reset.S        |  11 +-
 arch/arm64/kernel/cpu-reset.h        |  14 +-
 arch/arm64/kernel/hibernate.c        | 242 +++-------------------
 arch/arm64/kernel/machine_kexec.c    | 161 ++++++++++++---
 arch/arm64/kernel/relocate_kernel.S  | 246 +++++++++++++---------
 arch/arm64/mm/Makefile               |   1 +
 arch/arm64/mm/trans_pgd.c            | 293 +++++++++++++++++++++++++++
 12 files changed, 712 insertions(+), 365 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

-- 
2.17.1

