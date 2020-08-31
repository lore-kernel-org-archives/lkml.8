Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0442073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAYMh5n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHaJ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHaJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:28:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F726C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:28:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so2823377pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AANzE6Mz+tM900qLx7/w4VUV2q8lsU9qWaEx19XX7/g=;
        b=fAYMh5n/Cr8lvMhlCx2luUn950ofibpEJsobDD/HtQprQYYo1SSGgc6rErm38rOM+J
         JhC3GTKMcjLQNoI9QVzABDQNpc5He4zDtOxk5Ymp6Ww9dWIahWEY9rHE0ConDNh4+PPx
         AoRgnFpZ48WKsz9iiGTlfhmVh3vF3OM0jPVf5Akq/50FoqGipLAAauPyzJxfb7ybkAVl
         +QYXC908wmQlOr6hvCBAMNDelpjPiTecsWp0peGScmbGCA9WZ769bit8w6GqCt6kFLJ6
         crA2eXNW+vUJXKeb8W1GOyMNwpFX1gWx9KpG4edUaKTaXwYDAz75GQwoP3JWBuGAc0Ae
         u9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AANzE6Mz+tM900qLx7/w4VUV2q8lsU9qWaEx19XX7/g=;
        b=GR/zaWSOH/RlxCqxbrPDLKKxWGp6bT33w+0vsEKvBBrSY0pivEB6M9iZdG6AxUO2ds
         jHrSOq4OdxQ9s7YmVHbsgIrpMtb/0gIK9/IXcu4zuKENOPFEeY0BSv1jWrSJbNMlZTjT
         PjuhiN0Gh5wMqCdCr7HysyvhKGPkV8npKqWTRGGVc0NbgmrWmCXpBwEqoAJH/qsLJ5ac
         919Ej6j2HMkJpVbksEiK4SOLTROdVeL1TN2x53OyBJp12hScY0B+4zfr6/lIk3+lNpsa
         OvyUB1w2ZYtN9vkvxlf1IxzbXbCQ3S3MS3FD0+/Ol6obABFadUQ5pVb3Sm1sb+TG6gcJ
         PMrg==
X-Gm-Message-State: AOAM5334Docny9beQvvkIpvZRl7C6WlnRL/DRfzns9HY7ITSdHWLFvnE
        iqh0d+CcgkYMJrFo/R6UJSGe
X-Google-Smtp-Source: ABdhPJx4JTKp/iqIJDmduinWrm0c5usqtykvDq6XtvJfqQfFvaj+DGIXvuVGi5d+iCTUotmG77mAEg==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr388809plt.247.1598866091086;
        Mon, 31 Aug 2020 02:28:11 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id u14sm6934710pfm.103.2020.08.31.02.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 02:28:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:58:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add vendor prefix for RoseapplePi.org
Message-ID: <20200831092803.GE4154@mani>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
 <7b2624c1e2aa4cb09869ff38676ef2681caa2f77.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b2624c1e2aa4cb09869ff38676ef2681caa2f77.1598621459.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0828, Cristian Ciocaltea wrote:
> Add devicetree vendor prefix for RoseapplePi.org Foundation.
> Website: http://roseapplepi.org/
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Rob, are you going to take this patch? Else I'll take this through arm-soc tree!

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 63996ab03521..0b5bd97b4211 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -894,6 +894,8 @@ patternProperties:
>      description: Ronbo Electronics
>    "^roofull,.*":
>      description: Shenzhen Roofull Technology Co, Ltd
> +  "^roseapplepi,.*":
> +    description: RoseapplePi.org
>    "^samsung,.*":
>      description: Samsung Semiconductor
>    "^samtec,.*":
> -- 
> 2.28.0
> 
