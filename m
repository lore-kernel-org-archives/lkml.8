Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57598C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC520679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/vTWoM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgBQO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:56:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51574 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgBQO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:56:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so17443664wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UomH0/CqZR/5L4LXDuERHxj5MjAFC9BvzemuUjFlfxI=;
        b=I/vTWoM7APhakWpkEfkURFiBNDawMCGfvGpgcc1ZPTuXQ06uzwt9o9TlgZ29gMW7jS
         0nBXzM1uO0s+pWzYwAfoYr0nuT/TFSY7fopkCC7ctcori2iTTtrnYdSTvXhTsH3im7qC
         SNn93gAsnawIK9ueDjumYbVsG55zsA+H2PmG17JUVCD3xPFTtrGmdIqiaeSIcsWk/Qpu
         T8zW/1CRu/T88RPY3jQ+cqGYmaF45eUE6cCUpMt81Qc8KjA92lY0oEh5t14meH1Z3Rvn
         JrdAOiOf53N3oTu/tEVo0MEBJjU4SIWlcUjU1QVgJgP9E4BEY2HKiRy45YGMxCfv03Bf
         qlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UomH0/CqZR/5L4LXDuERHxj5MjAFC9BvzemuUjFlfxI=;
        b=hpkSlIxWuA/8pSwfngQpNYMDD0tXF5lgdtaxyaZCScC/3VwPmdkpW9wPh135GIKjmA
         tE0NLTaDtepzvfJmP5pV9CqX5GINzxyMPtJtGwvRPmDcnrxBQq2EEstmCkF0p/3DUqtj
         CAutAMOih0qQW7pF/s1KFn+YjPFExRSzs0vfDDFYlJrprzEPKgxQBAxKP6zxWw4YpyZI
         fm4PFkkKWu31p4+EJqY/vsEA4iaS15GjEqHquGj2tJ4RfGsvCJsBb5ghonsQpuCvvdE9
         C450Fgn+TBevDaFv5ubmSWrXr0NgE7jqeWSVpbBc9qr86eO8fcekx8tzeepekYh6B7Fi
         Xx1A==
X-Gm-Message-State: APjAAAW6jsS4Uu7KYkpHTROCUH2n6IhHXTyLjIAj9ys9WpIU7xQVciIj
        4kYPTQFmxdtete8KhBMF5c3aGg==
X-Google-Smtp-Source: APXvYqwFNP6vhC0IaxlDo7xfRMNRLg6C5/uM9WGLtNNhMRrPJeRKBqQ0H9p9wTjxbl0tEiiAoINyCQ==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr22447635wmi.21.1581951405415;
        Mon, 17 Feb 2020 06:56:45 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id i204sm922713wma.44.2020.02.17.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:56:44 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:56:44 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] modpost: return error if module is missing ns imports
 and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
Message-ID: <20200217145644.GA221719@google.com>
References: <20200214143709.6490-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200214143709.6490-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica!

On Fri, Feb 14, 2020 at 03:37:09PM +0100, Jessica Yu wrote:
>Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, modpost only warns
>when a module is missing namespace imports. Under this configuration, such a module
>cannot be loaded into the kernel anyway, as the module loader would reject it.
>We might as well return a build error when a module is missing namespace imports
>under CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, so that the build
>warning does not go ignored/unnoticed.

I generally agree with the idea of the patch. Thanks for working on
this! I also can't remember any reason why I did not write it like this
initially. Probably just because I introduced this configuration option
quite late in the development process of the initial patches.

>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---
> scripts/Makefile.modpost |  1 +
> scripts/mod/modpost.c    | 19 +++++++++++++++----
> 2 files changed, 16 insertions(+), 4 deletions(-)
>
>diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
>index b4d3f2d122ac..a53660f910a9 100644
>--- a/scripts/Makefile.modpost
>+++ b/scripts/Makefile.modpost
>@@ -53,6 +53,7 @@ MODPOST = scripts/mod/modpost						\
> 	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
> 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
> 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
>+	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N) 	\
> 	$(if $(KBUILD_MODPOST_WARN),-w)
>
> ifdef MODPOST_VMLINUX
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index 7edfdb2f4497..53e966f7d557 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
> static int sec_mismatch_fatal = 0;
> /* ignore missing files */
> static int ignore_missing_files;
>+/* Return an error when there are missing namespace imports */
>+static int missing_ns_import_error = 0;

A more suitable name is maybe missing_ns_import_is_error or follow the
naming of the config option: allow_missing_ns_imports (with default = 1).

>
> enum export {
> 	export_plain,      export_unused,     export_gpl,
>@@ -2216,9 +2218,15 @@ static int check_exports(struct module *mod)
>
> 		if (exp->namespace &&
> 		    !module_imports_namespace(mod, exp->namespace)) {
>-			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
>-			     basename, exp->name, exp->namespace);
>-			add_namespace(&mod->missing_namespaces, exp->namespace);
>+			if (missing_ns_import_error) {
>+				merror("module %s uses symbol %s from namespace %s, but does not import it.\n",
>+					basename, exp->name, exp->namespace);

I would like to avoid the code duplication here. The string literal is
identical for both cases.

>+				err = 1;

Also, if we fail here, we might as well help the user to fix it by
suggesting to run `make nsdeps` (once per failed modpost run). Speaking
of which, `make nsdeps` is currently broken by this patch as it relies
on a successful (yet warning-full) build of the modules. So, in case of
`make nsdeps`, we probably have to omit the -N flag again when invoking
modpost.

Cheers,
Matthias

>+			} else {
>+				warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
>+				     basename, exp->name, exp->namespace);
>+			}
>+				add_namespace(&mod->missing_namespaces, exp->namespace);
> 		}
>
> 		if (!mod->gpl_compatible)
>@@ -2560,7 +2568,7 @@ int main(int argc, char **argv)
> 	struct ext_sym_list *extsym_iter;
> 	struct ext_sym_list *extsym_start = NULL;
>
>-	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awEd:")) != -1) {
>+	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
> 		switch (opt) {
> 		case 'i':
> 			kernel_read = optarg;
>@@ -2598,6 +2606,9 @@ int main(int argc, char **argv)
> 		case 'E':
> 			sec_mismatch_fatal = 1;
> 			break;
>+		case 'N':
>+			missing_ns_import_error = 1;
>+			break;
> 		case 'd':
> 			missing_namespace_deps = optarg;
> 			break;
>-- 
>2.16.4
>
