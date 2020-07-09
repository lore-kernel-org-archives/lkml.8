Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B23C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FBF2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594336037;
	bh=nuY8B7MtSnrkeveXJ136EeuRvMPEqGlBV84ZUBNpRV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jt3h9BUHq9GojGuvMFk9h3hYkxsg6aVUuW9iDy0bkHVl9t7+e4E32T6LKnvFMfsIU
	 I09DmPzJZmXt8Ps2kiRLcAdkPHzFCKXepiDqzkRWOoRe4pQB3BOVLUTvbDFovBEZSj
	 q14Ee1z4LqnoQVpvTZqypITiUmbi9zqcocKwmBTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGIXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:07:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43406 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:07:15 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so4088079iom.10;
        Thu, 09 Jul 2020 16:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpUPxSg4+S4VKiL42RctcMIj4F/VgQ6lAZPDiD3WZ1c=;
        b=ZeTnPOo3ZOoOX4XMg2KJe3J23TDhOO1Xxx9fXdS2MRSdi7+3fKBFAEh8zd1RtuG+79
         gys1YrjijNzy3qzss+c9sOjFAYgcD6YjcdgmPiC+1ve8LujKzladAcB/O8dW09wLaTjV
         MR/y1mSRsHyUtY+3X9UPfJu/ameC5M8n0t+CuMP57cizZKrb9frzfaPz79lAj+MveKcl
         EQteb0bXjHpluLSSg4kpmkLtWSTlF5yo9ujAgV/xEuSoDRu0qqYf6sE9PQGcX9IE+nUk
         7Y9uZDtNxCQByvtPJgmRzcRa+0ZOYsqgYWEl98cENkJtHtNByI3V+/XNqSxRsT6f2KB9
         P/NA==
X-Gm-Message-State: AOAM530WsQXWaDe6ZShgg+MWiK4SWNtfTSHmUAeOUbvk3QtWvXb/DkWv
        HpNo3cf2TM5vJowbTcuDtg==
X-Google-Smtp-Source: ABdhPJwaXaUIQd+wSZRsx/L/XhnFNFY/DGeEFJ7JNWbK+VHIBsG3tfiZgEqUQ8jf1hhuDf+OE7e2aQ==
X-Received: by 2002:a5d:94cc:: with SMTP id y12mr23644866ior.133.1594336034560;
        Thu, 09 Jul 2020 16:07:14 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c77sm2720628ill.13.2020.07.09.16.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:07:14 -0700 (PDT)
Received: (nullmailer pid 1063353 invoked by uid 1000);
        Thu, 09 Jul 2020 23:07:12 -0000
Date:   Thu, 9 Jul 2020 17:07:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        yin1.li@intel.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, cheol.yong.kim@intel.com,
        linux-usb@vger.kernel.org, qi-ming.wu@intel.com
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add USB PHY support for Intel
 LGM SoC
Message-ID: <20200709230712.GA1063293@bogus>
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200617035818.54110-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617035818.54110-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 11:58:17 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add the dt-schema to support USB PHY on Intel LGM SoC
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/usb/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
