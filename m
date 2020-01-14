Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C0C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A4D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961808;
	bh=ICuLmJcd5MuUF5ih4nNV4O+uuHngWapP4XE/nqFRloI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aC7Ya+GzeaPNypGvs7Va9tkfb8XwNi0wEqXfqgxtpc3dOMUZtfsXz/MiFAktsup0b
	 VvuKMfTvRuZOJu6N2bgXL59b0JAbPd8lgHWCvG5aNgDHdyXC0po8lZsDVNnPp6IF1B
	 9arYmtCsN/6BrCnOnFqtpQswmb+OGBdfY0n5bc6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgANAaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:30:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41060 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgANAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:30:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so10167651oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qSm233hBzLTG9G2DIy5d4ytValKHnVbjxr5pAXtlvA=;
        b=Qf4+Oqmz1lVdJSse2MMUuBYIEcEaOLGOyscLd74cI7oGn0Kf9PKH+WmltU9Z6Ed2d9
         cSNxB8OZofoZtaYt7y4PM/w4Nu6l845zRZQXg0lroRE7JbUmzJVSbQDrIuNDCSA/oLMQ
         EF03zoNJ8VRtYeIBsg4lxqBld2f2QSPRq+WRgZ8S/E8VNKUdoh3VIR3/d08LOCTtU0U/
         zaBHSBAQ5Sh/xqiShcSFxk3fAkEp5X/xwt/zp8XohxKbSReRp2YP5FTFo0FG4uuU6B2n
         r6LyyOokUym71Wk+MNAJm589dDtW1SIau+5E6jNjF0XtfSdB11XdV/wlrPlTwBYLCxKt
         9l0A==
X-Gm-Message-State: APjAAAXvYYBLivfo9kI8edjC5T9fqm5rLe8JnHpi9rvwrENou6r9yjpk
        pW/cuk6lC7xDu+LLupWUGC77isR4Iw==
X-Google-Smtp-Source: APXvYqzPXZWcYHUa4L6AK0DrdFpp807IoUTu+EcYwldRQo/ISlUN/bdaYV89zbiodwWTb5Mx9rCXPA==
X-Received: by 2002:aca:cc87:: with SMTP id c129mr14349953oig.13.1578961804529;
        Mon, 13 Jan 2020 16:30:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm4735554oto.60.2020.01.13.16.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:30:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d1
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:21:19 -0600
Date:   Mon, 13 Jan 2020 18:21:19 -0600
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
Subject: Re: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add
 microchip,sam9x60-rtc
Message-ID: <20200114002119.GA18003@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:04 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtc to DT bindings documentation.
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Alexandre,
> 
> I kept this patch as in v1 (same for patch
> "dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
> I'm waiting your response to this version and take an action aftewards.
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
