Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667CAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8920717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFAWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:22:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:51767 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCFAWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:22:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 16:22:50 -0800
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="scan'208";a="439944012"
Received: from ldmartin-desk1.jf.intel.com (HELO ldmartin-desk1) ([10.24.14.222])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 16:22:49 -0800
Date:   Thu, 5 Mar 2020 16:22:50 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: move the namespace field in Module.symvers last
Message-ID: <20200306002250.4hxhtibvoiobosnr@ldmartin-desk1>
References: <20200304170345.21218-1-jeyu@kernel.org>
 <20200304172221.GB14910@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200304172221.GB14910@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 04, 2020 at 06:22:23PM +0100, Jessica Yu wrote:
>+++ Jessica Yu [04/03/20 18:03 +0100]:
>>In order to preserve backwards compatability with kmod tools, we have to
>>move the namespace field in Module.symvers last, as the depmod -e -E
>>option looks at the first three fields in Module.symvers to check symbol
>>versions (and it's expected they stay in the original order of crc,
>>symbol, module).
>>
>>Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>First, I apologize for not having caught this mistake earlier. I still
>have questions about the Module.symvers format, please see below.
>
>>---
>>Documentation/kbuild/modules.rst |  4 ++--
>>scripts/export_report.pl         |  2 +-
>>scripts/mod/modpost.c            | 24 ++++++++++++------------
>>3 files changed, 15 insertions(+), 15 deletions(-)
>>
>>diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
>>index 69fa48ee93d6..e0b45a257f21 100644
>>--- a/Documentation/kbuild/modules.rst
>>+++ b/Documentation/kbuild/modules.rst
>>@@ -470,9 +470,9 @@ build.
>>
>>	The syntax of the Module.symvers file is::
>>
>>-	<CRC>       <Symbol>          <Namespace>  <Module>                         <Export Type>
>>+	<CRC>       <Symbol>         <Module>                         <Export Type>     <Namespace>
>>
>>-	0xe1cc2a05  usb_stor_suspend  USB_STORAGE  drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL
>>+	0xe1cc2a05  usb_stor_suspend drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL USB_STORAGE
>>
>>	The fields are separated by tabs and values may be empty (e.g.
>>	if no namespace is defined for an exported symbol).
>>diff --git a/scripts/export_report.pl b/scripts/export_report.pl
>>index 548330e8c4e7..feb3d5542a62 100755
>>--- a/scripts/export_report.pl
>>+++ b/scripts/export_report.pl
>>@@ -94,7 +94,7 @@ if (defined $opt{'o'}) {
>>#
>>while ( <$module_symvers> ) {
>>	chomp;
>>-	my (undef, $symbol, $namespace, $module, $gpl) = split('\t');
>>+	my (undef, $symbol, $module, $gpl, $namespace) = split('\t');
>>	$SYMBOL { $symbol } =  [ $module , "0" , $symbol, $gpl];
>>}
>>close($module_symvers);
>>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>index 7edfdb2f4497..6ab235354f36 100644
>>--- a/scripts/mod/modpost.c
>>+++ b/scripts/mod/modpost.c
>>@@ -2427,7 +2427,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
>>}
>>
>>/* parse Module.symvers file. line format:
>>- * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
>>+ * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
>
>So, this comment was a source of confusion for me and Matthias I
>think. It suggests that the export field is optional, and that even
>following the export field there may also be "something" else,
>whatever that is.
>
>I suspect that there were historical reasons behind that comment that
>are no longer accurate. We have been unconditionally printing the
>export type since 2.6.18 (commit bd5cbcedf44), which is over a decade
>ago now. And let me explain the read_dump() changes...

I think this is a good information to be amended in the commit message,
so 10 years from now we can get find this info in git log.

>
>> **/
>>static void read_dump(const char *fname, unsigned int kernel)
>>{
>>@@ -2440,7 +2440,7 @@ static void read_dump(const char *fname, unsigned int kernel)
>>		return;
>>
>>	while ((line = get_next_line(&pos, file, size))) {
>>-		char *symname, *namespace, *modname, *d, *export, *end;
>>+		char *symname, *namespace, *modname, *d, *export;
>>		unsigned int crc;
>>		struct module *mod;
>>		struct symbol *s;
>>@@ -2448,16 +2448,16 @@ static void read_dump(const char *fname, unsigned int kernel)
>>		if (!(symname = strchr(line, '\t')))
>>			goto fail;
>>		*symname++ = '\0';
>>-		if (!(namespace = strchr(symname, '\t')))
>>-			goto fail;
>>-		*namespace++ = '\0';
>>-		if (!(modname = strchr(namespace, '\t')))
>>+		if (!(modname = strchr(symname, '\t')))
>>			goto fail;
>>		*modname++ = '\0';
>>-		if ((export = strchr(modname, '\t')) != NULL)
>>-			*export++ = '\0';
>>-		if (export && ((end = strchr(export, '\t')) != NULL))
>>-			*end = '\0';
>
>I believe the original read_dump() code treated the export field here
>as optional, to support pre <= 2.6.18 Module.symvers (which does not
>have the export type field). But I don't believe we have to support
>this case anymore, right? It's ages ago. So I cleaned up this area,
>made each field non-optional (but empty string "" for namespace is
>allowed), and updated the comment.

Same here. And agreed.

thanks

>
>>+		if (!(export = strchr(modname, '\t')))
>>+			goto fail;
>>+		*export++ = '\0';
>>+		if (!(namespace = strchr(export, '\t')))
>>+			goto fail;
>>+		*namespace++ = '\0';
>>+
>>		crc = strtoul(line, &d, 16);
>>		if (*symname == '\0' || *modname == '\0' || *d != '\0')
>>			goto fail;
>>@@ -2508,9 +2508,9 @@ static void write_dump(const char *fname)
>>				namespace = symbol->namespace;
>>				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
>>					   symbol->crc, symbol->name,
>>-					   namespace ? namespace : "",
>>					   symbol->module->name,
>>-					   export_str(symbol->export));
>>+					   export_str(symbol->export),
>>+					   namespace ? namespace : "");
>>			}
>>			symbol = symbol->next;
>>		}
>>-- 
>>2.16.4
>>
