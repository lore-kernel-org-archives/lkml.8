Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76213C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CC121D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582054087;
	bh=wSnhT8G0+waVSWdfV3Qqw8gZ3EiuOxwot7nGU0Ebt9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uknHxPCJkpXHJpEMVSFgEktYZrIMT4SE4ismKPfrp5IiN3Oc/O2E6tQSX+IurDGiS
	 E8/JXxBSpZ5zi6hhg7LlYrIATM1970WQpawiIVxX2Nmxy9os0II92qgZQ8MUfDFMyq
	 /3Ppi3G1ewK/4M1OsTi9YUSmm8np1WTgN0CdvV0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:28:06 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27158 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:28:05 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01IJRjGi005013
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 04:27:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01IJRjGi005013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582054066;
        bh=0LaSGEGizcBcrlCJXQ7v7CjwfgybxWS3s9NbZtBPJ5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cdbBFOXFZ23x11aP2VoefVJIUawvYaxkVvVaNmaQ7ksASvnS8r3oXIBBdPafGx/3e
         5q1IkX/NeM/uWc43eT+Ny9Vv1fiEF5EVjLCeJ3oaX7dKCPbryL7Q/5zBg9hxZdot66
         HGusDwaPEiHgISwr3KDYxdU4jQApQG/klhNVH6p9w1dMklkcOdiD+b1+Npbtbf4XUZ
         ZrWoZtljCj0fTYg/WeNyn5rHWnt1yJU3GtZ+PIZuJ5zCRqo8OZzviWS11lggCiCUrw
         /w3LUDVLJdYMVH16pnpYJvknQPvvCFq/5cR0fvfYleE6TWV0aVAEebDX2aoQ/9DXpF
         zNF5/jJNIOOVg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id r18so13801276vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:27:46 -0800 (PST)
X-Gm-Message-State: APjAAAUwP0Ap455/vYaIAQ2eiruJxoPib6tmBanNCGGU5j+c/apbA4fd
        wwusx/l0mTKgSXVho7uUHjyxTeFcS49O3YyJXzY=
X-Google-Smtp-Source: APXvYqyxgX9bz8kt0wGCHvppmFrEffcciJXshd1N+TopXEtPzP+/SHrMf7HlW3Og0qvRlwwPfSAZXgWZav4sYfNgjH0=
X-Received: by 2002:a05:6102:48b:: with SMTP id n11mr11885261vsa.181.1582054064789;
 Tue, 18 Feb 2020 11:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20200214143709.6490-1-jeyu@kernel.org> <20200217145644.GA221719@google.com>
 <20200218160553.GA18056@linux-8ccs>
In-Reply-To: <20200218160553.GA18056@linux-8ccs>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Feb 2020 04:27:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBCE7j-FH3kFwHOjgjerjx8hziK9iWD5Av6wyweovewA@mail.gmail.com>
Message-ID: <CAK7LNATBCE7j-FH3kFwHOjgjerjx8hziK9iWD5Av6wyweovewA@mail.gmail.com>
Subject: Re: [PATCH] modpost: return error if module is missing ns imports and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 1:06 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Matthias Maennich [17/02/20 14:56 +0000]:
> >Hi Jessica!
> >
> >On Fri, Feb 14, 2020 at 03:37:09PM +0100, Jessica Yu wrote:
> >>Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, modpost only warns
> >>when a module is missing namespace imports. Under this configuration, such a module
> >>cannot be loaded into the kernel anyway, as the module loader would reject it.
> >>We might as well return a build error when a module is missing namespace imports
> >>under CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, so that the build
> >>warning does not go ignored/unnoticed.
> >
> >I generally agree with the idea of the patch. Thanks for working on
> >this! I also can't remember any reason why I did not write it like this
> >initially. Probably just because I introduced this configuration option
> >quite late in the development process of the initial patches.
> >
> >>
> >>Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >>---
> >>scripts/Makefile.modpost |  1 +
> >>scripts/mod/modpost.c    | 19 +++++++++++++++----
> >>2 files changed, 16 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> >>index b4d3f2d122ac..a53660f910a9 100644
> >>--- a/scripts/Makefile.modpost
> >>+++ b/scripts/Makefile.modpost
> >>@@ -53,6 +53,7 @@ MODPOST = scripts/mod/modpost                                               \
> >>      $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS))) \
> >>      $(if $(KBUILD_EXTMOD),-o $(modulesymfile))                      \
> >>      $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                  \
> >>+     $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N)      \
> >>      $(if $(KBUILD_MODPOST_WARN),-w)
> >>
> >>ifdef MODPOST_VMLINUX
> >>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >>index 7edfdb2f4497..53e966f7d557 100644
> >>--- a/scripts/mod/modpost.c
> >>+++ b/scripts/mod/modpost.c
> >>@@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
> >>static int sec_mismatch_fatal = 0;
> >>/* ignore missing files */
> >>static int ignore_missing_files;
> >>+/* Return an error when there are missing namespace imports */
> >>+static int missing_ns_import_error = 0;
> >
> >A more suitable name is maybe missing_ns_import_is_error or follow the
> >naming of the config option: allow_missing_ns_imports (with default = 1).
> >
> >>
> >>enum export {
> >>      export_plain,      export_unused,     export_gpl,
> >>@@ -2216,9 +2218,15 @@ static int check_exports(struct module *mod)
> >>
> >>              if (exp->namespace &&
> >>                  !module_imports_namespace(mod, exp->namespace)) {
> >>-                     warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
> >>-                          basename, exp->name, exp->namespace);
> >>-                     add_namespace(&mod->missing_namespaces, exp->namespace);
> >>+                     if (missing_ns_import_error) {
> >>+                             merror("module %s uses symbol %s from namespace %s, but does not import it.\n",
> >>+                                     basename, exp->name, exp->namespace);
> >
> >I would like to avoid the code duplication here. The string literal is
> >identical for both cases.
>
> Hm, but one is a call to merror() and the other to warn(). The
> previous if (warn_unresolved) block does the same thing. I am not sure
> how to simplify it to one call without introducing macro magic or
> overcomplicating things. Or were you thinking of something else?


I would not say this is a horrible duplication,
but if you avoid repeating the same string,
maybe you could do like this:

PRINTF log(enum loglevel loglevel, const char *fmt, ...)



BTW, you accidentally changed the indentation of
add_namespace(&mod->missing_namespaces, exp->namespace);



> >>+                             err = 1;
> >
> >Also, if we fail here, we might as well help the user to fix it by
> >suggesting to run `make nsdeps` (once per failed modpost run). Speaking
> >of which, `make nsdeps` is currently broken by this patch as it relies
> >on a successful (yet warning-full) build of the modules. So, in case of
> >`make nsdeps`, we probably have to omit the -N flag again when invoking
> >modpost.
>
> Good catch! Since KBUILD_NSDEPS is set when running `make nsdeps`,
> maybe we can do something like:
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index a53660f910a9..145703ef8d3a 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -53,7 +53,7 @@ MODPOST = scripts/mod/modpost                                         \
>         $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS))) \
>         $(if $(KBUILD_EXTMOD),-o $(modulesymfile))                      \
>         $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                  \
> -       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N)      \
> +       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,$(if $(KBUILD_NSDEPS),,-N))      \


If you follow Matthias' suggestion
"follow the naming of the config option: allow_missing_ns_imports
(with default = 1)."
the option is inverted, and you can write it more simply:


      $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-n)
     \






--
Best Regards
Masahiro Yamada
