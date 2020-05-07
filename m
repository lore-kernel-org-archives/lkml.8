Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1BB216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiSACmCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEGQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgEGQqr (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:46:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19BCC05BD43
        for <Linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:46:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so384244qkm.6
        for <Linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ALB6CWA2NPbVZmvAcJDJvwoWj31I6zoHjr5Bjo7YDh8=;
        b=OiSACmChxi9gyUUngS6RRcjSkLUbt8gTQIpXJ9aLSM9Gjq/bjA9CtMr5WjutgVHrdU
         zpoHDYCMKgh9cuapjJndg6lWup7QoRz11eXvbC9Nnxy22zMPAi/tDPVrfMavVHJyURSk
         GPrsUuMD0hbD8V2gpq4Wu5rDfmlX5oMEFTWYexpELWxXcz7R4repS1cQnAj86klm3gyt
         2hPqRw7ySA9dqyzUKQPfFIbFr9NKKOxfo9NGyYw3q6WHtLQRBr2d5sOKg3/LIIh3/xGY
         768MW/nDidbsCzmKkNxOx/+53HF/3TqKmSFVwhK3bpoCKwSG5lKkQ3tQnD64v5IX4NFh
         4C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ALB6CWA2NPbVZmvAcJDJvwoWj31I6zoHjr5Bjo7YDh8=;
        b=TbSO2lc1ZfzB7amcZ1vxnapFjtcEWkWRJEduGlmfk/2GKgLDs0urUM6HQATwWYKsdr
         4+/U/HP9grZ9u0JFJZRmSIW4Yr27Offm0HXz6yhKeGdoYFlNbLWzkVDf73kutEeQtxIx
         Ff1Msxo36644dE4qivaUdZmILhAzYGHJ3zbD5mr7NQQTgy+WlpQI+j3MVYXtreTEf8zV
         /cY9HSn1s66kjUv719ypsLpaNJ13ofU+ZGT2SXDjlWa9yimDGevtjyxD8Zp+Y1Y8WRxM
         qXhUNHlpmeTx2UaMW7CsAxRIgvwwsTVCB6FZwdOwxoD3CrOHAkCHsrgMtYxt3RY8g95p
         5WKA==
X-Gm-Message-State: AGi0PuY2oMUMHPsmTVz3QO955IdJ0+q7V1zeK2B94KIYCQfr34PYLxT3
        91V7UQ3blhV+w/dNT7lZefs=
X-Google-Smtp-Source: APiQypIylaVGUfbraa2Y9PRQOgx/iShUYuNdAzUE+Go6x4/zdO+3kGKjDY92TgLUuK1/YwwxbEjlTA==
X-Received: by 2002:ae9:e894:: with SMTP id a142mr1644087qkg.296.1588870004942;
        Thu, 07 May 2020 09:46:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w27sm4710698qtc.18.2020.05.07.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:46:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B1C640AFD; Thu,  7 May 2020 13:46:42 -0300 (-03)
Date:   Thu, 7 May 2020 13:46:42 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200507164642.GD31109@kernel.org>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
 <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
 <20200430111551.GC1694693@krava>
 <0195184b-0b43-f2fd-8d80-3b70d3f5a950@huawei.com>
 <8685d584-1d28-4648-8d85-2ea637f3c695@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8685d584-1d28-4648-8d85-2ea637f3c695@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 30, 2020 at 09:38:34PM +0800, Jin, Yao escreveu:
> Hi John, Jiri,
> 
> On 4/30/2020 7:48 PM, John Garry wrote:
> > On 30/04/2020 12:15, Jiri Olsa wrote:
> > 
> > +
> > 
> > > On Thu, Apr 30, 2020 at 09:54:18AM +0100, John Garry wrote:
> > > > On 30/04/2020 09:45, Jiri Olsa wrote:
> > > > > On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > > > > > A big uncore event group is split into multiple small groups which
> > > > > > only include the uncore events from the same PMU. This has been
> > > > > > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > > > > > uncore event aliases in small groups properly").
> > > > > > 
> > > > > > If the event's PMU name starts to repeat, it must be a new event.
> > > > > > That can be used to distinguish the leader from other members.
> > > > > > But now it only compares the pointer of pmu_name
> > > > > > (leader->pmu_name == evsel->pmu_name).
> > > > > > 
> > > > > > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > > > > > the event list is:
> > > > > > 
> > > > > > evsel->name                    evsel->pmu_name
> > > > > > ---------------------------------------------------------------
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_4 (as leader)
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_2
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_0
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_5
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_3
> > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_1
> > > > > > unc_iio_data_req_of_cpu.mem_write.part1        uncore_iio_4
> > > > > > ......
> > > > > > 
> > > > > > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > > > > > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > > > > > It's not a new leader for this PMU.
> > > > > > 
> > > > > > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > > > > > would be failed and the event is stored to leaders[] as a new
> > > > > > PMU leader.
> > > > > > 
> > > > > > So this patch uses strcmp to compare the PMU name between events.
> > > > > > 
> > > > > > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore
> > > > > > event aliases in small groups properly")
> > > > > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > > > 
> > > > > looks good, any chance we could have automated test
> > > > > for this uncore leader setup logic? like maybe the way
> > > > > John did the pmu-events tests? like test will trigger
> > > > > only when there's the pmu/events in the system
> > > > > 
> > > > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > > > 
> > > > > thanks,
> > > > > jirka
> > > > 
> > > > Hi jirka,
> > > > 
> > > > JFYI, this is effectively the same patch as I mentioned to you, which was a
> > > > fix for the same WARN:
> > > > 
> > > > https://lore.kernel.org/linux-arm-kernel/1587120084-18990-2-git-send-email-john.garry@huawei.com/
> > > > 
> > > > 
> > > > but I found that it "fixed" d4953f7ef1a2 ("perf parse-events: Fix 3 use
> > > > after frees found with clang ASANutil/parse-events.c"), based on bisect
> > > > breakage
> > > 
> > > hum right.. sorry I did not recalled that, there's
> > > also the warn removal in here, could you guys also
> > > plz sync on the fixes clauses?
> > 
> > I just thought that it fixes d4953f7ef1a2, as I found that the pointer
> > equality fails from that commit. I assume the parse-events code was
> > sound before then (in that regard). That's all I know :)
> > 
> > Thanks!
> > 
> 
> For 3cdc5c2cb924a, I just think it should use strcmp for pmu_name comparison
> rather than using pointer. But I'm OK to add d4953f7ef1a2 in fixes clauses.
> :)

So, I'm keeping Ian's patch, as I just applied it, and replaced the
fixes clause to:

Fixes: d4953f7ef1a2 ("perf parse-events: Fix 3 use after frees found with clang ASAN")


Would this be ok? Or does John's fix has something else in it (I haven't
checked).

- Arnaldo
