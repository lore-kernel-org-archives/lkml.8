Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36939206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crVfh8S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFDVVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:21:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88688C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:21:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so1668248pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HmkJltUO28NwQuxDZ37g/BlLiFgZijm7NPnKleMlL+A=;
        b=crVfh8S/exP/Ro93kEhQMov5cpjyW13/HCN8lPuDUiXuDLJVKB7KiXGrL0Kxbrbb+R
         y4t/8dy+BjanjMVpsHrU6L92i0ohEB8W54XGWLynF79P/QR4c9eXofPbSea3/ySYUDrn
         YHVNv2RNDzIswlImMsOdEa1HU8zDETqXNqJHEH2Thdb926B9l3G37BYImG1bDxGbihKy
         yXsZFAIHIy2sUCEiA1vFY7mfYaTUWNzh/ikhbECsZ2Ecajhon9XumFqG9MswrzjEmcCc
         Q+dYDB49gOvaxvKUDdJnHB9BRe43DVMDEm5KG34FQNlFkd67VcISZqs2gzCxnWw1gHE/
         Cmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HmkJltUO28NwQuxDZ37g/BlLiFgZijm7NPnKleMlL+A=;
        b=TglAbGAK58akYhiSoHaeZo9lpfoPyOGjIuUfh2KnB0OuCNcX8spFBiIt8UlbPUECSR
         CneOwyfLUIPFd6wPId2kh/WknMzbbjw0We7rqaOCpixCR32+39cdh/8D43wG1xijLu6d
         6lG5IpE7B2SkCCNvA9AmXcAJmJxTtdFQilYPQTDb+nRt1Pivsh/V+haL7w3mtFbY9SN3
         tvTILu99Z3tE/ulMtbi72vruhVyWgqekyfXpR236zL40LHAD8PHNLi5Ui660pUuLTIIg
         8w5sCfG0a6jjzN5w/VpnpkEtHKjNTo9j0H5rg+Euddc917VKHol2NugcfbXrqQf+zsgl
         sxwA==
X-Gm-Message-State: AOAM530/RvUxdc6K26mkiK45ylftMxh/jBdTsjpfaG7sxd1vCloaTKr0
        2pcPpyhNuSz+DasKyXWu+jFLyw==
X-Google-Smtp-Source: ABdhPJzNlal1wl8ySxossrsQYPskSXenK/74RyXOG49eZfvl1keSh8yWC4+TJ+ZVyaS83GMbHk9G5g==
X-Received: by 2002:a17:902:ab8b:: with SMTP id f11mr6866714plr.145.1591305702081;
        Thu, 04 Jun 2020 14:21:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y23sm6472519pje.3.2020.06.04.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:21:41 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:21:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH v4 1/1] perf: cs-etm: Allow no CoreSight sink to be
 specified on command line
Message-ID: <20200604212139.GE18961@xps15>
References: <20200526105310.9706-1-mike.leach@linaro.org>
 <20200526105310.9706-2-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526105310.9706-2-mike.leach@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:53:10AM +0100, Mike Leach wrote:
> Adjust the handling of the session sink selection to allow no sink to
> be selected on the command line. This then forwards the sink selection to
> the CoreSight infrastructure which will attempt to select a sink based
> on the default sink select priorities.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 941f814820b8..ed9ea2c60f27 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -242,10 +242,10 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
>  	}
>  
>  	/*
> -	 * No sink was provided on the command line - for _now_ treat
> -	 * this as an error.
> +	 * No sink was provided on the command line - allow the CoreSight
> +	 * system to look for a default
>  	 */
> -	return ret;
> +	return 0;

Leo added a tested-by for this patch. As I wrote on a previous patch we are
currently in the middle of the merge window and as such this set needs to be
rebased on v5.8-rc1 (when it comes out) and sent again.

Thanks,
Mathieu

>  }
>  
>  static int cs_etm_recording_options(struct auxtrace_record *itr,
> -- 
> 2.17.1
> 
