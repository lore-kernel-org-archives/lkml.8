Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCF8C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588BA24649
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALwIsLAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBRSOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:14:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgBRSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:14:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so11342708pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjBsD1bfT+wBRsog7dLy88sj/+Yo7mrxAe78XoztkYs=;
        b=ALwIsLAM0QpZe9yPySSYv2CTq+TCBoDBBh9inOJ5gcT6TsIfE1ly09joWnq1CB5a5W
         9Ad3TYsUdV/t04zq11QYI6T6MOxARHtg12Jnk8jHJVS0UtkRDDB3j6QlpYsT6QbcozyD
         GO3Ni3W888vC7d8yr7MxTw9SNre1LeTGAlNvFFuFZbvhZYcVSYHnrKDOJxzbpymRnuLD
         JUKlIuZ7MncMNw4A+pGk5N90xXPktQdAmjREzVdXctPARRYOcoHlFB3fex/IwENM4Y0L
         Iof8/Wbb/9a53YmNzHUJaoA12eQMmD/MaFOnraYDILZ7VMXifedPlWaPmdtAuzbh1R3w
         o2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjBsD1bfT+wBRsog7dLy88sj/+Yo7mrxAe78XoztkYs=;
        b=OeMTO7QYrokx3Ja/ZmRPbSWRguCz9guD5X7LCtWIkoXa/s7JyQFSaNL/E20mqc32zV
         05XVVg1VMwxBHxOmfvl++64Wn7WHp84wXXUZ9z/8wzG8j0U1UtbtiL3HOsJqIR9TLCs6
         cQHD8OMVFUBgf+/g9QiD9nWvTE2qsyRSloLfa6PLb609fg/XVK/67/QS8QRDtDhYCfac
         46o91V42h3IyuZX88dTjEW2vm4qw/KdZ1QuanSKIzyGp9uIFTv1vlIEMgpxm6AXxFqXg
         BCTaf7WnhYZaUkm8pDzRnQZvjoMQiyVdShm9gvD3O+Yu9XdrUDfWJa1gwlx2Ac9yvip6
         w/1g==
X-Gm-Message-State: APjAAAUGJ9tDzDEI3US3A4/1dT0yWPP74dCPPe5hBqvG+TdCe5X55GYv
        GUUKMUKkcb6w6JC8XsZZ2iSpf/RLHhiDBIH4QmNZsg==
X-Google-Smtp-Source: APXvYqw3EsKWJnimAWkQkX2Vhseeanvb+WdTNPcWCvBHYz0vDLB0ijdKVrmwlHwCA6jFXJ3KHaicSQ5/6HtBt84zjeU=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr23370057pgk.381.1582049645698;
 Tue, 18 Feb 2020 10:14:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581997059.git.jpoimboe@redhat.com> <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
In-Reply-To: <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Feb 2020 10:13:54 -0800
Message-ID: <CAKwvOd=ZJReVqgY_QbyKiX2MoL1neSrhoCxYN--56yFVUkuy2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] objtool: Improve call destination function detection
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 7:42 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> A recent clang change, combined with a binutils bug, can trigger a
> situation where a ".Lprintk$local" STT_NOTYPE symbol gets created at the
> same offset as the "printk" STT_FUNC symbol.  This confuses objtool:
>
>   kernel/printk/printk.o: warning: objtool: ignore_loglevel_setup()+0x10: can't find call dest symbol at .text+0xc67
>
> Improve the call destination detection by looking specifically for an
> STT_FUNC symbol.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/872
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25551
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks Josh.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested defconfig and allyesconfig builds with the series.

> ---
>  tools/objtool/check.c | 27 ++++++++++++++++++---------
>  tools/objtool/elf.c   | 14 ++++++++++++--
>  tools/objtool/elf.h   |  1 +
>  3 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e7227649bac7..da0767128f61 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -415,8 +415,8 @@ static void add_ignores(struct objtool_file *file)
>                         break;
>
>                 case STT_SECTION:
> -                       func = find_symbol_by_offset(rela->sym->sec, rela->addend);
> -                       if (!func || func->type != STT_FUNC)
> +                       func = find_func_by_offset(rela->sym->sec, rela->addend);
> +                       if (!func)
>                                 continue;
>                         break;
>
> @@ -679,10 +679,14 @@ static int add_call_destinations(struct objtool_file *file)
>                                                insn->len);
>                 if (!rela) {
>                         dest_off = insn->offset + insn->len + insn->immediate;
> -                       insn->call_dest = find_symbol_by_offset(insn->sec,
> -                                                               dest_off);
> +                       insn->call_dest = find_func_by_offset(insn->sec, dest_off);
> +                       if (!insn->call_dest)
> +                               insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
>
> -                       if (!insn->call_dest && !insn->ignore) {
> +                       if (insn->ignore)
> +                               continue;
> +
> +                       if (!insn->call_dest) {
>                                 WARN_FUNC("unsupported intra-function call",
>                                           insn->sec, insn->offset);
>                                 if (retpoline)
> @@ -690,11 +694,16 @@ static int add_call_destinations(struct objtool_file *file)
>                                 return -1;
>                         }
>
> +                       if (insn->func && insn->call_dest->type != STT_FUNC) {
> +                               WARN_FUNC("unsupported call to non-function",
> +                                         insn->sec, insn->offset);
> +                               return -1;
> +                       }
> +
>                 } else if (rela->sym->type == STT_SECTION) {
> -                       insn->call_dest = find_symbol_by_offset(rela->sym->sec,
> -                                                               rela->addend+4);
> -                       if (!insn->call_dest ||
> -                           insn->call_dest->type != STT_FUNC) {
> +                       insn->call_dest = find_func_by_offset(rela->sym->sec,
> +                                                             rela->addend+4);
> +                       if (!insn->call_dest) {
>                                 WARN_FUNC("can't find call dest symbol at %s+0x%x",
>                                           insn->sec, insn->offset,
>                                           rela->sym->sec->name,
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index edba4745f25a..cc4601c879ce 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -62,8 +62,18 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>         struct symbol *sym;
>
>         list_for_each_entry(sym, &sec->symbol_list, list)
> -               if (sym->type != STT_SECTION &&
> -                   sym->offset == offset)
> +               if (sym->type != STT_SECTION && sym->offset == offset)
> +                       return sym;
> +
> +       return NULL;
> +}
> +
> +struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
> +{
> +       struct symbol *sym;
> +
> +       list_for_each_entry(sym, &sec->symbol_list, list)
> +               if (sym->type == STT_FUNC && sym->offset == offset)
>                         return sym;
>
>         return NULL;
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index 44150204db4d..a1963259b930 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -77,6 +77,7 @@ struct elf {
>
>  struct elf *elf_read(const char *name, int flags);
>  struct section *find_section_by_name(struct elf *elf, const char *name);
> +struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
>  struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
>  struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
>  struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
> --
> 2.21.1
>


-- 
Thanks,
~Nick Desaulniers
