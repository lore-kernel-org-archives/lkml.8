Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223CF2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586359979;
	bh=KR8dtiLzQM0I3iyqbpU/CmxNVf+o2K/a6r8i0w0Cym0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cVX2G4lPmwoO0zLpk5qJ4BTKpH+5LtCmsXdhN10qMs/n529Wq6zJZZJGAsADuTRrR
	 3kVNyHocgfB8kGFQ/mlWwYO9kmz4BNqR2+BNwz12pspHr2J2iW3Qry5Z6aAhEd60gQ
	 Q0FgsaDu4XPM1PDiBkFaodkEhAemPPdby+jApIkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgDHPc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgDHPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:32:54 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D17206F7;
        Wed,  8 Apr 2020 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586359974;
        bh=KR8dtiLzQM0I3iyqbpU/CmxNVf+o2K/a6r8i0w0Cym0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7lL3+zq930cGJDkQFlvjc5XwGkBDapjKHOG/9UgM4JsnogiMHRXglF92jzF4dBtJ
         k58QaErsFbYiAp7A6O8NHs5RlRQJPN7p0kSsuhmxTpE1VGNt/fmS9YAIgYHmbE9vKm
         032kuJB/Eh5dFYkwaGL6WDgvjpIuzCRU+WDoFIvI=
Date:   Wed, 8 Apr 2020 17:32:49 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200408153249.GA26619@linux-8ccs>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [03/04/20 19:13 +0200]:
>
>We're very close to enforcing W^X memory, refuse to load modules that
>violate this principle per construction.
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>---
> kernel/module.c |   25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2044,9 +2044,29 @@ static void module_enable_x(const struct
> 	frob_text(&mod->core_layout, set_memory_x);
> 	frob_text(&mod->init_layout, set_memory_x);
> }
>+
>+static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>+				       char *secstrings, struct module *mod)
>+{
>+	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
>+	int i;
>+
>+	for (i = 0; i < hdr->e_shnum; i++) {
>+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
>+			return -ENOEXEC;
>+	}
>+
>+	return 0;
>+}

Just to clarify, did we want to enforce this only when
CONFIG_STRICT_MODULE_RWX=y?  Because here it's still in the
CONFIG_ARCH_HAS_STRICT_MODULE_RWX block.

Unfortunately, when we add module_enforce_rwx_sections() in the
CONFIG_STRICT_MODULE_RWX block, we'll need two empty stubs, one for
!CONFIG_ARCH_HAS_STRICT_MODULE_RWX and one for !CONFIG_STRICT_MODULE_RWX.

This is because the CONFIG_STRICT_MODULE_RWX block is currently nested
within ARCH_HAS_STRICT_MODULE_RWX :/

That unholy nested ifdef mess needs to be fixed. I will post a patch
shortly that gets rid of this nesting and you could rebase on top of
it if you want to move module_enforce_rwx_sections() under
CONFIG_STRICT_MODULE_RWX. Then you'll only need to provide one empty
stub for !CONFIG_STRICT_MODULE_RWX.

Thanks,

Jessica
