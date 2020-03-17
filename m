Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EC8205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="KsS6p0MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCQNez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:34:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgCQNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:34:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so25667365wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Z+MKHW669WEkjd/iNBh7MeO0SsbRIG9idSMvjhyzbiM=;
        b=KsS6p0MSp52TQAcG7pvBldUBF4ekSYc5JYV6QQ25LYZtQM+GqD03+hDirW88u+gcB8
         i1g1ttt45YwZpoH3hjyZl4FIrK4b4qHgndHYQylhjojW0lVnobwze1ck8wlLy/XOTi8K
         1/HUrbQYGcLlGNCRXu7lDrkKVJFeYDXfkS48I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Z+MKHW669WEkjd/iNBh7MeO0SsbRIG9idSMvjhyzbiM=;
        b=khIUjdglP0RKyQ0bkW9/avBIBIeKHEucLSJvrllSpYl8UXjh+/8FnFWlD6KChv5cAB
         JmLTjaEPsJeJKwp5XVt2t6qKGxGSN2aWxhkRt8rXKbiBgYOwFyaHcYu+rG4/Ljk3Cqec
         igh4BiUDJ4wie6NCGpLq5yQHHYGCoQ4q48BS2MmlE6CJ8cbIwFSxQiHtKYr22tDe1BHG
         sL/w3n3c7f63uBaSq1puxbd5j3VNr8eobx6YPJVCqqTMtB5ad2jQYE25nmoTr/sqBVaB
         ptgIGqmKNZYsEE3h2McETC7NjgYCuPp42W2Bm7iLrS+2y921Me5pNttJ91CSCZB3LcTM
         m6+Q==
X-Gm-Message-State: ANhLgQ1FoOhDSQDAqT4BI/RoqJB/rNpOryjx4KenCDWh0wRUNGJbKpuo
        sWWiXttf2xnuGoQ5KZ738WvwOQ==
X-Google-Smtp-Source: ADFU+vvJjTHmfHQo38ivXXn/g9YSOLIfUDH6jMyjCpk9QGccwR5GHnql6GYdWNxMSbtwzbwStHLX+w==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr6080882wru.253.1584452092645;
        Tue, 17 Mar 2020 06:34:52 -0700 (PDT)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id n6sm4003655wmn.13.2020.03.17.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:34:52 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:34:50 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200317133450.58c25bcb@ub1910>
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 14:32:25 +0200
Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:

> The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> Rename it to PWM_POLARITY_INVERTED.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Looks good. PWM_POLARITY_INVERSED confused me when I was working in this area
recently. After applying to master there's no more instances of
PWM_POLARITY_INVERSED in the source tree.

Reviewed-by: Paul Barker <pbarker@konsulko.com>

-- 
Paul Barker
Konsulko Group
