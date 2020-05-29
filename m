Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A7DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6774220776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590776081;
	bh=ymAIBEab5FPPSocmORa0t3x2q+8B8IbR04s9IZ3rwS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVA4O3TXSoRs/mh1hE6IqJTTm2EsFsgCmJmGQKfrq+ryiNpMpndBD1/FAEnGFRZ4d
	 RSGK8VTRd0WldZfQjnmigFlucMxYkHTvPE61S3qZW5qOVc7F+TI1m/+joJamC22RNr
	 K6F++2gUGeGPmOR9px2p86EU//Zx68Fupu2YIaos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgE2SOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:14:41 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41013 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:14:40 -0400
Received: by mail-il1-f193.google.com with SMTP id d1so3381527ila.8;
        Fri, 29 May 2020 11:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpRQ/sE4FwRCuliRnokEgxqnFdsexjORBq+C6UB3EhI=;
        b=kz+WIsIP8Rguby+Po0t3vRSw3BU3rIWD8ZXEMDEBott5BQPhLpsG8dCeiWBq0ko7ow
         JvYJZ/pXszhBcfh5rkyVEdUb1ZuPNtldwjupuqOvHNk7NlqwD4GPCuLDIeeT0RyrtcfG
         ZAwP9C2QswEiBIMLJo8bFl0MqpQk4DyCHHUV7ehgEsUg0fCDlSBW9vD74o6yOkHwXXqW
         UlNXr8MetKGMZwmb08PREl8mvpxCRBN3w/HeFZQLbxOfT/aNSWLaLq5YIJUWqbw9/4+r
         HNg/G+8uh27APzrH/nwD/j7IjLO3b5RLUz5NeVrNyvKgKjD8b1M4Jy9CXDOkDJ4YUPLU
         v5SA==
X-Gm-Message-State: AOAM532lOKCL7iKaZnHbrmHP++sIEnTpLfEjNj0NfjZtSZmqY35cifXx
        RZ0XGNX/h40kAgI+fbl54g==
X-Google-Smtp-Source: ABdhPJzvi9bsOJFgClHgIdgjoPscdvkkEsnqnNIGf4ndljse4E6rFhgqWxD2dgYBIkQ7YzCNJ9ZWCA==
X-Received: by 2002:a92:9c52:: with SMTP id h79mr8272285ili.252.1590776078779;
        Fri, 29 May 2020 11:14:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j17sm5012580ilq.79.2020.05.29.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 11:14:38 -0700 (PDT)
Received: (nullmailer pid 2685148 invoked by uid 1000);
        Fri, 29 May 2020 18:14:37 -0000
Date:   Fri, 29 May 2020 12:14:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 02/25] dt-bindings: clock: Add a binding for the RPi
 Firmware clocks
Message-ID: <20200529181437.GA2685096@bogus>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
 <919e2f2f13583d4d53d0e95b81fc3fb8a7606107.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919e2f2f13583d4d53d0e95b81fc3fb8a7606107.1590594293.git-series.maxime@cerno.tech>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 17:44:58 +0200, Maxime Ripard wrote:
> The firmware running on the RPi VideoCore can be used to discover and
> change the various clocks running in the BCM2711. Since devices will
> need to use them through the DT, let's add a pretty simple binding.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
