Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5222C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC7F206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdIbvY1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgEEOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729142AbgEEOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:52:30 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:52:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so2194416ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIG8VNicf2Kv0fMlZdv+IUFU5X7895FdPSaFu4JhLc8=;
        b=IdIbvY1EZVldsRVIXSYUy+CDuRtYwezb6HSgPXVT4HRgsTs8yue/cx4pX0po6vBMcO
         69rktrFKo/h4JIC19PP51c1B7osH9zL0O6CcJileJ/dMJWFY6wRYb4qWEx4wWoXgEuV/
         CV9XowM9XDISA8KL1jLixhIlZkS24tlsfFnckZj1iHfhjBNgSsSoPCt1wdnbL/npmtv3
         Djj813ndgWwRv5aMdz/3AvHNq86l6aU6g8yXsJtCT2qXItmwpMs89aAva/4UImMfQ+Tl
         YV0xgBIB/l8v6nSzZ4irK96iD33RHWFF7Cf7KZz2NHW38U6G23bncGm4q+71zJONK+AL
         HcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIG8VNicf2Kv0fMlZdv+IUFU5X7895FdPSaFu4JhLc8=;
        b=Bwu2lz+E665JtSwgmGDr+KhR7h1MHMvG0gcBhRaQJKiSWLKSOXAst4HZbJHm/rqQHC
         U9p0utEgZt5Lddglx+MFHFyQ0zbYWRqC/f1lJk0IxfTJPHvClE91BL2s7BjbHWJ+Wldx
         3ycrpYY4qypevzbftsg9YzEJtge9IH/E/QKYQM5dKVjA9Ds0JRIo69GSPcSCWdxyGyzl
         C11rWP2oDTN8eAhnzJVbqdjNo+dMNfq0AqC3FqmKE8ZfOJET+Y2E/hRkFO4zrgEJiWia
         YKcCnNCZmWWfbPVlCR0//hk0JA+ipwm67qGtPbvX+uZ5/vTqy+QO4cBkoV3pHAa+vY3q
         zUUg==
X-Gm-Message-State: AGi0PuaiE696FA2LNh0QsLwRrVdJX9D3DqO21cre6cIKTaivABXC2+ln
        t1uLP/S/lmR4SUWjCj3qeJ2Ib9I6WueU1o94e8rPlw==
X-Google-Smtp-Source: APiQypK3s1ouG++CpfGxs1aiCBj+RgR3gBIhFZuKEIP/wFZnmiQcs7FD+RwsSDREk4fXZJx7+eOC9MfluRtssX9drd8=
X-Received: by 2002:a6b:ea16:: with SMTP id m22mr3838198ioc.73.1588690349601;
 Tue, 05 May 2020 07:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200505133642.4756-1-leo.yan@linaro.org>
In-Reply-To: <20200505133642.4756-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 5 May 2020 08:52:18 -0600
Message-ID: <CANLsYkwfiQjYCq1htu8ry02zhFXB5S9Hk0W39aRpUz+W3gUvig@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Move defined of traceid_list
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tor Jeremiassen <tor@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 07:37, Leo Yan <leo.yan@linaro.org> wrote:
>
> The variable 'traceid_list' is defined in the header file cs-etm.h,
> if multiple C files include cs-etm.h the compiler might complaint for
> multiple definition of 'traceid_list'.
>
> To fix multiple definition error, move the definition of 'traceid_list'
> into cs-etm.c.
>
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Reported-by: Thomas Backlund <tmb@mageia.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Tested-by: Thomas Backlund <tmb@mageia.org>
> ---
>  tools/perf/util/cs-etm.c | 3 +++
>  tools/perf/util/cs-etm.h | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 62d2f9b9ce1b..381d9708e9bd 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -94,6 +94,9 @@ struct cs_etm_queue {
>         struct cs_etm_traceid_queue **traceid_queues;
>  };
>
> +/* RB tree for quick conversion between traceID and metadata pointers */
> +static struct intlist *traceid_list;
> +
>  static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 650ecc2a6349..4ad925d6d799 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -114,9 +114,6 @@ enum cs_etm_isa {
>         CS_ETM_ISA_T32,
>  };
>
> -/* RB tree for quick conversion between traceID and metadata pointers */
> -struct intlist *traceid_list;
> -

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  struct cs_etm_queue;
>
>  struct cs_etm_packet {
> --
> 2.17.1
>
