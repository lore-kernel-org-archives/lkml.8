Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED402137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8StPHa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCSOHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:07:09 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44884 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCSOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:07:08 -0400
Received: by mail-qt1-f181.google.com with SMTP id y24so1820795qtv.11;
        Thu, 19 Mar 2020 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdeaYYBfZlT1xYUHd26MRFrRt9KEfvL1onkmyw+4xTc=;
        b=F8StPHa0DXeINnvt7XXdUu3vfuzCHzw/q5QED5DuC9GVL5vIlTxZ057HvcIUL8kNml
         o0XMPt8jbJsqXrM+pkMyGW1u0tZc93RHWJsvrqTRVDVAOO41lZtB15fKcnoM/KJpiu2S
         tW2L9KFnrkXudCOufZkuILtXiXQAuair3f79sRtx8+NuGkUR3UiB4RJDNA/DxCmCLia2
         q8017nnf0jS9maOGl076hvZtjj71otVPArUQdK9VA8ef+BqqjE69BaeAie63aA7h+jUC
         tOw19i4PNtB0ommhNCuG4FbeWo2KRb1R7qSK7WwTKnsqFfu6BDePmnSfroicp5RUs/td
         /iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdeaYYBfZlT1xYUHd26MRFrRt9KEfvL1onkmyw+4xTc=;
        b=ZrhKjwJuOoIYGfe/t7lAUzsf/ZyrL9Ryp1zoTSHoaRp3HThXEhIhBlamaQNnHdfcQm
         SLpIwyADnBC+dveHF5RZj63hb6hJH1Gi7ecVZZNHbHRk1j7fKHFEvwVyY3vpJIqyBjLR
         xYSzZxI87WcjXY9EvCgTMgO0OPRIctAbqP53nEpWNZqoA2HycUH7V9lUIKamnpIVXlGA
         E+nQ9UOypNnFngpGm015ckQK88bnR4QEtC79fTz2mIP68yY9ILt8SMgbsCspKWm/yPac
         og+N2FdSLrLPgbby8iDRHDczwJgVmo4i0BadWyza3UVhQCzgihsWp5HxeO0SyDtLuPnl
         +rOw==
X-Gm-Message-State: ANhLgQ2Jsr7FJ/2+H2niySCClqelldFP95hNXiM7iw2kiGqsgLC0ILkc
        vtst4+ZZF4Ee6dOqVzSenIM=
X-Google-Smtp-Source: ADFU+vsEwBUBlanCAYLYUw6EvkJN/q4YXeJFafD7hFVQMtLb28DsXo/MtSiupJ5GtPo+HPCzJmSVUQ==
X-Received: by 2002:ac8:12c8:: with SMTP id b8mr3005401qtj.60.1584626825978;
        Thu, 19 Mar 2020 07:07:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 128sm1574928qki.103.2020.03.19.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:07:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D610404E4; Thu, 19 Mar 2020 11:07:02 -0300 (-03)
Date:   Thu, 19 Mar 2020 11:07:02 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        disconnect3d <dominik.b.czarnota@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200319140702.GA14841@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
 <20200319140338.GB52834@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319140338.GB52834@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 03:03:38PM +0100, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >  32 files changed, 1340 insertions(+), 1123 deletions(-)
> >  create mode 100644 tools/perf/Documentation/perf-intel-pt.txt
 
> Pulled this and the previous perf/core pull request into tip:perf/core, thanks Arnaldo!
 
> (You might want to double check my conflict resolution with perf/urgent, 
> to tools/perf/util/map.c.)

I'll check, thanks for pulling the outstanding pull reqs!

- Arnaldo
