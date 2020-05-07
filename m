Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943CA20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXByn+gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEGQop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGQop (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:44:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203FC05BD43
        for <Linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:44:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so1165414qkg.1
        for <Linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zh3lcEToSxvQ9zIzdwO/bIHKYKJ2KvRssPpnn7ahZp8=;
        b=pXByn+gu1mLH3cLrodA9NBz6dZO1nIz8NifllRHUl4+b3Gjarga2ZjCihLauroCFoE
         AS29R+vtmvS36hyfzMNWMqVSFEigRpgevLfSjlVEG0k5s/jp/XNjKexbzYCOlVIXs99U
         Fsc3GGeetV+1CJ7gxvraTBy9kBPmpHjenrJe7miHxa0OJydJQEoFq2oiyit+el6lmHUp
         +IJdMV+YXeTtEy2FWe7bwCC9GRhLifKlUcgdECPJ1pr1Y7HBgLTHHd572KKlrYoTGXYf
         4XJQ5zpuCgNHFbh5la5KBCV8wXtommDKoHyRTnJo/Mv7a/9u7GF/aNPjzDrUYupBCQoL
         G2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zh3lcEToSxvQ9zIzdwO/bIHKYKJ2KvRssPpnn7ahZp8=;
        b=sK9PGv3dK40sIhUkPH5kI0msFOYG9b0M5bL9WeiS8UoAUS+KDtSXkStg9jtD89YTlT
         BM1W+W7Bg401VnUoQPHQFXprOJSqk3Z75BPEIBwfvgKSH5zwCqTRxiTg6YQAgjXsqyax
         4zijbB30IcEIeBkPN7CvUaImDGLVMVImhUVO0w4w7PlpJJ883/dZXUxKi0Rkfr3/BmLS
         jtDvx8UfiCS0NpilNUdm4/xe45jA7PfZ+BoZSAOrYa2ez0/LxTduP21AIQXNzSkYpjH2
         RXjYVRMG6Qp2/dd2J476HcVO6K0eW/R8zSMHVi1/jlHMEoCwtq2HqUz9rUi1516pHkZt
         RHWA==
X-Gm-Message-State: AGi0PuYWqRAic1P1pZFCFV6Nq0jFsYHFDNaOMSUHeC/ZxbceRzqW6Kd6
        x4h7XtF7UcaIwRQBWfMxrIs=
X-Google-Smtp-Source: APiQypKvGOhlv81Gzf2+0LIE/uFOOkTYcY5YbB/O4gv5Qva5FuBxoI2nXq01veXQsIBpN895n83rag==
X-Received: by 2002:a05:620a:1366:: with SMTP id d6mr15178100qkl.114.1588869884321;
        Thu, 07 May 2020 09:44:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g12sm4449837qtu.69.2020.05.07.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:44:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B862D40AFD; Thu,  7 May 2020 13:44:40 -0300 (-03)
Date:   Thu, 7 May 2020 13:44:40 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200507164440.GC31109@kernel.org>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430084529.GC1681583@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 30, 2020 at 10:45:29AM +0200, Jiri Olsa escreveu:
> On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > A big uncore event group is split into multiple small groups which
> > only include the uncore events from the same PMU. This has been
> > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > uncore event aliases in small groups properly").
> > 
> > If the event's PMU name starts to repeat, it must be a new event.
> > That can be used to distinguish the leader from other members.
> > But now it only compares the pointer of pmu_name
> > (leader->pmu_name == evsel->pmu_name).
> > 
> > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > the event list is:
> > 
> > evsel->name					evsel->pmu_name
> > ---------------------------------------------------------------
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_4 (as leader)
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_2
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_0
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_5
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_3
> > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_1
> > unc_iio_data_req_of_cpu.mem_write.part1		uncore_iio_4
> > ......
> > 
> > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > It's not a new leader for this PMU.
> > 
> > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > would be failed and the event is stored to leaders[] as a new
> > PMU leader.
> > 
> > So this patch uses strcmp to compare the PMU name between events.
> > 
> > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> looks good, any chance we could have automated test
> for this uncore leader setup logic? like maybe the way
> John did the pmu-events tests? like test will trigger
> only when there's the pmu/events in the system
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
