Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77753C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CD9208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQpy2eAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgCEI7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:59:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:59:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id u9so4787715wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tT2n8WhMPwCVEPoHlfKBHJYxhG2LFSqLNKYfKKAKbak=;
        b=mQpy2eAXj0LgOnRCXo1+EXGuY48tK9ZoekYlE2QzjUKL0M+3B5GD1swTnrFhyR6aIO
         JoJX92f8HP5dNa2rvZp+2kca4q2iXnOSgtZ9s48KS/s3h1hbkyCGHsazRJhc4LQ69r1H
         IcEaImsCFBBX2fey0lupxDXyDdQmnhfd4/TQEQlJFAqJcD5Z2mYRJkjyiO2H5PKKS5um
         BMM4OLyIbA6K1quz1wrbu60fjY6S2RU1CGvzHAPLw+6zaScuoTRER2njUsllkjaNMh+U
         qiVzoYnH7iTv77o35QSEY3yOV5T/u7qLNzJfBW15uCy3WbjwwkAUgGX6i4UmD0/2RdZa
         MifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tT2n8WhMPwCVEPoHlfKBHJYxhG2LFSqLNKYfKKAKbak=;
        b=TNikJlBuLgTsoUplr+t2e1zIUrJC0APhtyxW6wQEiCzSnbp8S3ja+7MUcRek3k+4r2
         DDbGs/XEfdnmZTkNgrAXqYjnjnVud2zZb1VlSL4PUOD7wFFzsZ3neGFgAyQe05z0JP0g
         jq3I2qHbH2RwOVCq5sKprLfG4cH2WChyhaYlckzLtmnlT657hLdl2S7FW9zt38HoUVIw
         JGOLCvwx4S3QE32WBgyuWTo5kQPJax5vjuYMbB592FcYZVEaTAA56Mxasi/T8JpeWn6s
         wAtL3KSqGI0sK/NKFp+C9VZgbeM2Ja0dlWPHBCKi+g4OMm/zKODrOCbOWsmntx93uKgo
         m/eA==
X-Gm-Message-State: ANhLgQ1EBMfQWXleEkufQXhzONBarb2McO2nX4mEU0jUTftbB6ybUzkC
        SbNinYv1O2Sf4PIlsY7T6zXUdA==
X-Google-Smtp-Source: ADFU+vuUD5KW4KZWOJh2hPzHlrS30/0U3JbJ5Re9k+/nGnA1inbRL9A2dp7zNDmPW9AWck/B1W4Jtg==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr8248443wmd.22.1583398789253;
        Thu, 05 Mar 2020 00:59:49 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id d203sm8014979wmd.37.2020.03.05.00.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 00:59:48 -0800 (PST)
Date:   Thu, 5 Mar 2020 08:59:48 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: move the namespace field in Module.symvers last
Message-ID: <20200305085948.GD119445@google.com>
References: <20200304170345.21218-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200304170345.21218-1-jeyu@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica!
Thanks for working on this!

On Wed, Mar 04, 2020 at 06:03:45PM +0100, Jessica Yu wrote:
>In order to preserve backwards compatability with kmod tools, we have to
>move the namespace field in Module.symvers last, as the depmod -e -E
>option looks at the first three fields in Module.symvers to check symbol
>versions (and it's expected they stay in the original order of crc,
>symbol, module).
>
>Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
>Cc: stable@vger.kernel.org

Please note, this patch did not actually go to stable@.

>Signed-off-by: Jessica Yu <jeyu@kernel.org>
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
>+		if (!(export = strchr(modname, '\t')))
>+			goto fail;
>+		*export++ = '\0';
>+		if (!(namespace = strchr(export, '\t')))

As mentioned below, we should probably treat namespace as an optional
field. Then this needs adjusting to handle that case. Similar to how
optional cases were handled before.

>+			goto fail;
>+		*namespace++ = '\0';
>+
> 		crc = strtoul(line, &d, 16);
> 		if (*symname == '\0' || *modname == '\0' || *d != '\0')
> 			goto fail;
>@@ -2508,9 +2508,9 @@ static void write_dump(const char *fname)
> 				namespace = symbol->namespace;
> 				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",

This creates trailing tabs for symbols without namespace. If we treat
'namespace' as an optional field, we should probably make the tab
conditional as well? What do you think?

Cheers,
Matthias

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
