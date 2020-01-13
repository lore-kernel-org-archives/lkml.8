Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5223C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEF52080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578959106;
	bh=dIlRjkZT12r2wfmOAPqexEVN/cHWXJ59S3jB6BaD6jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DhQUvHBTHhK93gDuPmKicjRHOJMPdjGLgBtrnecASLw8B9XGvs+FrUh7ofg7G1Dtr
	 8qR5lqd/Q0NVUnwFPXNaTIMf0V3mm9B+P3ECtj/LWAdNnd0siQXvuFm1KU9P2AnYH7
	 f/YWhgYPLMcl338FDxXGpdCOYB8TCPcWL+RLtSUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAMXpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:45:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42663 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgAMXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:45:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so10767938otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7d1TijNzzm5olBqQ6BOPTTjVLO96fK38vWoVBLQU76w=;
        b=ZiGssHkBNGtX9cxJjGuemL5n/u15peCRyq92jILNKA0bttaOcDyQok6CrqErWiuFYO
         31phr5z43ZW/PNPbxMVT36EMCSlNaEQyiqM+VAi6ZYNwngiYU4mWEYbuz8QeXv7gJZVZ
         MYWV15A4pkkaB6I19jkDAEBMxg/skEM4K21OJ4O+xQhE+886nLxVvBz/w2mlIYRSzo1Y
         D6+orLyxo74vSlpxOC7mBvG6jiIC1MOS88HgObN/bWNYbVs+z1AzBW8dwHIUWHYw+6S8
         Rgv5yclQ1gyNVGU34yxtrMJZq1n+jXP3uRDlSwGInPIhem/UjOt2aw18Cyj2F/BwKKkZ
         Lb4A==
X-Gm-Message-State: APjAAAWVbHW+6yhQciq6r59nk8gRkLCxABb4SdaTlDnp4rLdKXBANveM
        x3JUCHVNkWwvSGvFXLpSiw8bBpQ=
X-Google-Smtp-Source: APXvYqyhjIZwRo2dlLXF0PtTJPBUBDvVHFINYq8yRNgu7zu5zsqq3cEkF+tzpPRqv1sM22is8zaveg==
X-Received: by 2002:a9d:6e82:: with SMTP id a2mr14376104otr.336.1578959104798;
        Mon, 13 Jan 2020 15:45:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm4792944ota.27.2020.01.13.15.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:45:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:10 -0600
Date:   Mon, 13 Jan 2020 17:23:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 02/17] dt-bindings: at_xdmac: add microchip,sam9x60-dma
Message-ID: <20200113232310.GA30698@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:54 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-dma to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
