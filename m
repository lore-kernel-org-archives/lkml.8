Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F8A206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CreWbZrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD1KwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:52:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45441 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgD1KwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588071125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+DATouWaEe2jPNagjdiXPLUjwQpgYMzZZtq37hZJbg=;
        b=CreWbZrGEMK/VcBB5e01DBn34JU0/+RPEpCA4/e2WcKRF+068I81SmqolCL8ii1gKfgRTG
        VTMGQ1rViz0fHVyGLtgonpMZDE3tYnqba4FJbIxrnMxUIEoxwXhsBh+O6fzxWyyj980+Ji
        xa6Yqzmn1BPw4bPPP9qHtihMBb/o4RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Y21dZNK8PKKsYSs6Fo-svw-1; Tue, 28 Apr 2020 06:52:01 -0400
X-MC-Unique: Y21dZNK8PKKsYSs6Fo-svw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446BC84B8A0;
        Tue, 28 Apr 2020 10:52:00 +0000 (UTC)
Received: from krava (unknown [10.40.196.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF32B1001925;
        Tue, 28 Apr 2020 10:51:57 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:51:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix uncore event mixed metric with workload
 error issue
Message-ID: <20200428105155.GG1476763@krava>
References: <20200427144116.27330-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427144116.27330-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:41:16PM +0800, Jin Yao wrote:

SNIP

> index 9207b6c45475..b01ee06b1965 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1841,8 +1841,8 @@ static void setup_system_wide(int forks)
>  	 * conditions is met:
>  	 *
>  	 *   - there's no workload specified
> -	 *   - there is workload specified but all requested
> -	 *     events are system wide events
> +	 *   - there is workload specified but at least one requested
> +	 *     event is system wide event
>  	 */
>  	if (!target__none(&target))
>  		return;
> @@ -1851,13 +1851,16 @@ static void setup_system_wide(int forks)
>  		target.system_wide = true;
>  	else {
>  		struct evsel *counter;
> +		bool system_wide = false;
>  
>  		evlist__for_each_entry(evsel_list, counter) {
> -			if (!counter->core.system_wide)
> -				return;
> +			if (counter->core.system_wide) {
> +				system_wide = true;
> +				break;
> +			}

I wonder this would break some expectations.. would it be
more safe to detect duration event and bypass it from the
decission? but maybe the case I'm worried about is not a
problem at all.. Andi?

jirka

>  		}
>  
> -		if (evsel_list->core.nr_entries)
> +		if (evsel_list->core.nr_entries && system_wide)
>  			target.system_wide = true;
>  	}
>  }
> -- 
> 2.17.1
> 

