Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92676C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A57420B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGsay3fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGSVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSVl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:41:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41EC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:41:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so23338875wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70xFn8Ujt0CHfBd1Ffveh7ykNdf7NdjhgiX2kc3YNug=;
        b=XGsay3fecHCsZTO63QS67vk30jV4Bg3aXHhhVnjqpQjB/yYIhO4k3bx3+4bAfGB8hl
         XSjRo/2J+0301IC3895klDDGtMugJ5MKHF1+eYiaKsMQoVrFfviorLr1QjdIX1+GWSVB
         0pWpWcbVS6EYQ4knlu5Uxl8/Rml4MEfbpktbiOUK068xlbSyyxMaKRkju1CSt32ydLGA
         gqWsS8adbAcv6VOXh1TbvUkYL+v1CXoIENHeluVOxhF9+3UYlIpH6PZs4FomG9eY+fky
         iT1nSZhb2vWLtg4RrFK/0rnNuEZZnjeWbNfA5WMzY9dxKWkYVUz0e/X8uRMjJXvmy3SW
         2Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70xFn8Ujt0CHfBd1Ffveh7ykNdf7NdjhgiX2kc3YNug=;
        b=oHlVvla4CU3EcjHSsty1ZZ6y9yVlfy64UuHpHPzKqXaVwwrxoPMHgB8ZeCoY4Phnje
         MhhImjW2OFsgAqu+qd92b+nQxRNM2IXYxK0z5dsEsondxPltPEAleju3aInz7Q0nCfe4
         WESpuTEhRImv81zWIjl4k3p++u32gc774OHfH4zYQm66PGaczBGPtHrsPXHktpLK1V+Y
         jAhl6iawczOEbzj53nYpzk8QnfEcX+t+BnO0uqvvH2rND333IAuTzvXpPxcK9SMW+GaS
         kKICw+Xd6Vg42kdEA2yrQguF7QOQmzVXaqJKNixgPgqE7AwZtH4rv64QUAjm3UcRHNqi
         PIhw==
X-Gm-Message-State: AOAM531ohuEEdbHDg1Ia7pfEZXtuZElIpw4bqV6y3mke4s6b7OD3quwu
        OdmEckg5Zi5hP2CPpoAel+E6iKOQLK2zMw7m4Awemg==
X-Google-Smtp-Source: ABdhPJzaOAKfdrLFPS6Xq0cujLktwm/v2Ah4JoSoOxAuH49LuvzJl1uZ+VCUdbX/hehm6D+4de3DhMjS5lPSOf3/pgM=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr18760375wmz.124.1595194917640;
 Sun, 19 Jul 2020 14:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-2-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 14:41:46 -0700
Message-ID: <CAP-5=fWdgFCBj0r4nVgEXnwOpckCXOb-FSTqexuDw=YiNnH+9Q@mail.gmail.com>
Subject: Re: [PATCH 01/19] perf metric: Fix memory leak in expr__add_id function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Arnaldo found that we don't release value data in case the
> hashmap__set fails. Releasing it in case of an error.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/expr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 5d05f9765ed8..578a173d4873 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -47,6 +47,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>         }
>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
> +       if (ret)
> +               free(data_ptr);
>         free(old_key);
>         free(old_data);
>         return ret;
> --
> 2.25.4
>
