Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8241CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560442067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598344191;
	bh=0Pja9Pl58vSv4Xj3ePSQToQCG2OjZ4CUiuvoFXfrQ+U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=rWwdPe0VAAF5ulefeutjtUpSe3rTTcizOaXHaWwOSpNhl3YgeSf/hyfpFk8HiZttr
	 e921HH0/9lMJHKUAv5cujAFZ3H7ioE0y8pcvqF7LVHuX80g+hsGt5aQr6+5oFEBX0c
	 7k1C0/w8pM1dfvmJb7WRbcCbGusnOjsiu4am9lXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgHYI3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:29:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51197 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHYI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:29:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id t2so1544653wma.0;
        Tue, 25 Aug 2020 01:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkVGZDX8kJI9mI1G++5UxoqItzmkNicQe/GJs1RM9xw=;
        b=GQdATXdzIx/wDTfKHLjQWZZiCS/UNragrmuNSvhWq66KgK0U1kf2InULpc0/RhKI83
         cGsFH9vFgFTMBMtYdXmFlwjvN6e+v8N2/jg1+EVhkjBr82qRxNZqqKQtqshKU7kGoBI9
         ooeQz8Pl56yPa/d/Ry5WkPY4evEYWxeoeVCy2ZVBln/BOtVTGPDQvRkoDaj3BmJELNL4
         j6qe8iM3Cx+niXE8+eQ32yyV8K1xtzj8rkj8xjXvg9iHQN09aOfAdoipq6PwH3VB/mke
         cUw86Wv0l16xrOBu5fh9qd22IUJz4/ilicBvs4hgt3hqptr5dyGaW2oafAqFpH8vF9x5
         k85g==
X-Gm-Message-State: AOAM532xmEIgsVlCskeskzaHVFm0Q5eXqBgnEC1+ehqCm0lfgvMIVzi1
        OcEK6DD8HIzrqhnys7ATRDs=
X-Google-Smtp-Source: ABdhPJyGZYBTYvBnIb1U6Pi6IZyfXdLtVJVjvq4o+WqdI5gMCjQzeo/6wd0xJgWYZ/5Vtdr46sQ3cw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr940487wmb.54.1598344185330;
        Tue, 25 Aug 2020 01:29:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k204sm4973101wma.21.2020.08.25.01.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 01:29:44 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:29:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Message-ID: <20200825082942.GB12902@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824190701.8447-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:06:48PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects regulator names to be lowercase.  This fixes
> dtbs_check warnings like:

The subject here is not correct. Copy/paste error. I'll fix it up.

Best regards,
Krzysztof

