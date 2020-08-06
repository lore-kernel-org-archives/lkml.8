Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF83206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgHFRsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:48:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:60463 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgHFQfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:35:02 -0400
IronPort-SDR: mb8azU7q6OnPasrYFMjQyzra+BPBUkyVmFji5lA2/4RKlNTbeRGFLEXVh8k5qTver1nfYW9jx4
 1eRs6yuS7eFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="237715846"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="237715846"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 09:34:57 -0700
IronPort-SDR: s9MnVWk0qnB+x3CrRPd9eSjg7CJ9npFh9AmIH8kbb4Yx51prYh0UhDnfZUpJrh+Bdf2gn+i8bs
 huYBepBTzgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="276432190"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2020 09:34:45 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3iqq-0001Tw-Ae; Thu, 06 Aug 2020 16:34:44 +0000
Date:   Fri, 7 Aug 2020 00:33:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: arch/x86/net/bpf_jit_comp.c:342:6: warning: Variable 'ret' is
 reassigned a value before the old one has been used.
Message-ID: <202008070037.Dz0HMdFX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ec5303d73ea344e84f46660fff693c57641386
commit: 428d5df1fa4f28daf622c48dd19da35585c9053c bpf, x86: Emit patchable direct jump as tail call
date:   9 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> arch/x86/net/bpf_jit_comp.c:342:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = 0;
        ^
   arch/x86/net/bpf_jit_comp.c:334:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EBUSY;
        ^
   arch/x86/net/bpf_jit_comp.c:342:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 0;
        ^
   arch/x86/net/bpf_jit_comp.c:409:2: warning: Signed integer overflow for expression '72+(139<<8)+(132<<16)+(214<<24)'. [integerOverflow]
    EMIT4_off32(0x48, 0x8B, 0x84, 0xD6,       /* mov rax, [rsi + rdx * 8 + offsetof(...)] */
    ^

vim +/ret +342 arch/x86/net/bpf_jit_comp.c

   267	
   268	static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
   269					void *old_addr, void *new_addr,
   270					const bool text_live)
   271	{
   272		int (*emit_patch_fn)(u8 **pprog, void *func, void *ip);
   273		const u8 *nop_insn = ideal_nops[NOP_ATOMIC5];
   274		u8 old_insn[X86_PATCH_SIZE] = {};
   275		u8 new_insn[X86_PATCH_SIZE] = {};
   276		u8 *prog;
   277		int ret;
   278	
   279		switch (t) {
   280		case BPF_MOD_NOP_TO_CALL ... BPF_MOD_CALL_TO_NOP:
   281			emit_patch_fn = emit_call;
   282			break;
   283		case BPF_MOD_NOP_TO_JUMP ... BPF_MOD_JUMP_TO_NOP:
   284			emit_patch_fn = emit_jump;
   285			break;
   286		default:
   287			return -ENOTSUPP;
   288		}
   289	
   290		switch (t) {
   291		case BPF_MOD_NOP_TO_CALL:
   292		case BPF_MOD_NOP_TO_JUMP:
   293			if (!old_addr && new_addr) {
   294				memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
   295	
   296				prog = new_insn;
   297				ret = emit_patch_fn(&prog, new_addr, ip);
   298				if (ret)
   299					return ret;
   300				break;
   301			}
   302			return -ENXIO;
   303		case BPF_MOD_CALL_TO_CALL:
   304		case BPF_MOD_JUMP_TO_JUMP:
   305			if (old_addr && new_addr) {
   306				prog = old_insn;
   307				ret = emit_patch_fn(&prog, old_addr, ip);
   308				if (ret)
   309					return ret;
   310	
   311				prog = new_insn;
   312				ret = emit_patch_fn(&prog, new_addr, ip);
   313				if (ret)
   314					return ret;
   315				break;
   316			}
   317			return -ENXIO;
   318		case BPF_MOD_CALL_TO_NOP:
   319		case BPF_MOD_JUMP_TO_NOP:
   320			if (old_addr && !new_addr) {
   321				memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
   322	
   323				prog = old_insn;
   324				ret = emit_patch_fn(&prog, old_addr, ip);
   325				if (ret)
   326					return ret;
   327				break;
   328			}
   329			return -ENXIO;
   330		default:
   331			return -ENOTSUPP;
   332		}
   333	
   334		ret = -EBUSY;
   335		mutex_lock(&text_mutex);
   336		if (memcmp(ip, old_insn, X86_PATCH_SIZE))
   337			goto out;
   338		if (text_live)
   339			text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL);
   340		else
   341			memcpy(ip, new_insn, X86_PATCH_SIZE);
 > 342		ret = 0;
   343	out:
   344		mutex_unlock(&text_mutex);
   345		return ret;
   346	}
   347	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
