Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C3D206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591820582;
	bh=TKZ2LXML5cv9NCPIapwBFHDk2LIy23EqZcrzTZVUW2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mUjWob+Vzv5/AzTi9Y49yM7xBkKZo84WA8iJWHq4c1EvcZRDDFmnOl/WIXQmsU3OE
	 E6WF+cu+tlmeaKUM/lSfyAEje86KiBYJX9n7zriwfZEQMJSnE5kU353Kt0xt1MLlk2
	 zEXDiKQkwzvVXDaXi6b2FhgjWKf7a4eRLa4yh+tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgFJUW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:22:59 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40910 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:22:58 -0400
Received: by mail-il1-f196.google.com with SMTP id t8so3261836ilm.7;
        Wed, 10 Jun 2020 13:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YXSTCcj991zSNGpyu99kvR+1fYRbftjWLQgAbbx28Y=;
        b=tmOPQ72T53Rhi1rCpe41Jlwl4auOldbyBtFXHMhWGno/qg3nFG7xA+EOkAP2r5FCvE
         kU0oeN+57/V1S0ffD/PSZ6tvK8PVhCd8Ewl0ms3jYPiKafWK9Pz3WFxWwGXD6i7Rzp8/
         d3O8bUrTVLCo6CzCpOBXGX2PETwKkVFowZTtvV9ZwzsFn7hyN6ti6MzArtCuG7Z4+6YU
         ryBMfsNyl2FS/7OxN+Ogox5OkjZRtbBnOWXVkb/54wVWlrStK2W7LyUL9KY0qsMR2y8Y
         PGWSRZBe+CvTm+qm/uyj+jNYJ178aEnDP3fMpypaIdm/xe1WzRU3Sh3C024fPV4+3opE
         Wd2Q==
X-Gm-Message-State: AOAM531Xbiza9muTdTtbWu9e9nZ2iTv4Edmi7IyR6R2FgXDsbCv6kh0c
        6+v6OqblFXMolKvOAuaS6g==
X-Google-Smtp-Source: ABdhPJy5xOlUuXLQ2M0PsBlE2fZvLeM8bOQGR9ykS86xR02H3MBFr5qW9JVAsXPGGIBf/d9lBSfqyw==
X-Received: by 2002:a05:6e02:50c:: with SMTP id d12mr4753144ils.140.1591820577238;
        Wed, 10 Jun 2020 13:22:57 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 65sm455187ilv.7.2020.06.10.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:22:56 -0700 (PDT)
Received: (nullmailer pid 3649714 invoked by uid 1000);
        Wed, 10 Jun 2020 20:22:55 -0000
Date:   Wed, 10 Jun 2020 14:22:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
Message-ID: <20200610202255.GA3646369@bogus>
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603120915.14001-1-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:09:15PM +0200, Mike Looijmans wrote:
> Support VBUS power control using regulator framework. Enables the regulator
> while the port is in host mode.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Add missing devm_regulator_get call which got lost during rebase
> 
>  .../devicetree/bindings/usb/dwc3.txt          |  1 +
>  drivers/usb/dwc3/core.c                       | 34 ++++++++++++++-----
>  drivers/usb/dwc3/core.h                       |  4 +++
>  drivers/usb/dwc3/drd.c                        |  6 ++--
>  4 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 9946ff9ba735..56bc3f238e2d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -37,6 +37,7 @@ Optional properties:
>   - phys: from the *Generic PHY* bindings
>   - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
>  	or "usb3-phy".
> + - vbus-supply: Regulator handle that provides the VBUS power.

Does the DWC3 block require Vbus to power itself? Doubtful. This 
belongs in a usb-connector node. If the DWC3 driver wants to get the 
Vbus supply, it can fetch it from that node.

Rob
