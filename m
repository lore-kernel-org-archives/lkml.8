Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C42C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768112145D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590790917;
	bh=LkN2/kuYewEPGW32zwVrfg7tbyRXzKnGRJnPddnibBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQXJ5agO1jmviLai129fnosHzuSdCJ+CJuo9vit9F9kdF14Y6Hry33Oq9+z5FTpJd
	 falCbdiEaadkLkQmjkyCsxBxz341KOD5WQUs96+DBybbkteaiGbxj1atB+UkgGVb48
	 13NV8S/wToLKbNUhhz55XB7uodWS3ZF4eD/5s2sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgE2WV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:21:57 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38172 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2WV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:21:56 -0400
Received: by mail-il1-f196.google.com with SMTP id q18so4037143ilm.5;
        Fri, 29 May 2020 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPwj0QFqUBbFYB18xGAeOhFcbGHfZiXFWULCCqTjxpY=;
        b=i0KISL97z86+wbDmRHzTKq5uUBNFI8Ud+EEM/UvrH/HB/N02U0TMogtZhjoFkiD/AI
         jyErp8xXPeM7YM4yow4xZUANc/EIW7KzACH94OMIytLwzXF1ISJx5K+R/OVpG7xYAQNw
         iCP90V7K5vFr7x8l1j50siH6EbQCYkQ/e+Kl4l2p04WfWZj9vhQv0u/94kYjDkDa6T9R
         s4n59p/P5XAf3sYvEp4J0DC6TD/kr7lZr88tP1KAZ1O7y68yecZHW34DwLEMGAf2zqTt
         lFgQdnZovC5MItlXgbXMttOFAnmnSoMCwgcv9ORS5B9olA9kPUzyuf6BjsEoOZVwpF6F
         L1fg==
X-Gm-Message-State: AOAM5337Cg57gtsEb+3D3gsb4IoSLsVb1JLsUkPzV9plhGb7jDJG0P11
        gfcch0pHZI2AabpH/KeETg==
X-Google-Smtp-Source: ABdhPJx/OmTVluDC9NXUSYPMCzDnOZh6jZPZII+DVmbjYAUduAeIccpkT67XK8RMrNGYAuQpa/DYnQ==
X-Received: by 2002:a92:de10:: with SMTP id x16mr10127936ilm.6.1590790915535;
        Fri, 29 May 2020 15:21:55 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v2sm3419005iol.36.2020.05.29.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 15:21:54 -0700 (PDT)
Received: (nullmailer pid 3094488 invoked by uid 1000);
        Fri, 29 May 2020 22:21:53 -0000
Date:   Fri, 29 May 2020 16:21:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Merge gpio-usb-b-connector with
 usb-connector
Message-ID: <20200529222153.GA3094429@bogus>
References: <20200529180631.3200680-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529180631.3200680-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 20:06:31 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The binding for usb-connector is a superset of gpio-usb-b-connector. One
> major difference is that gpio-usb-b-connector requires at least one of
> the vbus-gpios and id-gpios properties to be specified. Merge the two
> bindings by adding the compatible string combination for the GPIO USB-B
> variant and an extra conditional for the required properties list to the
> usb-connector.yaml file.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/connector/usb-connector.yaml     | 39 +++++++++++++++++--
>  .../devicetree/bindings/usb/usb-conn-gpio.txt | 30 --------------
>  2 files changed, 35 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> 

Applied, thanks!
