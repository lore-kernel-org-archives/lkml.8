Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E12205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO4j4Tz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgEMPOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgEMPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:14:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:14:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b1so116793qtt.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SECExaF68jqsgwvUFVEH9etxfDpHjfhtHYaCcot2wVk=;
        b=WO4j4Tz6G9DKujlJMO41xMTBanh0Ki5ICFQzNhOvQPbqQixEid+Xyd4E/7YmQoCTMn
         PYcq9+VR55SGw9E1bL9Xu61n9Jpes+XG3qu9uZPo11GJRudAoACDlqgIzRRRo8N039FP
         JjhJ524I8jfZveYilb/aREvP+KxeylZWFij5lQIWLDVY/aR1vctOMBW5KfhJvDQYjWvg
         rx9aJH4dqL24QVYCt7uKrGjs2cIHv8faYb/mpYO14n6kLACmT9wStdsp+b/21RTyC9Yu
         QwxHPur75ojTqVON5BcCzL5yCJ8DepyNaonRsNL7obJ9TcvRhkRZ6ehvNFfhY7o3kIsq
         q+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SECExaF68jqsgwvUFVEH9etxfDpHjfhtHYaCcot2wVk=;
        b=VMEAxSOIWZo17cn8/qKzfzfDF4OBcY7oK5ZEvl4qIb/r53sY0DhZGjUq7n6NA9bL8b
         g70QdLA6s33qbF5HdVugR1F9dvrvlaAdVj0FW9Cw7zyM6N77LhPQJhU7digwZWv41Cl8
         /Rm0Lqu5VVQ/mWfnISEP916qgx57yuk5V+w4wuH9RiSA3P/R3gg+TsP5MOybll10a4Zv
         kSG0IngHTeKVqLafgq6pcGF4Mo5hAplsju6FByE04T4CDNxLPXJTmaqsiLeXk6HbTgJ0
         x64u5tP2btkSzh+27PCxxwjIbNvpmIQ49QWQCJ052sIPPCNCgbm1Qvi3LugKL8x3gv5H
         BmnQ==
X-Gm-Message-State: AOAM530u2dlNo6PFWgxd56695IkA+nfJ3GtOoidz0uhs1kSFYJf2oCtJ
        yqKyslsWmXFK4VkKle7qUu8=
X-Google-Smtp-Source: ABdhPJz5j1QkBCEXgF20vGxJ9SGN2ED3hSkK4Ju8DCGNhZT9gc+4PqAABFHnL52Cw7yGBIJ4010wjA==
X-Received: by 2002:aed:34c2:: with SMTP id x60mr13530226qtd.156.1589382889664;
        Wed, 13 May 2020 08:14:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a24sm11780294qto.10.2020.05.13.08.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:14:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25D4A40AFD; Wed, 13 May 2020 12:14:46 -0300 (-03)
Date:   Wed, 13 May 2020 12:14:46 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200513151446.GC7216@kernel.org>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-5-jolsa@kernel.org>
 <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
 <20200513113424.GJ3158213@krava>
 <20200513140825.GG5583@kernel.org>
 <20200513144610.GM3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513144610.GM3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 04:46:10PM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 11:08:25AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 13, 2020 at 01:34:24PM +0200, Jiri Olsa escreveu:
> > > On Wed, May 13, 2020 at 12:09:30AM -0700, Ian Rogers wrote:
> > > > On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Display line number on when parsing custom metrics file, like:
> > > > >
> > > > >   $ cat metrics
> > > > >   // IPC
> > > > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > > > >
> > > > >   krava
> > > > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > > > >   failed to parse metrics file: ./metrics:4
> > > > >
> > > > > Please note that because the grammar is flexible on new lines,
> > > > > the syntax could be broken on the next 'not fitting' item and
> > > > > not the first wrong word, like:
> > > > >
> > > > >   $ cat metrics
> > > > >   // IPC
> > > > >   krava
> > > > >   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
> > > > >   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
> > > > >   failed to parse metrics file: ./metrics:3
> > > > 
> > > > A line number is better than nothing :-) It'd be nice to be told about
> > > > broken events and more information about what's broken in the line. A
> > > > common failure is @ vs / encoding and also no-use or misuse of \\.
> > > > Perhaps expand the test coverage.
> > > 
> > > yep, error reporting needs more changes.. but the line is crucial ;-)
> > 
> > So I had started processing this patchkit, I assume you will send a v2
> > and I should drop what I had processed, is that ok?
> 
> yes, I will resubmit on top of the other expr changes
> we have now pending

Ok, I removed those from my local branch, and pushed what I have, which
includes a few more fixes from Ian and others, continuing to process
other remaining patches now.

- Arnaldo
