Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93325206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976050;
	bh=pDtKSsyNtfo6A+XZu64fFl0XntKONImNrGKzO4QURlQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NLgwLaHFHbiACZla7fJ6MGk2fdn7fmgVLVUCS4nd1zasRuun7TZnftgAFLIG6GuYL
	 wLEQadqmbdQX03nlGcGhvXMRf4/2jdmeG86QUutIcSQQDRI06D5tj0cQI8HhyjHWq9
	 69yZBKyXdnkP1ifm+Bs4cd1grJzHI0Wj2EgTBXaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgIAQAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbgIAQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:00:39 -0400
Received: from linux-8ccs.suse.de (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BCA208CA;
        Tue,  1 Sep 2020 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598976039;
        bh=pDtKSsyNtfo6A+XZu64fFl0XntKONImNrGKzO4QURlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=L4/n2oY8fWc+Nc61dJGdt6LEjVftFegfhIpxMofguxmhPWu3O5M6EtajeaJiLN4bu
         DHoqnE4lGESxgmyO21tQppdZZzQY8L5/at7tjBqlc0S1l0FwBI+22PlMAint62Ni/i
         V7N23PumbpUeM7lYDLHHysMn1vr1dmDt1zFVr0FA=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE
Date:   Tue,  1 Sep 2020 18:00:16 +0200
Message-Id: <20200901160016.3646-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the arm64 module linker script, the section .text.ftrace_trampoline
is specified unconditionally regardless of whether CONFIG_DYNAMIC_FTRACE
is enabled (this is simply due to the limitation that module linker
scripts are not preprocessed like the vmlinux one).

Normally, for .plt and .text.ftrace_trampoline, the section flags
present in the module binary wouldn't matter since module_frob_arch_sections()
would assign them manually anyway. However, the arm64 module loader only
sets the section flags for .text.ftrace_trampoline when CONFIG_DYNAMIC_FTRACE=y.
That's only become problematic recently due to a recent change in
binutils-2.35, where the .text.ftrace_trampoline section (along with the
.plt section) is now marked writable and executable (WAX).

We no longer allow writable and executable sections to be loaded due to
commit 5c3a7db0c7ec ("module: Harden STRICT_MODULE_RWX"), so this is
causing all modules linked with binutils-2.35 to be rejected under arm64.
Drop the IS_ENABLED(CONFIG_DYNAMIC_FTRACE) check in module_frob_arch_sections()
so that the section flags for .text.ftrace_trampoline get properly set to
SHF_EXECINSTR|SHF_ALLOC, without SHF_WRITE.

Link: http://lore.kernel.org/r/20200831094651.GA16385@linux-8ccs
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 arch/arm64/kernel/module-plts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 0ce3a28e3347..2e224435c024 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.core.plt_shndx = i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
 			mod->arch.init.plt_shndx = i;
-		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
-			 !strcmp(secstrings + sechdrs[i].sh_name,
+		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
-- 
2.16.4

