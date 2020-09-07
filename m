Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C4C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA820207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498230;
	bh=Zzfnlcjx2zYJ0tiWlm3weofgZXW5EGMPZ6lwrOZW6qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pri8jUqthyIHDjauX5lxK0p5WfxOyGmqfnTwbyjM5ikaNwX+vtue0NE90jtmJiEqx
	 gIO8I3G+JWo2Xp8VdTYyJShnQ1gTOclNxKUNgxkIQOYc23nayhppZnSlMmjvqjT5eh
	 8z/Aowg1kA/rDxwUaOwQX1g2/r8SnQ/9/xT37TpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgIGRDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgIGQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A722121D1B;
        Mon,  7 Sep 2020 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496397;
        bh=Zzfnlcjx2zYJ0tiWlm3weofgZXW5EGMPZ6lwrOZW6qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwvKmsGThSTRpO71SDAldVwQ1ExIRZ0n7WK9H4eHaBkaTyXOF7WBStjn67GlXK2b1
         jcNtSr5b8sM009XT8HofpnehRP2UQ4gODALsdtNvQoS+eSJPtK1UvTxURK9++x8jfQ
         iKje3PnyHmVf7RDrP479Gs2wukat4xeoc5TkCBdA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 45/53] arm64/module: set trampoline section flags regardless of CONFIG_DYNAMIC_FTRACE
Date:   Mon,  7 Sep 2020 12:32:11 -0400
Message-Id: <20200907163220.1280412-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Yu <jeyu@kernel.org>

[ Upstream commit e0328feda79d9681b3e3245e6e180295550c8ee9 ]

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

Signed-off-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: http://lore.kernel.org/r/20200831094651.GA16385@linux-8ccs
Link: https://lore.kernel.org/r/20200901160016.3646-1-jeyu@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/module-plts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 65b08a74aec65..37c0b51a7b7b5 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -271,8 +271,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
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
2.25.1

