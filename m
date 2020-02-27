Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C14C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381852468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maOSf5TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgB0Nqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:46:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgB0Nq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:46:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id m2so3114348qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNKG4+F+LTFwpzpyT4+p3VzII4Y7Yin7L8vMm6TuNbw=;
        b=maOSf5TOiNL1jUWavOPbZlor+ttx5R8cCBG00EGM+fvyjeh/hhhD+/1DSlj/eYNsWK
         WVpUc8Gnhyw9KLH0S4KS9NQTS574W5iLNgyBfk5UeMQxVUntv8VpJIljeIKxrhDC69K6
         VMzj+fJiWy4OPLtTIEBUqxTp18PMMgiceIjIIh1PBdlsse8e6tipJqBeFpt6064bFygX
         C5GeFgq+8rTsbexcZHFXb8O/OBND9+di5yo/8NQukf2628xEuipl5eI/ARRBBAYZbc7p
         tG0deKD8A594XAYjujjDIqN3ULVWJkvsEt+jsJxuoiXtYDQAgZHE0nPUTFJbvtGn9h9I
         KE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNKG4+F+LTFwpzpyT4+p3VzII4Y7Yin7L8vMm6TuNbw=;
        b=I/WFSYVTQiGuiar5LEMI0g5CW3qCS1fxY6cUM2jLsei5M/rhdhUEdvyv2ASadkrLl3
         IzXFfsdTG1tdE/wd2LN+pRIrN/lp8DA3qcRA5TdT6PAPbJ1glRpIm0zzk0JVKH5sMY8C
         L3N9UUq6j0QFbFNlwlRttjHsBstP5eNO1sCKMG0gTaxf1C1ptODwnlssJm4mKp9zblux
         XWy/QcHJFc4P7YCVgFXvwwpMQrJgXtJaoJo7k1X4kBWfAWpowMdjf+BUo1bAxdhHwyUd
         7DAklAeL1/0VNA6+rUcCylRvs3/iq/BmcG1QsmUyFLU+x6FDswVJEG1ZILlUalzqN5/3
         FayA==
X-Gm-Message-State: APjAAAVl5K+jjy1jqMZexOvcmb6g0M2oaJAo8wULCUSGEOyOCTA7h9Uu
        fP3Ba5FjMujAuMnstSkiLKz6wMrI0vg=
X-Google-Smtp-Source: APXvYqwTXYO/dGTkYStT+f8k8DCyX8/tZWe8TV+b8BPI+P1ZHK+GNkivO4qRMgToUEjiu63WEqhEXg==
X-Received: by 2002:a37:6c9:: with SMTP id 192mr5356300qkg.25.1582811188307;
        Thu, 27 Feb 2020 05:46:28 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v82sm3129067qka.51.2020.02.27.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:46:27 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B8485403AD; Thu, 27 Feb 2020 10:46:25 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:46:25 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCHv2 0/5] perf expr: Add flex scanner
Message-ID: <20200227134625.GC10761@kernel.org>
References: <20200224082918.58489-1-jolsa@kernel.org>
 <20200227121000.GE34774@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227121000.GE34774@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 27, 2020 at 01:10:00PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 24, 2020 at 09:29:13AM +0100, Jiri Olsa wrote:
> > hi,
> > while preparing changes for user defined metric expressions
> > I also moved the expression manual parser to flex.
> > 
> > The reason is to have an easy and reasonable way to support
> > and parse multiple user-defined metric expressions from
> > command line or file.
> > 
> > I was posponing the change, but I just saw another update to
> > the expr manual scanner (from Kajol Jain), so cherry picked
> > just the expr flex code changes to get it out.
> > 
> > Kajol Jain,
> > I think it should ease up your change for unknown values marked
> > by '?'. Would you consider rebasing your changes on top of this?
> > 
> > 
> 
> kajoljain found and issue in this one, I'll send v3 as
> soon as he confirms the fix

Ok, I'll hold off processing those patches then, thanks!

- Arnaldo
 
> jirka
> 
> 
> > v2 changes:
> >   - handle special chars properly
> >   - fix return value for expr__parse
> > 
> > Available also in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric_flex
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Jiri Olsa (5):
> >       perf expr: Add expr.c object
> >       perf expr: Move expr lexer to flex
> >       perf expr: Increase EXPR_MAX_OTHER
> >       perf expr: Straighten expr__parse/expr__find_other interface
> >       perf expr: Make expr__parse return -1 on error
> > 
> >  tools/perf/tests/expr.c       |  10 +++---
> >  tools/perf/util/Build         |  11 ++++++-
> >  tools/perf/util/expr.c        | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/expr.h        |   8 ++---
> >  tools/perf/util/expr.l        |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/expr.y        | 208 ++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------
> >  tools/perf/util/stat-shadow.c |   4 +--
> >  7 files changed, 272 insertions(+), 168 deletions(-)
> >  create mode 100644 tools/perf/util/expr.c
> >  create mode 100644 tools/perf/util/expr.l
> > 
> 

-- 

- Arnaldo
