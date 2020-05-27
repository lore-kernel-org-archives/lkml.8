Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CD12078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFA30Dft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgE0FD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgE0FD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:03:58 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A560C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:03:58 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n123so602784ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cQ99hNcBpqlblA8kwO3C9vHQdT0SWO2tDvJ+g7Myl8=;
        b=WFA30DftBDe2wuPwPNIyoqYvtqCv71gGanQC7p4xRta6756eSuqGdHxZAHzzHI3XXI
         k0EA5yCuBcK7xgDyLWPshErGdU18E/E55zO93e0f+2TyIh8atFGG5yUfyQyp5gZ/BU1T
         5nESTscCjwTOWYQ5ex+91TDC4bjzv53TDlneMRNpG79rWrOdCg4xj7F1Xbg/pC+rngpr
         jYe1qqU68p11kcRXMTaSQeNpOYdepl5JJ4Y2o2M0eydGiuMRffTShmuEZdMHMdemWPFR
         StcY1UTypM+pTGP9CNQsRD276LjotPa7+bqStS8JdSGpMc3OuNr3nGtXx/63Yc7n8nwr
         K0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cQ99hNcBpqlblA8kwO3C9vHQdT0SWO2tDvJ+g7Myl8=;
        b=nJeSRiiskDYEsKIsx5BdKIrPXotx8AGBa7Gf6LF4n85Pxxg/tH2TUf+Ww83zTgDRVI
         kmAr/Y56zKP62B49Ao6WHR4uIedkTW/ABLToJfZbacvmrrgH/BJ2bcDYwjd+PsLYG5jX
         FJX54Jv7d0FPHdWznvW+3XznQdfSXwb+N5GZJdpTnlAobHO7EIBadbDrUb8gToRefuaY
         bs+QmoKn6tvZjZ5Sj5ND8zpH1OlBaB4UGlmNBzZ5VQqeMpg7/eKDW6Kbzi+EbGYpRXkS
         dhxGHXZNXQnnmwZyndZL7a+HFIyuw+7jOtO78TIwnD20oDot044cDPgCAJlfvcQGHJS3
         hlRg==
X-Gm-Message-State: AOAM530lgkvEEiD9j/3ZwdXevfm9D4dXhuXTB/o1WIiN5X8z+MKFNN2T
        sPLO/NWH0vX3fldqvDLRJ/pc1tdARs2dhCrXOhMkeA==
X-Google-Smtp-Source: ABdhPJwsor73sWueKB15RCvM4rUou5eVfF0Y0LpuXkfOtkOGgW13SD9FglLD1bGBQ4c+XINywmfV/VmyU2dxvgr6ieg=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr7140950ybc.403.1590555836775;
 Tue, 26 May 2020 22:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200522065330.34872-1-nick.gasson@arm.com>
In-Reply-To: <20200522065330.34872-1-nick.gasson@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 May 2020 22:03:45 -0700
Message-ID: <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com>
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:54 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> For each PC/BCI pair in the JVMTI compiler inlining record table, the
> jitdump plugin emits debug line table entries for every source line in
> the method preceding that BCI. Instead only emit one source line per
> PC/BCI pair. Reported by Ian Rogers. This reduces the .dump size for
> SPECjbb from ~230MB to ~40MB.

Great result, thanks! I note there is a lack of symbolization when
benchmarking a few Java applications. I'll try to see if there's a
sensible resolution for those.

> Also fix an error in the DWARF line table state machine where addresses
> are incorrectly offset by -0x40 (GEN_ELF_TEXT_OFFSET). This can be seen
> with `objdump -S` on the ELF files after perf inject.

It'd be better to make this into two patches. Also on acme's perf/core
branch if possible:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> ---
>  tools/perf/jvmti/libjvmti.c    | 73 +++++++++++++---------------------
>  tools/perf/util/genelf_debug.c |  4 +-
>  2 files changed, 30 insertions(+), 47 deletions(-)
>
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index a9a056d68416..398e4ba6498d 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -32,38 +32,41 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
>
>  #ifdef HAVE_JVMTI_CMLR
>  static jvmtiError
> -do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
> -                   jvmti_line_info_t *tab, jint *nr)
> +do_get_line_number(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
> +                  jvmti_line_info_t *tab)
>  {
> -       jint i, lines = 0;
> -       jint nr_lines = 0;
> +       jint i, nr_lines = 0;
>         jvmtiLineNumberEntry *loc_tab = NULL;
>         jvmtiError ret;
> +       jint src_line = -1;
>
>         ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
>         if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
>                 /* No debug information for this method */
> -               *nr = 0;
> -               return JVMTI_ERROR_NONE;
> +               return ret;
>         } else if (ret != JVMTI_ERROR_NONE) {
>                 print_error(jvmti, "GetLineNumberTable", ret);
>                 return ret;
>         }
>
> -       for (i = 0; i < nr_lines; i++) {
> -               if (loc_tab[i].start_location < bci) {
> -                       tab[lines].pc = (unsigned long)pc;
> -                       tab[lines].line_number = loc_tab[i].line_number;
> -                       tab[lines].discrim = 0; /* not yet used */
> -                       tab[lines].methodID = m;
> -                       lines++;
> -               } else {
> -                       break;
> -               }
> +       for (i = 0; i < nr_lines && loc_tab[i].start_location <= bci; i++) {
> +               src_line = i;
> +       }
> +
> +       if (src_line != -1) {
> +               tab->pc = (unsigned long)pc;
> +               tab->line_number = loc_tab[src_line].line_number;
> +               tab->discrim = 0; /* not yet used */
> +               tab->methodID = m;
> +
> +               ret = JVMTI_ERROR_NONE;
> +       } else {
> +               ret = JVMTI_ERROR_ABSENT_INFORMATION;
>         }
> +
>         (*jvmti)->Deallocate(jvmti, (unsigned char *)loc_tab);
> -       *nr = lines;
> -       return JVMTI_ERROR_NONE;
> +
> +       return ret;
>  }
>
>  static jvmtiError
> @@ -71,9 +74,8 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  {
>         const jvmtiCompiledMethodLoadRecordHeader *hdr;
>         jvmtiCompiledMethodLoadInlineRecord *rec;
> -       jvmtiLineNumberEntry *lne = NULL;
>         PCStackInfo *c;
> -       jint nr, ret;
> +       jint ret;
>         int nr_total = 0;
>         int i, lines_total = 0;
>
> @@ -86,24 +88,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>         for (hdr = compile_info; hdr != NULL; hdr = hdr->next) {
>                 if (hdr->kind == JVMTI_CMLR_INLINE_INFO) {
>                         rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
> -                       for (i = 0; i < rec->numpcs; i++) {
> -                               c = rec->pcinfo + i;
> -                               nr = 0;
> -                               /*
> -                                * unfortunately, need a tab to get the number of lines!
> -                                */
> -                               ret = (*jvmti)->GetLineNumberTable(jvmti, c->methods[0], &nr, &lne);
> -                               if (ret == JVMTI_ERROR_NONE) {
> -                                       /* free what was allocated for nothing */
> -                                       (*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
> -                                       nr_total += (int)nr;
> -                               } else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
> -                                          || ret == JVMTI_ERROR_NATIVE_METHOD) {
> -                                       /* No debug information for this method */
> -                               } else {
> -                                       print_error(jvmti, "GetLineNumberTable", ret);
> -                               }
> -                       }
> +                       nr_total += rec->numpcs;
>                 }
>         }
>
> @@ -122,14 +107,12 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>                         rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
>                         for (i = 0; i < rec->numpcs; i++) {
>                                 c = rec->pcinfo + i;
> -                               nr = 0;
> -                               ret = do_get_line_numbers(jvmti, c->pc,
> -                                                         c->methods[0],
> -                                                         c->bcis[0],
> -                                                         *tab + lines_total,
> -                                                         &nr);
> +                               ret = do_get_line_number(jvmti, c->pc,
> +                                                        c->methods[0],
> +                                                        c->bcis[0],
> +                                                        *tab + lines_total);

Nit: It'd be nice to comment here that [0] is the leaf method/bci. I
don't believe it is supported but c->numstackframes could be used to
give full inlining information.

Thanks,
Ian


>                                 if (ret == JVMTI_ERROR_NONE)
> -                                       lines_total += nr;
> +                                       lines_total++;
>                         }
>                 }
>         }
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index 30e9f618f6cd..dd40683bd4c0 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
>          */
>
>         /* start state of the state machine we take care of */
> -       unsigned long last_vma = code_addr;
> +       unsigned long last_vma = 0;
>         char const  *cur_filename = NULL;
>         unsigned long cur_file_idx = 0;
>         int last_line = 1;
> @@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
>                 ent = debug_entry_next(ent);
>         }
>         add_compilation_unit(di, buffer_ext_size(dl));
> -       add_debug_line(dl, debug, nr_debug_entries, 0);
> +       add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
>         add_debug_abbrev(da);
>         if (0) buffer_ext_dump(da, "abbrev");
>
> --
> 2.26.2
>
