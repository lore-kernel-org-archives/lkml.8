Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE6C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73724699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY8tEFLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgB0NIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:08:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42252 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgB0NIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:08:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id r5so2167624qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMEjoFHYMwpiWZR3yLwrNnJzcfFYDBs4BnON0P19ld4=;
        b=SY8tEFLW0bKuXkREn5UbrJ92eYIoqgHc7fhYpkeyLYJy4R6NqiR6phhdcfLMWR1KO3
         f2vnl9miSA8KYBLKJcuNS1Hb656q9y+Dhol6OKwZAu9TaTkSMTAP+8DjUa4tqAVJTD4H
         1LzadEw9cwH91yKexmvL5O767WSNas+Ef794Yae2JvcM3seeN2aJhQKvDP6XwAp32JZU
         37saAgkYyDO3zvprL7SJ9U67SN2tCqe1sjVkXfKsdH7VeLUBo8nRtm0EVSFdx7OeIEHR
         QW26zMCtsQoHiRswmUIZeFuzQCeWxw3llaeDAhxTJEFktxsMfIQN5Fj/9ezWyypeEuci
         WXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMEjoFHYMwpiWZR3yLwrNnJzcfFYDBs4BnON0P19ld4=;
        b=uHfYkG3Q+1fHxzhLtuxyROOo4lF8m5d83ZA2pw0zU5eqvcKOBE9JKd6mTKvrDj4GbV
         uzXQfY7sBTRktJ1ZqgRLJNiyLU6wcuv7q+NGF3WTV13Ebn7Q3d4Xx1+QfmTxNj+dFRZn
         xdscdlXvblnIj2g6SZLQsNpghK+7M+RR5L4ONQg9aHP9D2fZGD7Nbkoyd0UrpoRuZpdn
         D07hpQdY1s91OMJnpkn7irB089Y8CcRr3IiRb8fPar+EnIj2npehvEZCDCAbZDFeOkEV
         VEZzM+UHrgJnl3XqyjqfULH/EEFEwcxyY2T+LKd588HOYVrVZn47rosQrWdn33c0+jfX
         i1Tg==
X-Gm-Message-State: APjAAAU2DLVqwctcH5zM44tFnNZU0Kx0zuilgFsN4Akd5uKNTeIv1T9+
        XFPcTN8HHZdQTY+29cFJfeE=
X-Google-Smtp-Source: APXvYqwyH1rDu4ALGHSw53n0uoRvsvR1GavFvch/QSyQFWPkp4p7ZxmRwZQe/ZIcsr4w6tyb2GqV+g==
X-Received: by 2002:ac8:6b8d:: with SMTP id z13mr4916637qts.290.1582808929250;
        Thu, 27 Feb 2020 05:08:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i28sm3193993qtc.57.2020.02.27.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:08:48 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B19B403AD; Thu, 27 Feb 2020 10:08:46 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:08:46 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] perf annotate/config: More fixes
Message-ID: <20200227130846.GA9899@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200216211549.GA157041@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216211549.GA157041@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 16, 2020 at 10:15:49PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 13, 2020 at 12:12:58PM +0530, Ravi Bangoria wrote:
> > These are the additional set of fixes on top of previous series:
> > http://lore.kernel.org/r/20200204045233.474937-1-ravi.bangoria@linux.ibm.com
> > 
> > Note for the last patch:
> > I couldn't understand what intel-pt.cache-divisor is really used for.
> > Adrian, can you please help.
> > 
> > Ravi Bangoria (8):
> >   perf annotate/tui: Re-render title bar after switching back from
> >     script browser
> >   perf annotate: Fix --show-total-period for tui/stdio2
> >   perf annotate: Fix --show-nr-samples for tui/stdio2
> >   perf config: Introduce perf_config_u8()
> >   perf annotate: Make perf config effective
> >   perf annotate: Prefer cmdline option over default config
> >   perf annotate: Fix perf config option description
> >   perf config: Document missing config options
> 
> nice, I guess this all worked in the past but got broken because
> we don't have any tests for annotation code.. any chance you could

I'm going thru them, can I take that "nice" as an Acked-by? Have you
gone thru those patches?

- Arnaldo

> think of some way to test annotations?
 
> perhaps some shell script, or prepare all the needed data for annotation
> manualy.. sort of like we did in tests/hists_*.c
> 
> thanks,
> jirka
> 
> > 
> >  tools/perf/Documentation/perf-config.txt | 74 +++++++++++++++++++-
> >  tools/perf/builtin-annotate.c            |  4 +-
> >  tools/perf/builtin-report.c              |  2 +-
> >  tools/perf/builtin-top.c                 |  2 +-
> >  tools/perf/ui/browsers/annotate.c        | 19 +++--
> >  tools/perf/util/annotate.c               | 89 +++++++++---------------
> >  tools/perf/util/annotate.h               |  6 +-
> >  tools/perf/util/config.c                 | 12 ++++
> >  tools/perf/util/config.h                 |  1 +
> >  9 files changed, 134 insertions(+), 75 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
> 

-- 

- Arnaldo
