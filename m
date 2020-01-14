Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29FC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B0824686
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579044623;
	bh=UjhzyhOUVK6JNG+xl43hmkQtrC9ZaW2jX2cOKAGvLI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U3Xia0WIFUudq04NMBIDMxGDzh+m6gi9GI1fj6I8dDgTvDK0AoqUbC3RR0W/TsvSb
	 qnn1+BJWUD5pmL2VTOO6mbNnTNb6jCyVYxuh5Ho3jXzPjgrWBwtm8PEmptTn1dZZTZ
	 U7ZwTe3+NUOb2gBUnBZ0hqUdPFtJagDkYqBycG5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgANXaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:30:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43200 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgANXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:30:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so14390415oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OD3k/3afce55aKrw/+Sox/ckv7HTxlsRWXlz74Axqv4=;
        b=mWJ9WA9JDjHwi8+KCYNxtAXHHiHIQNGW9F36vyhxrqt0s96F0bw4TEduUFqgrzHkCP
         j+MzSyZqIEuIcsumtqG+iElGK6+XdU1a2c87kFflIh9atffubca6mpxsX50RhooZWir/
         8ZeuWySWxTfaJe56gs9vnQ3kVFiL27z7xZmIzIF6L2L45p1YG6O56mZSIJhNmV2nPdB3
         C4jPPEBKbKihQczgMMhnXA41uzvqEW22EKtTsKoqBCzqFUvn2BQs8qneiy2DYFg7SDmS
         ccj8e6s7DrMIz8nMq7AOQ5oVbLrrfaCAxQdiltNunsTaCbC3lHjO5glqjMuA41fSsv9B
         wMRA==
X-Gm-Message-State: APjAAAVLx3+TuTKaSx31omlND6SzQmZl7r5QMozY3tZ40NINXc7hn8ep
        oBgNKJanhovmUMOg9VQSlLG+TV4=
X-Google-Smtp-Source: APXvYqypzvqPBs9OLl6eJg9h7KsSB7JMRbEqqAlLZKlE5JHSXTCSvWR80jfiR32TVozVUO52OMwHGQ==
X-Received: by 2002:a05:6830:1e1c:: with SMTP id s28mr633419otr.335.1579044620960;
        Tue, 14 Jan 2020 15:30:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a6sm6014761otd.81.2020.01.14.15.30.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:30:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:26:49 -0600
Date:   Tue, 14 Jan 2020 17:26:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: atmel-tcb: remove wildcard
Message-ID: <20200114232648.GA16276@bogus>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578997397-23165-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 12:23:11 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatibles.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
