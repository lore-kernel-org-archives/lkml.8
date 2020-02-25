Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AE9C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5260421927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654725;
	bh=eJqnvTlYQ8cI/dkhLZWwXZdl1I5/EjFXhLyx6vYxK/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HimONdvPiLbFxewXIfLm2ecP6HOP1/ZVVUUHqJSCubDPEuu2dxg9dtSTSDuEOdA6r
	 +v3KHAvNmJtWndxRVGHwZwCYAZXnrVACOkm80dHH+v6MY2hQESnVB0b8hB7w86mtv2
	 CJQEUq0HER7BMyhcG2hSmSeeWX4X4WxtIGYOyM8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgBYSSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:18:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34381 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:18:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so452963otl.1;
        Tue, 25 Feb 2020 10:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yH2p3xs+aaL+WXkwsTjWjJdrjOI9O37tLapilDd5TUo=;
        b=DzzRrknLBRznWk/r4QNkltCLQYzobt1018DZZCAVRvuDpMhLGcR3x6fxG1v9l1YVH3
         fuSdmP/SPRpKMzapllJJtjmYc8vDnT1wRHvW+nSAq5cdt+pKuySV/M7Sqn3HKCTpB6sr
         s7vtcIoiMrsNrvUcFZpLocy0HTh353gQo1DF6Xb6a88fUfS2sOjXWT4Nf2sflQ3CKejm
         tFYdq33ZflRmiihIwAVuJ4cAG4u8ORRX/hSKjImGKjuKDN7uPQeKG8n7c8zfWixQrHvJ
         MjB4r32+dzx6oqGd7m+RDQB3QiXZ9tby7MSCdKSju54K3DFHzdVfJHUs5fWHx3n7p/6n
         4gQA==
X-Gm-Message-State: APjAAAVf5V1bKxl+Kbz/Xm/5bGralE2BM6VNNtHZj/ny/krsuR34DPuc
        UJaXN7uXKq7Mv1ABfkwaGw==
X-Google-Smtp-Source: APXvYqyyeZ8ALcxDWMjiiWv1sZR+xuh4rkYVrqsLZj32FBSL2tBxLkUdVZM+IuRr/MNxXyTTRWlG2A==
X-Received: by 2002:a9d:774e:: with SMTP id t14mr44734522otl.358.1582654723053;
        Tue, 25 Feb 2020 10:18:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x22sm5922850otk.23.2020.02.25.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:18:42 -0800 (PST)
Received: (nullmailer pid 6637 invoked by uid 1000);
        Tue, 25 Feb 2020 18:18:41 -0000
Date:   Tue, 25 Feb 2020 12:18:41 -0600
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
Subject: Re: [PATCH 32/89] dt-bindings: display: vc4: hdmi: Add missing
 clock-names property
Message-ID: <20200225181841.GA6516@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <d549097789913d64104d6a5924af5b5981beef9b.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d549097789913d64104d6a5924af5b5981beef9b.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:34 +0100, Maxime Ripard wrote:
> While the device tree and the driver expected a clock-names property, it
> wasn't explicitly documented in the previous binding. The documented order
> was wrong too, so make sure clock-names is there and in the proper order.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
