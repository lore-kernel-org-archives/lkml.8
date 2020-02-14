Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8F024696
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696753;
	bh=DTuml5/KwJ6gZJ6eoU4PHeXh4oaNidhI++FJPDyWeK8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ssO9A4T3yr9k+UGdnyKEFoN0cn6/YKECof4MDVXr/6LM3I4jbxq6iKfwevDvR3+Sk
	 J2FpnCbypda0taG4PjDsumbP7HoWCQBNt7Qycg/U5ULdOKCfRDUJGhPO2RaBC+5r0w
	 msRqJ4qpTQo1foIUf0pv409TdPVYH+Dg+Me1tsqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392002AbgBNQMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:31 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45541 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391784AbgBNQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:27 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so8481286iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qApqAO5hEns7IADRO9DjZ1reRHVH3awB76VUzfWwdWc=;
        b=Y/UZScE06f+HTGyuvIOtXtbGdWIaDawrdPkXjF43C+BuaEf1y6sJbC0/Kh5Us6bYRB
         XH9Jzsxj2JjlUcZvCW9kOEz45hRiBk7nSf1jdXgqqzQHlrD20yvGutFfM+MpCnttW7P1
         ycvLvZX2nsMh7yAE7pRqzZ0YH2R0jTMRiMKgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qApqAO5hEns7IADRO9DjZ1reRHVH3awB76VUzfWwdWc=;
        b=aokCiPrGBJANgku5XNruRb0mwcwRs1Qw7haMi/gW81RNuLH4/5KgMnkY6lhGm4xUie
         +mxRca363rV8rEnS7Iw26N/SYke504a/d3fyPa60DeVi9QZ9uT/mb2OMPEA1GaN6Ww2H
         lbteLDFcQSagW3iPgfy3ngbWq6TJicn3ZMY2v5226k8iQEp7s3JTOkcUWjmO1Z1NElgv
         nOxsnnvT7QUvHyje9T4/21vs/oXlNX2btoQsc8SfDs3RQM9+za0YCrr7dPLq3ZsDcfh6
         EsVRA8FZlP8uot8sRTpuJNGSKStdUpFnUXqfzR04Nc8Rs6ZrIfeIg+eKXFeIIeJFyzIy
         EJmA==
X-Gm-Message-State: APjAAAUhoAJ13ppMRt/d2OVwkncMDjL6EWsELpqMVMualWC5SxITLKnu
        Tt0raUGwDoKKCAmKBuse+UNfWQ==
X-Google-Smtp-Source: APXvYqw5kux6yT2PzNVB2GnOfMGklo71kZRMAlCHzaJrAenMxgajv5Mr+xm2BvlnIl2AaL6rDatjbw==
X-Received: by 2002:a92:c747:: with SMTP id y7mr3462676ilp.60.1581696686860;
        Fri, 14 Feb 2020 08:11:26 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l17sm2085819ilc.49.2020.02.14.08.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 08:11:26 -0800 (PST)
Subject: Re: [PATCH v6 1/6] perf/cgroup: Reorder perf_cgroup_connect()
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191206231539.227585-1-irogers@google.com>
 <20200214075133.181299-1-irogers@google.com>
 <20200214075133.181299-2-irogers@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <28dafe17-5a63-cc69-4f1e-fd75edb8b1bd@linuxfoundation.org>
Date:   Fri, 14 Feb 2020 09:11:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214075133.181299-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 12:51 AM, Ian Rogers wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Move perf_cgroup_connect() after perf_event_alloc(), such that we can
> find/use the PMU's cpu context.

Can you elaborate on this usage? It will helpful to know how
this is used and what do we get from it. What were we missing
with the way it was done before?


> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   kernel/events/core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3f1f77de7247..9bd2af954c54 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10804,12 +10804,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   	if (!has_branch_stack(event))
>   		event->attr.branch_sample_type = 0;
>   
> -	if (cgroup_fd != -1) {
> -		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> -		if (err)
> -			goto err_ns;
> -	}
> -
>   	pmu = perf_init_event(event);
>   	if (IS_ERR(pmu)) {
>   		err = PTR_ERR(pmu);
> @@ -10831,6 +10825,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   		goto err_pmu;

Is this patch based on linux-next or linux 5.6-rc1. I am finding code
path to be different in those. Also in 
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git

goto err_ns makes more sense since if perf_init_event() doesn't return
valid pmu, especially since err_pmu tries to do a put pmu->module.

Something doesn't look right.


>   	}


>   
> +	if (cgroup_fd != -1) {
> +		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> +		if (err)
> +			goto err_pmu;
> +	}
> +
>   	err = exclusive_event_init(event);
>   	if (err)
>   		goto err_pmu;
> @@ -10891,12 +10891,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   	exclusive_event_destroy(event);
>   
>   err_pmu:
> +	if (is_cgroup_event(event))
> +		perf_detach_cgroup(event);
>   	if (event->destroy)
>   		event->destroy(event);
>   	module_put(pmu->module);
>   err_ns:
> -	if (is_cgroup_event(event))
> -		perf_detach_cgroup(event);
>   	if (event->ns)
>   		put_pid_ns(event->ns);
>   	if (event->hw.target)
> 

thanks,
-- Shuah
