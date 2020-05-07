Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C0C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBAD2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdg9wP5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEGRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgEGRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:01:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E51C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:01:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l18so959397qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ILKrToxO+UBNmlrxuLlUxDvNDWnweAkbzoOMkJWXLME=;
        b=pdg9wP5KM7ZKV6dTvbkxLX3E5WWxtoAKqOdgnUp79WQEFK3CHDxR4QtQEct9xHdBNF
         BmpV/j0aXlde6ywVj9Vdri42sws2oDBmsIYhBjBWUJ6nl4twjVUgz3HTGky/QEE2Izzo
         Arx/H2kss/diOf4Nuq9VJCUyWnLFdWbz355iSwRRZR4xK27I5hPN28m2EI4NfSH6EHHs
         xqq/TeL9wX6la1DRoSAHm70bzS/guDghkv1Rx3DsH8trV08ErcOH9tXqqFFA8HQ23lpl
         s1sFfXqdWK8Typ/XkU1c3pZtHx9WN07FYJaGVkcnG1moQ0CnORcm3eEbR8QscHRDHU8F
         4QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILKrToxO+UBNmlrxuLlUxDvNDWnweAkbzoOMkJWXLME=;
        b=ZjC9cJJLsbhaZ9a7D2z50C0+27PoUKGN5HDw41+EjS5sakD7FN2sSFlhr8ERB3J16w
         nyY3TsMsZMDRrVIFdUYlygJFvnkwtR5aph0vUzS4y73b1fcBnFL5mfaAUzB3b9SZGhwv
         F5holUFgVQqYJyHCE0L47iHuYqF5c9lnL0S9FYLIXdXMaqHUG1A2hIq0km+oaYMA2hFW
         TrNM44YO+hnu/OH9ofPCswt5xsFsZSDCvbE0BYaYqspP0MXJCaoYdkuBQ0BfjQ6YDW2y
         N8YHSuzhZLNYuaHw1yVeerwwZjMdA29QoQiMnYxilZtBgllyWEFOffCUt1qKYBXHR/03
         b01Q==
X-Gm-Message-State: AGi0Pua7rVptEyV/UrUXS7yToHoZvMWzHemf0ILXLoCRtPN1lW4wuXio
        vh6Nn4u5ZDF5zVBnoG7XuEdbO8LE4UnZGw==
X-Google-Smtp-Source: APiQypIvs3QSh6QL9FnLcOAcr3fZGwrzXIlLdpM4dVBNAAJaMrEz6bn/rd5qBhcyWdRsRhBuGWgh0A==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr15648997qto.230.1588870899027;
        Thu, 07 May 2020 10:01:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g11sm4508711qkk.106.2020.05.07.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:01:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F77A40AFD; Thu,  7 May 2020 14:01:36 -0300 (-03)
Date:   Thu, 7 May 2020 14:01:36 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] perf evlist: implement control command handling
 functions
Message-ID: <20200507170136.GG31109@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <142da58d-7ff1-ea73-89e0-30342a710aab@linux.intel.com>
 <20200506202138.GF9893@kernel.org>
 <68696671-50f7-7602-fc64-7802a8eab29a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68696671-50f7-7602-fc64-7802a8eab29a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:32:53AM +0300, Alexey Budankov escreveu:
> 
> On 06.05.2020 23:21, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 06, 2020 at 09:19:22PM +0300, Alexey Budankov escreveu:
> >>
> >> Implement functions of initialization, finalization and processing
> >> of control commands coming from control file descriptors.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/util/evlist.c | 100 +++++++++++++++++++++++++++++++++++++++
> >>  tools/perf/util/evlist.h |  12 +++++
> >>  2 files changed, 112 insertions(+)
> 
> <SNIP>
> 
> >> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> >> index 62f259d89b41..84386850c290 100644
> >> --- a/tools/perf/util/evlist.h
> >> +++ b/tools/perf/util/evlist.h
> >> @@ -358,4 +358,16 @@ void perf_evlist__force_leader(struct evlist *evlist);
> >>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
> >>  						 struct evsel *evsel,
> >>  						bool close);
> >> +
> >> +enum evlist_ctl_cmd {
> >> +	CTL_CMD_UNSUPPORTED = 0,
> >> +	CTL_CMD_ENABLE = 'e',
> >> +	CTL_CMD_DISABLE = 'd',
> >> +	CTL_CMD_ACK = 'a'
> >> +};
> > 
> > Can we make this a string, I think we'll eventually ask for lots more
> 
> Like this?
> 
> #define EVLIST__CTL_CMD_ENABLE	"enable"
> #define EVLIST__CTL_CMD_DISABLE	"disable"
> #define EVLIST__CTL_CMD_ACK	"ack"

Yeah
 
> > stuff, like asking for a --switch-output snapshot with --overwrite,
> > reconfiguring events to increase/decrease frequency, etc, interfacing
> > with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, PERF_EVENT_IOC_SET_FILTER, etc.
> > 
> > This will also allow us to have parameters, etc, wdyt?
> 
> Being a part of this patch the extension will implement configurability
> that potentially could never be used.
> 
> Switch from int to string commands of variable length belongs to
> the patches also implementing usage of that string commands.

Well, at that point we would have to support both, i.e. the way you're
doing now with integers, and as strings, otherwise 3rd party tooling
(vtune? :)) using this interface would break.

I.e. this is like the syscall interface.

So if we have "enable" now we can go ahead and forever understand that
as "please enable this evlist", but in the future we can extend it and
pass parameters to it, to control how that enablement will take place,
perhaps with a delay, etc.

> > Also please since these are events that deal with 'struct evlist', name
> > them with the evlist__ prefix, not the perf_evlist__ one, as those
> > should be used with 'struct perf_evlist', i.e. the one in libperf
> > (tools/lib/perf/).
> 
> Accepted in v3.
> 
> > 
> > Right now this is inconsistent, we did it that way to minimize
> > disruption of the codebase when moving things from tools/perf/ to
> > tools/lib/perf/, but this confuses things and I just did a
> > s/perf_evsel__/evsel__) for things dealing with 'struct evsel', so lets
> > not add new ones with the wrong prefix, eventually we'll have perf_ only
> > for things in libperf.
> > 
> >> +
> >> +int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
> >> +int perf_evlist__finalize_ctlfd(struct evlist *evlist);
> >> +int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
> >> +
> >>  #endif /* __PERF_EVLIST_H */
> >> -- 
> >> 2.24.1
> >>
> >>
> > 

-- 

- Arnaldo
