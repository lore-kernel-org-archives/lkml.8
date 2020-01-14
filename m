Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A307C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404922080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961518;
	bh=qMV9t6yq7xpLcOxvDk7MIU+TGS/TsLnI3P1Rd0BbMos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZTu9YNxjM1Jmy/79H+XKdYlh/kAvdil9TmIiyi0GqoC932ydFSlxcf7Z7yOPL/vq
	 BVqOfvqcBq4CYf/hYygM6CtBm6AiQ2qlK2b60xloZ011xOX8wLoh3ybV4udXrzjAm5
	 lfpo0jtg+dfHCUU8iqT0VRarZuYmE9aNPjgq4vUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANAZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:25:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36841 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANAZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:25:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so10191947oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4zWbyVluCegWLV1bmjQGYNlUCTLZBFCektijqCqk8g=;
        b=ohFCkx4e/2j9cHGG4gxsOASerya92wzJYHWRN6aXATDw56AOmIgZeJEiUSjWsTvm8B
         yBkqQd/8SnKK4xOTUVA7EWDgu0ILJgik+iseuxrxMkwWt1kjG/PEugUcOivQJq6eeqyh
         0KkvVQQgH8ZpKCZ79RQ3L3E4m36VLUWLuGx5i/IEDZeng85nt6NHqt/1xFSk3oINOwGm
         9USrFSuFlPSpF8ZvgaovKndTGN49LEriil5Gc7w6LjqKswpoKdriME8UAjvGG6x7h1wI
         WrLY1yHEDwdH+JUj+ov2EmpZc8Jd8SjSv7kJ7KWq67by/KRtlUs934rMx3aDcNUNX6nc
         8I6g==
X-Gm-Message-State: APjAAAXktJPHS1D2LJ9PH2pNXkTThv4BOdpBFyeq3ungFIOdnj+GPqD1
        l3mt1WCVwD6l+8BZ8Nz0bKgabjz2+g==
X-Google-Smtp-Source: APXvYqy23bOszj3W1JgLUAZl5R4AernNDb7+X7hZzFlZYLSQpZp77CJM4GNbSaf1T32txZ0G7NPPog==
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr1546887oig.112.1578961515367;
        Mon, 13 Jan 2020 16:25:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m185sm4077162oia.26.2020.01.13.16.25.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:14 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:20:42 -0600
Date:   Mon, 13 Jan 2020 18:20:42 -0600
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
Subject: Re: [PATCH v2 11/17] dt-bindings: atmel-gpbr: add
 microchip,sam9x60-gpbr
Message-ID: <20200114002042.GA17036@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:03 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-gpbr to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
