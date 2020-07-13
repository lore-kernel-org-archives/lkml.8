Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF532068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610029;
	bh=eU4Gqu0StB3nIy7sHat5sWMjvW1DveTv5X0HyaLUiF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WBPVidq5PxfWqdvYqYBmGNL0xYBR7tV83PBgbvXq0eRx7KOtUYfG0TwFOkDy/IYdi
	 8eUB1AaUTnf5lRtfNPGY78h97HbjHsDlgY7+CHaZgPko0JE+NAGeu5rcaJeTsva2pH
	 AuC23glZFOpQwVKgTFOuPfa67MbYxVi0sJ1niH+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGMDNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:13:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41444 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGMDNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:13:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so13318505wrl.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLnrLBJ5kAqFkLfTkdCmiKFDQ8GCKWsQrIBx+rJIfFU=;
        b=t7JemFm0Xh0U257Q2Fhp5VnRJfRNSGyoLDCJ/PZ+rWizpXTzH5qnwjp6ZxV1vd/fQV
         cn219BmFvuCaddOhcVo+1FxOgR6BgShMnBqJw+mSPB3E0DU1Nm+sVn4j4zRwm7rbkdcl
         aMsH+tNjB09J7kLexmrtOXvKuMON8XsJScnKd2CYCB9NQhjb+Z0YlwdB0myC3GNjdqOr
         tqbjdYAOtnaaCzEnuGLcmqYWfGxgSAbI/qnu127es/2DCKx8sDMefaCm5LILund1cN+w
         VJhG/xDA4Feg2+EaKZdJ/I7mtrEdbY8Ok9mC6hPv83V3cX2nY+RPUP5zr1ikJ65tBAkA
         8DgA==
X-Gm-Message-State: AOAM5327l+Xj7WjeCTDct/dZbhEttswo3JZ5HagxFV+zvkSy0Ulb6tCu
        GQmNXc3emZbxwxYmISNvmHapZ9+/fkTqhpyHJHE=
X-Google-Smtp-Source: ABdhPJwCq3z3JxOjbqdlgYe/7N/SWf315ySdmztrM4Ob5tQwBds+NoFzYglmQvb1F7rSfVd21aRabkFnXuMrQX2Hvg8=
X-Received: by 2002:adf:e901:: with SMTP id f1mr77862227wrm.80.1594610025296;
 Sun, 12 Jul 2020 20:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com> <92aa73c7-4148-a45d-6964-983fe1654d1e@linux.intel.com>
In-Reply-To: <92aa73c7-4148-a45d-6964-983fe1654d1e@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Jul 2020 12:13:34 +0900
Message-ID: <CAM9d7cj86U7xcmAdiKjEKNp+qS_YAP72xKusAjLWGo2frxpL_A@mail.gmail.com>
Subject: Re: [PATCH v10 04/15] perf evlist: introduce control file descriptors
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 8, 2020 at 4:47 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Define and initialize control file descriptors.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/evlist.c | 3 +++
>  tools/perf/util/evlist.h | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index bcbe0cb8482e..36eb50aba1f5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>         perf_evlist__set_maps(&evlist->core, cpus, threads);
>         evlist->workload.pid = -1;
>         evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
> +       evlist->ctl_fd.fd = -1;
> +       evlist->ctl_fd.ack = -1;
> +       evlist->ctl_fd.pos = -1;
>  }
>
>  struct evlist *evlist__new(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 38901c0d1599..2caf19fb87a8 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -74,6 +74,11 @@ struct evlist {
>                 pthread_t               th;
>                 volatile int            done;
>         } thread;
> +       struct {
> +               int     fd;
> +               int     ack;
> +               int     pos;
> +       } ctl_fd;

Could you please add brief descriptions for each field
in the comment?  It's not obvious to me other than fd.

Thanks
Namhyung


>  };
>
>  struct evsel_str_handler {
> --
> 2.24.1
>
>
