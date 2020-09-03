Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A14C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B494E20758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599137276;
	bh=7gaII+6iRrPDWY4oYtQ2Q/wK8sLcSyyW/j7PoEAKdiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fiac4x0wK9wdR8xxjMpgVllt9uHszuMp1ZQbwtP0oLG7T021fw5edRTvYtlXu/o+7
	 KvYEHHkfIvmnjDf3aQ5S3Ll7dR+I6y3SI17adNNQS+f7RDWUUVqCif8JTuNViJJ79U
	 sCjJrfuGyxBqwXn1+hBLyBUKBQHXwjCaQPKmg53o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgICMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgICMhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:37:51 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807A8206EB;
        Thu,  3 Sep 2020 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599136667;
        bh=7gaII+6iRrPDWY4oYtQ2Q/wK8sLcSyyW/j7PoEAKdiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zpMR8uosbiNvWvtT58vIYQb6KJYN8YwsaeMipiu3bb5uTCfi12zkPOpFgcUgq+D6w
         gV5rDJrdCXHXEyB9MQVAZyjNy9G5eECIEou9b3kK2bx/fkEGjf5uFhbPXt4HLlr13T
         xdnPrND6Nw8NMyVcrdpjzc29YCAg89RkEcitC9hs=
Date:   Thu, 3 Sep 2020 14:37:40 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200903123739.GA11683@linux-8ccs>
References: <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net>
 <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs>
 <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck>
 <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck>
 <20200831094651.GA16385@linux-8ccs>
 <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [31/08/20 19:42 +0900]:
[snipped for brevity]
>Sorry for the delay.
>
>Please try the attached patch.

Hi Masahiro,

Thank you for the patch. Sorry for the delay, I just wanted to report back
after briefly testing your patch. It works great, at the moment I've only
tested with arm64.

I made the following change to arch/arm64/include/asm/module.lds.h:

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 691f15af788e..d8e786e5fcdb 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -2,6 +2,8 @@
 SECTIONS {
        .plt (NOLOAD) : { BYTE(0) }
        .init.plt (NOLOAD) : { BYTE(0) }
+#ifdef CONFIG_DYNAMIC_FTRACE
        .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
+#endif
 }
 #endif

Since originally we wanted to include .text.ftrace_trampoline only conditionally.

The resulting scripts/module.lds looks correct with CONFIG_DYNAMIC_FTRACE=y:

SECTIONS {
 /DISCARD/ : {
  *(.discard)
  *(.discard.*)
 }
 __ksymtab 0 : { *(SORT(___ksymtab+*)) }
 __ksymtab_gpl 0 : { *(SORT(___ksymtab_gpl+*)) }
 __ksymtab_unused 0 : { *(SORT(___ksymtab_unused+*)) }
 __ksymtab_unused_gpl 0 : { *(SORT(___ksymtab_unused_gpl+*)) }
 __ksymtab_gpl_future 0 : { *(SORT(___ksymtab_gpl_future+*)) }
 __kcrctab 0 : { *(SORT(___kcrctab+*)) }
 __kcrctab_gpl 0 : { *(SORT(___kcrctab_gpl+*)) }
 __kcrctab_unused 0 : { *(SORT(___kcrctab_unused+*)) }
 __kcrctab_unused_gpl 0 : { *(SORT(___kcrctab_unused_gpl+*)) }
 __kcrctab_gpl_future 0 : { *(SORT(___kcrctab_gpl_future+*)) }
 .init_array 0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 __jump_table 0 : ALIGN(8) { KEEP(*(__jump_table)) }
}
SECTIONS {
 .plt (NOLOAD) : { BYTE(0) }
 .init.plt (NOLOAD) : { BYTE(0) }
 .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
} 

And with CONFIG_DYNAMIC_FTRACE=n as well:

SECTIONS {
 .plt (NOLOAD) : { BYTE(0) }
 .init.plt (NOLOAD) : { BYTE(0) }
}

I will test on more arches in the next days but in the meantime you could add my

    Tested-by: Jessica Yu <jeyu@kernel.org>

Thank you for working on this!

