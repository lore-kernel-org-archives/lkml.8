Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BFC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3943221D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654677;
	bh=DQ2bscNnB2HQpKsEm6GkMcGWiEn/O2+gl3WjJY0L5Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWLefNgn8W9+6fIqBwU31XH16YLoMF8rO7ynnxfEBQgSpZvkf7Rmr2ZC6uIpBIWk5
	 LJrT7582JRTP+Hg/9S+9rrtvALvej/nGuIcPPnikZdr2iymfhDx6FZ148SgXgMWtgh
	 OqBWJFTB5MjJ5KetyEef4Su327uCy31Nx3YUZ4HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgBYSRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:17:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37826 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgBYSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:17:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so423520otp.4;
        Tue, 25 Feb 2020 10:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfeiAYk0sz6jKgpfGcPq2AbGtANcSLd4G7ZU9zGmlGY=;
        b=NmRi6OLJpg7FgHexfIZhflfTbirfKyBTu+m47QX04VINa9MBHL8WNqa/0Ko/IZg7EZ
         9G1Dyn/cQzXKrO+h5IQp8WlR1iPUgRrt5zoCkqbrsW+VPvRtiyoqgwLM7Kql0iz/KY4y
         CoCw5cru9I85oPUqlOqXS4gsvST07UAF24H5XjMssTR3W7cIU3fTJ3VbIJiJp8OblGbw
         EgRPCdv0hcC9/nmzEiWp/ZTbykbnRtAllqemMm0mkj4/MBIM4PZQwr+LBePZKJCoAjZq
         3Sb1cN9b758rroSGluC+0SSKefNw95Xk4BRa3Il5MWlYGPJHYh7nLyatAOpu/DFKzt9D
         vdKA==
X-Gm-Message-State: APjAAAVpJw01e9+0aGGtZnqoOPm/EYnX7MUGtMTRT6iqyf5dUzIWAps3
        HAPYZf1iQXzFJxF/ZE2Ydg==
X-Google-Smtp-Source: APXvYqyfQgGOrT9ThsnJbQjUHaKtSnLHIPJhsBT8XMy6vzVDDAHDLigOB2OIEY8iBbOVlcXyZ2O+tw==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr2287541otr.299.1582654674415;
        Tue, 25 Feb 2020 10:17:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm5569162oib.42.2020.02.25.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:17:53 -0800 (PST)
Received: (nullmailer pid 5252 invoked by uid 1000);
        Tue, 25 Feb 2020 18:17:53 -0000
Date:   Tue, 25 Feb 2020 12:17:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org
Subject: Re: [PATCH 30/89] dt-bindings: display: vc4: dpi: Add missing
 clock-names property
Message-ID: <20200225181753.GA5213@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <042c8f676d3d863b55092bb58c1f15db95370782.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042c8f676d3d863b55092bb58c1f15db95370782.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:32 +0100, Maxime Ripard wrote:
> While the device tree and the driver expected a clock-names property, it
> wasn't explicitly documented in the previous binding. Make sure it is now.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
