Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221E6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412320754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0vHcpWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRTut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:50:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33837 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:50:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so8735385qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEOQpqYn6CgovvKOFdT+64NDwASSivhcwjOVx02uKzQ=;
        b=L0vHcpWBdO7kIo5esoq1QHPt3pzkXF017hDBQKcuouSbjkoyLypm2mFaoz7YEQnxva
         PQv9sgyV97vK0kJLtcWuYj188YQmZokxXhPmHaPH+ENJwPm0/X61A3wsWYIPBJQyWrwZ
         y+aPNq5fDeGe5btpuaMdt2k6nhn+P5vNAaLajxKKFK0Y8olrEL6odPM6RJ5fYvbOsJUI
         f8PGpSI9CDGiS2uCGTuHQ4fEqx1udRj3M2XtCV/v87loc7FoBzy+RxuKQLgHzPwaZrqT
         R6PzKZwyQxcINXJl0OY8BYcUqa9IRh/EeFL/i1ozz7OoSpIlyokwaUNduf6NRv5N0PPg
         p4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEOQpqYn6CgovvKOFdT+64NDwASSivhcwjOVx02uKzQ=;
        b=OjE/ijSKSzJv+wDM6tQggFR9M+ygAYyqTO8Mb5Qu9lS0mXIcWWs/qip22w7YOfmLyz
         8V9QehN8WwWZ1PDVzRD+kKzbn3brKbFW2oBIF4w6KkiqM5XVwiMO1RkN8AOkjWCyqJhZ
         X2pcxsJJbpdn0MKp4O3gnA1ODdNTJ6MqOhv9MfQqeBXv6hebFf6Kv5lED8skcen+eG7W
         /TQPy0rzsrR/XQF7wB3VpjrdvLNHGNZAc/2BEnwuv64aQheP/sPYMaK+eA3/omH9eKuC
         LV/K34TWPVgPLwuSBbEYKXFzsz39NQgV1G/VfZmeZGCeOQ1n4FvNBOHm665bkoyqoOGU
         hn0g==
X-Gm-Message-State: ANhLgQ00SqcSDxfQY/Ym82Sxg4LJLzl8C9c/3GNiQbSV9SAaHh24+WMo
        p+UHn581Ncy5OxyKdkF9l9U=
X-Google-Smtp-Source: ADFU+vsXZiwbDhQn7Qt2Zqs1Sb22TVxWejaCZwMqLlZG0QT3hd7Z0/GzYBBPl/hocuCLyW/jW6Ov+A==
X-Received: by 2002:ac8:3032:: with SMTP id f47mr6237419qte.273.1584561048003;
        Wed, 18 Mar 2020 12:50:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m1sm5648053qtm.22.2020.03.18.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:50:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72BA8404E4; Wed, 18 Mar 2020 16:50:45 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:50:45 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V3 05/17] perf machine: Remove the indent in
 resolve_lbr_callchain_sample
Message-ID: <20200318195045.GT11531@kernel.org>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313183319.17739-6-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 11:33:07AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The indent is unnecessary in resolve_lbr_callchain_sample.
> Removing it will make the following patch simpler.
> 
> Current code path for resolve_lbr_callchain_sample()
> 
>         /* LBR only affects the user callchain */
>         if (i != chain_nr) {
>                 body of the function
>                 ....
>                 return 1;
>         }
> 
>         return 0;
> 
> With the patch,
> 
>         /* LBR only affects the user callchain */
>         if (i == chain_nr)
>                 return 0;
> 
>         body of the function
>         ...
>         return 1;
> 
> No functional changes.

Thanks for doing this,

-  Arnaldo
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/machine.c | 123 +++++++++++++++++++-------------------
>  1 file changed, 63 insertions(+), 60 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fd14f1489802..9021e5b6a2a9 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2177,6 +2177,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>  	int chain_nr = min(max_stack, (int)chain->nr), i;
>  	u8 cpumode = PERF_RECORD_MISC_USER;
>  	u64 ip, branch_from = 0;
> +	struct branch_stack *lbr_stack;
> +	struct branch_entry *entries;
> +	int lbr_nr, j, k;
> +	bool branch;
> +	struct branch_flags *flags;
> +	int mix_chain_nr;
>  
>  	for (i = 0; i < chain_nr; i++) {
>  		if (chain->ips[i] == PERF_CONTEXT_USER)
> @@ -2184,71 +2190,68 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>  	}
>  
>  	/* LBR only affects the user callchain */
> -	if (i != chain_nr) {
> -		struct branch_stack *lbr_stack = sample->branch_stack;
> -		struct branch_entry *entries = perf_sample__branch_entries(sample);
> -		int lbr_nr = lbr_stack->nr, j, k;
> -		bool branch;
> -		struct branch_flags *flags;
> -		/*
> -		 * LBR callstack can only get user call chain.
> -		 * The mix_chain_nr is kernel call chain
> -		 * number plus LBR user call chain number.
> -		 * i is kernel call chain number,
> -		 * 1 is PERF_CONTEXT_USER,
> -		 * lbr_nr + 1 is the user call chain number.
> -		 * For details, please refer to the comments
> -		 * in callchain__printf
> -		 */
> -		int mix_chain_nr = i + 1 + lbr_nr + 1;
> -
> -		for (j = 0; j < mix_chain_nr; j++) {
> -			int err;
> -			branch = false;
> -			flags = NULL;
> +	if (i == chain_nr)
> +		return 0;
>  
> -			if (callchain_param.order == ORDER_CALLEE) {
> -				if (j < i + 1)
> -					ip = chain->ips[j];
> -				else if (j > i + 1) {
> -					k = j - i - 2;
> -					ip = entries[k].from;
> -					branch = true;
> -					flags = &entries[k].flags;
> -				} else {
> -					ip = entries[0].to;
> -					branch = true;
> -					flags = &entries[0].flags;
> -					branch_from = entries[0].from;
> -				}
> +	lbr_stack = sample->branch_stack;
> +	entries = perf_sample__branch_entries(sample);
> +	lbr_nr = lbr_stack->nr;
> +	/*
> +	 * LBR callstack can only get user call chain.
> +	 * The mix_chain_nr is kernel call chain
> +	 * number plus LBR user call chain number.
> +	 * i is kernel call chain number,
> +	 * 1 is PERF_CONTEXT_USER,
> +	 * lbr_nr + 1 is the user call chain number.
> +	 * For details, please refer to the comments
> +	 * in callchain__printf
> +	 */
> +	mix_chain_nr = i + 1 + lbr_nr + 1;
> +
> +	for (j = 0; j < mix_chain_nr; j++) {
> +		int err;
> +
> +		branch = false;
> +		flags = NULL;
> +
> +		if (callchain_param.order == ORDER_CALLEE) {
> +			if (j < i + 1)
> +				ip = chain->ips[j];
> +			else if (j > i + 1) {
> +				k = j - i - 2;
> +				ip = entries[k].from;
> +				branch = true;
> +				flags = &entries[k].flags;
>  			} else {
> -				if (j < lbr_nr) {
> -					k = lbr_nr - j - 1;
> -					ip = entries[k].from;
> -					branch = true;
> -					flags = &entries[k].flags;
> -				}
> -				else if (j > lbr_nr)
> -					ip = chain->ips[i + 1 - (j - lbr_nr)];
> -				else {
> -					ip = entries[0].to;
> -					branch = true;
> -					flags = &entries[0].flags;
> -					branch_from = entries[0].from;
> -				}
> +				ip = entries[0].to;
> +				branch = true;
> +				flags = &entries[0].flags;
> +				branch_from = entries[0].from;
> +			}
> +		} else {
> +			if (j < lbr_nr) {
> +				k = lbr_nr - j - 1;
> +				ip = entries[k].from;
> +				branch = true;
> +				flags = &entries[k].flags;
> +			} else if (j > lbr_nr)
> +				ip = chain->ips[i + 1 - (j - lbr_nr)];
> +			else {
> +				ip = entries[0].to;
> +				branch = true;
> +				flags = &entries[0].flags;
> +				branch_from = entries[0].from;
>  			}
> -
> -			err = add_callchain_ip(thread, cursor, parent,
> -					       root_al, &cpumode, ip,
> -					       branch, flags, NULL,
> -					       branch_from);
> -			if (err)
> -				return (err < 0) ? err : 0;
>  		}
> -		return 1;
> -	}
>  
> -	return 0;
> +		err = add_callchain_ip(thread, cursor, parent,
> +				       root_al, &cpumode, ip,
> +				       branch, flags, NULL,
> +				       branch_from);
> +		if (err)
> +			return (err < 0) ? err : 0;
> +	}
> +	return 1;
>  }
>  
>  static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
> -- 
> 2.17.1
> 

-- 

- Arnaldo
