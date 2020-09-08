Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B32C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A17206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEjB2PVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgIHQad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbgIHQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:27:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F8C0A3BE2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:54:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so16682101oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5WD7mYu1UZ17o5IwyM77lKheQXm/FoO3alEWArs8d8=;
        b=gEjB2PVRSfcdabC2to0ytgzJqyIE1We/Z9N99i/QXWyfZI29q9ILSekgH2UoRUTGo1
         mTSM6e38qq85pZ/1eQaDy5C9Ri71lBuFgqahCU3dDMEpfMcdod4JVa9HEaInoH/SEQwl
         Vh+EggBAgwVJ02di4FQXo38idBxXJArYd4VMOiIOZLi0ViL4a5UwDGnd0P5ZZiwoK6Ce
         IVuzaRE6dO5Er+fpuifC/1vBBr848mgts7QN0VCcqSs/Uf8+mrE8pvTPpMphF6Y6rwxu
         Ld+/jSsFye84Q/SxKreWOUnNkIEfxQWleKPBpMSNTFUHQVum/1MC+NmkLK4MmJsI7COx
         fgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5WD7mYu1UZ17o5IwyM77lKheQXm/FoO3alEWArs8d8=;
        b=tBocdiL9EC+bIKz9INx2f5rFUhsbamYdW7LyLjfwrzXzzB5ksTwFD1e0sSv6HexReK
         QmT2v2/s9k2lcmkrGEShoFMJ2lpX4wHvzW370efQ3mprXC6k+tjDYFctGCoFFslzEFr5
         2hwWwKSN3kIjrSJGlCmyj1wThWkwlRcnTGKO/FGJoeXXB1nxGPv8R2gf1T5TJnWLG2Sa
         z02hhJhOXrOyx+HxhK3uqqCZB0tvCq2h2pJRC9/tXNq5b63X84mTx6Y9mOSxBkZqM/Rd
         DHkzR2pN8Vq+//K5CUiINyZkiYO5UA0qxOak519SzLZkcMbsk+8HuHHLcFJF8f3NOkLL
         lRMQ==
X-Gm-Message-State: AOAM530JR2ozl3xIYi8x4wBDH6Kbr6JV6rdsc9t4tlnunTPTT0ydybZV
        SxMKs+2g3FChJVQmx1/qZxinjg==
X-Google-Smtp-Source: ABdhPJwfgX5hiHCKByDlCicvW5Vmn/1mu2VuOJ8ql9YPirRsdRzLX51mj7XJnCv+3+D49GSpE6m/uA==
X-Received: by 2002:aca:df84:: with SMTP id w126mr1740500oig.103.1599576894821;
        Tue, 08 Sep 2020 07:54:54 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id l5sm3498342otj.40.2020.09.08.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 07:54:54 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:54:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: qcom: fix SLIBMUS/SLIMBUS typo
Message-ID: <20200908145450.GM3715@yoga>
References: <20200908140818.28373-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908140818.28373-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Sep 09:08 CDT 2020, Jonathan Marek wrote:

> Fix slimbus case being broken thanks to a typo.
> 
> Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> This should be squashed into the problematic patch if possible,
> but I'm not sure if that's possible since its already in linux-next?
> 
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 100af93a5eab..c406a079d237 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -780,7 +780,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> -#if IS_ENABLED(CONFIG_SLIBMUS)
> +#if IS_ENABLED(CONFIG_SLIMBUS)
>  	if (dev->parent->bus == &slimbus_bus) {
>  #else
>  	if (false) {
> -- 
> 2.26.1
> 
