Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE8B2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttmpqzxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgC3QnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:43:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43784 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgC3QnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:43:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id o10so19641180qki.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCVs/i11H0dtezihW3UlZC+joCyx1llzbjRBIW5eZ7s=;
        b=TtmpqzxtBhnzjVkrxsdilyc81zeZNJ44Lo+cpNwot4XLY6K2XvgFO96DnO5AEoSulz
         J22I0VUpDOTZovvjn/0Unz0i9nTrYdOZxDI++9GYiiN+i3oK2Owm3n+Wo3wlrvvtQrvV
         OZqvjL9rXGtk9/gEXw9kr8moDyPI3+rmyT3OUYGaUiJAazqEscJxLdJtRxODyAX497wL
         gE1ImPHU6UWL4ZIsieho0qOghWvuUI1fB3L5S39MtlKmGVKEBw/U7ZbHuW9yu0TSdoaQ
         BVqJVMs87jt6oeY3iah3jQA+IOVtaJlxXt5SUd2dqrysuvlgb/UCAMAhqiH7kLPcuVcO
         d/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCVs/i11H0dtezihW3UlZC+joCyx1llzbjRBIW5eZ7s=;
        b=hrlbtMtXI9lscIa1bemNNuC0uJgVNG0RZtG3RFi9Onh9rMgizonIbidHrWimn4OU9I
         KPgidnTyTbS9880vlhfp2sWO67fcNStnqF1WFuIo0I+D+ZlFtoPl6iKdxXCfbG9ayDRr
         srld/JCCOA9s5ZggX3WtNs+vMnUVA8wbmQTgLrt7ys3qP1LHZvV4ALpPdGGh1ZCf5Bc7
         eq4fEn1q3vWVdTpYuonMJuHDkdWiBQaCkbyJKNuKWqErFmDX5UL/gMreNC2Tsk9XrQuj
         Lev5/VMPklnY2RYiAjWrSk3/S02ulYxSaysAgm/aMIdEWlMHr82vCjhU8gkqYEFE9vJp
         93QA==
X-Gm-Message-State: ANhLgQ3BVPnC9zJMP9ZFGoMdOUBGCxd65eA7a+77n2uaWyYKNiml6wyU
        kELsG3csfg4j9nJ49RPoNwQ=
X-Google-Smtp-Source: ADFU+vv5DaEIzfo2NkW+Hrt0C4tRsw6v9YP9SBcL1yN0qMy2bvmizTkJMire/fAKhxuX6pIi4X8dgg==
X-Received: by 2002:a37:8982:: with SMTP id l124mr821838qkd.195.1585586596022;
        Mon, 30 Mar 2020 09:43:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v187sm10542359qkc.29.2020.03.30.09.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:43:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9EEC8409A3; Mon, 30 Mar 2020 13:43:12 -0300 (-03)
Date:   Mon, 30 Mar 2020 13:43:12 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200330164312.GD4576@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-7-namhyung@kernel.org>
 <20200330163058.GC4576@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330163058.GC4576@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 30, 2020 at 01:30:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 25, 2020 at 09:45:33PM +0900, Namhyung Kim escreveu:
> > Synthesize cgroup events by iterating cgroup filesystem directories.
> > The cgroup event only saves the portion of cgroup path after the mount
> > point and the cgroup id (which actually is a file handle).
> 
> Breaks the build on alpine linux (musl libc):
> 
>   CC       /tmp/build/perf/util/srccode.o
>   CC       /tmp/build/perf/util/synthetic-events.o
> util/synthetic-events.c: In function 'perf_event__synthesize_cgroup':
> util/synthetic-events.c:427:22: error: field 'fh' has incomplete type
>    struct file_handle fh;
>                       ^
> util/synthetic-events.c:441:6: error: implicit declaration of function 'name_to_handle_at' [-Werror=implicit-function-declaration]
>   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
>       ^
> util/synthetic-events.c:441:2: error: nested extern declaration of 'name_to_handle_at' [-Werror=nested-externs]
>   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
>   ^
>   CC       /tmp/build/perf/util/data.o
> cc1: all warnings being treated as errors
> mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
> 
> 
> I'm trying to fix

musl libc up to 1.2.21 (IIRC) lacks name_to_handle_at and its structs,
then from the one that is in alpine linux 3.10 the error changes to:

  CC       /tmp/build/perf/util/cloexec.o
util/synthetic-events.c:427:22: error: field 'fh' with variable sized type 'struct file_handle' not at the end of a struct or class is a GNU
      extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                struct file_handle fh;
                                   ^
1 error generated.
mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/synthetic-events.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:617: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:225: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[root@quaco ~]#

So probably we'll need a feature test to catch this and do some
workaround or disable the feature on such systems, providing some
warning.

I left the container build tests running to see if some other system has
problems with this, perhaps the ones with uCLibc or some older glibc,
we'll see.

So far all the alpine versions failed with the above problems and ALT
Linux p8 and p9 built without problems.

- Arnaldo
