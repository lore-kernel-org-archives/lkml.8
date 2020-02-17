Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B930C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1407720801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581928376;
	bh=OwgMBsjVSCrvbV4TA2D+tr7AeyhpUQsV01Ho7eUVod0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KyLaM4wwOFUSoCbuMaDQ4g2ihl5y5tyNJw+YSx1ITwF/6MrYGormN6wIRt1Yv3ptn
	 614gckxNLsGr/GE3yO5aleA0hYmA1Sgs5tfCxF3tc0QzxFvD0YV2LPZlFfgb7u8Ynm
	 0TO0Y+z215Onm9Dxe8YNCBrrjVylCnx9jkGTdVow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBQIcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgBQIcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:53 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B89220725
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581928372;
        bh=OwgMBsjVSCrvbV4TA2D+tr7AeyhpUQsV01Ho7eUVod0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1Qsi15U7hTxkN1xdFFORkwVFajZ/gVGeHxiOLjCR1d1WrYJ9ngmW56hFGfLcG/vY1
         yFRc7dkoBHwkAs70yIqaRDY9Vu0PEbjZQ8KREpRR1jIe9ShqQQ8YZsxqi0qc6UGTsy
         AQfPaISrmT2i+Qx8knFGeMyJCWj2aw4n+uLS5irs=
Received: by mail-wm1-f45.google.com with SMTP id s10so16186256wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:52 -0800 (PST)
X-Gm-Message-State: APjAAAUUG4eb7AxYqGd2QbGhwcySHbZWECfQYwx6OiKU7r/UT45sxuua
        V2q3/+g5RWpOo5zjtaa9ttz3vqsJKZVbrY7ZU8HCwA==
X-Google-Smtp-Source: APXvYqyziBIaciYe96AavE0XzNcCSVkKBWen9F5MoO0KrZzjOxjQc0rgfFEuNAV7fOW971/GLufC9iE3EI+E9zbFjKU=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr20313635wmf.40.1581928370477;
 Mon, 17 Feb 2020 00:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org> <20200216182334.8121-13-ardb@kernel.org>
 <20200216191219.GA589207@rani.riverdale.lan>
In-Reply-To: <20200216191219.GA589207@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 09:32:39 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_NEuPAnEjFtk1MOs6xqcH-WNK2+6uP_EQ203vhjHzDaw@mail.gmail.com>
Message-ID: <CAKv+Gu_NEuPAnEjFtk1MOs6xqcH-WNK2+6uP_EQ203vhjHzDaw@mail.gmail.com>
Subject: Re: [PATCH 12/18] efi: clean up config_parse_tables()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020 at 20:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Feb 16, 2020 at 07:23:28PM +0100, Ard Biesheuvel wrote:
> > config_parse_tables() is a jumble of pointer arithmetic, due to the
> > fact that on x86, we may be dealing with firmware whose native word
> > size differs from the kernel's.
> >
> > This is not a concern on other architectures, and doesn't quite
> > justify the state of the code, so let's clean it up by adding a
> > non-x86 code path, constifying statically allocated tables and
> > replacing preprocessor conditionals with IS_ENABLED() checks.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/ia64/kernel/efi.c          |  3 +-
> >  arch/x86/platform/efi/efi.c     |  6 +--
> >  drivers/firmware/efi/arm-init.c |  5 +--
> >  drivers/firmware/efi/efi.c      | 47 ++++++++++----------
> >  include/linux/efi.h             |  5 ++-
> >  5 files changed, 32 insertions(+), 34 deletions(-)
> >
...
       if (!retval)
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 2bfd6c0806ce..db1fe765380f 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
...
> > @@ -498,39 +498,38 @@ static __init int match_config_table(efi_guid_t *guid,
> >       return 0;
> >  }
> >
> > -int __init efi_config_parse_tables(void *config_tables, int count, int sz,
> > -                                efi_config_table_type_t *arch_tables)
> > +int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
> > +                                int count,
> > +                                const efi_config_table_type_t *arch_tables)
> >  {
> > -     void *tablep;
> > +     const efi_config_table_64_t *tbl64 = (void *)config_tables;
> > +     const efi_config_table_32_t *tbl32 = (void *)config_tables;
> > +     const efi_guid_t *guid;
> > +     unsigned long table;
> >       int i;
> >
> > -     tablep = config_tables;
> >       pr_info("");
> >       for (i = 0; i < count; i++) {
> > -             efi_guid_t guid;
> > -             unsigned long table;
> > -
> > -             if (efi_enabled(EFI_64BIT)) {
> > -                     u64 table64;
> > -                     guid = ((efi_config_table_64_t *)tablep)->guid;
> > -                     table64 = ((efi_config_table_64_t *)tablep)->table;
> > -                     table = table64;
> > -#ifndef CONFIG_64BIT
> > -                     if (table64 >> 32) {
> > +             if (!IS_ENABLED(CONFIG_X86)) {
> > +                     guid = &config_tables[i].guid;
> > +                     table = (unsigned long)config_tables[i].table;
> > +             } else if (efi_enabled(EFI_64BIT)) {
> > +                     guid = &tbl64[i].guid;
> > +                     table = tbl64[i].table;
> > +
> > +                     if (IS_ENABLED(CONFIG_X64_32) &&
>                                               ^^^ typo, should be X86
>

Noted, thanks for spotting that.
