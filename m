Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659CC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10A22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCQowVY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD0Vnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbgD0Vnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:43:41 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33170C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:43:41 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a10so19192097uad.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYuhluAGb+RQCXL4DEC1KfJRCaKA6Wi//jTTboboaoo=;
        b=iCQowVY7qNm+2hDPTf19WoKbu9nq50bk0Nh7YjBlkpv+bHph+Gqo//W33qByKWOUi1
         rZgz+DsGMCagrOULZIri9qiafY7b/7Mi20EIiTQ36aPWrkY935PQMkDaZKJWlkFH2M5s
         1posC3qlpfwlLc1QA7PwzkdBm5GRxXQjT5Z7C8wmunaMy39Lfs4uA60SJ0D31hsB0gm3
         Pz3v28kWM0vJ+s357W2dZ2sgaBwaORVbMeQCgIv/Tgh+gYEXl5XO1lAvD7NTU6d2M9Nv
         39tn2vXG/OURY5Y4Ta2Olk7t0enCARDtf/X7MX5IMM8f7Ka1Q3QFMTKN1jvEF5toFZY7
         SyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYuhluAGb+RQCXL4DEC1KfJRCaKA6Wi//jTTboboaoo=;
        b=D8tdeuY9ujZed/XSThWKqc/5uiTvgDmLcO7VPNjzj4mxrCEWDxefNUvysN+YOO0Ohi
         kS1+ycjVOAa47A8WJtzW2GaivLmPBPp0sQHytwg8Aa0ihH8hX4rB8HrCDhruPkzfk+7R
         Xn0t3ocuH3D7V1dJc5nobbcviNBheA6pZMvERb6GN5k7VTxzfWbTM/Dp1nk1VtautYdH
         DgUJC3XSY8ALMLld8b/4AhloqrWl20gnrQRRRIqu3vjm0rYxMi+mrr1BpxRAEhFKVwhO
         VwCez0dY32UTgStNuClsM8WK0mTqpvM4XBefD6XzZlMp1mOFr9bvx6waJElVOKOpdTW+
         PRAw==
X-Gm-Message-State: AGi0PuZb6bSjehdT8P++iRM82/W7ZVdbsLmYbbiwjfN+raQcDGe+Lkqy
        xwIHnmpN/R+XiVJLDYVRnldioXt3dCP+0V31qReA66aa
X-Google-Smtp-Source: APiQypJR+mMBo+OzPqMc4x+fpJmrlgvxgdKsttw6Vv8slx44QAtGO85qE0ORgQnjrDNFhnvxXcirLSoI1Fkt2a2ne9o=
X-Received: by 2002:a67:d710:: with SMTP id p16mr6117024vsj.240.1588023819726;
 Mon, 27 Apr 2020 14:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200418231908.152212-1-eranian@google.com>
In-Reply-To: <20200418231908.152212-1-eranian@google.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 27 Apr 2020 14:43:28 -0700
Message-ID: <CABPqkBRLHx6dbMMcGv4fi-7+Suez29n0qxUCK=g+Fn41iwZBfw@mail.gmail.com>
Subject: Re: [PATCH] perf/script: remove extraneous newline in perf_sample__fprintf_regs()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 4:19 PM Stephane Eranian <eranian@google.com> wrote:
>
> When printing iregs, there was a double newline printed because
> perf_sample__fprintf_regs() was printing its own and then at the
> end of all fields, perf script was adding one.
> This was causing blank line in the output:
>
> Before:
> $ perf script -Fip,iregs
>            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
>
>            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
>
>            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
>
>            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
>
> After:
> $ perf script -Fip,iregs
>            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
>            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
>            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
>
> Signed-off-by: Stephane Eranian <eranian@google.com>


Ping?

>
> ---
>  tools/perf/builtin-script.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1f57a7ecdf3d0..0c0b6e807d06e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -604,8 +604,6 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>                 printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
>         }
>
> -       fprintf(fp, "\n");
> -
>         return printed;
>  }
>
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
