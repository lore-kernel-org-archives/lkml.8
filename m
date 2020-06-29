Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABA6206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ258LRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgF2TXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51556 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730502AbgF2TXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sjxgsbXUH5TliF6aeepZ4Uon8SNTJXYIGtvY8oeRGE=;
        b=FJ258LRJLStdpR8GHdntc7vs9z1PYe+nbraMw7FsFYmxoKTot+yqSfCAmnUD7L2ig1F8pa
        U5nc/RtfErZjG4hVF/zdmVGQMXj2YNG7p0TfjS+m490xDnr5Up/gQ8ZvjCC0fzBb2BHnms
        w5b0QR3tkT0z3RhwbW31u5lnZ/5z6v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-j_ra0JiINkOtileaBTFjaA-1; Mon, 29 Jun 2020 15:23:15 -0400
X-MC-Unique: j_ra0JiINkOtileaBTFjaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 165E9A0C0D;
        Mon, 29 Jun 2020 19:23:13 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D59D9CFF2;
        Mon, 29 Jun 2020 19:23:09 +0000 (UTC)
Date:   Mon, 29 Jun 2020 21:23:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 09/10] perf tools: Compute other metrics
Message-ID: <20200629192309.GD3031756@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-10-jolsa@kernel.org>
 <CAP-5=fUODuF+LY6cbU4BPEcxu_YXDYg42pgRYU=yY5e47z05=g@mail.gmail.com>
 <20200628215957.GO2988321@krava>
 <CAP-5=fWS7dsqrjM2gP6fpsjbjW5CoFHwGLYf-WxzJ9JdhD-LzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWS7dsqrjM2gP6fpsjbjW5CoFHwGLYf-WxzJ9JdhD-LzQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:35:12AM -0700, Ian Rogers wrote:

SNIP

> 
> {
>  "BriefDescription": "All L2 hit counts",
>  "MetricExpr": "L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT +
> L2_RQSTS.RFO_HIT",
>  "MetricName": "DCache_L2_All_Hits",
> }
> {
>  "BriefDescription": "All L2 miss counts",
>  "MetricExpr": "MAX(L2_RQSTS.ALL_DEMAND_DATA_RD -
> L2_RQSTS.DEMAND_DATA_RD_HIT, 0) + L2_RQSTS.PF_MISS +
> L2_RQSTS.RFO_MISS",
>  "MetricName": "DCache_L2_All_Miss",
> }
> {
>  "BriefDescription": "All L2 counts",
>  "MetricExpr": "metric:DCache_L2_All_Hits + metric:DCache_L2_All_Miss",
>  "MetricName": "DCache_L2_All",
> }
> {
>  "BriefDescription": "DCache L2 hit rate",
>  "MetricExpr": "d_ratio(metric:DCache_L2_All_Hits, metric:DCache_L2_All)",
>  "MetricName": "DCache_L2_Hits",
>  "MetricGroup": "DCache_L2",
>  "ScaleUnit": "100%",
> },
> {
>  "BriefDescription": "DCache L2 miss rate",
>  "MetricExpr": "d_ratio(metric:DCache_L2_All_Miss, metric:DCache_L2_All)",
>  "MetricName": "DCache_L2_Misses",
>  "MetricGroup": "DCache_L2",
>  "ScaleUnit": "100%",
> },
> 
> Firstly, it should be clear that having this change makes the json far
> more readable! The current approach is to copy and paste resulting in
> 100s of characters wide expressions. This is a great improvement!
> 
> With these metrics the hope would be that 'perf stat -M DCache_L2 ...'
> is going to report just DCache_L2_Hits and DCache_L2_Misses. To
> compute these two metrics, as an example, DCache_L2_All_Hits is needed
> three times. My comment was meant to mean that it seems a little
> unfortunate to keep repeatedly evaluating the expression rather than
> to compute it once and reuse the result.

nice example, the code should evaluate the expression just once as long
as it's under same name.. I'll prepare new version and verify that's the
case with the example above

thanks,
jirka

