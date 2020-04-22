Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5113C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A168C206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1SlTt7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDVHWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:22:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgDVHWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587540157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QU8gwHkCUYXbkdafNMuU8FRFr0WYwJmJfr+Lfeo6IY=;
        b=g1SlTt7Q1bl3EWqYwqWrygk3qxCqGwuegTTyDImjZUL9xLCRpVT/O20rdiN3h3NvfXRJKc
        kgv9i7czVFXGVTmBvg1uXcrX/IAOpJh0pCb11Gzqp9vrnTDokKjPfgn5HZqyAqx0Bro4BA
        rzLTaBjsYHhsH+LXR7ubDF0Ib25u8Y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Xb1nON28P2ykE-cM_uB3LA-1; Wed, 22 Apr 2020 03:22:36 -0400
X-MC-Unique: Xb1nON28P2ykE-cM_uB3LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75BDC8017F3;
        Wed, 22 Apr 2020 07:22:34 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F036176E9D;
        Wed, 22 Apr 2020 07:22:31 +0000 (UTC)
Date:   Wed, 22 Apr 2020 09:22:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
Message-ID: <20200422072223.GC962614@krava>
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420145417.6864-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:54:17PM +0800, Jin Yao wrote:
> For interval mode, the metric is printed after # if it exists. But
> it's not calculated by the counts generated in this interval. See
> following examples,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000422803            764,809      inst_retired.any          #      2.9 CPI
>       1.000422803          2,234,932      cycles
>       2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
>       2.001464585          4,022,591      cycles
> 
> The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000429493          2,869,311      cycles
>       1.000429493            816,875      instructions              #    0.28  insn per cycle
>       2.001516426          9,260,973      cycles
>       2.001516426          5,250,634      instructions              #    0.87  insn per cycle
> 
> The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).
> 
> The current code uses a global variable rt_stat for tracking and
> updating the std dev of runtime stat. Unlike the counts, rt_stat is
> not reset for interval. While the counts are reset for interval.
> 
> perf_stat_process_counter()
> {
>         if (config->interval)
>                 init_stats(ps->res_stats);
> }
> 
> So for interval, the rt_stat should be reset either.
> 
> This patch resets rt_stat before read_counters, so the runtime
> stat is only calculated by the counts generated in this interval.
> 
> With this patch,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
>       1.000420924          5,010,111      cycles
>       2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
>       2.001448579          4,599,861      cycles
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000428555          2,769,714      cycles
>       1.000428555            774,462      instructions              #    0.28  insn per cycle
>       2.001471562          3,595,904      cycles
>       2.001471562          1,243,703      instructions              #    0.35  insn per cycle
> 
> Now the second 'insn per cycle' and CPI are calculated by the counts
> generated in this interval.
> 
>  v2:
>  ---
>  Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
>  We don't need to define new function perf_stat__reset_rt_stat.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

