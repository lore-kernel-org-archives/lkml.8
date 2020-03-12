Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35806C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B71D206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCRa/6q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgCLHR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:17:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52327 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbgCLHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:17:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so4870199wmo.2;
        Thu, 12 Mar 2020 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jiBmksMrMfFbIHa3ZewzTbMHCps2UU4whG+wAJNTBQ=;
        b=qCRa/6q0ILq9l3DfKMhKjmfdCWyj5jDt69VIemin4LMyIWEMIFzpkX/xk15bh7a8Va
         WCi0by+fzbYYP1L/GdgW9RifNdtxSKaVoaZZCr6XwYxPSVmfnPHy/HiQ2KqQOS5GGsMc
         VCcGT160rohacuTPb7tz+9cIQE/RhLYy+mjeKxZnbOLptIxIYLsMRCfJ02S+srINTdAw
         YnPTNvWnkgfg6UFyM38nMvPdxDEU2ZJvcsHW1zL4gt0YsRmBDZPALVOKkkwGHNRJL5qP
         eB7mFiU5tq2xWkCGr+8kbsy/2vaOdCpUeCLhkc5GtoCFc00/LDHL2ClpsEVPwhUV/qJ+
         srAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jiBmksMrMfFbIHa3ZewzTbMHCps2UU4whG+wAJNTBQ=;
        b=CSKRsUi5sBIsffZEr3gI1+IX6cdf7XqQWQiysRY8dbCZOG83i5TBk8dQrZebJilXkN
         yUX0074ms7jG+fyYegZsmGQjuPaojSkh/3OB26UvHj/qtpdNZJKsILVsVevloe9mwUIV
         hcYwEx+W9jynZJCzThDtTUYjrzdxom/zvlAR803/PyVX+XQgrA/FmRJ3i8LdxIzhHzL+
         AqpddU5+A76+noHZL87p+PwyoSREdWUBDNfKev0928AL4fOvxJHvfq4uFUfpKHf6NSGG
         ntttwUABcwFZrkQU+w7onvpMhXzX30igpEqNEjPAQjjfxvBwqfuvQkQiTBnUGiuezVMg
         IXdg==
X-Gm-Message-State: ANhLgQ07Vx8pe9+agzxGBdR8UpvuekJrW8WgHdmaaZYl3Uk/RmKOZqar
        i1Fj/LJh18iYx2nIMcTAa2AW4Bnx6K64j/DERtgVSy/o
X-Google-Smtp-Source: ADFU+vuna7/EkiqUm3Pt6MoBfapvFtfi/fNt7GNXfSGcalppqq7tD082k1sG+OIOruCLHe89OYG9o8CT7dwYHJJJ7f0=
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr3264837wmm.165.1583997471183;
 Thu, 12 Mar 2020 00:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200311170120.12641-1-jeyu@kernel.org>
In-Reply-To: <20200311170120.12641-1-jeyu@kernel.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 12 Mar 2020 00:17:39 -0700
Message-ID: <CAKi4VAKgeKDq9uiBKfXRjgMV9TTDHrRX8dT42N1zyqwCgkw35A@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: move the namespace field in Module.symvers last
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        stable@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:02 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> In order to preserve backwards compatability with kmod tools, we have to
> move the namespace field in Module.symvers last, as the depmod -e -E
> option looks at the first three fields in Module.symvers to check symbol
> versions (and it's expected they stay in the original order of crc,
> symbol, module).
>
> In addition, update an ancient comment above read_dump() in modpost that
> suggested that the export type field in Module.symvers was optional. I
> suspect that there were historical reasons behind that comment that are
> no longer accurate. We have been unconditionally printing the export
> type since 2.6.18 (commit bd5cbcedf44), which is over a decade ago now.
>
> Fix up read_dump() to treat each field as non-optional. I suspect the
> original read_dump() code treated the export field as optional in order
> to support pre <= 2.6.18 Module.symvers (which did not have the export
> type field). Note that although symbol namespaces are optional, the
> field will not be omitted from Module.symvers if a symbol does not have
> a namespace. In this case, the field will simply be empty and the next
> delimiter or end of line will follow.
>
> Cc: stable@vger.kernel.org
> Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
> Tested-by: Matthias Maennich <maennich@google.com>
> Reviewed-by: Matthias Maennich <maennich@google.com>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> v2:
>
>   - Explain the changes to read_dump() and the comment (and provide
>     historical context) in the commit message. (Lucas De Marchi)

Great, thanks for fixing this.

Lucas De Marchi

>
>  Documentation/kbuild/modules.rst |  4 ++--
>  scripts/export_report.pl         |  2 +-
>  scripts/mod/modpost.c            | 24 ++++++++++++------------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
> index 69fa48ee93d6..e0b45a257f21 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -470,9 +470,9 @@ build.
>
>         The syntax of the Module.symvers file is::
>
> -       <CRC>       <Symbol>          <Namespace>  <Module>                         <Export Type>
> +       <CRC>       <Symbol>         <Module>                         <Export Type>     <Namespace>
>
> -       0xe1cc2a05  usb_stor_suspend  USB_STORAGE  drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL
> +       0xe1cc2a05  usb_stor_suspend drivers/usb/storage/usb-storage  EXPORT_SYMBOL_GPL USB_STORAGE
>
>         The fields are separated by tabs and values may be empty (e.g.
>         if no namespace is defined for an exported symbol).
> diff --git a/scripts/export_report.pl b/scripts/export_report.pl
> index 548330e8c4e7..feb3d5542a62 100755
> --- a/scripts/export_report.pl
> +++ b/scripts/export_report.pl
> @@ -94,7 +94,7 @@ if (defined $opt{'o'}) {
>  #
>  while ( <$module_symvers> ) {
>         chomp;
> -       my (undef, $symbol, $namespace, $module, $gpl) = split('\t');
> +       my (undef, $symbol, $module, $gpl, $namespace) = split('\t');
>         $SYMBOL { $symbol } =  [ $module , "0" , $symbol, $gpl];
>  }
>  close($module_symvers);
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a3d8370f9544..e1963ef8c07c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2421,7 +2421,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
>  }
>
>  /* parse Module.symvers file. line format:
> - * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
> + * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
>   **/
>  static void read_dump(const char *fname, unsigned int kernel)
>  {
> @@ -2434,7 +2434,7 @@ static void read_dump(const char *fname, unsigned int kernel)
>                 return;
>
>         while ((line = get_next_line(&pos, file, size))) {
> -               char *symname, *namespace, *modname, *d, *export, *end;
> +               char *symname, *namespace, *modname, *d, *export;
>                 unsigned int crc;
>                 struct module *mod;
>                 struct symbol *s;
> @@ -2442,16 +2442,16 @@ static void read_dump(const char *fname, unsigned int kernel)
>                 if (!(symname = strchr(line, '\t')))
>                         goto fail;
>                 *symname++ = '\0';
> -               if (!(namespace = strchr(symname, '\t')))
> -                       goto fail;
> -               *namespace++ = '\0';
> -               if (!(modname = strchr(namespace, '\t')))
> +               if (!(modname = strchr(symname, '\t')))
>                         goto fail;
>                 *modname++ = '\0';
> -               if ((export = strchr(modname, '\t')) != NULL)
> -                       *export++ = '\0';
> -               if (export && ((end = strchr(export, '\t')) != NULL))
> -                       *end = '\0';
> +               if (!(export = strchr(modname, '\t')))
> +                       goto fail;
> +               *export++ = '\0';
> +               if (!(namespace = strchr(export, '\t')))
> +                       goto fail;
> +               *namespace++ = '\0';
> +
>                 crc = strtoul(line, &d, 16);
>                 if (*symname == '\0' || *modname == '\0' || *d != '\0')
>                         goto fail;
> @@ -2502,9 +2502,9 @@ static void write_dump(const char *fname)
>                                 namespace = symbol->namespace;
>                                 buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
>                                            symbol->crc, symbol->name,
> -                                          namespace ? namespace : "",
>                                            symbol->module->name,
> -                                          export_str(symbol->export));
> +                                          export_str(symbol->export),
> +                                          namespace ? namespace : "");
>                         }
>                         symbol = symbol->next;
>                 }
> --
> 2.16.4
>


-- 
Lucas De Marchi
