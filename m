Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2BBC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790E1214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961222;
	bh=4fiixW2EB7t7wNVahtcaM/AyIKNE6SsJpV4VmYij+Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9zXDFQ0C4VjDMDSx95QQ624R1rv77LxJo2Dsl/I6K3bR1wiyejyc7leM9FdxH601
	 2c1cy1cAeFwK8/t+BE8avUzRP7EJgxh3nFO7UVJVe76d4VmXCKzwlLJiK2YcJFI6h9
	 LUMKlIHcSgQSE6206uJ8Sk8K7XZkDozO3MQoA5QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgANAUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:20:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33636 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgANAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:20:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so10892165otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PuZkmizV0FjMntSV+5swUbzzYgbKg4dX9XcvnF9x9qQ=;
        b=XsW+UL7qsAn5AVvYZXztjGSghsBJ6lNsqiDK9QfkX2qrVd/HEkRZxIYMJX64WwF+K3
         iBmT6KafYGjRnC4x5YfBg5xZiDXHkoXtnomwH8HcA9LqpkkaY01BR1zRS/PhKwD+wDyU
         KvCfH+TDYZd3w1zaAPWwvIjKoZeX/P3b6oIHviG4gYh6m46+O153Z1YAt8/USXHA+tlP
         w7/1hYf2ykomJHbqqTdW7Wb/VsYRlIN9lUdf0BHHWtBzrgsPW9vxDrE9aaYG9UqnuCVC
         fBdoLJQnauqK5rfZG2By7hOFyQw7zxSjnnd0s56eBOe7iWBcfrWCHChxE/usxkdWjm+v
         8Wew==
X-Gm-Message-State: APjAAAW3GOPzQRAvrqK5ckGWfbeUlhJ+FWh4Kr07yExaTM7p9gvhfCKU
        LXrtEa2PXaeyiqod+zngcyZMnuYcUg==
X-Google-Smtp-Source: APXvYqxQyHc5eQN3JBujKc0Rhs7V7KBbK5AbWkO8LcWnjx+5MZb4F1Pgu8XImBYnM1i9yJTbfsUaJQ==
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr15499734otq.55.1578961220148;
        Mon, 13 Jan 2020 16:20:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm4744497oth.28.2020.01.13.16.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:20:19 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223d55
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:17:17 -0600
Date:   Mon, 13 Jan 2020 18:17:17 -0600
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
Subject: Re: [PATCH v2 09/17] dt-bindings: atmel-sysreg: add
 microchip,sam9x60-ddramc
Message-ID: <20200114001717.GA11996@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-10-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-10-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:01 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-ddramc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
