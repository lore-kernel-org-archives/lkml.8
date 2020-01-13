Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32411C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834320678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578957808;
	bh=ekpsGuHx8XGU6flbs8e8D7XDFTMebDIjmH8ohTnK4Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NfGuydtXJ91CW88xjYfqFCNBVRuYYnNfPDuI4ZsSNjIbbHLHEMOTS0yzGj3VZl4ib
	 wvomqX+IsPUPTfwQmAoiBLlOemwk+ouftFpBXVVEvz/a8XCbXWkVYN0e9zI9gbr5rk
	 iYjih9cUQpXqupD6wLuTtjyToly8auXY5cxD+FYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgAMXX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:23:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38006 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAMXX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:23:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so8606116oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=KsoEMbLLvrJMLMGQdYwY6LpMbMBEMn0smgBz4yfrvLsWFcYOnDR5MOFpkdEmRtevwm
         eAIj3OpcadTbs3bHwTTOlc+tImg4KjxHtYfeE/rssYDRbCLpkPwYFZ0KxpqExZRhmXIA
         giW+Hf2oILPhY53F0iqRJ35symMgSgeia5kw19UZ9Zd41b3/E30lD47eRftpoUdN8QIX
         4L2RTG4dS3iZG4mTmZiNSYwZclJ+5Yg/A3iX96/EuzrdwDJklGdmIyIG//mFDCK497rG
         s+stJBAXu9REEMWVUi2Tx7ELu84RahcUll0/CqDV5YCBMbEdz4UtmOTf3NmBEKVPAYw7
         eJ6Q==
X-Gm-Message-State: APjAAAUmvaj/BBc+GsUTaVbhZMhRrBmQf6ySyeTuFiQUL8Njc+OcCjVd
        npRrhTsDTBYcPqFZM8GqCXXh+OyjQA==
X-Google-Smtp-Source: APXvYqzxpIegVtMutKvnJnVNobt4ZzjRZBJJKtvOTafqVJCXBZobRL+7mwd0F7pSvULO9Y1LL43tsg==
X-Received: by 2002:a05:6830:114f:: with SMTP id x15mr14299773otq.291.1578957805583;
        Mon, 13 Jan 2020 15:23:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm4699270otk.11.2020.01.13.15.23.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:23:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
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
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
