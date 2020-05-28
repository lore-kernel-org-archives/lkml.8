Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD5BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522F1206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590705310;
	bh=V9I0XlpNT2yGPGPjJIp+slxoH+pKZKhBrrEfAFo6qNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IYKKKdYL+cO50X7Gq3Nzt2WqQp5ikJnpt7iLj+b1sTTP6lleUNToY2GPWBx7kzASF
	 oK/it+GO3sQPiXz3yk483paRmJ7iDZLDbyq4v5v5d2isrx7xOuQX2T9n7NLReze1Tj
	 WHeDAZWXBdj372Tp7osmslt51GW0SuALWXzqqMRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437241AbgE1WfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:35:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436978AbgE1WfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:35:02 -0400
Received: by mail-io1-f65.google.com with SMTP id c8so264494iob.6;
        Thu, 28 May 2020 15:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vc11D40+QJOl6GHZVySQUAvoPWMfQ0L2bp2zzUmVK6M=;
        b=ooKOFivYDkWqcoNOjdG3Yjjw99DkH7DxMnDRvvLfjOWC2cHJv+pr7tjWlkFqKQC8eq
         NUpH4QpqtRkRqOiT3K4kP9OQOAjw68Yk9bulDmyKXCapVqqQWohdCDR4HyuRTB4ZeV8U
         8HcFJcXqSvK3hkLrQXbKuPGgN9WgQRvHhVsjMS1URGSu75pv5DwVrOXt0XTkJsyVMwDD
         sf9VNkfoq6eJThM992qTKrfEgwhdIcWI8uv6uRQDm6pDDbYvyJ5zwfnpZ+1TLoPawi5A
         qI3Wh0SSpz1oG9w48sfY+HbG0HUYe05qLD4aClVHMLHcIaO//1SHqdQNZ7qFyA92UcHg
         38kg==
X-Gm-Message-State: AOAM533QakWVhcVS+T1CmrSUSu8bk/oCyao4ZnMONHieLZc73Fijvvyx
        VXoObQ6mtnGwyVitpQIyGA==
X-Google-Smtp-Source: ABdhPJzB91paeCyhW/j6/x4otvuD3Y6HLW6aKg1pGAJ+pFQqh78A3J6xvNVi71EvpMQ11hiIkZaUZQ==
X-Received: by 2002:a6b:b9d5:: with SMTP id j204mr4273743iof.38.1590705301042;
        Thu, 28 May 2020 15:35:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm1529648ili.83.2020.05.28.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:35:00 -0700 (PDT)
Received: (nullmailer pid 804641 invoked by uid 1000);
        Thu, 28 May 2020 22:34:58 -0000
Date:   Thu, 28 May 2020 16:34:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        agross@kernel.org, robh+dt@kernel.org, kishon@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: phy-qcom-usb-hs-phy: Add
 qcom,enable-vbus-pullup
Message-ID: <20200528223458.GA804610@bogus>
References: <20200521005031.747162-1-bryan.odonoghue@linaro.org>
 <20200521005031.747162-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521005031.747162-2-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 01:50:30 +0100, Bryan O'Donoghue wrote:
> This patch adds a dt-binding for qcom,enable-vbus-pullup. The binding
> qcom,enable-vbus-pullup tells the HS USB PHY driver whether it should set
> and unset the internal VBUS pullup bits when starting/stopping the USB PHY.
> 
> Setting the pullup bits is something you want to do if you have not routed
> VBUS to a GPIO on the SoC and thus cannot use extcon with the current
> switching logic in the PHY.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
