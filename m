Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7559C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A474024125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HOmDjtWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAWLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:23:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWLXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:23:35 -0500
Received: from zn.tnic (p200300EC2F095B007CEF2742CE4F9BF9.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:7cef:2742:ce4f:9bf9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 630C21EC090E;
        Thu, 23 Jan 2020 12:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579778613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hRe9d/8HwMsKWPju00wJDOvQA2tbXHEiP0IhYplqqI=;
        b=HOmDjtWBraDg+MI/vyhzgsCJ+b8r/QCnRTgOlw6P2PBByxZQLlIOZ7Kob6KNlAIN4VRky9
        zeEGRREhX3p0G5MROnl9p3w614SZJUEOvm+UWrwxBH7UoUCydhhY5q+JEJ4zeu4OzoHYzV
        HC6K/7lGV7n87nJSm2E06EPHisV94Qc=
Date:   Thu, 23 Jan 2020 12:23:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org
Subject: Re: [PATCH 0/3] [RFC] x86: start the MPX removal process
Message-ID: <20200123112325.GC10328@zn.tnic>
References: <20190705175317.1B3C9C52@viggo.jf.intel.com>
 <20200122130913.GA20584@zn.tnic>
 <26980d2a-def2-6069-1687-5066f90eb749@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26980d2a-def2-6069-1687-5066f90eb749@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:14:58AM -0800, Dave Hansen wrote:
> Here's an updated tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx.git/log/?h=mpx-remove-202001
> 
> Very lightly tested.

Thx.

So I merged tip/master into it and did some build smoke testing. The
only issue I found is below which happens with an allnoconfig build and
the fix is simple:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 34360ca301a2..e8133c0e7799 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -21,6 +21,7 @@
 #include <asm/pgtable.h>
 #include <asm/mce.h>
 #include <asm/nmi.h>
+#include <asm/insn.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>

as apparently the include hell needs to be satisfied again. :)

You could fold it into one of your 4 patches so that you don't break
bisection and then either send the pull request directly to Linus next
week or I can do that - I'm fine with either.

Provided, of course, there are no other complaints.

Thx.

---
    arch/x86/kernel/alternative.c: In function ‘text_poke_loc_init’:
    arch/x86/kernel/alternative.c:1172:14: error: storage size of ‘insn’ isn’t known
     1172 |  struct insn insn;
          |              ^~~~
    arch/x86/kernel/alternative.c:1178:2: error: implicit declaration of function ‘kernel_insn_init’; did you mean ‘kernfs_init’? [-Werror=implicit-function-declaration]
     1178 |  kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
          |  ^~~~~~~~~~~~~~~~
          |  kernfs_init
    arch/x86/kernel/alternative.c:1178:35: error: ‘MAX_INSN_SIZE’ undeclared (first use in this function); did you mean ‘CALL_INSN_SIZE’?
     1178 |  kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
          |                                   ^~~~~~~~~~~~~
          |                                   CALL_INSN_SIZE
    arch/x86/kernel/alternative.c:1178:35: note: each undeclared identifier is reported only once for each function it appears in
    arch/x86/kernel/alternative.c:1179:2: error: implicit declaration of function ‘insn_get_length’ [-Werror=implicit-function-declaration]
     1179 |  insn_get_length(&insn);
          |  ^~~~~~~~~~~~~~~
    In file included from ./include/linux/export.h:43,
                     from ./include/linux/linkage.h:7,
                     from ./include/linux/kernel.h:8,
                     from ./include/linux/list.h:9,
                     from ./include/linux/module.h:12,
                     from arch/x86/kernel/alternative.c:4:
    arch/x86/kernel/alternative.c:1181:10: error: implicit declaration of function ‘insn_complete’; did you mean ‘complete’? [-Werror=implicit-function-declaration]
     1181 |  BUG_ON(!insn_complete(&insn));
          |          ^~~~~~~~~~~~~
    ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
       78 | # define unlikely(x) __builtin_expect(!!(x), 0)
          |                                          ^
    arch/x86/kernel/alternative.c:1181:2: note: in expansion of macro ‘BUG_ON’
     1181 |  BUG_ON(!insn_complete(&insn));
          |  ^~~~~~
    arch/x86/kernel/alternative.c:1172:14: warning: unused variable ‘insn’ [-Wunused-variable]
     1172 |  struct insn insn;
          |              ^~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:266: arch/x86/kernel/alternative.o] Error 1
    make[2]: *** Waiting for unfinished jobs....
    make[1]: *** [scripts/Makefile.build:503: arch/x86/kernel] Error 2
    make: *** [Makefile:1694: arch/x86] Error 2
    make: *** Waiting for unfinished jobs....



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
