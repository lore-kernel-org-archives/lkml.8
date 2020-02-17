Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F4C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5724658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581967340;
	bh=e5ynq68K7XvQCy1SpM5+Di9nf0iC5AyuVQV2dGoHBPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W39X7BBRtEceiv8FwGbvubW76v/A6ZRNJZk58BLKQOgylM1iSzYn9yZVFkPv4shFE
	 jTnHYAmoyQelHrsyyFU0DUH0HAoJ6tgeUp91WdC+pFgL3DBdvN/CjyRWurc/9BqI1v
	 8XAuaOJmvWPAwAT/aiy1wden9B9mwx2vlGQpkG/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBQTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:22:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgBQTWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:22:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so21111904wrt.2;
        Mon, 17 Feb 2020 11:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQu0c/96h+gGpCGNJWP56GTqSBWJTi+tOW85OAlEpGo=;
        b=PksRAbLi1ZtOjbgdvz6tprUvq0f6OpowU9ojiYRPaIU7F5N0YwIds7pS0W5SpRcfQJ
         C51PXqT4fNTOL72d9EnFQYOTWTesf/7xskdHY0Toi1rTWHnu6BGc687KUXSIxf0sJvtI
         SczJccJToC7TrkDTj6nU2r6s3/nysU1G/R92bJYF/QcgfaktpM3zA4CEsahoGrGu9erA
         kLmtuJRGiGJhmtNbTb9wqnE6QNZ+ROF99DKndBgk2RkyMTcjAN8vHBd/++IVUApNcpa3
         UBQskXwgulPfvGSd+V+xc0XiaLf/tnSF8+nC8F+yKB7/krGzfApDFcCKzL7XIDEnQFR7
         Bwbw==
X-Gm-Message-State: APjAAAUvJsaEX6f3ao6fcD4Qw71mJviL4lMt/pSDchNOHU+ShfnQ87VH
        mAo/wu/p4yzakguWHhVMa8//WJr+PqNNRnXtPCU=
X-Google-Smtp-Source: APXvYqzje049VqM8Uvs3YZgtldZLuL23bcp8xq730hDgZyw6hmDMsr2PamxYJgibsaPwTngrk4GnMvr+nAJ2rKs0gHw=
X-Received: by 2002:a05:6000:c4:: with SMTP id q4mr22678321wrx.332.1581967335660;
 Mon, 17 Feb 2020 11:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava> <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
 <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
 <20200121094246.GA707582@krava> <20200217154604.GE19953@kernel.org>
In-Reply-To: <20200217154604.GE19953@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 17 Feb 2020 11:22:04 -0800
Message-ID: <CAM9d7ciaNNJFxVPeCHkwkshDccbdYc2MMzM7+-eD_AVBnRM-aQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Feb 17, 2020 at 7:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jan 21, 2020 at 10:42:46AM +0100, Jiri Olsa escreveu:
> > On Mon, Jan 20, 2020 at 10:57:47PM +0900, Namhyung Kim wrote:
> > > So I tried this but then realized that it's hard to get the perf_env later
> > > when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
> > > I also checked maybe I can resolve it when a hist entry is added,
> > > but it doesn't have the pointer there too.
>
> > looks like there might be a path for standard report where hists
> > are part of evsel object:
> >
> >   'struct hist_entry' via ->hists to  'struct hists'
> >   hists_to_evsel(hists) to 'struct evsel'
> >   'struct evsel' via ->evlist to 'struct evlist'
> >   and there you have evlist->env ;-)
>
> Hey, recently I did work that ended up adding a 'struct maps' to 'struct
> map_symbol' and then hist_entry::ms has it, enough?
>
> i.e.:
>
> hist_entry::ms->maps->machine
>
>   he->ms->maps->machine

Yep, that's enough for my use.

>
> > however I was wondering if we could add 'machine' pointer
> > to the hist object, that would make that simpler ;-)
>
> Directly from one of its hist_entries? As above?

Right, any path from hist_entry to perf_env would be ok.

>
> > not sure about the way.. would be nice if that'd work for
> > both evsel hists and standalone ones like in c2c
>
> > but maybe just some init helper that sets the pointer early on
> > might do the job
>
> Sorry for the delay in answering, was travelling/vacations, now taming a
> huge mailbox :-\

No problem, I'll send the next version soon.

Thanks
Namhyung
