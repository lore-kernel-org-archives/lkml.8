Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349FC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E9320CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654654;
	bh=Sz0O+RmsM6GYZzUqFAn+GmhbI0FnVhg9hOoh5+csysU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HtWgKVY9QciNQAGxHnjU1co28GDUhgvBubPHJHLZnidyY7nQfrHcOH3gooOISP+Qu
	 jsKgICGqPfgXHLn4f5XZR+DLUN/Wco8GwnBY/lxCJCNKyfS17GU4VG9hSGvIqi34V/
	 CFxbu6uoPbY5Ep9UCcxaw/IyBjnnKQPDpE6jrg+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgBYSRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:17:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42719 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgBYSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:17:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so223385oih.9;
        Tue, 25 Feb 2020 10:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0E7HviNSBsG8AdRJKzEgXOr8kHrjfuX94agJUStr7g=;
        b=OXcywOJPbqRHChkGWl6XUK7li5avqEpoC4waArh/4AkMHnp5NJ58GCKV/v9Gd3Yytz
         4A+r/1Su/uWuiXFNZSsmWNyBIcfVMQDBTER5BmCWUD3h2sEakcu12LovtmtRTZf99zkw
         sBMV8XKJVth0ASzjsWa8fgiRSP4hdHN+I6aVn4KLYGua2Zf42y/F9UzuT6HGsvkBW1ud
         FAJ2K11xz6VvFI9VUkiQWHDd2AAbN6FTfTOGisv5G9+4JYVVmUnEH8UUEqcmPj97Sy1c
         VII6LwasAkpEIxl82GvLGFIKW2+RyfpxBy8xcMxDCxuuor7EqNMWImtAJpSLEENoPJ8w
         iOxQ==
X-Gm-Message-State: APjAAAXs898mA/Yd4S7VJ+NlVIBwwIDZF/MvA+cJxcR3+Soj3uZEVZLM
        OPSpfvlTleLjJ+yyxMWIpA==
X-Google-Smtp-Source: APXvYqz1dylt8yKJtPhfpv45+IE1rLmfphrTF+EPA04MjmfXy9gQm/1y+8I9VO0b52zpWHhUF1c3oQ==
X-Received: by 2002:aca:b9c2:: with SMTP id j185mr181742oif.112.1582654652267;
        Tue, 25 Feb 2020 10:17:32 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v25sm5890424otk.51.2020.02.25.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:17:31 -0800 (PST)
Received: (nullmailer pid 4562 invoked by uid 1000);
        Tue, 25 Feb 2020 18:17:30 -0000
Date:   Tue, 25 Feb 2020 12:17:30 -0600
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
        Maxime Ripard <maxime@cerno.tech>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 26/89] dt-bindings: clock: Add BCM2711 DVP binding
Message-ID: <20200225181730.GA4511@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <106e8a589a79eb70668b03d7160994c6a09a92c4.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106e8a589a79eb70668b03d7160994c6a09a92c4.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:28 +0100, Maxime Ripard wrote:
> The BCM2711 has a unit controlling the HDMI0 and HDMI1 clock and reset
> signals. Let's add a binding for it.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml | 47 +++++++-
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
