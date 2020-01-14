Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6CC33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C3A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961505;
	bh=AfbOkoOfBZ0Lq93SqNGArLGHFuoVeCsjXzMdoV78J8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBBHej+AKVx1Ypjq5KGldcrPY/VMxXxwnwnWAp9vdOV3KSK7hZii8zyYRyfSU2boW
	 MLKIqKrqOyZ1glsoFKufQrkzyH0kooW88VAzE89FXmN2MyTKw2qih+3KNrHe3iVj8V
	 Uwu0qUUjMS7wm/Apu19SvclfEgHs0gVavAgv5oww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgANAZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:25:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41888 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANAZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:25:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so10855189otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiO2+Fp93HhiZmZTyPCKddyYzvj9rECWLiqMRlRa5BM=;
        b=mv+R/smN7mTb3EjXD84wRTaMTsBVWD5OsO7ch27PhZltFDPdWq5riV1y0c/ncX511P
         0WlEwtzIOJFI/jeLDU304Ic8SMuDsZRmTTZkS4eHCnuEtii80uLrUy0t/54zip5AJIuc
         KqfLWBc7jp2mvZX9w7qmXbtFROht0Vq1lTrYxViLTF+FCjQXxc7clhkfcEkrY23eVPaO
         4kHmIdOL7mCXQcZxXH7a5ZpyF0nzL9RA+F6pVmouwfgwdM1pgkNcgkEIqalLtfLCmxzP
         c4yGpI0pp/Dm2wjGE7VmYvE1CMKuddn6/Vr5dy6sRagI3KQr5ffX4ZwBsLKlMlLe+Dw8
         R9GA==
X-Gm-Message-State: APjAAAVYn4eb8/Az7FOFwGtcM1XYuCvWymI0MqTXxEmI1v40rhJ+q9Qf
        sQ26ifGLFynl86WK3A4S3n833L97kA==
X-Google-Smtp-Source: APXvYqx6H9dn9Z3+VbB78oOxjMtujuJk3rWpBUThHGdTnb796bO/RBXsluxAO5Rskl6XXnZ7B7+GHQ==
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr15228900otd.39.1578961503746;
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm4731527oto.52.2020.01.13.16.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:18:03 -0600
Date:   Mon, 13 Jan 2020 18:18:03 -0600
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
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Message-ID: <20200114001803.GA13249@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:02 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-smc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
