Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792D5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D28D20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525261;
	bh=Kd2t7se21ko+PgUs3sgGCgpVXC2raAgXoG9X1Itk+PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lkm56pWD4T4rASESGlSgC/D8y5YHrJf/YHJaq9/fgoqVZFT04W9u6Py09xs7IEjlj
	 a2PB3AkFxlQjkDRw+YaJNFE8SG99QUUso47oyC4zB7MTVXJFL3g8D+n2GXXVu4gtC6
	 6MgYaLgul/jlahakYapmh3zdS2p47fHfb6icLLTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgGWR1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:27:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35909 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:27:39 -0400
Received: by mail-il1-f193.google.com with SMTP id x9so5013189ila.3;
        Thu, 23 Jul 2020 10:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMUWSqKkNZM2zMbqqSpDRd9pc9Jy3A9V3GllvmqHBXE=;
        b=Df9yHeK/BvXWnM9/F4kk6AGLduuHVGRqzEUF2snVlC07vdcMohPfimrkXAru/lAkEQ
         mYTKxcmn7u+gm5w0oxEsTJSwUSWlMkD/gblN1QhvK5o6SPnQHnwJUed6J9xo63mm6E8q
         QioAew88D9nyz7ojPulzCL+Etx99C+jlO/hkHHYv8ruPgZDzCGwnpcX+NT5jUKr3+Z+H
         fN6upFofwsR8mmtmTOiswd8ybDifdIXfdU5e5uuEnDr5gtGVe4EOEk91cUlexkNFSXlh
         nCFyi2aq/mlc1thS6UoCOn/xK0IukytKTSwDkhzNyYqvGs93Pyz7s+LCjICGywrh+bJn
         8XcQ==
X-Gm-Message-State: AOAM5338Z/x71HYw6j0YylNTMFVhnNXdSv6U/VRlKh7M5XOs320Rjt4C
        izTYY2iqL3zT/1U9k+9mEw==
X-Google-Smtp-Source: ABdhPJytNaxsTBikx+XWpS4VyjyHdBBo4ztlkHSqH079wFE4n+9bobuugvvz76Q8GfEPhrXTFvIB4A==
X-Received: by 2002:a92:d648:: with SMTP id x8mr5540065ilp.190.1595525259095;
        Thu, 23 Jul 2020 10:27:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v10sm1768585ilj.40.2020.07.23.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:27:38 -0700 (PDT)
Received: (nullmailer pid 569085 invoked by uid 1000);
        Thu, 23 Jul 2020 17:27:37 -0000
Date:   Thu, 23 Jul 2020 11:27:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 14/14] dts: bindings: coresight: ETMv4.4 system
 register access only units
Message-ID: <20200723172737.GA569038@bogus>
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

On Wed, 22 Jul 2020 18:20:40 +0100, Suzuki K Poulose wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
