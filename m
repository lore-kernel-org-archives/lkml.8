Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B92C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1EC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEo8442R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgE1Hbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1Hbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:31:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBFC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:31:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n123so2472792ybf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYE6p5UwpkWq7bxp4EB9q/2Nru5zecAQppMwLOCRTN8=;
        b=rEo8442RE1GAFP0Nvyz9c/sAvJx4qjqL6Ry7UlBf0fzMjXUUb9sMB4jyCVEWrg5dHL
         hgBUyMyhfxQ2viBU6ZMmydoycqTGREyreIjw0969gbEVe79+uTd75kr2XSUMoS+PKlx+
         n70R+abwCzsm7WVgGVElW3YEocGO9hZVgOUNmlDVwUaTDAYx+HM8TJRCLEb7K67cGmpT
         L/RO+nku5yB6SqF+qeliTKTO8XW29yGYHC/WlfTlS1Qrndx/50UPyBUK2evQJ7dEaLj4
         X9I07b0LbffXvXVabZwBwFIC4lUIaTmR7DPSzxIbVcMaQ4D+ehaF6kswxZ0HoFnzYTpS
         J+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYE6p5UwpkWq7bxp4EB9q/2Nru5zecAQppMwLOCRTN8=;
        b=RP7hK18rQRkS30gI6YO6ZbTtGh/xatSymqtpmdpzkLTFXL2seVUM6FLOajWdrI5QoY
         qJBKrccAApbI8ZMT0Kav3RW8vP2nvwXMd2CmALBDa9XfencE0ebE6qHKrI2Tj+rI69CL
         Vq84YccXtX9p7t6g/5ulgSyWMLdA8fRpL7ymxryNsAGcDAJrKD8M4GlvrzwvM/7JZLsB
         QIbVr/WlQNRUrHv+MJgaw4nl8Zd08LKU+dwFgxIPMvNhaRelQIENdAQ6wTefWKcWIfs2
         +YHDtqDmFi/73m/C2GngaB7b4WdB5jBE+G3Y9kIMwJQeLiOlfdYie2gBctkvUXjclyvI
         t6cA==
X-Gm-Message-State: AOAM530h0lApA27DFN4DyF2Aet2WUHn8O9OaxqLW7KHmE78bQR+PwjQk
        4r7yYcd49og/lZMXDEHSZcEvvhltZ9FM0+Fx6mZceQ==
X-Google-Smtp-Source: ABdhPJwSOv8m66f6lrkyqRtiTjAFaVHdWEmyC8xBfIrG3gWjE3lb1PL33rE980aWbkjOi5f00QXwtepSJJV9x5JIKlw=
X-Received: by 2002:a25:5387:: with SMTP id h129mr2888046ybb.47.1590651102358;
 Thu, 28 May 2020 00:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054049.13662-1-nick.gasson@arm.com>
In-Reply-To: <20200528054049.13662-1-nick.gasson@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 May 2020 00:31:31 -0700
Message-ID: <CAP-5=fWcMKtPa3C9Jbyf=zY=YmTRaoiyc837nYJcK9pC+NJ-LA@mail.gmail.com>
Subject: Re: [PATCH v2] perf jvmti: Remove redundant jitdump line table entries
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

On Wed, May 27, 2020 at 10:41 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> For each PC/BCI pair in the JVMTI compiler inlining record table, the
> jitdump plugin emits debug line table entries for every source line in
> the method preceding that BCI. Instead only emit one source line per
> PC/BCI pair. Reported by Ian Rogers. This reduces the .dump size for
> SPECjbb from ~230MB to ~40MB.
>
> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> ---
> Changes in v2:
> - Split the unrelated DWARF debug fix into a separate patch
> - Added a comment about the use of c->methods
>
>  tools/perf/jvmti/libjvmti.c | 78 ++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 45 deletions(-)
>
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index c5d30834a64c..fcca275e5bf9 100644
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
> -                               } else if (ret == JVMTI_ERROR_ABSENT_INFORMATION ||
> -                                          ret == JVMTI_ERROR_NATIVE_METHOD) {
> -                                       /* No debug information for this method */
> -                               } else {
> -                                       print_error(jvmti, "GetLineNumberTable", ret);
> -                               }
> -                       }
> +                       nr_total += rec->numpcs;
>                 }
>         }
>
> @@ -122,14 +107,17 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>                         rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
>                         for (i = 0; i < rec->numpcs; i++) {
>                                 c = rec->pcinfo + i;
> -                               nr = 0;
> -                               ret = do_get_line_numbers(jvmti, c->pc,
> -                                                         c->methods[0],
> -                                                         c->bcis[0],
> -                                                         *tab + lines_total,
> -                                                         &nr);
> +                                /*
> +                                 * c->methods is the stack of inlined method calls
> +                                 * at c->pc. [0] is the leaf method. Caller frames
> +                                 * are ignored at the moment.
> +                                 */

Thanks!

Acked-by: Ian Rogers <irogers@google.com>

> +                               ret = do_get_line_number(jvmti, c->pc,
> +                                                        c->methods[0],
> +                                                        c->bcis[0],
> +                                                        *tab + lines_total);
>                                 if (ret == JVMTI_ERROR_NONE)
> -                                       lines_total += nr;
> +                                       lines_total++;
>                         }
>                 }
>         }
> --
> 2.26.2
>
