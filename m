Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B6C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457D42173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsVh7QRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgEARtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729697AbgEARtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:49:20 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB559C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:49:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b17so5309473ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vr7i4KBzRAJaxFRYhCEC2mVKHkt5/69Cvw0YZLzHCkI=;
        b=PsVh7QRveASnS9mQbzIV54P0vEmP87capTD8KvpENmUfjmXbCnci0GT90owMQxvORd
         3mpwwpY+o3GxItma7tH2B2oc9+foqqtSJ0V1Pu6144iLPjzT4xLT4q9GnJEetWNKUzgU
         K6D1UEk2LbOuE/iPnIhD5D00s1uAeI1jU3vvcpf4PtzlWhYcpTl8uv4mTZU9onHfWDQk
         7LQNzkytaXi/vwuxxxVJ7xnJdib4Kt9oInZH+sQk9VVsKXli++rv6CwOcrdHlm76u/Z/
         U58xhqjkfgwL0MuD25Vz2b7YpSRuPg59Bn9uG0tsAyuEIbAQ6vMdRGcV57cfg0Bw4QYk
         mFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vr7i4KBzRAJaxFRYhCEC2mVKHkt5/69Cvw0YZLzHCkI=;
        b=c9Kv+thVsTQ44KvFdFoyWuxqmXOGQNdYSylAKhcpIVr2AEU5hied1W42yn2E/3yL4J
         HY6IcU64XALiO5oaV263LEWJQI2Rch1f2/1oqf3/UwCiom09u9SBHV7oZazcbixPEC9+
         1HdoSvXkAnIvgRHXPpCN6tI9rPJybF4h6514lzf58cNoT2RDw4JaYfUaWeuKGwCBt7Fv
         sRnpFGa0aVIp4xGzV+oR2sj5OjPzS0t/Vhgr0Jw5zWWJB6rRFejX68nSK9YuorMEAgJ0
         8GeG3PVUcfmrtIjpDzTusJnKG5eq44YI7XCWCrWeT96z0Rzc3GSZl1My9avu52cy75oo
         Euig==
X-Gm-Message-State: AGi0PuYhxWeRBIW5Q9jlEBVw8U51zCHdjDGEJ9wGh/1uXN0w+TyOxV0f
        IagHyUJ9B0/K6wGzAYPPMbWnMnOStKn8+ik/ZhGzkg==
X-Google-Smtp-Source: APiQypLVTKFhOiWfbcYQxrLnlEljDpT8buG+pzGvryeq4wTccpcCURS59rQbR8fqWP/X/WKvrSXFbSorBFD6L1zzZxc=
X-Received: by 2002:a5b:9cb:: with SMTP id y11mr8303374ybq.177.1588355357976;
 Fri, 01 May 2020 10:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200501113448.1809037-1-jolsa@kernel.org>
In-Reply-To: <20200501113448.1809037-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 May 2020 10:49:06 -0700
Message-ID: <CAP-5=fVCTDoQ--gwjo3rqp6FxiMqiJHoNxtP+b8AMZChhQ5dtg@mail.gmail.com>
Subject: Re: [PATCH] perf session: Try to read pipe data from file
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 4:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Jiri Olsa <jolsa@redhat.com>
>
> Ian came with the idea of having support to read the pipe
> data also from file [1]. Currently pipe mode files fails
> like:
>
>   $ perf record -o - sleep 1 > /tmp/perf.pipe.data
>   $ perf report -i /tmp/perf.pipe.data
>   incompatible file format (rerun with -v to learn more)
>
> This patch adds the support to do that by trying the pipe
> header first, and if its successfully detected, switching

nit: s/its/it's/

> the perf data to pipe mode.
>
> [1] https://lore.kernel.org/lkml/20200409185744.255881-1-irogers@google.com/
> Original-patch-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Tested and works great, thanks!
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/header.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 0ce47283a8a1..8ca709f938b8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3574,7 +3574,7 @@ static int perf_header__read_pipe(struct perf_session *session)
>                 return -EINVAL;
>         }
>
> -       return 0;
> +       return f_header.size == sizeof(f_header) ? 0 : -1;
>  }
>
>  static int read_attr(int fd, struct perf_header *ph,
> @@ -3676,7 +3676,7 @@ int perf_session__read_header(struct perf_session *session)
>         struct perf_file_header f_header;
>         struct perf_file_attr   f_attr;
>         u64                     f_id;
> -       int nr_attrs, nr_ids, i, j;
> +       int nr_attrs, nr_ids, i, j, err;
>         int fd = perf_data__fd(data);
>
>         session->evlist = evlist__new();
> @@ -3685,8 +3685,16 @@ int perf_session__read_header(struct perf_session *session)
>
>         session->evlist->env = &header->env;
>         session->machines.host.env = &header->env;
> -       if (perf_data__is_pipe(data))
> -               return perf_header__read_pipe(session);
> +
> +       /*
> +        * We can read 'pipe' data event from regular file,
> +        * check for the pipe header regardless of source.
> +        */
> +       err = perf_header__read_pipe(session);
> +       if (!err || (err && perf_data__is_pipe(data))) {
> +               data->is_pipe = true;
> +               return err;
> +       }
>
>         if (perf_file_header__read(&f_header, header, fd) < 0)
>                 return -EINVAL;
> --
> 2.25.4
>
