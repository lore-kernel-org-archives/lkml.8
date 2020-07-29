Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5920809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LykoZLGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2RVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:21:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:21:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so14585819pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RkhmVmn+F8zZR3MXN6wM+ixzJP6uusXl8abDcaadbwU=;
        b=LykoZLGIweffexQ73NX4n24tMeVD1jxrVEhBFJdBzix3ieNIhRJ1UyAW2pW9Xdc6Dd
         +T4eZ8jXk9fGCOP3GjK/h9dTk9cRzBH9ZARUErXgO7WCIRjN5z9dJu3Smaps7hgACjS4
         17VDpJ+EICAYp1oBGgmLp3aHiR6vfBiz686B/12/P5/yoOLRxFRhwyVPzowlRukVAVuN
         8k0+DWeyk5EvjcRrjsQE6/hA3qY8SGfBBfOd53gR4i2ZqHrp0/g1s6JwMpxyh77i6rqE
         j/vlvZj51WYAmbYXW9+Cu1ovFP6kdt+lU6uMfD8fdFRm1kAeE4xZwo4G3iNGEIlxH2B9
         7s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RkhmVmn+F8zZR3MXN6wM+ixzJP6uusXl8abDcaadbwU=;
        b=N1KaHWJ+5R+06PcTaaskcAFw6cfdfuMQA3E4E4XepGuXolJkHRmo/JLqwudwENXNGf
         BywTSOSB1UXgm2B9NFHRpj8kA5cZjXZTqHzKEuCTo2gcMzgbjdFqQ5nU4CprVrc12Y65
         WM2b6rS0jE7Oj44FMD9hgVeSYFE3A+wjVi0w34I2Wx4MNCVd5gaJI/OZ0E6ZToeE/4qX
         dmC66CVug24q7TCv2QDdHr1sEPoAdyvt5xAhabM4/pU9EmzwKIyXC6GrxufJ5sz6a9DH
         477atqNG3XbknCMB3cRNKRzSb57gYDmqe1nrR6k34jH6D/1JnYyDSyy5X+p8G7AEYGzE
         ddmg==
X-Gm-Message-State: AOAM530htojZ07RYDmGhIRgUt5YDkfYFhYLilBf+G8LU2wIbmf1w2hiJ
        7BRfLyNx1Q4o5L2bn94zOMJW6g==
X-Google-Smtp-Source: ABdhPJzYsG6bJfs+OjDq/bcVUSUtHseUIVoDgm8UZLKpJ5a7m2X7FhMkTfYyTY/cwe3oMahk3ykPTw==
X-Received: by 2002:a63:3c09:: with SMTP id j9mr30423593pga.206.1596043260739;
        Wed, 29 Jul 2020 10:21:00 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j11sm2950518pfn.38.2020.07.29.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:21:00 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:20:58 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 14/14] dts: bindings: coresight: ETMv4.4 system
 register access only units
Message-ID: <20200729172058.GA3060370@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-15-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-15-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:40PM +0100, Suzuki K Poulose wrote:
> Document the bindings for ETMv4.4 and later with only system register
> access.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d711676b4a51..cfe47bdda728 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -34,9 +34,13 @@ its hardware characteristcs.
>  					Program Flow Trace Macrocell:
>  			"arm,coresight-etm3x", "arm,primecell";
>  
> -		- Embedded Trace Macrocell (version 4.x):
> +		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
>  			"arm,coresight-etm4x", "arm,primecell";
>  
> +		- Embedded Trace Macrocell (version 4.4 and later) with system
> +		  register access only.
> +			"arm,coresight-etm-v4.4";

I would rather call this "arm,coresight-etm-v4.4+" so that the binding's
semantic is still relevant when dealing with ETM v4.5 and onward. 

Thanks,
Mathieu

> +
>  		- Coresight programmable Replicator :
>  			"arm,coresight-dynamic-replicator", "arm,primecell";
>  
> -- 
> 2.24.1
> 
