Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45401C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044D120848
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7AHUzKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbgALInC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:43:02 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46188 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgALInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:43:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id 13so5627563oij.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xmx0tpI9VECbWS87RMJi3tvMEfC97nidqqr7BCeTGD0=;
        b=s7AHUzKj7/fABTyHdhz6ShjsfWwrCFdUPKFWY4SNXCDF+wRPw2/p6FJnDpEw9HUfI2
         LvTWMmqyYYpG0Bj4Fvt4Hr6469cLU6kRJo5Za2iIS/CWTm8piaOzvBtMQSjpLmgfXu4u
         Me1rAYqj1oDX7cAaGGJSWtulKYDY0IbxODrYnh5IJPBNcYWonweWmSieCBFhmne5a8+U
         w6FU6vosdBHoMdI6RneXErhPHZcmsisF20Hqh66DD1h9Xr2QuehrtBEjP+xuNEUqg0En
         Sf1eA5wFiaUjZRUDK0e8vgcW6s0mhq+tvWO7Ob9fXkGQMSFpK3K7dIjPabTPWFm4QCKE
         Iiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xmx0tpI9VECbWS87RMJi3tvMEfC97nidqqr7BCeTGD0=;
        b=JkU8Ujdb60fNBvEDzg0t9ksihLSB9TGCCQnpzJN3HEHylPF0GzmqWTwq/ZuYTlsiLS
         AA+jZa+Mmxurk3hcTc8Yq9b869bthBZaOMuklAWAJMKgg1RGyzIxvscHbyELb7i+L5yX
         KYrf3U8fuMtYw6tZ9tQifh6Ww6qDnjkhnBFGQpmeaPWYALCJhowbqfDJyut6ioJnizoC
         Zb/pYPzfviMG9RBeDXzqzhk7GI8jDrkOoHKO9ft0QyZCYkPfjHfgboJMynxtbiNj7COM
         fh6bmWPUPXJpifa6tRNmkJ7TxvN+znx96MRbhFlfkbRuU0AkTKP/k57IoVfNjjiLwBo2
         f9/g==
X-Gm-Message-State: APjAAAUxKD7MKkjb6zfZlAvTeEooMAKihma1EURQmj9TrN9zqP3nZQtc
        p94G9WtjdZe2GXgaePcSFU86v/Sc
X-Google-Smtp-Source: APXvYqzeNBNgMmWY3Xv5YrhcZkLRPhmd6hfeX3yWj5xWikDZm7uEBNEiL4I5j7dyfCHYx5z71NHClQ==
X-Received: by 2002:a54:468b:: with SMTP id k11mr8358515oic.134.1578818580380;
        Sun, 12 Jan 2020 00:43:00 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s145sm2357598oie.44.2020.01.12.00.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jan 2020 00:42:59 -0800 (PST)
Date:   Sun, 12 Jan 2020 01:42:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
> Hi,
> 
> This patch series is the continuation of Raphael's work [1]. All the
> patches can be retrieved from:
> git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git
> 
> There still are some outstanding issues but the series is starting to
> get pretty big so it is probably good to start having some discussions
> on the current state of things.
> 
> It felt necessary to split some of the patches (especially the arm64
> decoder). In order to give Raphael credit for his work I used the
> "Suggested-by" tag. If this is not the right way to give credit or if
> it should be present on more patches do let me know.
> 
> There still are some shortcomings. On defconfig here are the remaining
> warnings:
> * arch/arm64/crypto/crct10dif-ce-core.o: warning: objtool: crc_t10dif_pmull_p8()+0xf0: unsupported intra-function call
> * arch/arm64/kernel/cpu_errata.o: warning: objtool: qcom_link_stack_sanitization()+0x4: unsupported intra-function call
> Objtool currently does not support bl from a procedure to itself. This
> is also an issue with retpolines. I need to investigate more to figure
> out whether something can be done for this or if this file should not be
> validated by objtool.
> 
> * arch/arm64/kernel/efi-entry.o: warning: objtool: entry()+0xb0: sibling call from callable instruction with modified stack frame
> The EFI entry jumps to code mapped by EFI. Objtool cannot know statically where the code flow is going.
> 
> * arch/arm64/kernel/entry.o: warning: objtool: .entry.tramp.text+0x404: unsupported intra-function call
> Need to figure out what is needed to handle aarch64 trampolines. x86
> explicitly annotates theirs with ANNOTATE_NOSPEC_ALTERNATIVE and
> patching them as alternatives.
> 
> * arch/arm64/kernel/head.o: warning: objtool: .head.text+0x58: can't find jump dest instruction at .head.text+0x80884
> This is actually a constant that turns out to be a valid branch opcode.
> A possible solution could be to introduce a marco that explicitly
> annotates constants placed in code sections.
> 
> * arch/arm64/kernel/hibernate-asm.o: warning: objtool: el1_sync()+0x4: unsupported instruction in callable function
> Symbols el<x>_* shouldn't be considered as callable functions. Should we
> use SYM_CODE_END instead of PROC_END?
> 
> * arch/arm64/kvm/hyp/hyp-entry.o: warning: objtool: .hyp.text: empty alternative at end of section
> This is due to the arm64 alternative_cb. Currently, the feature
> corresponding to the alternative_cb is defined as the current number of
> features supported by the kernel, meaning the identifier is not fixed
> accross kernel versions. This makes it a bit hard to detect these
> alternative_cb for external tools.
> 
> Would it be acceptable to set a fixed identifier for alternative_cb?
> (probably 0xFF so it is always higher than the number of real features)
> 
> * drivers/ata/libata-scsi.o: warning: objtool: ata_sas_queuecmd() falls through to next function ata_scsi_scan_host()
> This is due to a limitation in the switch table metadata interpretation.
> The compiler might create a table of unsigned offsets and then
> compute the final offset as follows:
> 
> 	ldrb    offset_reg, [<offset_table>, <offset_idx>, uxtw]
> 	adr     base_reg, <base_addr>
> 	add     res_addr, base_reg, offset_reg, sxtb #2
> 
> Effectively using the loaded offset as a signed value.
> I don't have a simple way to solve this at the moment, I'd like to
> avoid decoding the instructions to check which ones might sign extend
> the loaded offset.
> 
> * kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x44: sibling call from callable instruction with modified stack frame
> This is because the function uses a C jump table which differ from
> basic jump tables. Also, the code generated for C jump tables on arm64
> does not follow the same form as the one for x86. So the existing x86 objtool
> code handling C jump tables can't be used.
> 
> I'll focus on understanding the arm64 pattern so objtool can handle them.
> 
> 
> In the mean time, any feedback on the current state is appreciated.
> 
> * Patches 1 to 18 adapts the current objtool code to make it easier to
>   support new architectures.
> * Patches 19 to 45 add the support for arm64 architecture to objtool.
> * Patches 46 to 57 fix warnings reported by objtool on the existing
>   arm64 code.
> 
> Changes since RFCv4[1]:
> * Rebase on v5.5-rc5
> * Misc cleanup/bug fixes
> * Fix some new objtool warnings reported on arm64 objects
> * Make ORC subcommand optional since arm64 does not currently support it
> * Support branch instructions in alternative sections when they jump
>   within the same set of alternative instructions
> * Replace the "extra" stack_op with a list of stack_op
> * Split the decoder into multiple patches to ease review
> * Mark constants generated by load literal instructions as bytes that
>   should not be reached by execution flow
> * Rework the switch table handling
> 
> [1] https://lkml.org/lkml/2019/8/16/400
> 
> Thanks,
> 
> Julien
> 
> -->
> 
> Julien Thierry (43):
>   objtool: check: Remove redundant checks on operand type
>   objtool: check: Clean instruction state before each function
>     validation
>   objtool: check: Use arch specific values in restore_reg()
>   objtool: check: Ignore empty alternative groups
>   objtool: Give ORC functions consistent name
>   objtool: Make ORC support optional
>   objtool: Split generic and arch specific CFI definitions
>   objtool: Abstract alternative special case handling
>   objtool: check: Allow jumps from an alternative group to itself
>   objtool: Do not look for STT_NOTYPE symbols
>   objtool: Support addition to set frame pointer
>   objtool: Support restoring BP from the stack without POP
>   objtool: Make stack validation more generic
>   objtool: Support multiple stack_op per instruction
>   objtool: arm64: Decode unknown instructions
>   objtool: arm64: Decode simple data processing instructions
>   objtool: arm64: Decode add/sub immediate instructions
>   objtool: arm64: Decode logical data processing instructions
>   objtool: arm64: Decode system instructions not affecting the flow
>   objtool: arm64: Decode calls to higher EL
>   objtool: arm64: Decode brk instruction
>   objtool: arm64: Decode instruction triggering context switch
>   objtool: arm64: Decode branch instructions with PC relative immediates
>   objtool: arm64: Decode branch to register instruction
>   objtool: arm64: Decode basic load/stores
>   objtool: arm64: Decode load/store with register offset
>   objtool: arm64: Decode load/store register pair instructions
>   objtool: arm64: Decode FP/SIMD load/store instructions
>   objtool: arm64: Decode load/store exclusive
>   objtool: arm64: Decode atomic load/store
>   objtool: arm64: Decode pointer auth load instructions
>   objtool: arm64: Decode load acquire/store release
>   objtool: arm64: Decode load/store with memory tag
>   objtool: arm64: Decode load literal
>   objtool: arm64: Decode register data processing instructions
>   objtool: arm64: Decode FP/SIMD data processing instructions
>   objtool: arm64: Decode SVE instructions
>   objtool: arm64: Implement functions to add switch tables alternatives
>   arm64: Generate no-ops to pad executable section
>   arm64: Move constant to rodata
>   arm64: Mark sigreturn32.o as containing non standard code
>   arm64: entry: Avoid empty alternatives entries
>   arm64: crypto: Remove redundant branch
> 
> Raphael Gault (14):
>   objtool: Add abstraction for computation of symbols offsets
>   objtool: orc: Refactor ORC API for other architectures to implement.
>   objtool: Move registers and control flow to arch-dependent code
>   objtool: Refactor switch-tables code to support other architectures
>   objtool: arm64: Add required implementation for supporting the aarch64
>     architecture in objtool.
>   gcc-plugins: objtool: Add plugin to detect switch table on arm64
>   objtool: arm64: Enable stack validation for arm64
>   arm64: alternative: Mark .altinstr_replacement as containing
>     executable instructions
>   arm64: assembler: Add macro to annotate asm function having non
>     standard stack-frame.
>   arm64: sleep: Prevent stack frame warnings from objtool
>   arm64: kvm: Annotate non-standard stack frame functions
>   arm64: kernel: Add exception on kuser32 to prevent stack analysis
>   arm64: crypto: Add exceptions for crypto object to prevent stack
>     analysis
>   arm64: kernel: Annotate non-standard stack frame functions
> 
>  arch/arm64/Kconfig                            |    2 +
>  arch/arm64/crypto/Makefile                    |    3 +
>  arch/arm64/crypto/sha1-ce-core.S              |    3 +-
>  arch/arm64/crypto/sha2-ce-core.S              |    3 +-
>  arch/arm64/crypto/sha3-ce-core.S              |    3 +-
>  arch/arm64/crypto/sha512-ce-core.S            |    3 +-
>  arch/arm64/include/asm/alternative.h          |    2 +-
>  arch/arm64/kernel/Makefile                    |    4 +
>  arch/arm64/kernel/entry.S                     |    4 +-
>  arch/arm64/kernel/hyp-stub.S                  |    3 +
>  arch/arm64/kernel/relocate_kernel.S           |    5 +
>  arch/arm64/kernel/sleep.S                     |    5 +
>  arch/arm64/kvm/hyp-init.S                     |    3 +
>  arch/arm64/kvm/hyp/entry.S                    |    3 +
>  include/linux/frame.h                         |   19 +-
>  scripts/Makefile.gcc-plugins                  |    2 +
>  scripts/gcc-plugins/Kconfig                   |    4 +
>  .../arm64_switch_table_detection_plugin.c     |   94 +
>  tools/objtool/Build                           |    4 +-
>  tools/objtool/Makefile                        |   13 +-
>  tools/objtool/arch.h                          |   14 +-
>  tools/objtool/arch/arm64/Build                |    5 +
>  tools/objtool/arch/arm64/arch_special.c       |  262 ++
>  tools/objtool/arch/arm64/bit_operations.c     |   69 +
>  tools/objtool/arch/arm64/decode.c             | 2866 +++++++++++++++++
>  .../objtool/arch/arm64/include/arch_special.h |   23 +
>  .../arch/arm64/include/bit_operations.h       |   31 +
>  tools/objtool/arch/arm64/include/cfi_regs.h   |   44 +
>  .../objtool/arch/arm64/include/insn_decode.h  |  206 ++
>  tools/objtool/arch/x86/Build                  |    3 +
>  tools/objtool/arch/x86/arch_special.c         |  182 ++
>  tools/objtool/arch/x86/decode.c               |   29 +-
>  tools/objtool/arch/x86/include/arch_special.h |   28 +
>  tools/objtool/arch/x86/include/cfi_regs.h     |   25 +
>  tools/objtool/{ => arch/x86}/orc_dump.c       |    4 +-
>  tools/objtool/{ => arch/x86}/orc_gen.c        |  114 +-
>  tools/objtool/cfi.h                           |   21 +-
>  tools/objtool/check.c                         |  461 +--
>  tools/objtool/check.h                         |   13 +-
>  tools/objtool/elf.c                           |    3 +-
>  tools/objtool/objtool.c                       |    2 +
>  tools/objtool/orc.h                           |   38 +-
>  tools/objtool/special.c                       |   44 +-
>  tools/objtool/special.h                       |   13 +
>  44 files changed, 4282 insertions(+), 400 deletions(-)
>  create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
>  create mode 100644 tools/objtool/arch/arm64/Build
>  create mode 100644 tools/objtool/arch/arm64/arch_special.c
>  create mode 100644 tools/objtool/arch/arm64/bit_operations.c
>  create mode 100644 tools/objtool/arch/arm64/decode.c
>  create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
>  create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
>  create mode 100644 tools/objtool/arch/arm64/include/cfi_regs.h
>  create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h
>  create mode 100644 tools/objtool/arch/x86/arch_special.c
>  create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>  create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h
>  rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
>  rename tools/objtool/{ => arch/x86}/orc_gen.c (62%)
> 
> --
> 2.21.0
> 

Hi Julien,

The 0day bot reported a couple of issues with clang with this series;
the full report is available here (clang reports are only sent to our
mailing lists for manual triage for the time being):

https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ

The first obvious issue is that this series appears to depend on a GCC
plugin? I'll be quite honest, objtool and everything it does is rather
over my head but I see this warning during configuration (allyesconfig):

WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
  Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
    Selected by [y]:
      - ARM64 [=y] && STACK_VALIDATION [=y]

Followed by the actual error:

error: unable to load plugin
'./scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
'./scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
open shared object file: No such file or directory'

If this plugin is absolutely necessary and can't be implemented in
another way so that clang can be used, seems like STACK_VALIDATION
should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.

The second issue I see is the -Wenum-conversion warnings; they are
pretty trivial to fix (see commit e7e83dd3ff1d ("objtool: Fix Clang
enum conversion warning") upstream and the below diff).

Would you mind addressing these in a v6 if you happen to do one?

Cheers,
Nathan

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 5a5f82b5cb81..1ed6bf0c85ce 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -1518,7 +1518,7 @@ int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
 		op->dest.type = OP_DEST_REG_INDIRECT;
 		op->dest.reg = rn;
 		op->dest.offset = SIGN_EXTEND(imm9, 9);
-		op->src.type = OP_DEST_REG;
+		op->src.type = OP_SRC_REG;
 		op->src.reg = rt;
 		op->src.offset = 0;
 		break;
@@ -1605,7 +1605,7 @@ int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
 		op->dest.type = OP_DEST_REG_INDIRECT;
 		op->dest.reg = rn;
 		op->dest.offset = imm12;
-		op->src.type = OP_DEST_REG;
+		op->src.type = OP_SRC_REG;
 		op->src.reg = rt;
 		op->src.offset = 0;
 	}
@@ -1772,7 +1772,7 @@ int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
 		op->dest.type = OP_DEST_REG_INDIRECT;
 		op->dest.reg = rn;
 		op->dest.offset = SIGN_EXTEND(imm9, 9);
-		op->src.type = OP_DEST_REG;
+		op->src.type = OP_SRC_REG;
 		op->src.reg = rt;
 		op->src.offset = 0;
 		break;
@@ -1852,7 +1852,7 @@ int arm_decode_atomic(u32 instr, enum insn_type *type,
 	list_add_tail(&op->list, ops_list);
 
 	op->src.reg = rn;
-	op->src.type = OP_DEST_REG_INDIRECT;
+	op->src.type = OP_SRC_REG_INDIRECT;
 	op->src.offset = 0;
 	op->dest.type = OP_DEST_REG;
 	op->dest.reg = rt;
@@ -2187,7 +2187,7 @@ int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
 		break;
 	default:
 		/* store */
-		op->dest.type = OP_SRC_REG_INDIRECT;
+		op->dest.type = OP_DEST_REG_INDIRECT;
 		op->dest.reg = rn;
 		op->dest.offset = SIGN_EXTEND(imm9, 9);
 		op->src.type = OP_SRC_REG;
