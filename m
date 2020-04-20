Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CDC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CA02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDTMjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:39:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgDTMjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:39:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N94FT-1jCQUQ2wfn-01695X; Mon, 20 Apr 2020 14:38:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-sh@vger.kernel.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] sh: remove unused sh5 files
Date:   Mon, 20 Apr 2020 14:38:44 +0200
Message-Id: <20200420123844.3998746-2-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420123844.3998746-1-arnd@arndb.de>
References: <20200420123844.3998746-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4Oj9p5Ct9AisTLnVzWd8JpP94Rf+sxGRgf5PRdiM0iWzEEmh13T
 71pRCXKJnyXHFPh64uKvE0HPB3ScElgUi8b8xu10QwNmSHlFd4cWqHuB1UJp5eD8T7NOmxN
 BUXnU5XohZwCnSULSpqKjUdxqeJ3TwbQqfilT3qhDtxJZvmyJckmq6yon1lh461wmWlgubM
 oE/uA8wbEl79BaOzr8SJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5EuaTMvxZs4=:JnL5LRZXcGU3N2fUNo1CKK
 OphPdmX779Ay1p3q9YQXFeYh7Xz0EX2SwUop7rfexeoQ9WMGhENVtzSOLx+VJyYv4ArITYLHC
 B2TLwOpIq7RCAWZTUmSYzROn9LbkQgB5eMNoczmhmcxNGeCHxLvnFMOtiBn8n1RRcvfr0JmtO
 e5O7PRKMtrE8qNdXuifbJr/lLDjQpSP6ngdRJoRAp1KyKEcuP88M/+iARTfW2CMmOsqjHFQdY
 JjC4qiyGVyDFWwiTf+J/mhK5yfPIuCinT2+ixkUmel+LPN2YnFVVVqyXSzHDyiD8DZeIIVc+8
 ro/0sRb6wD2RxsJzsGGKjapVTmmYxxp9VNpHqYFVLqa3tgyDu4Y/k2ycndRfdhIoHXZAhoJwR
 Z7/+9gE4c5oaeNlRlzF5AnHZ3YvBwXGmOJ9sCIGKOImsSyb9QM6+zv1P4E9NXncHkVXqD2K1b
 1tA9nM0Q1/N8WDLC92luzhzUq230NYkzZivVaxfghzIMzD8vYtjMkRoSJc9CLzidUV5EzUot/
 UIkBHipOCcUI5EQquLYs53gYHwi+v4ZbaD5I2k1B+WZKbyrUOpNHT2clD48h2xVQ1mo68b++Q
 gO1j71hRdtKj3gXvKK7sROGdu//f63qRPkfXZgEXQB6oEOAegUrNHjnmPsUCVE5u1v4bOmIj+
 +9ZOWYV0kSVupPVGasb7t25MCDuiMKh3r62VUWWLAPwQqY1yYv8XTjzhRozoyDxk/nP1P/uub
 poIUBP6z2CmP7fIw4xm/Ht9ZzsLgofzovvGOcinMLUDojsdO81Uq7f0IAvnkRyCrHilmW2hFo
 w4Y9iGcHmhHBVMrMZiLlKQLtE39xgl+yiMWnw83iWjtQEZJvTc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these files are used now that sh5 has been
disabled, so they can be completely removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/drivers/pci/ops-sh5.c             |   65 -
 arch/sh/drivers/pci/pci-sh5.c             |  217 ---
 arch/sh/drivers/pci/pci-sh5.h             |  108 --
 arch/sh/include/asm/bl_bit_64.h           |   37 -
 arch/sh/include/asm/cache_insns_64.h      |   20 -
 arch/sh/include/asm/mmu_context_64.h      |   75 -
 arch/sh/include/asm/pgtable_64.h          |  307 ----
 arch/sh/include/asm/processor_64.h        |  212 ---
 arch/sh/include/asm/ptrace_64.h           |   14 -
 arch/sh/include/asm/string_64.h           |   21 -
 arch/sh/include/asm/switch_to_64.h        |   32 -
 arch/sh/include/asm/syscall_64.h          |   75 -
 arch/sh/include/asm/syscalls_64.h         |   18 -
 arch/sh/include/asm/tlb_64.h              |   68 -
 arch/sh/include/asm/traps_64.h            |   35 -
 arch/sh/include/asm/uaccess_64.h          |   85 -
 arch/sh/include/cpu-sh5/cpu/addrspace.h   |   12 -
 arch/sh/include/cpu-sh5/cpu/cache.h       |   94 -
 arch/sh/include/cpu-sh5/cpu/irq.h         |  113 --
 arch/sh/include/cpu-sh5/cpu/mmu_context.h |   22 -
 arch/sh/include/cpu-sh5/cpu/registers.h   |  103 --
 arch/sh/include/cpu-sh5/cpu/rtc.h         |    9 -
 arch/sh/include/uapi/asm/posix_types_64.h |   29 -
 arch/sh/include/uapi/asm/ptrace_64.h      |   15 -
 arch/sh/include/uapi/asm/unistd_64.h      |  423 -----
 arch/sh/kernel/cpu/irq/intc-sh5.c         |  194 --
 arch/sh/kernel/cpu/sh5/Makefile           |   16 -
 arch/sh/kernel/cpu/sh5/clock-sh5.c        |   76 -
 arch/sh/kernel/cpu/sh5/entry.S            | 2000 ---------------------
 arch/sh/kernel/cpu/sh5/fpu.c              |  106 --
 arch/sh/kernel/cpu/sh5/probe.c            |   72 -
 arch/sh/kernel/cpu/sh5/setup-sh5.c        |  121 --
 arch/sh/kernel/cpu/sh5/switchto.S         |  195 --
 arch/sh/kernel/cpu/sh5/unwind.c           |  342 ----
 arch/sh/kernel/head_64.S                  |  346 ----
 arch/sh/kernel/irq_64.c                   |   48 -
 arch/sh/kernel/process_64.c               |  461 -----
 arch/sh/kernel/ptrace_64.c                |  576 ------
 arch/sh/kernel/sh_ksyms_64.c              |   51 -
 arch/sh/kernel/signal_64.c                |  567 ------
 arch/sh/kernel/syscalls_64.S              |  419 -----
 arch/sh/kernel/traps_64.c                 |  814 ---------
 arch/sh/lib64/Makefile                    |   17 -
 arch/sh/lib64/copy_page.S                 |   89 -
 arch/sh/lib64/copy_user_memcpy.S          |  218 ---
 arch/sh/lib64/memcpy.S                    |  202 ---
 arch/sh/lib64/memset.S                    |   92 -
 arch/sh/lib64/panic.c                     |   15 -
 arch/sh/lib64/sdivsi3.S                   |  136 --
 arch/sh/lib64/strcpy.S                    |   98 -
 arch/sh/lib64/strlen.S                    |   34 -
 arch/sh/lib64/udelay.c                    |   49 -
 arch/sh/lib64/udivdi3.S                   |  121 --
 arch/sh/lib64/udivsi3.S                   |   60 -
 arch/sh/mm/cache-sh5.c                    |  621 -------
 arch/sh/mm/tlb-sh5.c                      |  224 ---
 56 files changed, 10589 deletions(-)
 delete mode 100644 arch/sh/drivers/pci/ops-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.h
 delete mode 100644 arch/sh/include/asm/bl_bit_64.h
 delete mode 100644 arch/sh/include/asm/cache_insns_64.h
 delete mode 100644 arch/sh/include/asm/mmu_context_64.h
 delete mode 100644 arch/sh/include/asm/pgtable_64.h
 delete mode 100644 arch/sh/include/asm/processor_64.h
 delete mode 100644 arch/sh/include/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/asm/string_64.h
 delete mode 100644 arch/sh/include/asm/switch_to_64.h
 delete mode 100644 arch/sh/include/asm/syscall_64.h
 delete mode 100644 arch/sh/include/asm/syscalls_64.h
 delete mode 100644 arch/sh/include/asm/tlb_64.h
 delete mode 100644 arch/sh/include/asm/traps_64.h
 delete mode 100644 arch/sh/include/asm/uaccess_64.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/addrspace.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/cache.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/irq.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/mmu_context.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/registers.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/rtc.h
 delete mode 100644 arch/sh/include/uapi/asm/posix_types_64.h
 delete mode 100644 arch/sh/include/uapi/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/uapi/asm/unistd_64.h
 delete mode 100644 arch/sh/kernel/cpu/irq/intc-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/Makefile
 delete mode 100644 arch/sh/kernel/cpu/sh5/clock-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/entry.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/fpu.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/probe.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/setup-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/switchto.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/unwind.c
 delete mode 100644 arch/sh/kernel/head_64.S
 delete mode 100644 arch/sh/kernel/irq_64.c
 delete mode 100644 arch/sh/kernel/process_64.c
 delete mode 100644 arch/sh/kernel/ptrace_64.c
 delete mode 100644 arch/sh/kernel/sh_ksyms_64.c
 delete mode 100644 arch/sh/kernel/signal_64.c
 delete mode 100644 arch/sh/kernel/syscalls_64.S
 delete mode 100644 arch/sh/kernel/traps_64.c
 delete mode 100644 arch/sh/lib64/Makefile
 delete mode 100644 arch/sh/lib64/copy_page.S
 delete mode 100644 arch/sh/lib64/copy_user_memcpy.S
 delete mode 100644 arch/sh/lib64/memcpy.S
 delete mode 100644 arch/sh/lib64/memset.S
 delete mode 100644 arch/sh/lib64/panic.c
 delete mode 100644 arch/sh/lib64/sdivsi3.S
 delete mode 100644 arch/sh/lib64/strcpy.S
 delete mode 100644 arch/sh/lib64/strlen.S
 delete mode 100644 arch/sh/lib64/udelay.c
 delete mode 100644 arch/sh/lib64/udivdi3.S
 delete mode 100644 arch/sh/lib64/udivsi3.S
 delete mode 100644 arch/sh/mm/cache-sh5.c
 delete mode 100644 arch/sh/mm/tlb-sh5.c

diff --git a/arch/sh/drivers/pci/ops-sh5.c b/arch/sh/drivers/pci/ops-sh5.c
deleted file mode 100644
index 9fbaf72949ab..000000000000
diff --git a/arch/sh/drivers/pci/pci-sh5.c b/arch/sh/drivers/pci/pci-sh5.c
deleted file mode 100644
index 03225d27770b..000000000000
diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
deleted file mode 100644
index 91348af0ef6c..000000000000
diff --git a/arch/sh/include/asm/bl_bit_64.h b/arch/sh/include/asm/bl_bit_64.h
deleted file mode 100644
index aac9780fe864..000000000000
diff --git a/arch/sh/include/asm/cache_insns_64.h b/arch/sh/include/asm/cache_insns_64.h
deleted file mode 100644
index ed682b987b0d..000000000000
diff --git a/arch/sh/include/asm/mmu_context_64.h b/arch/sh/include/asm/mmu_context_64.h
deleted file mode 100644
index bacafe0b887d..000000000000
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
deleted file mode 100644
index 1778bc5971e7..000000000000
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
deleted file mode 100644
index 53efc9f51ef1..000000000000
diff --git a/arch/sh/include/asm/ptrace_64.h b/arch/sh/include/asm/ptrace_64.h
deleted file mode 100644
index 6ee08229b433..000000000000
diff --git a/arch/sh/include/asm/string_64.h b/arch/sh/include/asm/string_64.h
deleted file mode 100644
index d51d6150a4e2..000000000000
diff --git a/arch/sh/include/asm/switch_to_64.h b/arch/sh/include/asm/switch_to_64.h
deleted file mode 100644
index 2dbf2311669f..000000000000
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
deleted file mode 100644
index 72efcbc76f91..000000000000
diff --git a/arch/sh/include/asm/syscalls_64.h b/arch/sh/include/asm/syscalls_64.h
deleted file mode 100644
index df42656cebea..000000000000
diff --git a/arch/sh/include/asm/tlb_64.h b/arch/sh/include/asm/tlb_64.h
deleted file mode 100644
index 59fa0a23dad7..000000000000
diff --git a/arch/sh/include/asm/traps_64.h b/arch/sh/include/asm/traps_64.h
deleted file mode 100644
index f28db6dfbe45..000000000000
diff --git a/arch/sh/include/asm/uaccess_64.h b/arch/sh/include/asm/uaccess_64.h
deleted file mode 100644
index 0c19d02dc566..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/addrspace.h b/arch/sh/include/cpu-sh5/cpu/addrspace.h
deleted file mode 100644
index 6dd1e72f31b2..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/cache.h b/arch/sh/include/cpu-sh5/cpu/cache.h
deleted file mode 100644
index ef49538f386f..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/irq.h b/arch/sh/include/cpu-sh5/cpu/irq.h
deleted file mode 100644
index 4aa6ac54b9d6..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/mmu_context.h b/arch/sh/include/cpu-sh5/cpu/mmu_context.h
deleted file mode 100644
index 23c53be945b7..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/registers.h b/arch/sh/include/cpu-sh5/cpu/registers.h
deleted file mode 100644
index 372c1e1978b3..000000000000
diff --git a/arch/sh/include/cpu-sh5/cpu/rtc.h b/arch/sh/include/cpu-sh5/cpu/rtc.h
deleted file mode 100644
index d7e25d435f4a..000000000000
diff --git a/arch/sh/include/uapi/asm/posix_types_64.h b/arch/sh/include/uapi/asm/posix_types_64.h
deleted file mode 100644
index 3a9128d4aee3..000000000000
diff --git a/arch/sh/include/uapi/asm/ptrace_64.h b/arch/sh/include/uapi/asm/ptrace_64.h
deleted file mode 100644
index a6f84eba5277..000000000000
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
deleted file mode 100644
index 75da54851f02..000000000000
diff --git a/arch/sh/kernel/cpu/irq/intc-sh5.c b/arch/sh/kernel/cpu/irq/intc-sh5.c
deleted file mode 100644
index 1b3050facda8..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/Makefile b/arch/sh/kernel/cpu/sh5/Makefile
deleted file mode 100644
index 97d23ec3005f..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/clock-sh5.c b/arch/sh/kernel/cpu/sh5/clock-sh5.c
deleted file mode 100644
index dee6be2c2344..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
deleted file mode 100644
index 81c8b64b977f..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/fpu.c b/arch/sh/kernel/cpu/sh5/fpu.c
deleted file mode 100644
index 3966b5ee8e93..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/probe.c b/arch/sh/kernel/cpu/sh5/probe.c
deleted file mode 100644
index 947250188065..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
deleted file mode 100644
index dc8476d67244..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/switchto.S b/arch/sh/kernel/cpu/sh5/switchto.S
deleted file mode 100644
index d1beff755632..000000000000
diff --git a/arch/sh/kernel/cpu/sh5/unwind.c b/arch/sh/kernel/cpu/sh5/unwind.c
deleted file mode 100644
index 3cb0cd9cea29..000000000000
diff --git a/arch/sh/kernel/head_64.S b/arch/sh/kernel/head_64.S
deleted file mode 100644
index 67685e1f00e1..000000000000
diff --git a/arch/sh/kernel/irq_64.c b/arch/sh/kernel/irq_64.c
deleted file mode 100644
index 7a1f50435e33..000000000000
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
deleted file mode 100644
index c2844a2e18cd..000000000000
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
deleted file mode 100644
index 11085e48eaa6..000000000000
diff --git a/arch/sh/kernel/sh_ksyms_64.c b/arch/sh/kernel/sh_ksyms_64.c
deleted file mode 100644
index 9de17065afb4..000000000000
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
deleted file mode 100644
index b9aaa9266b34..000000000000
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
deleted file mode 100644
index 1bcb86f0b728..000000000000
diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
deleted file mode 100644
index 37046f3a26d3..000000000000
diff --git a/arch/sh/lib64/Makefile b/arch/sh/lib64/Makefile
deleted file mode 100644
index 69779ff741df..000000000000
diff --git a/arch/sh/lib64/copy_page.S b/arch/sh/lib64/copy_page.S
deleted file mode 100644
index 0ec6fca63b56..000000000000
diff --git a/arch/sh/lib64/copy_user_memcpy.S b/arch/sh/lib64/copy_user_memcpy.S
deleted file mode 100644
index 515f81b00202..000000000000
diff --git a/arch/sh/lib64/memcpy.S b/arch/sh/lib64/memcpy.S
deleted file mode 100644
index 231ea595b39a..000000000000
diff --git a/arch/sh/lib64/memset.S b/arch/sh/lib64/memset.S
deleted file mode 100644
index 453aa5f1d263..000000000000
diff --git a/arch/sh/lib64/panic.c b/arch/sh/lib64/panic.c
deleted file mode 100644
index 38c954e04f6a..000000000000
diff --git a/arch/sh/lib64/sdivsi3.S b/arch/sh/lib64/sdivsi3.S
deleted file mode 100644
index b422e2374430..000000000000
diff --git a/arch/sh/lib64/strcpy.S b/arch/sh/lib64/strcpy.S
deleted file mode 100644
index b61631e523d4..000000000000
diff --git a/arch/sh/lib64/strlen.S b/arch/sh/lib64/strlen.S
deleted file mode 100644
index c00b972f9999..000000000000
diff --git a/arch/sh/lib64/udelay.c b/arch/sh/lib64/udelay.c
deleted file mode 100644
index f215b063da70..000000000000
diff --git a/arch/sh/lib64/udivdi3.S b/arch/sh/lib64/udivdi3.S
deleted file mode 100644
index c032cb157589..000000000000
diff --git a/arch/sh/lib64/udivsi3.S b/arch/sh/lib64/udivsi3.S
deleted file mode 100644
index e4788fb4fe82..000000000000
diff --git a/arch/sh/mm/cache-sh5.c b/arch/sh/mm/cache-sh5.c
deleted file mode 100644
index 445b5e69b73c..000000000000
diff --git a/arch/sh/mm/tlb-sh5.c b/arch/sh/mm/tlb-sh5.c
deleted file mode 100644
index e4bb2a8e0a69..000000000000
-- 
2.26.0

