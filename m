Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391FAC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC320409
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up5ayR0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCQUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:41:20 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34484 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:41:19 -0400
Received: by mail-qv1-f68.google.com with SMTP id o18so11672388qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p7n64HFEEFD1bxFrQS335VRgtrxyON8bbgS0WDdlslE=;
        b=up5ayR0p8zH39veN7UqJNt0jdqt8l3r16i1ksu6T2anaYpPn4LVaakMwjxoBdyACN+
         cJ264U44HGDzUD+hadlCx7rG6VAhFDqxWGAjJL12v4bmUYgjcYZA5uSlztOUCxq8t+fD
         KxSiPjBLnHSPUmVILrWXIP0WlxocEqMeNmOiP0SN3ZS6i2IYwNFt2H1bWb0bCQAlQuHS
         1uO3GudsOSvLtDPMzFxhY3/YqwiGww0CsvhLFm6kRxIKz4V+yyZ36XClHSLiv5ngtgjW
         JG6mujPI/oP0QnSNM2g3tLe4YacUocpKaarUqCUaawrOlV3HMUtDAFj2zfe9YXp355Dz
         05Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p7n64HFEEFD1bxFrQS335VRgtrxyON8bbgS0WDdlslE=;
        b=PNpfGW8IS28362siuysPJBvLgQFIsUwylbIIOrg3iRoGpz7rwn/fpYfVlQtlRh+1dG
         WjddaVoGQAyvplQfMPJwu2YerYSWLc2+b+DvNgp0dzv1OxDD8zDSmavGUtwJQnr51BAq
         Nc5rjiGwJGQSkNgajjGIHhv/lTrjBDrdEPdmo64ex8rM2xFNJCNOQ8gQiTvqyJOyPhwQ
         oJV5VMpBzOELH1zxueQNR1frWwnKjvn+p1hti9W4JuJ7dr+yoarI2hnzVDb7grMBDONR
         RyQij+ah3xzJRM1EiREFcOlpLJ4AaZtp3nvG0T2/u2nm6qjJkMZ+tg1CVzZwTtrOHHER
         FGaQ==
X-Gm-Message-State: ANhLgQ15Es3DzZ9s58Qpi32T6TJS9bW4EPvWf8jI90JqeNpB1BBOKiVN
        j9rvTgd8LPRyioUNGDNOoeM=
X-Google-Smtp-Source: ADFU+vsdIWNhPCxdordz3SLRqEvuM+XT3++eIJX0J5W8tPVDMxDLoEg1WFVGTriylzbNx/qaGx8r/g==
X-Received: by 2002:a0c:ffd3:: with SMTP id h19mr1057949qvv.166.1584477678727;
        Tue, 17 Mar 2020 13:41:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 82sm2715647qkd.62.2020.03.17.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:41:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF6CD404E4; Tue, 17 Mar 2020 17:41:15 -0300 (-03)
Date:   Tue, 17 Mar 2020 17:41:15 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        will@kernel.org, ak@linux.intel.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, james.clark@arm.com,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 2/7] perf jevents: Support test events folder
Message-ID: <20200317204115.GA11531@kernel.org>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-3-git-send-email-john.garry@huawei.com>
 <20200317162052.GD759708@krava>
 <de5b58ee-980e-973a-16db-73f23c3edfef@huawei.com>
 <20200317170645.GE759708@krava>
 <dcaf4aa9-213e-47c5-16e2-e7f8af259ce9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcaf4aa9-213e-47c5-16e2-e7f8af259ce9@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 17, 2020 at 05:42:46PM +0000, John Garry escreveu:
> On 17/03/2020 17:06, Jiri Olsa wrote:
> > On Tue, Mar 17, 2020 at 04:25:32PM +0000, John Garry wrote:
> > > On 17/03/2020 16:20, Jiri Olsa wrote:
> > > > On Tue, Mar 17, 2020 at 07:02:14PM +0800, John Garry wrote:
> > > > > With the goal of supporting pmu-events test case, introduce support for a
> > > > > test events folder.
> > > > > 
> > > > > These test events can be used for testing generation of pmu-event tables
> > > > > and alias creation for any arch.
> > > > > 
> > > > > When running the pmu-events test case, these test events will be used
> > > > > as the platform-agnostic events, so aliases can be created per-PMU and
> > > > > validated against known expected values.
> > > > > 
> > > > > To support the test events, add a "testcpu" entry in pmu_events_map[].
> > > > > The pmu-events test will be able to lookup the events map for "testcpu",
> > > > > to verify the generated tables against expected values.
> > > > > 
> > > > > The resultant generated pmu-events.c will now look like the following:
> > > > 
> > > > can't compile this one:
> > > > 
> > > >     HOSTCC   pmu-events/jevents.o
> > > > pmu-events/jevents.c: In function ‘main’:
> > > > pmu-events/jevents.c:1195:3: error: ‘ret’ undeclared (first use in this function)
> > > >    1195 |   ret = 1;
> > > >         |   ^~~
> > > > pmu-events/jevents.c:1195:3: note: each undeclared identifier is reported only once for each function it appears in
> > > > pmu-events/jevents.c:1196:3: error: label ‘out_free_mapfile’ used but not defined
> > > >    1196 |   goto out_free_mapfile;
> > > >         |   ^~~~
> > > > mv: cannot stat 'pmu-events/.jevents.o.tmp': No such file or directory
> > > > make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: pmu-events/jevents.o] Error 1
> > > > make[2]: *** [Makefile.perf:619: pmu-events/jevents-in.o] Error 2
> > > > make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > > > make: *** [Makefile:70: all] Error 2
> > > 
> > > Hi jirka,
> > > 
> > > What baseline are you using? I used v5.6-rc6. The patches are here:
> > 
> > I applied your patches on Arnaldo's perf/core
> 
> My recent fix on jevents.c does not seem to be on that branch, but it is on
> perf/urgent and also included in v5.6-rc6

I'll merge perf/urgent into perf/core soon,

- Arnaldo
 
> Thanks,
> John
> 
> > 
> > > 
> > > https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.6-pmu-events-test-upstream-v2
> > 
> > ok, will check
> > 
> > jirka
> > 
> > .
> > 
> 

-- 

- Arnaldo
