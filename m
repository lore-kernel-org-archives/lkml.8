Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B55F206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaBPBeSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGIEnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGIEny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:43:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E944C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:43:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so332491ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 21:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uYFWXsn6/lmz5ncMBjNDIoIoMFK4tdm/Q5x2mlsCoiI=;
        b=EaBPBeSfNjYdLPMxKFn3vKHHQTk5DSQ1a6GPgTC0RJBdk3vV5Rz4W5hW1lxLQTcKee
         SQiBOIbmK4ZEu66KcjHN93aQcF3i+4Y0HkohdNaED7tbe1nNfNA/Je0FMcyEXbEYbwZz
         yGLL9ktIkHKt3RAYVIW4mdMZEwF87KWgALxa5rFAzeBB9izvi00SM8sXpB+bj5NC3HBO
         UZlZ9hKFDUZ7F4qkTRn6hSj6Yr6ZPRir36NPKvxiwoP9tDRiXg9ADUi6RCffMQ1XHnNg
         WkRko8g50tJwH7rXSdhWz61K8WZZv04UhednMu0IK/LAJNzubu0wSqiHsE9NO6WPtLF6
         JMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYFWXsn6/lmz5ncMBjNDIoIoMFK4tdm/Q5x2mlsCoiI=;
        b=ntiDFIDBzMnF3+9EnImfX5M37h2Bt9f2b2OAEJ6TVzjs/ghR6BH1rG4vn2BGhmOIZi
         DhtNRm1qFmEJnpRz1c5bqoK68EfJy2NwM1U6n3Axf7unyDSITlJ+CeU2aQ+d6/ZOqcpj
         c6acsaMuKFTVV7JFEjmusC6muyY3jwuG2acer9JyvHE4Ga/owckzrNqjaZsOv5zDeOFm
         G7ciDWJ4fyljWz6SnRCKRklcAKXCSsMQge0a/AjEPkMM6/Lk4b0bYSUyZ9YFguSQywPh
         XL96ycE/2vWpQq1fJEstRcI4q2xs7mBgmL9Gc3M8Nyy2vljk5qsZXn/26+bpDlCFOc9g
         +mtA==
X-Gm-Message-State: AOAM532ecnwsYxAAuwFkJySB2/iWSak7JJNA6jxKYP1oK3+itp629wUR
        H43KHQwPXf3HKy+g+MCROnIxGQ==
X-Google-Smtp-Source: ABdhPJxJHTDRM74uOKDi3SikC5ArM6o0/DCY1lNNoz2eFTGKxdAZS39R0GDvGntXe5ZbIYSVT0WPQw==
X-Received: by 2002:a17:902:d698:: with SMTP id v24mr22151646ply.163.1594269833703;
        Wed, 08 Jul 2020 21:43:53 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j26sm1152574pfe.200.2020.07.08.21.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 21:43:52 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:44:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/8] arm64: dts: qcom: smmu/USB nodes and
 HDK855/HDK865 dts
Message-ID: <20200709044420.GB3453565@ripper>
References: <20200609194030.17756-1-jonathan@marek.ca>
 <20200703123113.GA18953@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703123113.GA18953@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03 Jul 05:31 PDT 2020, Will Deacon wrote:

> On Tue, Jun 09, 2020 at 03:40:18PM -0400, Jonathan Marek wrote:
> > Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.
> > 
> > Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
> > few changes. Notably, the HDK865 dts has regulator config changed a bit based
> > on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).
> > 
> > V2 changes:
> > * Added two patches for sm8150 and sm8250 iommu compatibles
> > * Changed apps_smmu node patches to use new compatibles
> > * Updated commit messages for apps_smmu patches to be more correct
> > * Updated HDK dts patches based on Bjorn's comments
> > 
> > Jonathan Marek (8):
> >   dt-bindings: arm-smmu: Add sm8150 and sm8250 compatible strings
> >   iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles
> >   arm64: dts: qcom: sm8150: add apps_smmu node
> >   arm64: dts: qcom: sm8250: add apps_smmu node
> >   arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
> >   arm64: dts: qcom: sm8250: Add USB and PHY device nodes
> >   arm64: dts: qcom: add sm8150 hdk dts
> >   arm64: dts: qcom: add sm8250 hdk dts
> 
> What's your plan for merging this? I can take the first two patches
> via arm-smmu, if you like. Please just let me know.
> 

Please pick up the binding and driver patch through your tree.

Regards,
Bjorn
