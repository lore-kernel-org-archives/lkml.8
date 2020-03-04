Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ABCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574721D56
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583342549;
	bh=3CPV+AsSdS5WdEO5Ob/fxquNaWSN/KrsHEiHs0jjZvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHKb9VIa5e18/m0N84zGqOfgkStWecpYXyGd9+6GPoGP0UCxptQEbBPLpdS/BfdQm
	 hawIgjgMpVp7+d057Pf6OmYOwyt662GTb9nVY4Y1Aj1dIiN+S7QCPCGpCHqtPuZJ8s
	 kB4UNR2aTXLB/VUYQlq0sEYd16CkZYHc3LszCLnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgCDRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDRW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:22:28 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0D424654;
        Wed,  4 Mar 2020 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342547;
        bh=3CPV+AsSdS5WdEO5Ob/fxquNaWSN/KrsHEiHs0jjZvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZmGdI1lM65i4Af/w+Zj502oECNTgmrJ6NenC+brcuNvJFNY5Eqeyxpn7nk8OYgwf
         0bZHo3E/zytCTAXfneKSrfkP5TF/FrfZVz5Wuih6wFibGWmsX3vAinpmSd8R31WOfR
         D86ehJv6lr7Xq9sY+AqkE4QF8VXxumBH7w6+0eEo=
Date:   Wed, 4 Mar 2020 18:22:23 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: move the namespace field in Module.symvers last
Message-ID: <20200304172221.GB14910@linux-8ccs>
References: <20200304170345.21218-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200304170345.21218-1-jeyu@kernel.org>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [04/03/20 18:03 +0100]:
>In order to preserve backwards compatability with kmod tools, we have to
>move the namespace field in Module.symvers last, as the depmod -e -E
>option looks at the first three fields in Module.symvers to check symbol
>versions (and it's expected they stay in the original order of crc,
>symbol, module).
>
>Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jessica Yu <jeyu@kernel.org>

First, I apologize for not having caught this mistake earlier. I still
have questions about the Module.symvers format, please see below.

>---
> Documentation/kbuild/modules.rst |  4 ++--
> scripts/export_report.pl         |  2 +-
> scripts/mod/modpost.c            | 24 ++++++++++++------------
> 3 files changed, 15 insertions(+), 15 deletions(-)
>
>diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
>index 69fa48ee93d6..e0b45a257f21 100644
>--- a/Documentation/kbuild/modules.rst
>+++ b/Documentation/kbuild/modules.rst
>@@ -470,9 +470,9 @@ build.
>
> 	The syntax of the Module.symvers file is::
>
>-	<CRC>       <Symbol>          <Namespace>  <Module>                         <Export Type>
>+	<CRC>       <Symbol>         <Module>                         <Export Type>     <Namespace>
>
>-	0xe1cc2a05  usb_stor_suspend  USB_STORAGE  drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL
>+	0xe1cc2a05  usb_stor_suspend drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL USB_STORAGE
>
> 	The fields are separated by tabs and values may be empty (e.g.
> 	if no namespace is defined for an exported symbol).
>diff --git a/scripts/export_report.pl b/scripts/export_report.pl
>index 548330e8c4e7..feb3d5542a62 100755
>--- a/scripts/export_report.pl
>+++ b/scripts/export_report.pl
>@@ -94,7 +94,7 @@ if (defined $opt{'o'}) {
> #
> while ( <$module_symvers> ) {
> 	chomp;
>-	my (undef, $symbol, $namespace, $module, $gpl) = split('\t');
>+	my (undef, $symbol, $module, $gpl, $namespace) = split('\t');
> 	$SYMBOL { $symbol } =  [ $module , "0" , $symbol, $gpl];
> }
> close($module_symvers);
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index 7edfdb2f4497..6ab235354f36 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -2427,7 +2427,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
> }
>
> /* parse Module.symvers file. line format:
>- * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
>+ * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace

So, this comment was a source of confusion for me and Matthias I
think. It suggests that the export field is optional, and that even
following the export field there may also be "something" else,
whatever that is.

I suspect that there were historical reasons behind that comment that
are no longer accurate. We have been unconditionally printing the
export type since 2.6.18 (commit bd5cbcedf44), which is over a decade
ago now. And let me explain the read_dump() changes...

>  **/
> static void read_dump(const char *fname, unsigned int kernel)
> {
>@@ -2440,7 +2440,7 @@ static void read_dump(const char *fname, unsigned int kernel)
> 		return;
>
> 	while ((line = get_next_line(&pos, file, size))) {
>-		char *symname, *namespace, *modname, *d, *export, *end;
>+		char *symname, *namespace, *modname, *d, *export;
> 		unsigned int crc;
> 		struct module *mod;
> 		struct symbol *s;
>@@ -2448,16 +2448,16 @@ static void read_dump(const char *fname, unsigned int kernel)
> 		if (!(symname = strchr(line, '\t')))
> 			goto fail;
> 		*symname++ = '\0';
>-		if (!(namespace = strchr(symname, '\t')))
>-			goto fail;
>-		*namespace++ = '\0';
>-		if (!(modname = strchr(namespace, '\t')))
>+		if (!(modname = strchr(symname, '\t')))
> 			goto fail;
> 		*modname++ = '\0';
>-		if ((export = strchr(modname, '\t')) != NULL)
>-			*export++ = '\0';
>-		if (export && ((end = strchr(export, '\t')) != NULL))
>-			*end = '\0';

I believe the original read_dump() code treated the export field here
as optional, to support pre <= 2.6.18 Module.symvers (which does not
have the export type field). But I don't believe we have to support
this case anymore, right? It's ages ago. So I cleaned up this area,
made each field non-optional (but empty string "" for namespace is
allowed), and updated the comment.

>+		if (!(export = strchr(modname, '\t')))
>+			goto fail;
>+		*export++ = '\0';
>+		if (!(namespace = strchr(export, '\t')))
>+			goto fail;
>+		*namespace++ = '\0';
>+
> 		crc = strtoul(line, &d, 16);
> 		if (*symname == '\0' || *modname == '\0' || *d != '\0')
> 			goto fail;
>@@ -2508,9 +2508,9 @@ static void write_dump(const char *fname)
> 				namespace = symbol->namespace;
> 				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
> 					   symbol->crc, symbol->name,
>-					   namespace ? namespace : "",
> 					   symbol->module->name,
>-					   export_str(symbol->export));
>+					   export_str(symbol->export),
>+					   namespace ? namespace : "");
> 			}
> 			symbol = symbol->next;
> 		}
>-- 
>2.16.4
>
