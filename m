Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4EC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A002082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGPGzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:55:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46313 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPGzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:55:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id h19so5850685ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sxgpg0qwKqhAjjJRcJlW0cPbc10NRb95BKsLnURjnI4=;
        b=WUKHk0VjJBKvS0+P3kq8srNyyJu0gvA5u1zNx46+G4qY539PEL0c8bnb4GJT4mq7u8
         WhZSYSNDqq3/o3sp8XuzwVaVV7VyXcXACk47W8hKLcBbOhqSXGRG09HwI5bbJTGYJ2qp
         rOTesJJDtkxiTBIKvyuktBiscUL7ueueaAdKpRnxOfX5T7g3o/GIe6uEAYKFP3HnKbWn
         I3edTdTi1faJq4JTiVVClAMmMBhSNyUvr/ncfpp3eim42aTTLSMf+A16ihtVaTgO6H7l
         vcejOp3/ZJZyIRvzB8PWm9eiXObLmPpGBymwR2eUf0fObdqqpCt5SY9jcUToahZsQUxZ
         uOtg==
X-Gm-Message-State: AOAM530wEdV15bmH/JoUdPowSu0TF54bLx/8Fb3N4JBziF/6yks5zLOh
        dkeHnxXsuStY9MyWRoajQ59D9rgHtHo=
X-Google-Smtp-Source: ABdhPJxsZVod59rhV7kTlqQmnu9HOUhhJymFj5doxHvaMNT9DnLTvLYGchXEBRPzCvHbVdqgKkDiKQ==
X-Received: by 2002:a2e:b53c:: with SMTP id z28mr1262663ljm.439.1594882500508;
        Wed, 15 Jul 2020 23:55:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u5sm1175508lfm.81.2020.07.15.23.55.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 23:55:00 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u12so2711251lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:55:00 -0700 (PDT)
X-Received: by 2002:a19:14e:: with SMTP id 75mr1395358lfb.7.1594882500157;
 Wed, 15 Jul 2020 23:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200716062427.71763-1-vkoul@kernel.org>
In-Reply-To: <20200716062427.71763-1-vkoul@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 16 Jul 2020 14:54:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v65E1SeNi9Lt5US1YQrFB_uhKisL8daZwqth_wqzpkNTKg@mail.gmail.com>
Message-ID: <CAGb2v65E1SeNi9Lt5US1YQrFB_uhKisL8daZwqth_wqzpkNTKg@mail.gmail.com>
Subject: Re: [PATCH] phy: sun4i-usb: explicitly include gpio/consumer.h
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 2:24 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Driver uses GPIO functions but doesn't include the header explcitly. Add
> that to fix build errors when GPIOLIB is disabled.
>
> drivers/phy/allwinner/phy-sun4i-usb.c:367:11: error: implicit
> declaration of function ‘gpiod_get_value_cansleep’; did you mean
> ‘gpio_get_value_cansleep’? [-Werror=implicit-function-declaration]
> drivers/phy/allwinner/phy-sun4i-usb.c:707:22: error: implicit
> declaration of function ‘devm_gpiod_get_optional’; did you mean
> ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
> drivers/phy/allwinner/phy-sun4i-usb.c:708:11: error: ‘GPIOD_IN’
> undeclared (first use in this function); did you mean ‘GPIOF_IN’?
> drivers/phy/allwinner/phy-sun4i-usb.c:815:21: error: implicit
> declaration of function ‘gpiod_to_irq’; did you mean ‘gpio_to_irq’?
> [-Werror=implicit-function-declaration]
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Maybe add

Fixes: ba4bdc9e1dc0 ("PHY: sunxi: Add driver for sunxi usb phy") ?

Though it probably doesn't apply cleanly on the oldest stable
kernel due to the extcon-provider header.

Either way,

Acked-by: Chen-Yu Tsai <wens@csie.org>
