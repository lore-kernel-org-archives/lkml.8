Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C0622B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272893;
	bh=/+ZsdyN9Kt65Sl2HXcikMSwV8Fxqvg5M4a2yOC/W9cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtRBNyjK/S5hCa3BCphURgek+ujI9825HNbzCVcsIIrN2cTbDT5hGP1fdpLmCeS/p
	 iFtDDCoEEk19PkvKECm7hYaVbYMGJrTGcREw2oaY72/loThZXJDxpylh/kUotDXgR1
	 LpAnEQJ8M6uYMXujFpr30/ecaH1Gi9YB1FmwV9e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgGTTVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:21:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38991 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgGTTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:21:31 -0400
Received: by mail-io1-f68.google.com with SMTP id z6so1312939iow.6;
        Mon, 20 Jul 2020 12:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d5LgybrNa/iLgJZG6ZBOwUOQyQWDmgRLoObd92GIzvA=;
        b=YK3L2JbpML/WqIFYxw7PssD0UcYCKyLX0KEZ45vVRdgwbKho/cr6ait5JyIATkJ7Ek
         8BOt1bQ41jSUDZtQxQ5cRZJeZAMjg8MAhiK5UvMd9Pm409tUrZInZ8Bp9BjTabW7dGkP
         46UkhPGrHE7Yewx/1CfkN2PeYFm/l6BBZy3DD3tVBsuAkyIHebfW3xXK0LeHFTQm/Tmq
         BtBjGhzUSVtdq8Nms7WbbZRnL34ImJEu47YoC/1DcJid1xMC3UvcI9SNj4Cdc0GhajU+
         U0tuqEH8QbINfOhkXfeI/V0RsTSBD/DNUlZrsFnPoU3eQwXz+HIsutoYhqmCuE35XZ2H
         7IRg==
X-Gm-Message-State: AOAM532+vmaDTlTKcXzpQCf8S1s0/Dv+8CgG54BeYr98sOR0Qltb7BJG
        dlpB2me11iu4mBgBgmc1Vg==
X-Google-Smtp-Source: ABdhPJxMWUB8qi3fLkZnspl7ED1srlDCBz/8M9WgKY58AKDdWH0Iv7E6iDlegaD0OpqXALPh6nLhaQ==
X-Received: by 2002:a5d:9c44:: with SMTP id 4mr24511126iof.15.1595272890498;
        Mon, 20 Jul 2020 12:21:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y2sm9539756iox.22.2020.07.20.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:21:29 -0700 (PDT)
Received: (nullmailer pid 2852474 invoked by uid 1000);
        Mon, 20 Jul 2020 19:21:28 -0000
Date:   Mon, 20 Jul 2020 13:21:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, krzk@kernel.org,
        p.zabel@pengutronix.de, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, jonas.gorski@gmail.com, alcooperx@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v8 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Message-ID: <20200720192128.GA2852419@bogus>
References: <20200720131209.1236590-1-noltari@gmail.com>
 <20200720131209.1236590-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720131209.1236590-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 15:12:08 +0200, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v8: no changes.
>  v7: introduce changes suggested by Rob:
>   - Move clock conditions to the main section.
>   - Set missing additionalProperties to false.
>  v6: introduce changes suggested by Rob:
>   - Add another if case to device tree binding for SoCs with just 1 clock.
>   - Ignored "additionalProperties: false" suggestion since it triggers a
>     warning. This has been reported, but I haven't received any answer yet.
>  v5: no changes.
>  v4: conditionally require 1/2 clocks and fix clock/reset values.
>  v3: no changes.
>  v2: phy-cells changed to 1.
> 
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
