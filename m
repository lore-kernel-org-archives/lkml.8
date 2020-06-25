Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0502C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B8320789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBCAuD92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405984AbgFYSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405871AbgFYSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:42:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1FEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:42:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so6981979wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q8nBgI5fYdLkf44M/rpFf59ow7O6nvw1cbXU0tP/3dc=;
        b=MBCAuD92q8/NSqoJOljKJyZjrpJEyknYxVeADT3gugZwyf/U9nprDMBfig3oIZaDab
         7wWPaP7zDS4eAgIoMo1OdZye1noJWO+HYAJjclFMGWBb1a0LSjY9oSdCengKJTAnxGLf
         9FtKQ5JqWRFqzvZcrcF/GBZ0QhhMtDykuMeav/fSHU7u+AAIJEcCGc4HRa0uk4IhC4R7
         DIHlJmgM7vw192vdHVz9AD888/WMsITdk5ccwWf4fhEQc0E/CE0bRx5mdenm5W8uGRKY
         g/sAuTsX/XGzbZ0W9CCMtCVl8HJEKNZuhpyyTWXfWkkzvEr/RNNA8hNqqEbom/FLUPVw
         8+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q8nBgI5fYdLkf44M/rpFf59ow7O6nvw1cbXU0tP/3dc=;
        b=W0VC5nPy07Mc0lr+f4T86wAgW8vKE94VDf9sSWpgx0Oppwb3P636+Jeg87dPw0IAgC
         CZp2YGX19j38KJ0FJxYhXgQeqtCE8FWEIKBrD72NX+XOC33/RO6Vcuc/5tzl+uoxvZR3
         bYNQvwNQf92ijoKfSufDf5PeSR3nrmPuYCi/17/29ir2ArcneDeF1Pm/GTF0gPVKyh+Z
         Kt1RXjp6d9BMOnCELjrdQf27jLMG1tyVQHxza8M+VtoVYOC/iBRuq6G5OPJ/Ypp7lVpR
         NxnYDN4iOMdtRRpo5FoEw/v15j9kopaa2avV/iPhaVaxNW9Qf5D2jw/YQhJRKB83EapA
         KHAg==
X-Gm-Message-State: AOAM532e25zZNPLixzQqIOIXkkEhqp7Nr2+IZG07xgarJ1IotpmskjVS
        jAyQcP1fq1ZQAZZn7tnreaEvZw==
X-Google-Smtp-Source: ABdhPJxFJ2dLH4VgwSt9IoYG6C6YRW6P6gUXk1Vov0TqEtIw8ihaymjRs5AQmHY8lsWK9lBM9ugvFA==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr4602726wmc.146.1593110540992;
        Thu, 25 Jun 2020 11:42:20 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 92sm25829134wrr.96.2020.06.25.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:42:20 -0700 (PDT)
Date:   Thu, 25 Jun 2020 19:42:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] regulator: devres: Fix issues with kerneldoc
 headers
Message-ID: <20200625184218.GU954398@dell>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-3-lee.jones@linaro.org>
 <20200625172813.GD5686@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625172813.GD5686@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Mark Brown wrote:

> On Thu, Jun 25, 2020 at 05:36:06PM +0100, Lee Jones wrote:
> 
> >  /**
> >   * devm_regulator_register - Resource managed regulator_register()
> > + * @dev: device for regulator "consumer"
> >   * @regulator_desc: regulator to register
> >   * @config: runtime configuration for regulator
> >   *
> 
> That's an odd style you're using in your "change" here - why the quotes?

It's taken from other instances in the same file.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
