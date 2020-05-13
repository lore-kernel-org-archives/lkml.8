Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F6CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6562C20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdEwm2cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbgEMOIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgEMOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:08:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A044C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:08:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so13442115qtt.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKMxLrMImHpihipagkeEtVhqmNLGnx4qu2/FD8xcA6o=;
        b=sdEwm2cIdqOD3iWIoQS36r309tWKQGDjXMzsI45DrA1kBFEijMoCq0pzDXKebBvrrr
         uq+2t4DDsZRUmbKJWeb86uOmadZf0klvmmwtnYP5sk5cVJcPbfUh5F2wGnIfBs9Fv3Qr
         SXuWn+xSDTphAnQ3F1GiQZeJ4Inpy/NsXWJUgm9u+FK3TQvQwwJyiTzXv9uWTD3QOP03
         7C8jzcaMv8xH5EDGbPn5Cg26VRcMyEwv7mEvQmXCLW91oa5G3Tcwy8EdhVmAzQ6Zzt37
         qXiZZwQERfa7CRTBfSZEfGyLDWZ03qq8hGbXBei8ML6le7DXrRu3ftrr15syMOh+S2BQ
         oabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKMxLrMImHpihipagkeEtVhqmNLGnx4qu2/FD8xcA6o=;
        b=lUJD0FL2WIJgmMpj1ZnjRcsRPo111HZztkmEx8+V0MsTfwQzgQN7w8Gkqf2rJiPVk9
         Hmxs7F8nEiAP7Zmx/V3chjUbG6TpNKR7V3ZYxZteh9DqvJix6pnIArCETG/4yWYcFSv7
         2PSOL7dCzCmByIZ9FUlDAeXnHR5sxglIN1+kjrYwhw6DlPsCPzeV+980FgPXjjYf6UEX
         DvGF6c091RyU39lNTJ+TAtIoE9Q1iFqqHKvpF3UVLZ4KcIbMLWn6OD7qeg8kTMwRD+NK
         ClsjSOMfMlQHrZHC9xpzmW6H8LzcTKPbY9QtRmgCxSP72WIh2eKcSHN1JYE0U88+KJzx
         sgIg==
X-Gm-Message-State: AOAM532liTP5sYfZex9ATVdqFZhsNDTwu3TP8hTXnZkGVtGIOpd1g25m
        rxHsFRCJbhwM3m/8wz3dPYg=
X-Google-Smtp-Source: ABdhPJxlNbjMFQymgJkPyFZKqH7HW1GZjGi67EVn77gxCgfGM07PaE6R9GLqKAoaeGFoHvzEWc6mrQ==
X-Received: by 2002:ac8:1af3:: with SMTP id h48mr2081144qtk.371.1589378926205;
        Wed, 13 May 2020 07:08:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 28sm14048460qkr.96.2020.05.13.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:08:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8596E40AFD; Wed, 13 May 2020 11:08:25 -0300 (-03)
Date:   Wed, 13 May 2020 11:08:25 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 4/4] perf expr: Report line number with error
Message-ID: <20200513140825.GG5583@kernel.org>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-5-jolsa@kernel.org>
 <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
 <20200513113424.GJ3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513113424.GJ3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 01:34:24PM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 12:09:30AM -0700, Ian Rogers wrote:
> > On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Display line number on when parsing custom metrics file, like:
> > >
> > >   $ cat metrics
> > >   // IPC
> > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > >
> > >   krava
> > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > >   failed to parse metrics file: ./metrics:4
> > >
> > > Please note that because the grammar is flexible on new lines,
> > > the syntax could be broken on the next 'not fitting' item and
> > > not the first wrong word, like:
> > >
> > >   $ cat metrics
> > >   // IPC
> > >   krava
> > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > >   failed to parse metrics file: ./metrics:3
> > 
> > A line number is better than nothing :-) It'd be nice to be told about
> > broken events and more information about what's broken in the line. A
> > common failure is @ vs / encoding and also no-use or misuse of \\.
> > Perhaps expand the test coverage.
> 
> yep, error reporting needs more changes.. but the line is crucial ;-)

So I had started processing this patchkit, I assume you will send a v2
and I should drop what I had processed, is that ok?

- Arnaldo
