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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0910C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33F206D5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGB1/rZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCEOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:06:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgCEOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:06:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id a141so5869630wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQCgcMQAbjazY0dG0x2fmRVj8mec9VUgxfwAHJ9Ls7U=;
        b=mGB1/rZkD/afXBJr6f7xL2398ySNZ1aiOw4aw1xyzRc0zry/yC3nkBVvPfISIjEM7o
         H7oUPV61UwDC4NC+M/WzL5QrGF01sob/KXGJXEUMFv8mK3ZoovIuVwwydAlVrH07FWdH
         hFwRqPNqdN5kc1+1TgjxwB1Gby+Ni0+KhDz1ECJJW37vT3TrE2E1ZC+WQsNNufhw3dT6
         TbGnGA7jnaZUlGinLwTJ9nr4/W3O7K6cuHjI79LI3YMsZt9NS9GJFSE5zFbqxZqj9u8n
         fKK4uBEsG2ROsf51NbgmwXIcVtY1A4gMgzR/KhkBQk+0ke/lDu1Wu9pBSP4FTftOMRZH
         Vong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQCgcMQAbjazY0dG0x2fmRVj8mec9VUgxfwAHJ9Ls7U=;
        b=DgxTDn40VMcncF9ORE6ztWoMDFSyNvohfpePRS8ZFFtK+PN+IcfSJyJ5dKTez6qEYu
         dkxo/4jaV7clXLNlFmjq9LDjEOA5zHR30jIjyZDQ5ElqFCfGVRIauKZE/L2ewx/9SGzt
         cxlVbuYXkaGxH+zMk1huHOnDNwRsPzrHjSEVveij6nyjM/DNRcHebXDT7EPX+cwQGjld
         DBZ9yA2j+30npvuSvRX4GFjPCGU9hP9GYI9fTVgiyo9QPPRUPEzPGvM5XulLwpjYXosq
         FoaQ9MUdWNMWx148kbNoa5FHkGVkaL0yARn65REC5yH+hCd/maoUNUtQG0xM0MNW8Knn
         dUsQ==
X-Gm-Message-State: ANhLgQ2/jc2qGuoD39XaOpITO8LCcbqZ7+PGAwJKEQ5Kj9r5OQFvbKJI
        UcKGB+dV0wfFayh/uS3EmZ83tQ==
X-Google-Smtp-Source: ADFU+vvf5anuLhN0UOveLL6VJCkTy6HkwxJ/ltrhqkW7fGHiARv2IAXrgPQo69tRkPHa1VczHQm4ow==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr9682302wmm.123.1583417169647;
        Thu, 05 Mar 2020 06:06:09 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id b82sm9594291wmb.16.2020.03.05.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:06:08 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:06:08 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modpost: move the namespace field in Module.symvers last
Message-ID: <20200305140608.GF119445@google.com>
References: <20200304170345.21218-1-jeyu@kernel.org>
 <20200305085948.GD119445@google.com>
 <20200305134732.GA1637@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200305134732.GA1637@linux-8ccs.fritz.box>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:47:32PM +0100, Jessica Yu wrote:
>+++ Matthias Maennich [05/03/20 08:59 +0000]:
>>Hi Jessica!
>>Thanks for working on this!
>>
>>On Wed, Mar 04, 2020 at 06:03:45PM +0100, Jessica Yu wrote:
>>>In order to preserve backwards compatability with kmod tools, we have to
>>>move the namespace field in Module.symvers last, as the depmod -e -E
>>>option looks at the first three fields in Module.symvers to check symbol
>>>versions (and it's expected they stay in the original order of crc,
>>>symbol, module).
>>>
>>>Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
>>>Cc: stable@vger.kernel.org
>>
>>Please note, this patch did not actually go to stable@.
>
>Hi Matthias! Thanks, I missed that.
>
>>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>>---
>>>Documentation/kbuild/modules.rst |  4 ++--
>>>scripts/export_report.pl         |  2 +-
>>>scripts/mod/modpost.c            | 24 ++++++++++++------------
>>>3 files changed, 15 insertions(+), 15 deletions(-)
>>>
>>>diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
>>>index 69fa48ee93d6..e0b45a257f21 100644
>>>--- a/Documentation/kbuild/modules.rst
>>>+++ b/Documentation/kbuild/modules.rst
>>>@@ -470,9 +470,9 @@ build.
>>>
>>>	The syntax of the Module.symvers file is::
>>>
>>>-	<CRC>       <Symbol>          <Namespace>  <Module>                         <Export Type>
>>>+	<CRC>       <Symbol>         <Module>                         <Export Type>     <Namespace>
>>>
>>>-	0xe1cc2a05  usb_stor_suspend  USB_STORAGE  drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL
>>>+	0xe1cc2a05  usb_stor_suspend drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL USB_STORAGE
>>>
>>>	The fields are separated by tabs and values may be empty (e.g.
>>>	if no namespace is defined for an exported symbol).
>>>diff --git a/scripts/export_report.pl b/scripts/export_report.pl
>>>index 548330e8c4e7..feb3d5542a62 100755
>>>--- a/scripts/export_report.pl
>>>+++ b/scripts/export_report.pl
>>>@@ -94,7 +94,7 @@ if (defined $opt{'o'}) {
>>>#
>>>while ( <$module_symvers> ) {
>>>	chomp;
>>>-	my (undef, $symbol, $namespace, $module, $gpl) = split('\t');
>>>+	my (undef, $symbol, $module, $gpl, $namespace) = split('\t');
>>>	$SYMBOL { $symbol } =  [ $module , "0" , $symbol, $gpl];
>>>}
>>>close($module_symvers);
>>>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>>index 7edfdb2f4497..6ab235354f36 100644
>>>--- a/scripts/mod/modpost.c
>>>+++ b/scripts/mod/modpost.c
>>>@@ -2427,7 +2427,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
>>>}
>>>
>>>/* parse Module.symvers file. line format:
>>>- * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
>>>+ * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
>>>**/
>>>static void read_dump(const char *fname, unsigned int kernel)
>>>{
>>>@@ -2440,7 +2440,7 @@ static void read_dump(const char *fname, unsigned int kernel)
>>>		return;
>>>
>>>	while ((line = get_next_line(&pos, file, size))) {
>>>-		char *symname, *namespace, *modname, *d, *export, *end;
>>>+		char *symname, *namespace, *modname, *d, *export;
>>>		unsigned int crc;
>>>		struct module *mod;
>>>		struct symbol *s;
>>>@@ -2448,16 +2448,16 @@ static void read_dump(const char *fname, unsigned int kernel)
>>>		if (!(symname = strchr(line, '\t')))
>>>			goto fail;
>>>		*symname++ = '\0';
>>>-		if (!(namespace = strchr(symname, '\t')))
>>>-			goto fail;
>>>-		*namespace++ = '\0';
>>>-		if (!(modname = strchr(namespace, '\t')))
>>>+		if (!(modname = strchr(symname, '\t')))
>>>			goto fail;
>>>		*modname++ = '\0';
>>>-		if ((export = strchr(modname, '\t')) != NULL)
>>>-			*export++ = '\0';
>>>-		if (export && ((end = strchr(export, '\t')) != NULL))
>>>-			*end = '\0';
>>>+		if (!(export = strchr(modname, '\t')))
>>>+			goto fail;
>>>+		*export++ = '\0';
>>>+		if (!(namespace = strchr(export, '\t')))
>>
>>As mentioned below, we should probably treat namespace as an optional
>>field. Then this needs adjusting to handle that case. Similar to how
>>optional cases were handled before.
>
>Hm, I think introducing optional fields would add unnecessary
>complexity, and make future parsing harder. For example, say in the
>distant future we add another field. If fields are optional, we are no
>longer able to tell if the 4th field is a namespace or the new_field.
>Whereas, if we made the fields mandatory (even if empty), we would see
>crc<tab>symbol<tab>module<tab>export_type<tab><tab>new_field, and it's
>clear that the namespace is empty. I hope that makes sense...
>
>IMO, I think it's easiest to just establish the fact that
>Module.symvers has 5 fields, and fields can be empty. If a field an
>empty, then the next delimiter or end of line will just follow
>immediately.
>
>Just to reiterate, it is true namespaces are optional, and in the case
>of no namespace, I would prefer it to be an empty string/field rather
>than omitting it entirely.
>
>>>+			goto fail;
>>>+		*namespace++ = '\0';
>>>+
>>>		crc = strtoul(line, &d, 16);
>>>		if (*symname == '\0' || *modname == '\0' || *d != '\0')
>>>			goto fail;
>>>@@ -2508,9 +2508,9 @@ static void write_dump(const char *fname)
>>>				namespace = symbol->namespace;
>>>				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
>>
>>This creates trailing tabs for symbols without namespace. If we treat
>>'namespace' as an optional field, we should probably make the tab
>>conditional as well? What do you think?
>
>Yeah you're right, the trailing tab after an empty namespace looks
>weird...but for reasons I cited above, I would like to keep it simple,
>unless there are huge objections.

I think I don't want to object. Having trailing whitespaces in the file
just looks a bit weird. And I am not sure if this might confuse anyone.
E.g. think of this file ending up in some source control or packaging
where trailing spaces are removed, then this format is broken and can't
be reliably read. But maybe I am overthinking it.

Besides  this, the patch looks fine and I successfully tested it.
Maybe let others chime in for their opinion.

Cheers,
Matthias

>
>Thank you for the review!
>
>Jessica
>
