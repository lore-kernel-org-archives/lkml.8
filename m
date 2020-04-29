Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96183C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBCC21D90
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1qiKgNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD2SLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:11:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF2C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:11:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w29so2699102qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSjpzk4GKD4rtzuDjwyNiMCz02SClbaDJ2PcUXYhH2Q=;
        b=k1qiKgNrxS3qAHWZd5BbwP9B95GdNvgf9v7rUNasIKv7D2BS8OeWQiuFxnLvyls5OJ
         CY/Qd8rnm1DwJrgzXoc+AQ+decXkaYhrt2rwC+6uW4pAhbi8RS9DaR3mt9cR6ayxC70S
         QkROxqK6uoHl9q6qjkcY120siTZi+3T5ChQFHgyLoAKD4oc55IiRe7WA86wUYYOBVAGP
         kzVdUkm+kznrbpiN5P8NSwtt0ZE2pweBneas9FT5EG0wxVGSzbmZ7XmSzoVv0qsls60/
         WU8UsSKQXr2yyTMdxvIhtDPyzX58zkjNR8wUmc0tliGBPV5GTf6TyS7TKtrXuGKRNWsC
         63pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSjpzk4GKD4rtzuDjwyNiMCz02SClbaDJ2PcUXYhH2Q=;
        b=bSCYxxcfc2WrIVQmXk81FF176s5PJLaRo3NuAxIaLqJREU3cPb/KX1r6+kj4RyJZ5f
         6j+alsl7jzPZZvoHdBewaI/JaC5SdS179O1OMQ6987ocJkk0xgC1aTvPf9EW8X+gCB2j
         QLjrplfw3bcNqpBOn3gcErFK5sFYgQU8krPjTx8jq4sL9QqD3NCLruS7A+gm6rn9kEkb
         /2/JMPUbf8rkX4vbdrf0WTwfMin7zAyNPRAbtiysbLg7aHWLN0i3J5e8lBZ29UJJCoFk
         47b0Ok/bs3wUKQ1pa0QEChGYr2XG/aUbPWg91NydKZxwk+btUo7wremT5Gyq2awasou4
         IaHQ==
X-Gm-Message-State: AGi0PuaGLktH8vhhoQp/GtDF85ZNLNsAQnqvpe5XR7HxlFgwcrHijIrM
        +DWa4SpGPKEVOkYI4hGLtac=
X-Google-Smtp-Source: APiQypJeLHEmaD1LMhYHwVVDzUxcGYVdnxr0YFTBxagSfSK0r9iYg/rffbLquYNdNDfOBLl9CevssA==
X-Received: by 2002:ac8:2c78:: with SMTP id e53mr35966221qta.365.1588183865162;
        Wed, 29 Apr 2020 11:11:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p80sm16414571qka.134.2020.04.29.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:11:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 564BA409A3; Wed, 29 Apr 2020 15:11:02 -0300 (-03)
Date:   Wed, 29 Apr 2020 15:11:02 -0300
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH v2 1/3] perf tool: fix reading new topology attribute
 "core_cpus"
Message-ID: <20200429181102.GE30487@kernel.org>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158817718710.747528.11009278875028211991.stgit@buzz>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 07:19:47PM +0300, Konstantin Khlebnikov escreveu:
> Check access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK) fails,
> unless current directory is "/sys". Simply try read this file first.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
> ---
>  tools/perf/util/smt.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied,

- Arnaldo
 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 3b791ef2cd50..8481842e9edb 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -24,13 +24,13 @@ int smt_on(void)
>  
>  		snprintf(fn, sizeof fn,
>  			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
> -		if (access(fn, F_OK) == -1) {
> +		if (sysfs__read_str(fn, &str, &strlen) < 0) {
>  			snprintf(fn, sizeof fn,
>  				"devices/system/cpu/cpu%d/topology/thread_siblings",
>  				cpu);
> +			if (sysfs__read_str(fn, &str, &strlen) < 0)
> +				continue;
>  		}
> -		if (sysfs__read_str(fn, &str, &strlen) < 0)
> -			continue;
>  		/* Entry is hex, but does not have 0x, so need custom parser */
>  		siblings = strtoull(str, NULL, 16);
>  		free(str);
> 

-- 

- Arnaldo
