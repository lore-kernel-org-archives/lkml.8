Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D7320724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aExmPbWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCMLdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:33:33 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36365 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCMLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:33:32 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so942282pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqWkBQ+UQoj3qonw3F8cFJSQqNQ+pWh1jUw1LgUoqD4=;
        b=aExmPbWUsZEV7sFZwkmnUXHpmKtR7RVepsbHTvtgwOPSj6PaCaaaNGNUEFZP/l+Q5D
         iMrMyq5aPX5mwF6pZfNF5itieysdHiCD6txAYL0h2aE1sq5tBLjADz99NaxeDVqNF2KT
         uZOsAvDlo71DJ4tWb/znVK4AgPCdhvQXuhaY2xvOOneY7xDMFPHCvRZ8220iABJWwavF
         xuxc4Vlzbo0i4A8uefQ5YbKhgaJWcmgum5rj3n1fCoNuS7h9aZ3IYcgIWXtotUAOXjeU
         V14XdbkUqJ6i4FNNap3KC4i+SV6E4A6eSNU8krUvp9CmnQWnlJ3t1f7DvGNVVVkfGQ3T
         gwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqWkBQ+UQoj3qonw3F8cFJSQqNQ+pWh1jUw1LgUoqD4=;
        b=nyMOi4VPenc/ew0jtq5cTjf+S8fIuIusNjzAQJjO9YhhDg4//+NEFwtPHCp4Mah43U
         JzmxBHEjLXhASyk3ghpMcTCECVwvYWi+yT+R1JnWWhiX3bpByMkzJAMnon1XzOlYFFTf
         8WKDFFSSPR5VjX1GyPC/B3Eucws3vTkNf35faixYwEiUGlt/AYcI3xBWs89BScdXPFSc
         8/4A/ztEAnd+nXXRLzUFQpF9UpSQ5BPU8fGGoRXopLC9Hu9ZOEAwAX+OQ4X79TJ6W2jQ
         f09mpoT8ccQ9fDeVbADAQqsNd5Ybk3ULvvsHMnBG3csYxjsssuFs7L/DBxvkvauG93LK
         uchQ==
X-Gm-Message-State: ANhLgQ20l1znDj/XZ5bsH3XCMfiBGaI407XfbxMlbfqrPWn1DvHM3Zy5
        spJKyb+V+TT4sn37yvJUlxeOkA==
X-Google-Smtp-Source: ADFU+vv8WTv+xIg1ExTl2Wez3rJG869zbTz19yhBWtmKute2nxlgZEWIy1kMVZF5Sqdk+CbnbBIBbw==
X-Received: by 2002:a17:902:d885:: with SMTP id b5mr12806651plz.109.1584099211290;
        Fri, 13 Mar 2020 04:33:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:ee42])
        by smtp.gmail.com with ESMTPSA id a24sm8435284pfl.115.2020.03.13.04.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 04:33:30 -0700 (PDT)
Date:   Fri, 13 Mar 2020 19:33:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 3/3] perf report: Add SPE options to --itrace argument
Message-ID: <20200313113311.GA16574@leoy-ThinkPad-X240s>
References: <20200228160126.GI36089@lakrids.cambridge.arm.com>
 <20200306152520.28233-1-james.clark@arm.com>
 <20200306152520.28233-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306152520.28233-4-james.clark@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Mar 06, 2020 at 03:25:20PM +0000, James Clark wrote:
> From: Tan Xiaojun <tanxiaojun@huawei.com>
> 
> The previous patch added support in "perf report" for some arm-spe
> events(llc-miss, tlb-miss, branch-miss, remote_access). This patch
> adds their help instructions.
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Tested-by: Qi Liu <liuqi115@hisilicon.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/itrace.txt | 5 ++++-
>  tools/perf/util/auxtrace.h          | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index 82ff7dad40c2..da3e5ccc039e 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -1,5 +1,5 @@
>  		i	synthesize instructions events
> -		b	synthesize branches events
> +		b	synthesize branches events (branch misses on Arm)

This is not valid for Arm CoreSight actually.  Arm CoreSight can use
option 'b' to inject branch samples.  For this reason, suggest to
change as "(branch misses for Arm SPE)".

Thanks,
Leo

>  		c	synthesize branches events (calls only)
>  		r	synthesize branches events (returns only)
>  		x	synthesize transactions events
> @@ -9,6 +9,9 @@
>  			of aux-output (refer to perf record)
>  		e	synthesize error events
>  		d	create a debug log
> +		m	synthesize LLC miss events
> +		t	synthesize TLB miss events
> +		a	synthesize remote access events
>  		g	synthesize a call chain (use with i or x)
>  		l	synthesize last branch entries (use with i or x)
>  		s       skip initial number of events
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 80617b0d044d..52e148eea7f8 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -587,7 +587,7 @@ void auxtrace__free(struct perf_session *session);
>  
>  #define ITRACE_HELP \
>  "				i:	    		synthesize instructions events\n"		\
> -"				b:	    		synthesize branches events\n"		\
> +"				b:	    		synthesize branches events (branch misses on Arm)\n" \
>  "				c:	    		synthesize branches events (calls only)\n"	\
>  "				r:	    		synthesize branches events (returns only)\n" \
>  "				x:	    		synthesize transactions events\n"		\
> @@ -595,6 +595,9 @@ void auxtrace__free(struct perf_session *session);
>  "				p:	    		synthesize power events\n"			\
>  "				e:	    		synthesize error events\n"			\
>  "				d:	    		create a debug log\n"			\
> +"				m:	    		synthesize LLC miss events\n" \
> +"				t:	    		synthesize TLB miss events\n" \
> +"				a:	    		synthesize remote access events\n" \
>  "				g[len]:     		synthesize a call chain (use with i or x)\n" \
>  "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
>  "				sNUMBER:    		skip initial number of events\n"		\
> -- 
> 2.17.1
> 
