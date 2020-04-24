Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C4C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122AF2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfGgPPK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDXFgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbgDXFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:36:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1AC09B046
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:36:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so3340101pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZhnONtykAfnsqa3IwkU1k8fhowiK4Exd+SQDhYlxkkE=;
        b=TfGgPPK1TxT3gMb2eG8p5CMEtzEyu18TYw54WstOEXZqF21dCs6qJQG+nvSUs1+a35
         iAX1DZKjE/o9OctBDxHYW66jJj4RXh5CLglh0R31oAmwjOL7pW+cYeg2fs5l0/ecFggW
         NDsP+lX3nuoZ0vTEJnGACD3nPLdyZpNuJrV2pHg/LvSzvnBuuFHZs6nmapUTTBPnvZPZ
         +lCfJa9Ir+IXhtCbzbK0JvKKgrig+WObsgtyXrGIDRBhkBZ+PdKdQuCJwUs7scDyTELr
         PnAHMXhn20dEM+Ir1cKfQjsx2AiznpX3mlv1mgv2wA2CPYuYJ9P14TAsrnJwV5lNAZGt
         i7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZhnONtykAfnsqa3IwkU1k8fhowiK4Exd+SQDhYlxkkE=;
        b=I0M1Q37U5GoYvRXDJkXHtQvQMJ2Ojg5RhSbc49VfcIUvtsXrY7FoD3vtjQoxleIXky
         +GHsDfdsTJwTb+i28MIXuCfsMiNdqUZFaU7QDKsPs31Zj1yyY772b/ROnGIVPv/nDuCv
         qKW0QMXjgCXsKoPhy+8ICuFSJPuvFV+tTiWBNSQTQc/BKYBqmV8XQ7DGCqlwVac/d9Dz
         0hymB2XyNzuztJrvFIGeJCHrQjqI1YWH6sJw32xdLCsfq6cOyyrwG5+p87geBCqM4MWD
         fTM2nGmHPhemmTCrWKnFq90u/BANTAWs/Qb73NnbV7A3WG8DniBwM1c0Q81eVs50Z16N
         Yu2A==
X-Gm-Message-State: AGi0PuaBpHgp2AtNyGccfJ02d4YKYFk37S46rkbwI+QrlOC2CRprI+AJ
        BRB59W1DwB9pRX+ucdNOvuCqdw==
X-Google-Smtp-Source: APiQypLiHMqhyAGxLqmuGbbCEuklJYAieSPoChxeYti7LoKjj/AQ3szJ44XCT6e0cwR+DJh46437RA==
X-Received: by 2002:a17:90a:23cd:: with SMTP id g71mr4337368pje.174.1587706612508;
        Thu, 23 Apr 2020 22:36:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b140sm4402370pfb.119.2020.04.23.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 22:36:51 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:37:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh-rsc: Loop over less bits in irq
 handler
Message-ID: <20200424053720.GW20625@builder.lan>
References: <20200424045414.133381-1-swboyd@chromium.org>
 <20200424045414.133381-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424045414.133381-3-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Apr 21:54 PDT 2020, Stephen Boyd wrote:

> readl returns a u32, and BITS_PER_LONG is different on 32-bit vs. 64-bit
> architectures. Let's make the type we stash the readl into a u32 and
> then loop over the bits set in that type instead of potentially looping
> over more bits than we will ever need to.
> 
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/soc/qcom/rpmh-rsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 76e0294a672c..462dd267afef 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -365,13 +365,13 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>  {
>  	struct rsc_drv *drv = p;
>  	int i, j, err = 0;
> -	unsigned long irq_status;
> +	u32 irq_status;
>  	const struct tcs_request *req;
>  	struct tcs_cmd *cmd;
>  
>  	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
>  
> -	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
> +	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
>  		req = get_req_from_tcs(drv, i);
>  		if (!req) {
>  			WARN_ON(1);
> -- 
> Sent by a computer, using git, on the internet
> 
