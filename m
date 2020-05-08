Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3238E21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BXFNddSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEHJzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:55:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB1AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1qiPHwUFLeR9Y+U8shdiunNxWjV/LvI/p08aPdE5Uzk=; b=BXFNddSQ8wWBlo23mkyZxKRExm
        Wu7bY+KZ6WjSbbvP1r4oLQctDj8lTXtaoewGS3XCiM0wZTd+3sboFl+szcN1sv/8lOvkhlciO9gYa
        J/LUXud7yXAYikCDKCvRSovhquPiFpvzKpdYcMr7vrlhxxHhrkboN6yBijL8E5wZAz+DYwRYgkHYz
        dpfLM0a2k2c+j383RvRHG3Y6cb4rgKBoNuB4n+Sn3G2OioNVB0lWDnDN1k3PVNeUoOggos3WIQl18
        3bhIrFSGTy6HpWbWQ43ulfr+UsxsUqBXWh1QcIrsNKvwB1AlXtIwPKmAd7fHZWQGe7VHN97IghKCf
        TjjtWKlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzip-00051t-CN; Fri, 08 May 2020 09:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D71C03012DC;
        Fri,  8 May 2020 11:55:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C166F201C228D; Fri,  8 May 2020 11:55:09 +0200 (CEST)
Date:   Fri, 8 May 2020 11:55:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508095509.GX5298@hirez.programming.kicks-ass.net>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:27:39AM +0200, Arnd Bergmann wrote:

> Right, makes sense. It would be nice though to have a way of intentionally
> turning all objtool warnings into errors. I do my randconfig tests
> with '-Werror'
> at the moment in order to catch all new warnings, but this does not catch
> objtool errors at the moment. For now, this is probably the right thing to do,
> as there are a couple of warnings that I have no patches for, but at some point
> I would prefer to trap immediately when a new warning pops up.

Completely untested, and I'm 100% unsure of the Makefile change, but
something like so, then?

---

 scripts/Makefile.build        | 2 ++
 tools/objtool/builtin-check.c | 3 ++-
 tools/objtool/builtin.h       | 2 +-
 tools/objtool/check.c         | 8 +-------
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9fcbfac15d1d..c656f114ce30 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -201,6 +201,8 @@ objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
 objtool_args += $(if $(part-of-module), --module,)
 
+objtool_args += $(if $(findstring $(KBUILD_CFLAGS), "-Werror "), --error,)
+
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index be42b716166b..3d10ae8b0b25 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, error;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -35,6 +35,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
+	OPT_BOOLEAN('e', "error", &error, "Return error on warnings"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 85c979caa367..90c43c6c1e35 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, error;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 831ffa9e68c4..eed24c584d71 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2793,14 +2793,8 @@ int check(const char *_objname, bool orc)
 	}
 
 out:
-	if (ret < 0) {
-		/*
-		 *  Fatal error.  The binary is corrupt or otherwise broken in
-		 *  some way, or objtool itself is broken.  Fail the kernel
-		 *  build.
-		 */
+	if (error && ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
