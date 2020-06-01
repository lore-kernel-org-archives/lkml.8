Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47702206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591025481;
	bh=PF2KhuKEL3ycx6XYmOpZIdvX0z4+Sjt0iBBkM8qs0gE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FUO17bJQGD7MrFtWuUtpmFQrJC6ZyU+mc+c7izTM8gOGVAq8l/sLIFZFjuPEjFI0R
	 3NEctQzE6ASJZNzH3o1wwSBbZeR4qtUJdLK/cS8gcVBMe3Y2M/iQY3NY0lq7yCARwI
	 VmKC/jJfAmZG1UYAMwq6KniNIsDMmpOjfyM296L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFAPbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:31:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB7C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:31:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so11782096wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pQwTbknM9WKNEvPXjZkLfYm7OjmOKY6ZX0EtJ33xNIw=;
        b=OeBL440709VGlnJ0rmki3e+8CGkbFTssv8PKWAekoU5BJ/NmPqjIBvp/zE3cVPSUTO
         aw39wc4GqGVVBxcn9CuiJ5Aixirq3DcNJWjhg7XPPTRSW2ToX+7SwOG5F/oCOxuPmqH9
         CsCEH5xPwVdJLvkKqyxFX86npy7IqWlReeh+tHwZhZyu5rusToQ352TCD5OOL0OfiODF
         VQ7DjHjbABm9HlDFhLqhkL8iVIoP8SjFTHloi1mlO4q+jVrWVqXMMQtvch23Bzr4zy/7
         0XFpGQKF1lgZfg21RW4c0L52PbwuuHC+sf5enNpKJ3hry6J5XQahaowI4MyZyIwlEnKy
         ZhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=pQwTbknM9WKNEvPXjZkLfYm7OjmOKY6ZX0EtJ33xNIw=;
        b=Yu4jtVnJRGGLrIsw88PdVXfECzyaWxot88FXlXdX8f1knTvWU/zx4m3uPkR0Y5ShQa
         PgRUngYHB/9AHHf0QVIDD4xum09p5seVRisBG9KlnGDRkbORtfTRruwMXBQamEW8Qdns
         KL9lBgykfwjDc9obE7S+a/b2jStR65P1ENkdJ5XtSxsNdij1quBXe6i3LXO+58diA+HF
         im/KR+NN7jUqMyAKBv+8DupDc/Eqv9OOTB+xZIg96pWlMatW3La6uLGS5Cm/tiRrgukx
         4sIjS2AEU/7AAqjqlCWh61ihMDuR5MoKwLNV78MXEBMnJVuGKQQdm1YtBtBeGhkqoRH9
         pOYw==
X-Gm-Message-State: AOAM5303SsDoRf+PwE8qMJ3aPSCDtD/JtghTXHIoODwxB7bKBtQhMUPh
        aSleLWtkw0u28ZvVA20c1+I=
X-Google-Smtp-Source: ABdhPJwiPxgguODtgiHSxwYysFB6H+BpmYw8UHF/RhCIb0/rmgihy1vUb9bxJY5sd/80ij9NhZ5JuA==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr22088794wme.84.1591025477595;
        Mon, 01 Jun 2020 08:31:17 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 94sm22669764wrf.74.2020.06.01.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:31:16 -0700 (PDT)
Date:   Mon, 1 Jun 2020 17:31:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.8
Message-ID: <20200601153114.GA994053@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-06-01

   # HEAD: 0decf1f8de919782b152daf9c991967a2bac54f0 objtool: Enable compilation of objtool for all architectures

There are a lot of objtool changes in this cycle, all across the map:

 - Speed up objtool significantly, especially when there are large number of sections
 - Improve objtool's understanding of special instructions such as IRET,
   to reduce the number of annotations required
 - Implement 'noinstr' validation
 - Do baby steps for non-x86 objtool use
 - Simplify/fix retpoline decoding
 - Add vmlinux validation
 - Improve documentation
 - Fix various bugs and apply smaller cleanups

 Thanks,

	Ingo

------------------>
Alexandre Chartre (4):
      objtool: Uniquely identify alternative instruction groups
      objtool: is_fentry_call() crashes if call has no destination
      objtool: UNWIND_HINT_RET_OFFSET should not check registers
      objtool: Add support for intra-function calls

Ingo Molnar (3):
      objtool: Constify 'struct elf *' parameters
      objtool: Rename elf_read() to elf_open_read()
      objtool: Constify arch_decode_instruction()

Josh Poimboeuf (2):
      samples/ftrace: Fix asm function ELF annotations
      objtool: Add check_kcov_mode() to the uaccess safelist

Julien Thierry (9):
      objtool: Fix off-by-one in symbol_by_offset()
      objtool: Always do header sync check
      objtool: Remove redundant checks on operand type
      objtool: Clean instruction state before each function validation
      objtool: Ignore empty alternatives
      objtool: Use arch specific values in restore_reg()
      objtool: Split out arch-specific CFI definitions
      objtool: Support multiple stack_op per instruction
      objtool: Remove check preventing branches within alternative

Matt Helsley (3):
      objtool: Exit successfully when requesting help
      objtool: Move struct objtool_file into arch-independent header
      objtool: Enable compilation of objtool for all architectures

Miroslav Benes (1):
      objtool: Move the IRET hack into the arch decoder

Muchun Song (1):
      objtool: Remove redundant .rodata section name comparison

Nick Desaulniers (1):
      objtool: Documentation: document UACCESS warnings

Peter Zijlstra (26):
      objtool: Fix 32bit cross builds
      objtool: Better handle IRET
      objtool: Introduce HINT_RET_OFFSET
      x86,ftrace: Fix ftrace_regs_caller() unwind
      x86,ftrace: Use SIZEOF_PTREGS
      x86,ftrace: Shrink ftrace_regs_caller() by one byte
      objtool: Remove SAVE/RESTORE hints
      objtool: Rename struct cfi_state
      objtool: Fix !CFI insn_state propagation
      objtool: Implement noinstr validation
      objtool: Optimize !vmlinux.o again
      objtool: Use sec_offset_hash() for insn_hash
      kbuild/objtool: Add objtool-vmlinux.o pass
      objtool: Avoid iterating !text section symbols
      objtool: Rearrange validate_section()
      objtool: Add STT_NOTYPE noinstr validation
      objtool: Fix ORC vs alternatives
      x86,smap: Fix smap_{save,restore}() alternatives
      objtool: Rework allocating stack_ops on decode
      objtool: Make handle_insn_ops() unconditional
      objtool: Remove INSN_STACK
      x86/speculation: Change FILL_RETURN_BUFFER to work with objtool
      x86: Simplify retpoline declaration
      x86: Change {JMP,CALL}_NOSPEC argument
      x86/retpoline: Fix retpoline unwind
      objtool: Allow no-op CFI ops in alternatives

Raphael Gault (1):
      objtool: Add abstraction for destination offsets

Sami Tolvanen (2):
      objtool: use gelf_getsymshndx to handle >64k sections
      objtool: optimize add_dead_ends for split sections

Thomas Gleixner (1):
      objtool: Also consider .entry.text as noinstr


 arch/x86/crypto/aesni-intel_asm.S                |   4 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S      |   2 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S     |   2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S        |  26 +-
 arch/x86/entry/entry_32.S                        |   6 +-
 arch/x86/entry/entry_64.S                        |   2 +-
 arch/x86/include/asm/GEN-for-each-reg.h          |  25 +
 arch/x86/include/asm/asm-prototypes.h            |  35 +-
 arch/x86/include/asm/nospec-branch.h             |  76 +--
 arch/x86/include/asm/orc_types.h                 |   3 +-
 arch/x86/include/asm/processor.h                 |   2 -
 arch/x86/include/asm/smap.h                      |  11 +-
 arch/x86/include/asm/unwind_hints.h              |  31 +-
 arch/x86/kernel/ftrace.c                         |  14 +-
 arch/x86/kernel/ftrace_32.S                      |   2 +-
 arch/x86/kernel/ftrace_64.S                      |  44 +-
 arch/x86/lib/checksum_32.S                       |   4 +-
 arch/x86/lib/retpoline.S                         |  63 +-
 arch/x86/platform/efi/efi_stub_64.S              |   2 +-
 include/linux/frame.h                            |  11 +
 lib/Kconfig.debug                                |   5 +
 samples/ftrace/ftrace-direct-modify.c            |   4 +
 samples/ftrace/ftrace-direct-too.c               |   2 +
 samples/ftrace/ftrace-direct.c                   |   2 +
 scripts/link-vmlinux.sh                          |  24 +
 tools/arch/x86/include/asm/orc_types.h           |   3 +-
 tools/objtool/Build                              |  13 +-
 tools/objtool/Documentation/stack-validation.txt |  41 ++
 tools/objtool/Makefile                           |  15 +-
 tools/objtool/arch.h                             |  19 +-
 tools/objtool/arch/x86/decode.c                  | 302 +++++----
 tools/objtool/arch/x86/include/cfi_regs.h        |  25 +
 tools/objtool/builtin-check.c                    |  13 +-
 tools/objtool/builtin-orc.c                      |   3 +-
 tools/objtool/builtin.h                          |   2 +-
 tools/objtool/cfi.h                              |  35 +-
 tools/objtool/check.c                            | 801 +++++++++++++++--------
 tools/objtool/check.h                            |  35 +-
 tools/objtool/elf.c                              | 102 ++-
 tools/objtool/elf.h                              |  37 +-
 tools/objtool/objtool.c                          |   4 +-
 tools/objtool/objtool.h                          |  27 +
 tools/objtool/orc.h                              |  18 -
 tools/objtool/orc_dump.c                         |   3 +-
 tools/objtool/orc_gen.c                          |  12 +-
 tools/objtool/weak.c                             |  40 ++
 46 files changed, 1228 insertions(+), 724 deletions(-)
 create mode 100644 arch/x86/include/asm/GEN-for-each-reg.h
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h
 create mode 100644 tools/objtool/objtool.h
 delete mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/weak.c

