Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4728C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88BD20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6CyMjyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbgDCJpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:45:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727792AbgDCJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585907111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kS5ENOsGNL/0nyuCfyKnLwjxvhjQBYybEvJXw0BjaFU=;
        b=N6CyMjyfxzVd2bl3Ieg8IQRkyQwr+KrNBJwqE3canQOsDx++SvIAbi16RWUYcB9yZ4pb0P
        gdQrSVFyEVTojUgNStPg6Gnb7kxFfEXaJl0s8rQ5uVRMYCIJIr/G2pucB/5B7k6tYHOpUJ
        H+SVHAMqZ8yO3cZUhduWUO+HhefLcak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300--DxnThAKPHSW_oUQrNHOgA-1; Fri, 03 Apr 2020 05:45:09 -0400
X-MC-Unique: -DxnThAKPHSW_oUQrNHOgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3FD2108442D;
        Fri,  3 Apr 2020 09:45:07 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 423C7B19A5;
        Fri,  3 Apr 2020 09:45:03 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:45:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix no metric header if --per-socket and
 --metric-only set
Message-ID: <20200403094500.GH2784502@krava>
References: <20200331180226.25915-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331180226.25915-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:02:26AM +0800, Jin Yao wrote:
> We received a report that was no metric header displayed if --per-socket
> and --metric-only were both set.
> 
> It's hard for script to parse the perf-stat output. This patch fixes this
> issue.
> 
> Before:
> 
>   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
>   ^C
>    Performance counter stats for 'system wide':
> 
>   S0        8                  2.6
> 
>          2.215270071 seconds time elapsed
> 
>   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
>   #           time socket cpus
>        1.000411692 S0        8                  2.2
>        2.001547952 S0        8                  3.4
>        3.002446511 S0        8                  3.4
>        4.003346157 S0        8                  4.0
>        5.004245736 S0        8                  0.3
> 
> After:
> 
>   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
>   ^C
>    Performance counter stats for 'system wide':
> 
>                                CPI
>   S0        8                  2.1
> 
>          1.813579830 seconds time elapsed
> 
>   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
>   #           time socket cpus                  CPI
>        1.000415122 S0        8                  3.2
>        2.001630051 S0        8                  2.9
>        3.002612278 S0        8                  4.3
>        4.003523594 S0        8                  3.0
>        5.004504256 S0        8                  3.7
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/stat-shadow.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 0fd713d3674f..03ecb8cd0eec 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -803,8 +803,11 @@ static void generic_metric(struct perf_stat_config *config,
>  				     out->force_header ?
>  				     (metric_name ? metric_name : name) : "", 0);
>  		}
> -	} else
> -		print_metric(config, ctxp, NULL, NULL, "", 0);
> +	} else {
> +		print_metric(config, ctxp, NULL, NULL,
> +			     out->force_header ?
> +			     (metric_name ? metric_name : name) : "", 0);
> +	}
>  
>  	for (i = 1; i < pctx.num_ids; i++)
>  		zfree(&pctx.ids[i].name);
> -- 
> 2.17.1
> 

