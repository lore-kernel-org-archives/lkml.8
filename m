Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51826C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8121556
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578963609;
	bh=w6b7zxtaX1JNVVh331GpaaL1Tljp48nC2gXOjBChnjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GFcVpI/G2NF+96MZNo5xkcX8xzazSVM6JlIj1ap5yfwf/pHb9nNtOwe/xTG2CM2qy
	 5REo+ZPkaUY1AMT7d8cURc58xB7PJyz//BxWAf/Qf8fW0v0Ik5I4whWPsmgnMQNx0B
	 wd7JE9bRqcEYiHoX/zQyMSg96VS5gquw1zHwAHsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgANBAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:00:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36921 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgANBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:00:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so10265107oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXJN2b85yGTyfLCLDYBimi22Hg8WM/nHD10wRzYfTm4=;
        b=Ro0P7aDz6hyzXO5rfR6V0kzTF46LLJ4qA3uOcdYARDHRiMs+m3v8ojvGigkRRtK18f
         iYunyjDgyarDDKdhiDOV78S4umEOtTK25TlY7OXR34IDbsdqAixpe7EY0dVDuZKSjBo1
         Ind8alKZ4U0XWKoWAtzLqeFp74I0uYxcmWrqGRnyN0sR9dIhgibqbF32wD8DrF0YiHvp
         s1CMR99X5BXdmuLKe9/6Qrz1HM18yG3IxZg2EkE3JorUutJINybSxaAMAln8n0rGPnS2
         T2qC9lDH7wiVxZprLWg3wxO+tJvc5pG22VpStTwtXr/CQEjf1aJWVbJskCt45cC0Bk8Z
         2PGw==
X-Gm-Message-State: APjAAAW6MtBFpuNtw5BprTVnSPM0ML+Zh/aMVY+ycG6LGGvrveTKkhaf
        Q06z/uTfNDNDvP0xZ9SAMK+KnwSFQA==
X-Google-Smtp-Source: APXvYqzXw2S6y8s5CM5uOD6UWMTfHf4By9csm5iuhLieHFP1Um4mlWMxJgjQbiChEu8l8h8UDHqU4w==
X-Received: by 2002:a05:6808:3c2:: with SMTP id o2mr15125700oie.45.1578963606483;
        Mon, 13 Jan 2020 17:00:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm4106780oib.16.2020.01.13.17.00.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:00:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:33:32 -0600
Date:   Mon, 13 Jan 2020 18:33:32 -0600
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
Subject: Re: [PATCH v2 15/17] dt-bindings: arm: add sam9x60-ek board
Message-ID: <20200114003332.GA3401@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:07 +0200, Claudiu Beznea wrote:
> Add documentation for SAM9X60-EK board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
