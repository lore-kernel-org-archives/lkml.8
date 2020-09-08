Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF395C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF991208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A42L4iBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgIHUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgIHPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD1C0619ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:11:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so3250990pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqQzdsNyVZxQfTKZQ3YstL3rPQCUat0ck3Wbh+a/dRg=;
        b=A42L4iBc1CLoIwG4vjkgmHVXssQmnn3pAMqht8EDGn5jdLIp0DEMm5fr4fRpNNZ6GB
         cYpBWQkG770jRLy7OaKNz1ax7PjmhebIMH94oOt0oJsVF+Dwlh/vxyjmbAEUSlWYeX7j
         nrYDiolhDL3/k31KAqubdudhePJwyIK4M16TzYv5GMRUnXe56k6P77Mwl6Dvu7VEGcgq
         bEapsJBiR0hlNw0O9U16OsSNqLJc2hWQmHmQZyXyzvMHCvFZEJxBP9L4835Zv9l944bW
         h6pGAmzhouGRV/7qtqbJ86YEqHShEZKpc1wDIxcNthdw4Kb+uUMDhUZ4ixEXFRS0sHq7
         pWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqQzdsNyVZxQfTKZQ3YstL3rPQCUat0ck3Wbh+a/dRg=;
        b=NuQKajCoIvxeFMq4R50NUAQISaWvcXlc5m7T0dfeYyjf6TscsPHXalCFK2zEeOxois
         7fgWGyJMOjynd9POYVJJkkUzf9s7ixArRCH+lo5jOoPveqTyfy0H9MIiLWGt7Rct2yuv
         zPDMq8qctaW1HfQEeSnH5sgB97uT9mYqSzm11eYVUui+LJ8zOkWpJXrQPAzVfyWrRLoz
         2KmughScJ45cjfP7G/HWy0Hybd7z8uzGO9fmN3QtXPa8sfU6WCQRr4q8atQvEkfim+DJ
         LLgfcciqqWd2Oz7UFVU7t8ZwoS8POeZPsoV0Lu9rG/9kkrKRb8ARSaAJ5nPgTl72hkDb
         HEvQ==
X-Gm-Message-State: AOAM530SEEEHf9kNglGO5e3IARJsuHoMx+Jnys8I2BqhfDfm66RdhM/S
        wrnNUFvC7OPKMpNri8pNkF4K
X-Google-Smtp-Source: ABdhPJygg2wc2pJ6EFNe7SN5QXwBrjuD9HtWHBZlXZcCYsz145npyX1ctKgCmabtN4zCr836QQoSxA==
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id 1-20020aa792010000b029013ed13da10cmr1456521pfo.40.1599577868308;
        Tue, 08 Sep 2020 08:11:08 -0700 (PDT)
Received: from mani-NUC7i5DNKE ([2409:4072:6213:6149:cb0:8a44:a6a5:e3bd])
        by smtp.gmail.com with ESMTPSA id t25sm15461220pgn.13.2020.09.08.08.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 08:11:07 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:40:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document
 SM8250 compatible
Message-ID: <20200908151050.GC2352@mani-NUC7i5DNKE>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
 <20200908145819.GN3715@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145819.GN3715@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0908, Bjorn Andersson wrote:
> On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:
> 
> > Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
> > hardware block which carries out CPUFreq operations on SM8250 SoC is
> > called EPSS.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Please follow up, after this has been accepted, with a conversion of
> this binding to yaml.
> 

Sure.

Thanks,
Mani

> Regards,
> Bjorn
> 
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > index 33856947c561..aea4ddb2b9e8 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -8,7 +8,7 @@ Properties:
> >  - compatible
> >  	Usage:		required
> >  	Value type:	<string>
> > -	Definition:	must be "qcom,cpufreq-hw".
> > +	Definition:	must be "qcom,cpufreq-hw" or "qcom,sm8250-epss".
> >  
> >  - clocks
> >  	Usage:		required
> > -- 
> > 2.17.1
> > 
