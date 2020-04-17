Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2118DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA85320B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqVHTnND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgDQV4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:56:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE85C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:56:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id y3so4120250qky.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/O74kvUM08JKjYVyQSBSoLz9jgAbQCBcWMd1yrXQFNQ=;
        b=aqVHTnNDwMe8HsrWQO9eDoRogfZzIDRRuE2u8u+pE4R14yndiBCKKXz+rz+vuANXmf
         E2UQKNDVQLcDWNuWj/4aAjdhtcDpuMiS7nEjBDCXwFRHMxTaejNQ6iBLzn5f+obdVwg9
         QUAEmQsynhQNEwfuJsx3l0+VKwtBueRFkypdGe1VmbCkIDZoA1KkEo1CA2iuQDKXXFck
         vWROCrHevYJkQK6iyOMPj7/W5WMJR9gE+2xjvduVWIIKWJ5L1yE391p4J9d2mU+Z8HPy
         fCMVdbs2jk0cHmEhJ6NySMwzPwgIJaZxJI+zcx9zIb5L8lPOh15+1jSs1vgoimQRUlR+
         l3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/O74kvUM08JKjYVyQSBSoLz9jgAbQCBcWMd1yrXQFNQ=;
        b=pymbDm4lsPq0DO9z4GTQ38Xtk3O8s9C+tyj3mvdTl35KlQN8sNRbHOk4dfLdrnk3yu
         KX/JG28mIJeK9yzEpAtD8lrQBRyYpbYjB0zhJh2bLxgswnMNI725mTuoU1HwJmz+3Cvp
         /eAtz/tOB0d4xxWNPUEjbR54563zEQPpUpBAJ8EZNLufXVusdg2c7nMT9BBZldmdu5TI
         w0kN4//SapOtL3kVhjRj5G/GZq6tomdvUepC9sek2W9syD19H7OdqKV+D3nVSLTt6Fmk
         3dwCOXf9ioJXZSp0L2KlSdSuBaDgS13xnpu60HlkX/Ji81fGi47DiBxctYV58wlzzA6s
         IuJw==
X-Gm-Message-State: AGi0Pua9+X7R/nvThgV6nA3FFBCUMZZfufqunXwjbizuoidHE334BPMy
        kVlL6GPuojK7DIOY8f/JYHk=
X-Google-Smtp-Source: APiQypK8ouSewffhiusSqM7XJ1LDn7TIBEQ68Ike6Ixk4O2rMwydkkE0JbiwMDltBDtglxhmsyG9VA==
X-Received: by 2002:a05:620a:1458:: with SMTP id i24mr5428810qkl.279.1587160559417;
        Fri, 17 Apr 2020 14:55:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d23sm14586204qkj.26.2020.04.17.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:55:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CBC0409A3; Fri, 17 Apr 2020 18:55:56 -0300 (-03)
Date:   Fri, 17 Apr 2020 18:55:56 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Message-ID: <20200417215556.GE21512@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200417174803.GA21512@kernel.org>
 <2b34783b-85d1-6d30-d9e1-f550f8b6e9c0@linux.intel.com>
 <20200417215402.GC21512@kernel.org>
 <20200417215516.GD21512@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417215516.GD21512@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 17, 2020 at 06:55:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 17, 2020 at 06:54:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Apr 17, 2020 at 05:47:49PM -0400, Liang, Kan escreveu:
> > > 
> > > 
> > > On 4/17/2020 1:48 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com escreveu:
> > > > > For a simple test case tchain_edit with 43 depth of call stacks.
> > > > > perf record --call-graph lbr -- ./tchain_edit
> > > > > perf report --stitch-lbr
> > 
> > > > > Without --stitch-lbr, perf report only display 32 depth of call stacks.
> > > > > With --stitch-lbr, perf report can display all 43 depth of call stacks.
> > > > > The depth of call stacks increase 34.3%.
> > 
> > > > > Correspondingly, the processing time of perf report increases 39%,
> > > > > Without --stitch-lbr:                           11.0 sec
> > > > > With --stitch-lbr:                              15.3 sec
> > 
> > > > Next time provide the full test proggie, I had to expand those ... to
> > > > reproduce your results,
> > 
> > > Sure, I will do so in the future.
> > 
> > > > all I have is in perf/core, some patches are
> > > > still to be processed, will continue later, have to stop now, see:
> > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=13cfba6b741ff
> > 
> > > > For my testing, looks really great!
> > 
> > > Thanks for the testing. :)
> > 
> > My pleasure.
> > 
> > BTW everything is in there by now.
> 
> And I had to do some more fixes to get it building in my container build
> test suite, I've restarted it and now its at this point:
> 
> Fri 17 Apr 2020 06:18:18 PM -03
> $ export PERF_TARBALL=http://192.168.122.1/perf/perf-5.7.0-rc1.tar.xz
> $ dm
>    1   125.76 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>    2   123.16 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>    3   127.96 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>    4   138.24 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    5   147.38 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    6   160.57 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    7   186.38 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    8   208.66 alpine:3.11                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>    9   176.99 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.1 (git://git.alpinelinux.org/aports 6c34b9a10bcdcdac04a11569c50b61fb50c4ea6e) (based on LLVM 9.0.1)
>   10    86.14 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
>   11    99.43 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.3.1 20190507 (ALT p9 8.3.1-alt5), clang version 7.0.1
>   12   104.78 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.2.1 20200123 (ALT Sisyphus 9.2.1-alt3), clang version 9.0.1
>   13    77.72 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>   14   120.69 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>   15    24.96 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   16    25.73 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   17    22.34 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   18    31.91 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   19    36.18 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
>   20   129.17 centos:8                      : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)
>   21: clearlinux:latest

Just as I pressed the send hotkey:

  21    45.71 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.3.1 20200325 releases/gcc-9.3.0-55-gdff885cdc0, clang version 9.0.1


:-)

- Arnaldo
