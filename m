Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF637C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956572065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4WrLLt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgENWHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgENWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:07:13 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1456BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:07:12 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id c2so71961ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEuaG5HmQ1+XGijDghhh88566gfBFNICNVJ8SXX1ahA=;
        b=P4WrLLt82WbynqZzFFhuwOC5JpoDcBhNJ+Mf6iKnf5txTEedDvyWJKCtBTXVZbzGMY
         5k3uaE+/tV7XMDN1COq4518F5/iJfx/mzHya2ekwhQfZHUdQGlJydvSeFE4BhijpY2Ei
         dURawXxjGAVo1zyh1x3Aog4n4R/2AH5uxtham8FsPnch8uhev6rHFNETFhHFA5ngqcKb
         Kkc7TgR8zH6Gi7IWGSwoO02Pw1otGxQYJkQsnUUfB/AwxV9UA5zkxqUC8+Tct82Yxh3R
         M1u+pfEDF/OdHwc6/dc9jm5fZ2NdHRXwg2eKMkmjHq0cGkEfgKgjcFAfw3+uURU6nDov
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEuaG5HmQ1+XGijDghhh88566gfBFNICNVJ8SXX1ahA=;
        b=CGS6iM9oL6q9F7VJQMGAOrfNs2WPgAFDQxSQanEGUBkDwOKsaeuct42N5Cs7KQvqBl
         M7dI4ceZjWI/ju586NhiXL66kjsVDcd4mKre/ZNrHkbW15iuWJtXhU3O2SBoT+kUHksP
         NT2ODvEfZVpGE0eKz6H/2zp3OnEUG/CH1B8TbHd5KVXM9+pQH2ykobMv+UtDQ1cKDQKC
         o07kYmfyguX3AzKPeR3+OlJINGw73YnBUmVpzpdVYsYWEXyFPG7me2xxc862uWONzxF8
         GFTe05FsZqDFN8YSTi+Mjxmd4TAdaSoDwfe7PF8nqKMssJ0+6ES7tTJXxFuAVGp0MFuU
         XktQ==
X-Gm-Message-State: AOAM530kHSPoRhYtjJncjArg5SBdsAY+YsXfC+IYEVi9b2gFhegLMxp2
        BmuBMV72CdcLRcCfDW0wpzo+9z1JPeVQoy3OrbcQww==
X-Google-Smtp-Source: ABdhPJxCUXcTCTngSvm6woGmY2I8Src/7FBCFcBI/Omr9H01gul6vBRWLhROeIjCZT0bxbthgZpG4lu7bzyD0t8Mrl4=
X-Received: by 2002:a25:3182:: with SMTP id x124mr725631ybx.324.1589494031030;
 Thu, 14 May 2020 15:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200427061520.24905-1-nick.gasson@arm.com> <20200427061520.24905-2-nick.gasson@arm.com>
In-Reply-To: <20200427061520.24905-2-nick.gasson@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 15:06:59 -0700
Message-ID: <CAP-5=fUJt6bN4egoQ7ohWTPN40YCyf+819iSvH_noggnOHaoKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf jvmti: Fix jitdump for methods without debug info
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:16 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> If a Java class is compiled with -g:none to omit debug information, the
> JVMTI plugin won't write jitdump entries for any method in this class
> and prints a lot of errors like:
>
>     java: GetSourceFileName failed with JVMTI_ERROR_ABSENT_INFORMATION
>
> The call to GetSourceFileName is used to derive the file name `fn`, but
> this value is not actually used since commit ca58d7e64bdf ("perf jvmti:
> Generate correct debug information for inlined code") which moved the
> file name lookup into fill_source_filenames(). So the call to
> GetSourceFileName and related code can be safely removed.
>
> Signed-off-by: Nick Gasson <nick.gasson@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/jvmti/libjvmti.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index c441a34cb1c0..50ef524b5cd4 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -246,8 +246,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>         char *class_sign = NULL;
>         char *func_name = NULL;
>         char *func_sign = NULL;
> -       char *file_name = NULL;
> -       char fn[PATH_MAX];
>         uint64_t addr = (uint64_t)(uintptr_t)code_addr;
>         jvmtiError ret;
>         int nr_lines = 0; /* in line_tab[] */
> @@ -282,12 +280,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>                 }
>         }
>
> -       ret = (*jvmti)->GetSourceFileName(jvmti, decl_class, &file_name);
> -       if (ret != JVMTI_ERROR_NONE) {
> -               print_error(jvmti, "GetSourceFileName", ret);
> -               goto error;
> -       }
> -
>         ret = (*jvmti)->GetClassSignature(jvmti, decl_class,
>                                           &class_sign, NULL);
>         if (ret != JVMTI_ERROR_NONE) {
> @@ -302,8 +294,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>                 goto error;
>         }
>
> -       copy_class_filename(class_sign, file_name, fn, PATH_MAX);
> -
>         /*
>          * write source line info record if we have it
>          */
> @@ -323,7 +313,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>         (*jvmti)->Deallocate(jvmti, (unsigned char *)func_name);
>         (*jvmti)->Deallocate(jvmti, (unsigned char *)func_sign);
>         (*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
> -       (*jvmti)->Deallocate(jvmti, (unsigned char *)file_name);
>         free(line_tab);
>         while (line_file_names && (nr_lines > 0)) {
>             if (line_file_names[nr_lines - 1]) {
> --
> 2.26.1
>
