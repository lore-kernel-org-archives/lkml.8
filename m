Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827FC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpnMtZPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBQPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:46:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37229 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBQPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:46:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so12306980qtk.4;
        Mon, 17 Feb 2020 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sDxoW8+9czRBbEFQzBHeiOSVKv/rAbdRDyu3nztPdI8=;
        b=qpnMtZPSHlz6gufUUDG9XI9/sUpT50605WFK27+cPhKw30vOvKTB38b4TI0oSSYFfW
         jOVdGZI/WmOp0sy73x/wJJT5Au5vH6IB8mLb12tRvA4r42BijZzp06piz4Wp2ORPq4vx
         mTvgnl1Y4BExg1mzzh/SgS52JInUzSQwYfT7A5bcSnNvGWALYhu+UerlL2Y+nc9FN2xc
         lF/MJbFaqNNg25Jf8b81zVpSDRfp3g6FWWD8vpXpp+nwfIejz1Es+HOCbRiMi6UjFttQ
         DzZ2ErwludDpp5w/FQMNpULNhWy03qGtwoMIvk+V1/3ljbxfsh1hS4GxNMAH718FkZZL
         LI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDxoW8+9czRBbEFQzBHeiOSVKv/rAbdRDyu3nztPdI8=;
        b=cllMYvWmYbjaTcgKyJAUo3doGZxnmAvSXsdDXtZl/9v/l1oI4Iuooe7EpTpG5c+QlU
         7HAmg1vSw8aakfvnVZWyQiXDD/wE32Mgqzdz6EFMgOvqWE+0Tb2t5RpDX8bTqJOsz+Kf
         z4DcYzIRi6ybXeLcMJQjPn7i3AfkZLGtyebTiUmv7IiwssheDtkHXuJWgJba5z+kWRRH
         pMCmDMkjvaznJJ81qvduJoEGn1ucjw2UxdXnJnlz6wDVVWway4EmU+hGFBf+drlV/jc/
         9Q03h46CloSRi0YffcKroOwyY5jTxfEEZevaztKHoqDVhE9/Sj8Lqm+O94rFKSTwxMRH
         +epA==
X-Gm-Message-State: APjAAAX2i/0F0VpnxTZomALywvPE/c6gfnxTFZEl+ygMyie4ymv1BGsr
        uvB2QaWzZhkyb1Ft/+Ir+OU=
X-Google-Smtp-Source: APXvYqyBrEfOHNe+8AYXzm3NAXp40Xzohs1HyIF8vz8BZXC2x+zQCaVIybbZ9XApBL0XeiGW42JX9w==
X-Received: by 2002:aed:204d:: with SMTP id 71mr13906928qta.116.1581954367889;
        Mon, 17 Feb 2020 07:46:07 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o21sm389569qki.56.2020.02.17.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 07:46:07 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E77B2403AD; Mon, 17 Feb 2020 12:46:04 -0300 (-03)
Date:   Mon, 17 Feb 2020 12:46:04 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Message-ID: <20200217154604.GE19953@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava>
 <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
 <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
 <20200121094246.GA707582@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121094246.GA707582@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 21, 2020 at 10:42:46AM +0100, Jiri Olsa escreveu:
> On Mon, Jan 20, 2020 at 10:57:47PM +0900, Namhyung Kim wrote:
> > So I tried this but then realized that it's hard to get the perf_env later
> > when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
> > I also checked maybe I can resolve it when a hist entry is added,
> > but it doesn't have the pointer there too.
 
> looks like there might be a path for standard report where hists
> are part of evsel object:
> 
>   'struct hist_entry' via ->hists to  'struct hists'
>   hists_to_evsel(hists) to 'struct evsel'
>   'struct evsel' via ->evlist to 'struct evlist'
>   and there you have evlist->env ;-)

Hey, recently I did work that ended up adding a 'struct maps' to 'struct
map_symbol' and then hist_entry::ms has it, enough?

i.e.:

hist_entry::ms->maps->machine

  he->ms->maps->machine
 
> however I was wondering if we could add 'machine' pointer
> to the hist object, that would make that simpler ;-)

Directly from one of its hist_entries? As above?
 
> not sure about the way.. would be nice if that'd work for
> both evsel hists and standalone ones like in c2c
 
> but maybe just some init helper that sets the pointer early on
> might do the job

Sorry for the delay in answering, was travelling/vacations, now taming a
huge mailbox :-\

- Arnaldo
