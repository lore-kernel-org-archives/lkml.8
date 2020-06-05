Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D3420772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591349641;
	bh=FImC/l4G4zxlbSBs4Ry93KD5MEwyhWGyKsQ3lcZ3cd4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=itvUbLMtU7eWHsqhkQG7SuWG57sr0qK534irsRR8mBR8E4Nbm2XX55hG8r/pXIUWJ
	 E+wec01VSqonlgq1+ubgwlhMmqXqgCq5EgsOm+4c5Bwk4y/Ps3bJg0Ug437sITZvzA
	 G0kWuIP4qA69qipik06g+W86tGWSSBLt7lQx8i+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFEJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFEJeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:34:00 -0400
Received: from linux-8ccs.fritz.box (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8739820772;
        Fri,  5 Jun 2020 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591349639;
        bh=FImC/l4G4zxlbSBs4Ry93KD5MEwyhWGyKsQ3lcZ3cd4=;
        h=Date:From:To:Cc:Subject:From;
        b=AdGU7FFN1HYRa2nRlXmMoMa9bP1w70c2K1flQVCozB09AeKJjfK/gqMi044PfVMDo
         /ffHb+s0P93qi0ito4g10fTRGS6xYAZ0kBoycKjUFxPztDPyEQTUXyWUAw2B4tAJZN
         u8/YOVVGNxi8UnSimYQYXs7ZY0JAZygoR67ligH0=
Date:   Fri, 5 Jun 2020 11:33:56 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.8
Message-ID: <20200605093354.GA23721@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.8 merge window.
Details can be found in the signed tag.

There was a small conflict with the livepatching tree, which has already been
merged into master. Inlined below you'll find the conflict resolution merging
modules-next into mainline. It should be straightforward, but please let me
know if you run into any issues. Thanks!

diff --cc kernel/module.c
index bca993c5f1bc,70fc20583e66..ef400c389f49
--- a/kernel/module.c
+++ b/kernel/module.c
@@@ -2026,20 -2052,29 +2042,29 @@@ static void module_enable_nx(const stru
  	frob_writable_data(&mod->init_layout, set_memory_nx);
  }
  
+ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+ 				       char *secstrings, struct module *mod)
+ {
+ 	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
+ 	int i;
+ 
+ 	for (i = 0; i < hdr->e_shnum; i++) {
+ 		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
+ 			return -ENOEXEC;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  #else /* !CONFIG_STRICT_MODULE_RWX */
 -/* module_{enable,disable}_ro() stubs are in module.h */
  static void module_enable_nx(const struct module *mod) { }
 +static void module_enable_ro(const struct module *mod, bool after_init) {}
- #endif /*  CONFIG_STRICT_MODULE_RWX */
- static void module_enable_x(const struct module *mod)
+ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+ 				       char *secstrings, struct module *mod)
  {
- 	frob_text(&mod->core_layout, set_memory_x);
- 	frob_text(&mod->init_layout, set_memory_x);
+ 	return 0;
  }
- #else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
- static void module_enable_nx(const struct module *mod) { }
- static void module_enable_x(const struct module *mod) { }
- #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
- 
+ #endif /*  CONFIG_STRICT_MODULE_RWX */
  
  #ifdef CONFIG_LIVEPATCH
  /*

---
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.8

for you to fetch changes up to 5c3a7db0c7ec4bbd5bd3f48af9be859a8fa3e532:

  module: Harden STRICT_MODULE_RWX (2020-04-21 17:20:13 +0200)

----------------------------------------------------------------
Modules updates for v5.8

Summary of modules changes for the 5.8 merge window:

- Harden CONFIG_STRICT_MODULE_RWX by rejecting any module that has
  SHF_WRITE|SHF_EXECINSTR sections
- Remove and clean up nested #ifdefs, as it makes code hard to read

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
      module: break nested ARCH_HAS_STRICT_MODULE_RWX and STRICT_MODULE_RWX #ifdefs

Peter Zijlstra (1):
      module: Harden STRICT_MODULE_RWX

 kernel/module.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)
