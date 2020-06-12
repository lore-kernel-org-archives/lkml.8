Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DACCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCE207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6cpDsvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLEEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgFLEEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:04:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF8C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:04:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v79so7814080qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk4oPlKcNdHHWRnpa3/f3nYi5KMB00ccTNvWIrQryOY=;
        b=R6cpDsvT/ZtAhMqliqQzZZLTPgAUxbObMR3xYvl2A8PCBQ61fylOJ7Pj8Zj5moLXmc
         h41OgOsty8Q01d20WpK7FCL32eE+BILSSRYUipxLGzF3EQ281iWrWt8OLZl1S8QQpVKe
         CaimkkMwzro9be7TGvDSfseVuoDEc+CZejrSgO/CMd0HhFFewb7Ih/ckGE5heb7z/OWO
         Wz8sOu0nFnzeV1GSEA75ZustZTWHA/ar9O4d5ofF2Do0C7FVLQNq7HHMMa4EOvPGyqfo
         IYnZC84vYPpaiRGvt7bx7dlmQAe9VepHnK8IS4RScCYuxrEjWgtcvagtfIjoMFszOlzj
         1E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk4oPlKcNdHHWRnpa3/f3nYi5KMB00ccTNvWIrQryOY=;
        b=KmHMtu3msYXIbkMzM5hNundA2pY+mMaHciV2t+M+0KP3sm80qcsjFp5x38pLg5JQgo
         4C6aM8cdr+O9nqxvnD0/LDX9DnfMRjY/BRAqmF1zdAsgO7apO5f4g46ya7LOWUly3mx/
         y7LXJD0o+HNeNtzikfYBUn/6wUwkjBVdbVVcHeJx0GjPIfYvVcUDA9H2VAVIjayLZ9UZ
         Ft0ITFzCNOg+2PAZ822DbWc71f9oANcst37Js+m0NVUBkRYyyFKBLAl1moUV08mnRTgU
         P7QaY3liEICncKwppVl9X5W1bWVNNvPfL+Za8dc62478GfRkuGFL6i9m2iJ7Hyo5PKeX
         5hyw==
X-Gm-Message-State: AOAM532YuD8O8Ev2b4ZVpJrMjO3UaHvSm7aiHqeGtncoJuS/tjpVraR/
        uSfIAWQGWNKHqPj+WnYPweIEpls6hpHybwKEupgkow==
X-Google-Smtp-Source: ABdhPJwh806t14C2PS8COYYZeOFR7I1aBqRT2alf9DAAf7HImiLOq3WFcG2AMoPspKZH9c1kOOTE0QYgQ9vtwbX2Cgw=
X-Received: by 2002:a37:a0c6:: with SMTP id j189mr1147710qke.256.1591934661563;
 Thu, 11 Jun 2020 21:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net> <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net> <20200611215538.GE4496@worktop.programming.kicks-ass.net>
In-Reply-To: <20200611215538.GE4496@worktop.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Jun 2020 06:04:09 +0200
Message-ID: <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 08, 2020 at 01:01:08PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 08, 2020 at 09:57:39AM +0200, Dmitry Vyukov wrote:
> >
> > > As a crazy idea: is it possible to employ objtool (linker script?) to
> > > rewrite all coverage calls to nops in the noinstr section? Or relocate
> > > to nop function?
> > > What we are trying to do is very static, it _should_ have been done
> > > during build. We don't have means in existing _compilers_ to do this,
> > > but maybe we could do it elsewhere during build?...
> >
> > Let me try and figure out how to make objtool actually rewrite code.
>
> The below is quite horrific but seems to sorta work.
>
> It turns this:
>
>   12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
>                         13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
>
> Into this:
>
>   12:   90                      nop
>   13:   90                      nop
>                         13: R_X86_64_NONE       __sanitizer_cov_trace_pc-0x4
>   14:   90                      nop
>   15:   90                      nop
>   16:   90                      nop
>
>
> I'll have to dig around a little more to see if I can't get rid of the
> relocation entirely. Also, I need to steal better arch_nop_insn() from
> the kernel :-)

Wow! Cool!
Thanks for resolving this. I guess this can be used to wipe more
unwanted things in future :)

Marco double checked and his patch did not actually fix the existing
crash under KCSAN. The call itself was the problem or something,
returning early did not really help. This should hopefully fix it.
Marco, please double check.

Re better nop insn, I don't know how much work it is (or how much you
are striving for perfection :)). But from KCOV point of view, I think
we can live with more or less any nop insn. The main thing was
removing overhead from all other (not noinstr) cases, I would assume
the noinstr cases where we use nops are very rare. I mean don't spend
too much time on it, if it's not needed for something else.

Thanks again!


> ---
>  tools/objtool/arch.h            |  2 ++
>  tools/objtool/arch/x86/decode.c | 24 ++++++++++++++++++++++
>  tools/objtool/check.c           | 15 +++++++++++++-
>  tools/objtool/elf.c             | 45 ++++++++++++++++++++++++++++++++++++++++-
>  tools/objtool/elf.h             | 11 ++++++++--
>  5 files changed, 93 insertions(+), 4 deletions(-)
>
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index eda15a5a285e..3c5967748abb 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -84,4 +84,6 @@ unsigned long arch_jump_destination(struct instruction *insn);
>
>  unsigned long arch_dest_rela_offset(int addend);
>
> +const char *arch_nop_insn(int len);
> +
>  #endif /* _ARCH_H */
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 4b504fc90bbb..b615c32e21db 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -565,3 +565,27 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
>         state->regs[16].base = CFI_CFA;
>         state->regs[16].offset = -8;
>  }
> +
> +const char *arch_nop_insn(int len)
> +{
> +       static const char insn[16] = {
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +               0x90,
> +       };
> +
> +       return insn;
> +}
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5fbb90a80d23..487b4dc3d122 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -765,6 +765,17 @@ static int add_call_destinations(struct objtool_file *file)
>                 } else
>                         insn->call_dest = rela->sym;
>
> +               if (insn->sec->noinstr &&
> +                   !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> +                       if (rela)
> +                               elf_write_rela(file->elf, rela);
> +
> +                       elf_write_insn(file->elf, insn->sec,
> +                                      insn->offset, insn->len,
> +                                      arch_nop_insn(insn->len));
> +                       insn->type = INSN_NOP;
> +               }
> +
>                 /*
>                  * Whatever stack impact regular CALLs have, should be undone
>                  * by the RETURN of the called function.
> @@ -2802,11 +2813,13 @@ int check(const char *_objname, bool orc)
>                 if (ret < 0)
>                         goto out;
>
> +       }
> +
> +       if (file.elf->changed) {
>                 ret = elf_write(file.elf);
>                 if (ret < 0)
>                         goto out;
>         }
> -
>  out:
>         if (ret < 0) {
>                 /*
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 84225679f96d..705582729374 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -525,6 +525,7 @@ static int read_relas(struct elf *elf)
>                                 return -1;
>                         }
>
> +                       rela->idx = i;
>                         rela->type = GELF_R_TYPE(rela->rela.r_info);
>                         rela->addend = rela->rela.r_addend;
>                         rela->offset = rela->rela.r_offset;
> @@ -713,6 +714,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
>         elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
>         elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
>
> +       elf->changed = true;
> +
>         return sec;
>  }
>
> @@ -779,7 +782,43 @@ int elf_rebuild_rela_section(struct section *sec)
>         return 0;
>  }
>
> -int elf_write(const struct elf *elf)
> +int elf_write_insn(struct elf *elf, struct section *sec,
> +                  unsigned long offset, unsigned int len,
> +                  const char *insn)
> +{
> +       Elf_Data *data = sec->data;
> +
> +       if (data->d_type != ELF_T_BYTE || data->d_off) {
> +               printf("ponies\n");
> +               return -1;
> +       }
> +
> +       memcpy(sec->data->d_buf + offset, insn, len);
> +
> +       elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
> +
> +       sec->changed = true;
> +       elf->changed = true;
> +
> +       return 0;
> +}
> +
> +int elf_write_rela(struct elf *elf, struct rela *rela)
> +{
> +       struct section *sec = rela->sec;
> +
> +       rela->rela.r_info = 0;
> +       rela->rela.r_addend = 0;
> +
> +       gelf_update_rela(sec->data, rela->idx, &rela->rela);
> +
> +       sec->changed = true;
> +       elf->changed = true;
> +
> +       return 0;
> +}
> +
> +int elf_write(struct elf *elf)
>  {
>         struct section *sec;
>         Elf_Scn *s;
> @@ -796,6 +835,8 @@ int elf_write(const struct elf *elf)
>                                 WARN_ELF("gelf_update_shdr");
>                                 return -1;
>                         }
> +
> +                       sec->changed = false;
>                 }
>         }
>
> @@ -808,6 +849,8 @@ int elf_write(const struct elf *elf)
>                 return -1;
>         }
>
> +       elf->changed = false;
> +
>         return 0;
>  }
>
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index f4fe1d6ea392..4a3fe4f455c5 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -64,9 +64,10 @@ struct rela {
>         GElf_Rela rela;
>         struct section *sec;
>         struct symbol *sym;
> -       unsigned int type;
>         unsigned long offset;
> +       unsigned int type;
>         int addend;
> +       int idx;
>         bool jump_table_start;
>  };
>
> @@ -76,6 +77,7 @@ struct elf {
>         Elf *elf;
>         GElf_Ehdr ehdr;
>         int fd;
> +       bool changed;
>         char *name;
>         struct list_head sections;
>         DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
> @@ -118,7 +120,7 @@ struct elf *elf_open_read(const char *name, int flags);
>  struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
>  struct section *elf_create_rela_section(struct elf *elf, struct section *base);
>  void elf_add_rela(struct elf *elf, struct rela *rela);
> -int elf_write(const struct elf *elf);
> +int elf_write(struct elf *elf);
>  void elf_close(struct elf *elf);
>
>  struct section *find_section_by_name(const struct elf *elf, const char *name);
> @@ -132,6 +134,11 @@ struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
>  struct symbol *find_func_containing(struct section *sec, unsigned long offset);
>  int elf_rebuild_rela_section(struct section *sec);
>
> +int elf_write_rela(struct elf *elf, struct rela *rela);
> +int elf_write_insn(struct elf *elf, struct section *sec,
> +                  unsigned long offset, unsigned int len,
> +                  const char *insn);
> +
>  #define for_each_sec(file, sec)                                                \
>         list_for_each_entry(sec, &file->elf->sections, list)
>
>
