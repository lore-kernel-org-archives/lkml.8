Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F3CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F87422B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582041960;
	bh=uxsydmaLYiWRBP1YEUE0J/D9SsS2i7BFVOmXJcknkls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KPRITvINQ50bfEAImP69NQ0aiqkLCiiUtpGs7mg5OBP/FY74yDbSvtFKnVTUYv1gP
	 UiRHz7tldYMeciq/8ZDsmRE2XFD5ie+7ACUxyqcmHaG+Wwk0kt2c4KA1ha2Lco7Wpc
	 rNEejfFYQ51h6L9iv2wJKBX3M8GofGFyVL8/DGTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRQF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:05:58 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A90208C4;
        Tue, 18 Feb 2020 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582041958;
        bh=uxsydmaLYiWRBP1YEUE0J/D9SsS2i7BFVOmXJcknkls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB3XtSmYfMVVrnf3YlMjGTIT5Fth77E08J3UneeouY/zVS9EvATh57yeL1uwQKVSQ
         hHfmHn0fvy0R4Q0hcrvZ1a/SC2ejVwc6L5aYXjI4AyfWQv1a320vAqesnHEeuxf2Om
         jLVTc6o9U/lkqvOZT4nsGt82MyaxDOI4PG+IH39s=
Date:   Tue, 18 Feb 2020 17:05:54 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] modpost: return error if module is missing ns imports
 and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
Message-ID: <20200218160553.GA18056@linux-8ccs>
References: <20200214143709.6490-1-jeyu@kernel.org>
 <20200217145644.GA221719@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217145644.GA221719@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [17/02/20 14:56 +0000]:
>Hi Jessica!
>
>On Fri, Feb 14, 2020 at 03:37:09PM +0100, Jessica Yu wrote:
>>Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, modpost only warns
>>when a module is missing namespace imports. Under this configuration, such a module
>>cannot be loaded into the kernel anyway, as the module loader would reject it.
>>We might as well return a build error when a module is missing namespace imports
>>under CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, so that the build
>>warning does not go ignored/unnoticed.
>
>I generally agree with the idea of the patch. Thanks for working on
>this! I also can't remember any reason why I did not write it like this
>initially. Probably just because I introduced this configuration option
>quite late in the development process of the initial patches.
>
>>
>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>---
>>scripts/Makefile.modpost |  1 +
>>scripts/mod/modpost.c    | 19 +++++++++++++++----
>>2 files changed, 16 insertions(+), 4 deletions(-)
>>
>>diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
>>index b4d3f2d122ac..a53660f910a9 100644
>>--- a/scripts/Makefile.modpost
>>+++ b/scripts/Makefile.modpost
>>@@ -53,6 +53,7 @@ MODPOST = scripts/mod/modpost						\
>>	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
>>	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
>>	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
>>+	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N) 	\
>>	$(if $(KBUILD_MODPOST_WARN),-w)
>>
>>ifdef MODPOST_VMLINUX
>>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>index 7edfdb2f4497..53e966f7d557 100644
>>--- a/scripts/mod/modpost.c
>>+++ b/scripts/mod/modpost.c
>>@@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
>>static int sec_mismatch_fatal = 0;
>>/* ignore missing files */
>>static int ignore_missing_files;
>>+/* Return an error when there are missing namespace imports */
>>+static int missing_ns_import_error = 0;
>
>A more suitable name is maybe missing_ns_import_is_error or follow the
>naming of the config option: allow_missing_ns_imports (with default = 1).
>
>>
>>enum export {
>>	export_plain,      export_unused,     export_gpl,
>>@@ -2216,9 +2218,15 @@ static int check_exports(struct module *mod)
>>
>>		if (exp->namespace &&
>>		    !module_imports_namespace(mod, exp->namespace)) {
>>-			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
>>-			     basename, exp->name, exp->namespace);
>>-			add_namespace(&mod->missing_namespaces, exp->namespace);
>>+			if (missing_ns_import_error) {
>>+				merror("module %s uses symbol %s from namespace %s, but does not import it.\n",
>>+					basename, exp->name, exp->namespace);
>
>I would like to avoid the code duplication here. The string literal is
>identical for both cases.

Hm, but one is a call to merror() and the other to warn(). The
previous if (warn_unresolved) block does the same thing. I am not sure
how to simplify it to one call without introducing macro magic or
overcomplicating things. Or were you thinking of something else?

>>+				err = 1;
>
>Also, if we fail here, we might as well help the user to fix it by
>suggesting to run `make nsdeps` (once per failed modpost run). Speaking
>of which, `make nsdeps` is currently broken by this patch as it relies
>on a successful (yet warning-full) build of the modules. So, in case of
>`make nsdeps`, we probably have to omit the -N flag again when invoking
>modpost.

Good catch! Since KBUILD_NSDEPS is set when running `make nsdeps`,
maybe we can do something like:

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index a53660f910a9..145703ef8d3a 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -53,7 +53,7 @@ MODPOST = scripts/mod/modpost                                         \
        $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS))) \
        $(if $(KBUILD_EXTMOD),-o $(modulesymfile))                      \
        $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                  \
-       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N)      \
+       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,$(if $(KBUILD_NSDEPS),,-N))      \
        $(if $(KBUILD_MODPOST_WARN),-w)

 ifdef MODPOST_VMLINUX

Thanks for the review!

