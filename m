Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E301C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF7920849
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boXYK+gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOQng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:43:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:43:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so2482473qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O2iqJ8KQcZDCTc9y6KB4+QJ4upFjWYXxi/TwEeRaUVo=;
        b=boXYK+gwglwO9n0Wi0Vh9KYiXI/hyUq7NVa8NqLzdNyA4/HucC05wZQJu3ZG5TwRKM
         m68w9gsFgwLrLA3rjbEnFEPeo+fKoiezd/rd8D1s2euwBB1hgVH0Ma8tMviuiTTpkD4W
         Tk2dp8qewFd3z5vd2dKw3bVeD6XMSqklEZmyPIWT50+IeaRQhmaISX7KV8bRPEv/hqwF
         fmMVONMdSalRkLw9Z3P4Atp6ddIBJ7lgF2XTs283vTtsx70PoKAak73QaCwKLNNNJvzD
         UXW2+9lWDM1EyLT2Xf/31G5wLybv0snRX7p/WAEqOXGg1jAWptiHYs7K9rM0W739bXCG
         V7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O2iqJ8KQcZDCTc9y6KB4+QJ4upFjWYXxi/TwEeRaUVo=;
        b=n6cK05Ym0TZKk/2NePCEmzaxi9O5QS09lewkl9LB22lDAWMtjEOCXO8shhHgRhjByA
         Yba2KIKHICrZz2RS35VcurofQwi9keBAocOQnIQA1toOPJj8db7wMzxq7aTFahJr+eZo
         ateH8+gtOzVc1NaghabvT5EEh8g2st+JYwMKoAiWp+vx9nagDYRmKTLrnllNF9RgfnjT
         ZxfsYk7lf4/i5tPtNBzouMngAsRB36Fj82vUbqbem08npwhZmvDQUwcEMF8L8xF+ANFI
         ac3ZQR2qWgGMHVVuhtSmtle9ztMbfzVVytu0ZkKpIalyjhN077dmDctBraQBjxXQP0GI
         L08A==
X-Gm-Message-State: AOAM5310ghV6tWBMtfZG1FxGGJr+VuEm6YvnHw5H94sA3thXwbvGfUYU
        ZHWg80zFdweemKcEoFq6AyE=
X-Google-Smtp-Source: ABdhPJxjvVPL/hbo4sp5d8UNeHn7+/aj+pTxfFp3wyHR1MXqIFSw3iOzCKsi17s6o/H5cwzj3qPuTg==
X-Received: by 2002:ac8:c0d:: with SMTP id k13mr4538302qti.136.1589561013697;
        Fri, 15 May 2020 09:43:33 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y140sm1951030qkb.127.2020.05.15.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:43:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36B1540AFD; Fri, 15 May 2020 13:43:31 -0300 (-03)
Date:   Fri, 15 May 2020 13:43:31 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200515164331.GE9335@kernel.org>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor>
 <20200515164153.GD9335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515164153.GD9335@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 15, 2020 at 01:41:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 14, 2020 at 07:10:25PM -0500, Gustavo A. R. Silva escreveu:
> > On Thu, May 14, 2020 at 03:46:05PM -0700, Ian Rogers wrote:
> > > On Thu, May 14, 2020 at 3:04 PM Gustavo A. R. Silva
> > > <gustavoars@kernel.org> wrote:
> > 
> > Yep. I just built linux-next --which contains all the flexible-array
> > conversions-- with Clang --GCC doesn't catch this issue, not even GCC
> > 10-- and I don't see any other issue like this.
> > 
> > I mean, I have run into these other two:
> > 
> > https://lore.kernel.org/lkml/20200505235205.GA18539@embeddedor/
> > https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/
> > 
> > but those are due to the erroneous application of the sizeof operator
> > to zero-length arrays.
> > 
> > > complicated stack allocation I suggested. It may be nice to save
> > > cycles if code this pattern is widespread and the code hot.
> > > 
> > 
> > Apparently, this is the only instace of this sort of issue in the whole
> > codebase.
> 
> Adrian Hunter was not CCed, Adrian?

Gustavo, I've removed this from my tree from now till this gets
resolved.

- Arnaldo
