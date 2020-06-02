Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF21D20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098632;
	bh=/FFBEJBvLLUN1ASqlYN7NyXi+TisjmUHsggbGnlp6P0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0ayRBJ9vPWjx/1zIvemKLa/d3DPIIkriz59RycP7/yB/4YQSzDSQQxkryPiPEkThe
	 wLlABeLGgc3MuXOtqZGjE4YIpUqmxAUp2riH4hToeEeGZ5ouB/JitEkgrN9Dy/3qIU
	 Vaz6JUWzZqmybETBx0d0N20kOUQpK4EDEGQNj+kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBLub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:50:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34424 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:50:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so3120155wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 04:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kmAT8l4yxXPHwQROzZlDZxhf3oO5Z1m1PUuVX32Y3o=;
        b=HLCEWVFQ+60bKkD25NoHf2Jdl35fgIatnvfqtEWZ8imoP3vL/vxQl9iGgTsee7csYc
         7RQAsMscksI3NxiJUEojxm4vLLXVJAfDPUlEWPC4hFkoQGCMVWNbfBoJgegZhUA8X6v1
         yfh+J8ueICko/CUPftkYW53t+DkDEIsqMjX4ncUqSS96DTtOL6OfbGD9/m1LZtnvJD8k
         9k1Ns6OIekBYCUf0/n6angkwY5Sab65IX4Fjh2Yei9VbYLQxACaWmQqts7glo6CYcoxI
         1AKC+CYperIKM+02awJBfg0MWI3xyK+x8MdVTRRniLGYDYOQbDUL6gtOEyr4/WCSyWhx
         DiwA==
X-Gm-Message-State: AOAM533igHibReHudEE1gr2h5ogiGZ6rHNXCvny1G5X4Xq+Ny7Z1SX3b
        iewYN2pLG5CqXWGKI+NjKFGUi1y46uKIYQHMLi8=
X-Google-Smtp-Source: ABdhPJzyyqDuo6Q+3JXP8CrIU8gOuCPWbHpRtPlr5KtBwRcesrX6A2wafAtik2FrPCmh0EnSzpRPc2zmpjDmQy95oog=
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr19226030wrx.391.1591098628253;
 Tue, 02 Jun 2020 04:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200531162206.911168-1-jolsa@kernel.org> <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava> <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <CAM9d7cgw+h9xC08hEErnQnqZjfN1bJWu8psGsUVicWoXWSWcLQ@mail.gmail.com> <20200602081551.GC1112120@krava>
In-Reply-To: <20200602081551.GC1112120@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Jun 2020 20:50:17 +0900
Message-ID: <CAM9d7cgZYjCkrFtpcKr=QHrLY6PkOx6CODBiH8fmoFqEcBXKeQ@mail.gmail.com>
Subject: Re: [PATCHv2] perf stat: Ensure group is defined on top of the same
 cpu mask
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Jun 2, 2020 at 5:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jun 02, 2020 at 11:47:19AM +0900, Namhyung Kim wrote:
> > On Tue, Jun 2, 2020 at 1:21 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Jun 1, 2020 at 1:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > Jin Yao reported the issue (and posted first versions of this change)
> > > > with groups being defined over events with different cpu mask.
> > > >
> > > > This causes assert aborts in get_group_fd, like:
> > > >
> > > >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> > > >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> > > >   Aborted
> > > >
> > > > All the events in the group have to be defined over the same
> > > > cpus so the group_fd can be found for every leader/member pair.
> > > >
> > > > Adding check to ensure this condition is met and removing the
> > > > group (with warning) if we detect mixed cpus, like:
> > > >
> > > >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> > > >   WARNING: event cpu maps do not match, disabling group:
> > > >     anon group { power/energy-cores/, cycles }
> > > >     anon group { instructions, power/energy-cores/ }
> > > >
> > > > Ian asked also for cpu maps details, it's displayed in verbose mode:
> > > >
> > > >   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
> > > >   WARNING: group events cpu maps do not match, disabling group:
> > > >     anon group { power/energy-cores/, cycles }
> > > >        power/energy-cores/: 0
> > > >        cycles: 0-7
> > > >     anon group { instructions, power/energy-cores/ }
> > > >        instructions: 0-7
> > > >        power/energy-cores/: 0
> > >
> > > This is great! A nit, would 'grouped events cpus do not match' read
> > > better? I think the cpu map is more of an internal naming convention.
> > Allowed cpus?
>
> hum, what you mean?

I mean that we can use 'allowed cpus' rather then 'cpu map' in the message.
Something like this?

  allowed cpus for events in a group do not match, disabling group:

Thanks
Namhyung
