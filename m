Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF762206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc9GC/q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgE2Eon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE2Eom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:44:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3698CC08C5C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:44:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so623869pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TSemzb3dqlu5hiVSHS+Hj5ocpjzPNZhkfK/fQHweg94=;
        b=Gc9GC/q6JIDcq5qCFx6QtKtFBG9pGJ0jswzlU/WU8bSCq3SiaZtPd7/Y7qvLkVvBQt
         uUCo8VLB6Eeq4FyWlmRY11LqDDZDBRvyZpv87uWcewyMPVYZa28pWzHgVymu93yZ6+Mp
         qU2sJZg0VP2Yv+wPBP4reiFPcwrkXwek2ZdT4kUiP0HYzM+TBpgRLmnymK54xDv0omAR
         VoEhvuuknaO1ud6O1YBCpipSThcvpKcqHvVceKnmZraUO2dMXbrh65QnHHpnOvvDXsdJ
         ydH9WtErG7aeMUFRxSyYhSTATX8yjfxjEQdlqnQU205ZHcAY4/B4/U22fi3XL+p9+fFo
         5u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSemzb3dqlu5hiVSHS+Hj5ocpjzPNZhkfK/fQHweg94=;
        b=QxDnyX+wZW88bXnxeNtj7DaRqVEqUDKfEOOkZikeDyVOzRpc4jHW8zpSdHBQcEOp9w
         thOicxu9od38xAoKzyC7vZdztrgwviEjB+RovhtkB0jU45gUWLhvOFRkL8TRZReJWkCd
         2w+y+ly7170ACXzLTRv+j+u1NQsi5pSA7gGxRmGSm4sbxaVxzjgnvwYasBdj5yxe2tjq
         xb/yLZPshfaU+bnkeeK2KmFnkRK/PaJgRF0Rxw1yIzCBPCWLj9nPacdbznhFXhA+/039
         DAunHJ6apooOVtUgtHJrE9FfFUKu0cAfEwOQcxDC0DTS/0KdFPty8YQffjqENpOm424l
         /WZg==
X-Gm-Message-State: AOAM530Xkc8Lta1u8udonI+YHBJOdvnC08FrjAN+pFeFN3HfrAVEXgLq
        rPgA5KAgWqFSvAmKL8jvRayN0w==
X-Google-Smtp-Source: ABdhPJwCwEYSFkgpKp43mpNdmaCGr0pAiysoJt/rRf7SmuzVNwJa2UYzSDsNkgFLSFiCf/joUZsq7A==
X-Received: by 2002:a17:90a:2242:: with SMTP id c60mr7784943pje.224.1590727480482;
        Thu, 28 May 2020 21:44:40 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id t4sm3157356pfh.5.2020.05.28.21.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 21:44:39 -0700 (PDT)
Date:   Fri, 29 May 2020 10:14:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200529044437.5wmbbews2vn66dia@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-5-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>  {
>  	struct dev_pm_opp *opp;
> -	int count, supply_size;
> +	int supply_count, supply_size, icc_size;
>  
>  	/* Allocate space for at least one supply */
> -	count = table->regulator_count > 0 ? table->regulator_count : 1;
> -	supply_size = sizeof(*opp->supplies) * count;
> +	supply_count = table->regulator_count > 0 ? table->regulator_count : 1;
> +	supply_size = sizeof(*opp->supplies) * supply_count;
> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
>  
>  	/* allocate new OPP node and supplies structures */
> -	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> +	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
> +
>  	if (!opp)
>  		return NULL;
>  
>  	/* Put the supplies at the end of the OPP structure as an empty array */
>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
>  	INIT_LIST_HEAD(&opp->node);

Added this delta here.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7302f2631f8d..dfbd3d10410c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1330,7 +1330,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 
        /* Put the supplies at the end of the OPP structure as an empty array */
        opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
-       opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
+       if (icc_size)
+               opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
        INIT_LIST_HEAD(&opp->node);
 
        return opp;


-- 
viresh
