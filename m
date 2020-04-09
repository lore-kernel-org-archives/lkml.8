Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18431C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D434E20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/C/mQMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDIPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:43:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728167AbgDIPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586447022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mtjSwR8IguPOXLT021Rh82aVT+w9DQDweQ+imYBuk/8=;
        b=P/C/mQMKU7epnIUDRvm0wnehLP8xs5OpqhxWaJWYtnmJG2MazrGcsPfcOslCBXXDWzK00S
        htvhJSpQXU94QzEOKuOVwiotsv7VoLOunCdhbLbl/jsGpkeXiXrGFgZt7ll84qp2ZnL9E5
        iMSDp9gCMGc1gOgAk+wH0Fc3wEXM/yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-ivM-dGSJM1eeyFLSix0CsA-1; Thu, 09 Apr 2020 11:43:38 -0400
X-MC-Unique: ivM-dGSJM1eeyFLSix0CsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0021CDB66;
        Thu,  9 Apr 2020 15:43:36 +0000 (UTC)
Received: from krava (unknown [10.40.196.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A33560BF3;
        Thu,  9 Apr 2020 15:43:34 +0000 (UTC)
Date:   Thu, 9 Apr 2020 17:43:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Zero ena and run for interval mode
Message-ID: <20200409154332.GD3309111@krava>
References: <20200409070755.17261-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409070755.17261-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:07:55PM +0800, Jin Yao wrote:
> As the code comments in perf_stat_process_counter() say,
> we calculate counter's data every interval, and the display
> code shows ps->res_stats avg value. We need to zero the stats
> for interval mode.
> 
> But the current code only zeros the res_stats[0], it doesn't
> zero the res_stats[1] and res_stats[2], which are for ena
> and run of counter.
> 
> This patch zeros the whole res_stats[] for interval mode.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

nice catch ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/stat.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 5f26137b8d60..242476eb808c 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -368,8 +368,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>  	 * interval mode, otherwise overall avg running
>  	 * averages will be shown for each interval.
>  	 */
> -	if (config->interval)
> -		init_stats(ps->res_stats);
> +	if (config->interval) {
> +		for (i = 0; i < 3; i++)
> +			init_stats(&ps->res_stats[i]);
> +	}
>  
>  	if (counter->per_pkg)
>  		zero_per_pkg(counter);
> -- 
> 2.17.1
> 

