Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AD6C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE09420727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583749292;
	bh=UwZjNm1o4WstS42n0XHVzq/WBGCbmUHrtoh2mqeU+CM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YA54iTAdyUmdZnlpsTkGYTexx/UXzNx3qSamH/ZyqUj2sl/q22TEv5edks6rbOjxG
	 L5NjsMJRo6eWrZLZ6WtB3FSpJYgppNJDGhgcARC31hcN8kwtCNpoKogiGzmNv4JPc1
	 aUpoy6qB2Syu5veAPlS7m7zmNQCD+1WnMFkYpRQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIKVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:21:31 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:24579 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgCIKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:21:31 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 029ALCNW008026
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 19:21:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 029ALCNW008026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583749273;
        bh=qHcJNSpF730WgCGzGVRmp2fbBMHKHbwx6bmfXOyzE00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W1/tJPzic9XvaLdkoE336gMjy55ELdX+L+8XG441M+Imi+41kXazxpGRaLvwoqMGP
         E0ErgfgVoWI9KZSGIYffvefPkQwvd4Dm6Gn6pnotBkyVPg1tOKZMfihTGLFJOB8He7
         oilUvzZ5FrFxYhc0B5muI5ZDM2fJEzEvg/yZCmHkXkRldGRgsrc7L9Y/VUMhKWnXLy
         TvPA2DExJHx/dZYzYQBRq4Ywo808SXOKcjSfh9SrfK/w6F4t5ETpDvwtPbg0IVnhyo
         hZkzKGvOvobDvRnlGSWuGXJfDyifJN4nHJ95zvr9Ci7OmQh3mycakOyh0J+gTIDVx4
         xUro67oUjOv/w==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id z125so1718371vsb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:21:12 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2PQ1ehT3BMzbOV18DJZqP9ecrMK+/agGaKlSoRVqX+/DN4CaEZ
        4wUqzC9dHfUxNxn0tRqggVb6GXlw4KDLzUW2usY=
X-Google-Smtp-Source: ADFU+vteoQCHVTbhDrPA4pRy0Br1C9+cf5sBCXZ/wAdJtRnSUshiVG61EaJ9ihxu/Wfpuyk5bKtyZNG4zoUuz7MpdxY=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr2932905vsz.155.1583749271301;
 Mon, 09 Mar 2020 03:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org> <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
In-Reply-To: <20200309095914.GA18870@linux-8ccs.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Mar 2020 19:20:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
Message-ID: <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 6:59 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [09/03/20 09:40 +0900]:
> >Hi Jessica,
> >
> >
> >
> >On Sat, Mar 7, 2020 at 1:02 AM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> Rework modpost's logging interface by consolidating merror(), warn(), =
and
> >> fatal() to use a single function, modpost_log(). Introduce different
> >> logging levels (WARN, ERROR, FATAL) as well. The purpose of this clean=
up is
> >> to reduce code duplication when deciding whether or not to warn or err=
or
> >> out based on a condition.
> >>
> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >> ---
> >> v3:
> >>         - remove level variable from modpost_log and just call fprintf=
 in each
> >>           case
> >>         - remove warn_unless and just call modpost_log() directly
> >>         - fix checkpatch error:
> >>                 ERROR: space required before the open parenthesis '('
> >>         #102: FILE: scripts/mod/modpost.c:61:
> >>         + switch(loglevel) {
> >>
> >>  scripts/mod/modpost.c | 68 ++++++++++++++++++++++--------------------=
---------
> >>  scripts/mod/modpost.h | 14 ++++++++---
> >>  2 files changed, 40 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >> index 7edfdb2f4497..a2329235a6db 100644
> >> --- a/scripts/mod/modpost.c
> >> +++ b/scripts/mod/modpost.c
> >> @@ -51,41 +51,34 @@ enum export {
> >>
> >>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
> >>
> >> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> >> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
> >>
> >> -PRINTF void fatal(const char *fmt, ...)
> >> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
> >>  {
> >
> >
> >This series looks good to me.
> >
> >I can queue it up to kbuild tree
> >if there is no objection.
> >
> >
> >I just noticed one nit.
> >
> >Now that modpost_log() is the only user of PRINTF,
> >we can delete PRITNF, and directly add the attribute
> >to modpost_log(), like this:
> >
> >
> >void __attribute__((format(printf, 2, 3)))
> >modpost_log(enum loglevel loglevel, const char *fmt, ...)
> >{
> >       ...
> >}
> >
> >
> >If you agree, I can modify it when I apply it.
>
> Yes, I agree with this change. Thank you!
>
> One more thing, it's not immediately obvious to me why the first patch
> would cause those kbuild warnings :-/ I'll see if I have any luck
> reproducing them locally..
>


Hmm, this warning option is not so new.


At least, commit 7c0d35a339db6 (4 years ago)
fixed a similar one.



I use GCC 7.4

If I apply your previous version,
I see build log like follows:




$ gcc --version
gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

masahiro@pug:~/ref/linux$ make defconfig all
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/sorttable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/export.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/x86/include/generated/asm/mmiowb.h
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
scripts/mod/modpost.c: In function =E2=80=98modpost_log=E2=80=99:
scripts/mod/modpost.c:75:2: warning: format not a string literal and
no format arguments [-Wformat-security]
  fprintf(stderr, level);
  ^~~~~~~
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/x86/kernel/asm-offsets.s


--=20
Best Regards
Masahiro Yamada
