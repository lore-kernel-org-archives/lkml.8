Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863AFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6BF2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLxAfI3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgDBDEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:04:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41751 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbgDBDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:04:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so1166746pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZpcZ8k25ZOnNqiiEox+hd2FE0mXNC5NeCm2io35Gmk=;
        b=TLxAfI3RbRmmIqpenOTqSWfeQzOgrHIrHoxIxKC2Sv74++JtenW/cigbUj4150Zwj4
         AxZMY9QSHfIBnmp7Uck5+4LNz6SO6RK9jPE5Qf96TClUJzQGO03VKuiN6LD6sM/swb8v
         HPmvdfeAfrYT+tfKbjxMXhE1kVEerBClHKWVckEBxuKXkrvfHNNyP1x6H1oA0x+gqaQR
         0y+G6hzgqMGGbXeZjFKWL06PNMmpkAfetQv4Ml1Es/4Uf2bLrxZPpULKyvGHw7SDlCm4
         sVZRZ2OyqH8l7VNLtRu1uiQXlg81Jw4CxRJ/tX5JQ9djjqp9Q26zFY0xOZMThcJl7rqp
         tIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZpcZ8k25ZOnNqiiEox+hd2FE0mXNC5NeCm2io35Gmk=;
        b=GdnYPe8Ue4R3x/Q8OpHouvzhkUo+745PbQfDb9ZsZKb4H+8Sai358YkW+E23aNk8I8
         /SkRR+H1RY/xYr8LWz5qxdcKzWrJMNKaM1C0MSTUNsWcv3da/Zh7O7rHshBJIQibvC0t
         8WxoXttFRfBz5inmynDuvU01V0VD90eOlW6PRbW6iav2upC47L/FqASHYihXgX6h8N1f
         6/KTTrIrRYLwJr2IWbyfMSRSciO6S7kMhlNz9sM66Y80B1ZYFN1NzIt6FeECmCHFtp/b
         P3al/WSwdLV5QqpQ1dEelXUFRO1buPdoIg3E+RGIGEJUYS/SrIYyHGLz7ensUu9KPyY6
         A5Yw==
X-Gm-Message-State: AGi0PuZQrfDbtvfrI6MyFGFas4DlR/BmVAkNYC+EBdQii0Vufkhv9x1I
        R5z70Ji80U9+0Izj7xpQoy3W/isfo2nHCg==
X-Google-Smtp-Source: APiQypL/6ZXe7XUd+GPj1ov3ZqmolMDIu+D0tJDTDEneKBjWFjrRauRTHNu+AfFrU3Inoh19wI/uiQ==
X-Received: by 2002:aa7:9a1c:: with SMTP id w28mr1045237pfj.16.1585796642409;
        Wed, 01 Apr 2020 20:04:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id a8sm2372401pgg.79.2020.04.01.20.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 20:04:01 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:03:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH 04/16] perf arm-spe: Implement ->evsel_is_auxtrace()
 callback
Message-ID: <20200402030347.GA11494@leoy-ThinkPad-X240s>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401101613.6201-5-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:16:01PM +0300, Adrian Hunter wrote:
> Implement ->evsel_is_auxtrace() callback.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 53be12b23ff4..b30cc74d0fb4 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -176,6 +176,15 @@ static void arm_spe_free(struct perf_session *session)
>  	free(spe);
>  }
>  
> +static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
> +				      struct evsel *evsel)
> +{
> +	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
> +					     auxtrace);
> +
> +	return evsel->core.attr.type == spe->pmu_type;
> +}
> +
>  static const char * const arm_spe_info_fmts[] = {
>  	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
>  };
> @@ -218,6 +227,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->auxtrace.flush_events = arm_spe_flush;
>  	spe->auxtrace.free_events = arm_spe_free_events;
>  	spe->auxtrace.free = arm_spe_free;
> +	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
>  	session->auxtrace = &spe->auxtrace;

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  	arm_spe_print_info(&auxtrace_info->priv[0]);
> -- 
> 2.17.1
> 
