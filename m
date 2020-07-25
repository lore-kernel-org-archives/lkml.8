Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE461C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD88206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1VnkpQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGYLv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:51:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726583AbgGYLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595677914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0afFqAur257GK/ap6tytilWq+yG+Tf9kQhohDroojF8=;
        b=X1VnkpQHfyA27izlH2HPmzMkbKVo4/31YVrH3pAO6TrjGMR8A7TLfP5W0ej+cgAHl1J1ZV
        Kfn3veNpkOy4gSBc7rDtexZOcrLlimwTaT06uBJgtjSmIg1qs5UKxf1/mtPDuKnW5r2KiC
        Bo2PvaBnVxgbxw+gIa9QCt6JKR2I9CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-frKsRCXQN2a7QYS_tvh5nw-1; Sat, 25 Jul 2020 07:51:50 -0400
X-MC-Unique: frKsRCXQN2a7QYS_tvh5nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CC0D57;
        Sat, 25 Jul 2020 11:51:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A6A110013C2;
        Sat, 25 Jul 2020 11:51:44 +0000 (UTC)
Date:   Sat, 25 Jul 2020 13:51:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200725115143.GA1157288@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
 <20200720191625.GL760733@krava>
 <eec934d1-5f45-739e-d5df-847a4b995fa5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec934d1-5f45-739e-d5df-847a4b995fa5@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:22:28AM +0530, kajoljain wrote:

SNIP

> 
> Hi Jiri,
>        The change looks good to me. I tried with adding this patch on top of your perf/metric branch. It did resolve the issue of not printing
> all chips data. And now I can see proper values for hv-24x7 metric events.
> 
> I was also trying by adding new metric using the feature added in this patchset with something like this:
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index 8383a37647ad..dfe4bd63b587 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -16,6 +16,11 @@
>          "MetricName": "PowerBUS_Frequency",
>          "ScaleUnit": "2.5e-7GHz"
>      },
> +    {
> +       "MetricExpr": "Memory_WR_BW_Chip + Memory_RD_BW_Chip",
> +        "MetricName": "Total_Memory_BW",
> +        "ScaleUnit": "1.6e-2MB"
> +    },

hum, we'll need special case this.. because Memory_WR_BW_Chip will
unwind to Memory_WR_BW_Chip_[01] and Total_Memory_BW is not aware of
that.. what's the expected behaviour in here?

have Total_Memory_BW_[01] for each runtime arg?

I think this will need to come on top of this changes,
it's already too big

thanks,
jirka

> 
> I guess as we have dependency on '?' symbol, I am not able to see all chips data for Total_Memory_BW.
> I am not sure if Its expected behavior?
> 
> This is what I am getting:
> 
> [root@ltc-zz189-lp4 perf]# ./perf stat --metric-only -M Total_Memory_BW,Memory_WR_BW_Chip,Memory_RD_BW_Chip -I 1000 -C 0
> #           time  MB  Total_Memory_BW MB  Memory_RD_BW_Chip_1 MB  Memory_WR_BW_Chip_1 MB  Memory_WR_BW_Chip_0 MB  Memory_RD_BW_Chip_0 
>      1.000067388                 36.4                      0.2                     36.3                     65.0                     72.1 
>      2.000374276                 36.2                      0.3                     35.9                     65.4                     77.9 
>      3.000543202                 36.3                      0.3                     36.0                     68.7                     81.2 
>      4.000702855                 36.3                      0.3                     36.0                     70.9                     93.3 
>      5.000856837                 36.0                      0.2                     35.8                     67.4                     81.5 
> ^C     5.367865273                 13.2                      0.1                     13.1                     23.5                     28.3 
>  Performance counter stats for 'CPU(s) 0':
>                194.4                      1.3                    193.1                    361.0                    434.3 
>        5.368039176 seconds time elapsed
> 
> We can only get single chip data's sum in Total_Memory_BW. Please let me know if I am missing something.

SNIP

