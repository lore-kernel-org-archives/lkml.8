Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04900C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EF92072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNlEBamk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgICRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:47:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E8C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:47:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so1821924pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uho6H+6cq1mUUNMmCmm2pdenHSQWJ5gH77w73EO1KkU=;
        b=cNlEBamkE+KzQgpA181/XyRXuQMJEXg93JsgqtgKXiHRaHkqgaCMzyGfqWFr9nrdHX
         0OyktzLobJj9BnHM63YWJD/Osd4wAiLCiMY5FGd9Jyl+/2x283S8HKD/9K2Ye+7NnLxX
         60wEXEoTEtqYE9LrO4RcWzsbsUiu8ufIx97/mVG9ea4sDysXjkFA40Fusg3YKkUCleul
         y5Fumc4PEc6pe1s9LGTMmtyIUnfuv6jyX2SjKeFUkdwWY5CSuF9hzOyc6+9yJZNfX8OR
         6yUXItCim/igsle/V8oR9mCFBcK4J2Adbs4fP8qr8tyNW3qZ2tymqXBm64BbosNm9pgk
         jSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uho6H+6cq1mUUNMmCmm2pdenHSQWJ5gH77w73EO1KkU=;
        b=USQyeJQFoFDjiZ2nTbZnAzH4zTjh0LlWp1HrkdLpHfJ8SRSIKM7tFCgLBkTTbAvBpx
         dqCkpGZpOCUCBxBNRitW5238PKfmvqqtoYQDmevUDydouCSOw1XxGRhezsP9l31DKBPJ
         hNpgKzdM9AYQaXn3XoRSrcUF9g1cjWf1RvtynTf6jPZ5VEwMZ3O+IM7HYMcZPmSBWmcZ
         CFGUc2Pnno1ELGl0QutcQrnqRUaSQciREzA2j4YHnAo960pEDMFHM278DGFGFrgQm06v
         pkW7yhKu0SGecpyiI4TPcyyF/FWWgSjg7VfnSe5ClrMN++1bB5U0Ngx6vSYPkRSxVZ3U
         rtyg==
X-Gm-Message-State: AOAM530EQAVln91NCBT0lnPP6INwVQanamFHcKCzsCgc+paGbTunqp/g
        DidF+xxqWKJBN0LAVoYVBhn8MZL3jFdsaw==
X-Google-Smtp-Source: ABdhPJwTUMqMVGCPKKjk+OiQsu0K83avIfewUQEsv+HmE1TmU8Bjl5/4vTYVTvlUT0kRCy7CwI3WqA==
X-Received: by 2002:a17:90a:6a0d:: with SMTP id t13mr4622621pjj.208.1599155238807;
        Thu, 03 Sep 2020 10:47:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s8sm4057359pfm.180.2020.09.03.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 10:47:18 -0700 (PDT)
Date:   Thu, 3 Sep 2020 11:47:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v2] coresight: etm4x: Handle unreachable sink in perf mode
Message-ID: <20200903174716.GD312784@xps15>
References: <20200902152847.195909-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902152847.195909-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:28:47PM +0100, Suzuki K Poulose wrote:
> If the specified/hinted sink is not reachable from a subset of the CPUs,
> we could end up unable to trace the event on those CPUs. This
> is the best effort we could do until we support 1:1 configurations.
> Fail gracefully in such cases avoiding a WARN_ON, which can be easily
> triggered by the user on certain platforms (Arm N1SDP), with the following
> trace paths :
> 
>  CPU0
>       \
>        -- Funnel0 --> ETF0 -->
>       /                        \
>  CPU1                           \
>                                   MainFunnel
>  CPU2                           /
>       \                        /
>        -- Funnel1 --> ETF1 -->
>       /
>  CPU1
> 
> $ perf record --per-thread -e cs_etm/@ETF0/u -- <app>
> 
> could trigger the following WARNING, when the event is scheduled
> on CPU2.
> 
> [10919.513250] ------------[ cut here ]------------
> [10919.517861] WARNING: CPU: 2 PID: 24021 at
> drivers/hwtracing/coresight/coresight-etm-perf.c:316 etm_event_start+0xf8/0x100
> ...
> 
> [10919.564403] CPU: 2 PID: 24021 Comm: perf Not tainted 5.8.0+ #24
> [10919.570308] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
> [10919.575865] pc : etm_event_start+0xf8/0x100
> [10919.580034] lr : etm_event_start+0x80/0x100
> [10919.584202] sp : fffffe001932f940
> [10919.587502] x29: fffffe001932f940 x28: fffffc834995f800
> [10919.592799] x27: 0000000000000000 x26: fffffe0011f3ced0
> [10919.598095] x25: fffffc837fce244c x24: fffffc837fce2448
> [10919.603391] x23: 0000000000000002 x22: fffffc8353529c00
> [10919.608688] x21: fffffc835bb31000 x20: 0000000000000000
> [10919.613984] x19: fffffc837fcdcc70 x18: 0000000000000000
> [10919.619281] x17: 0000000000000000 x16: 0000000000000000
> [10919.624577] x15: 0000000000000000 x14: 00000000000009f8
> [10919.629874] x13: 00000000000009f8 x12: 0000000000000018
> [10919.635170] x11: 0000000000000000 x10: 0000000000000000
> [10919.640467] x9 : fffffe00108cd168 x8 : 0000000000000000
> [10919.645763] x7 : 0000000000000020 x6 : 0000000000000001
> [10919.651059] x5 : 0000000000000002 x4 : 0000000000000001
> [10919.656356] x3 : 0000000000000000 x2 : 0000000000000000
> [10919.661652] x1 : fffffe836eb40000 x0 : 0000000000000000
> [10919.666949] Call trace:
> [10919.669382]  etm_event_start+0xf8/0x100
> [10919.673203]  etm_event_add+0x40/0x60
> [10919.676765]  event_sched_in.isra.134+0xcc/0x210
> [10919.681281]  merge_sched_in+0xb0/0x2a8
> [10919.685017]  visit_groups_merge.constprop.140+0x15c/0x4b8
> [10919.690400]  ctx_sched_in+0x15c/0x170
> [10919.694048]  perf_event_sched_in+0x6c/0xa0
> [10919.698130]  ctx_resched+0x60/0xa0
> [10919.701517]  perf_event_exec+0x288/0x2f0
> [10919.705425]  begin_new_exec+0x4c8/0xf58
> [10919.709247]  load_elf_binary+0x66c/0xf30
> [10919.713155]  exec_binprm+0x15c/0x450
> [10919.716716]  __do_execve_file+0x508/0x748
> [10919.720711]  __arm64_sys_execve+0x40/0x50
> [10919.724707]  do_el0_svc+0xf4/0x1b8
> [10919.728095]  el0_sync_handler+0xf8/0x124
> [10919.732003]  el0_sync+0x140/0x180
> 
> Even though we don't support using separate sinks for the ETMs yet (e.g,
> for 1:1 configurations), we should at least honor the user's choice and
> handle the limitations gracefully, by simply skipping the tracing on ETMs
> which can't reach the requested sink.
> 
> Fixes: f9d81a657bb8 ("coresight: perf: Allow tracing on hotplugged CPUs")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I have applied your patch.

Thanks,
Mathieu

> ---
> Change since v1:
>  - Updated the description, added Tested-by.
>  - No code changes
>  - Rebased on coresight/next
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 1a3169e69bb1..9d61a71da96f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -321,6 +321,16 @@ static void etm_event_start(struct perf_event *event, int flags)
>  	if (!event_data)
>  		goto fail;
>  
> +	/*
> +	 * Check if this ETM is allowed to trace, as decided
> +	 * at etm_setup_aux(). This could be due to an unreachable
> +	 * sink from this ETM. We can't do much in this case if
> +	 * the sink was specified or hinted to the driver. For
> +	 * now, simply don't record anything on this ETM.
> +	 */
> +	if (!cpumask_test_cpu(cpu, &event_data->mask))
> +		goto fail_end_stop;
> +
>  	path = etm_event_cpu_path(event_data, cpu);
>  	/* We need a sink, no need to continue without one */
>  	sink = coresight_get_sink(path);
> -- 
> 2.24.1
> 
