Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD7C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD902073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6Dtm2xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgBUOPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:15:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33105 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgBUOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:15:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so1617733lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkDE61A38BuP/ygTbozBgf5MHpH9Vo95SRLvSWO439k=;
        b=t6Dtm2xouaekc2EYrWLEiRUk9zuzsx/ycSUdwto1vsa8hH21/0n0fsS5EpTujeRKQY
         8cObip8/t43obcYamNuVdIlHszzzCp5VGj6iyMSEieDfy/vR/lx5E6LccTtYZ83AOfyP
         oZECnvFBM1fTQI9Hc933Gn3ZkAOWB0Exf7IQsnk3yy+tySMBmH1NCFPCdUsmF7AiPWXH
         VKMqvJr6BsuzUCZxCOut1irILOrmr8G6HWBoZcUMvtJbz6e6OPfpV0CUqlZO9WuoScWy
         Nt4NTixxcAszC3FBbeBToY0zMqja6JoruuxoS5PaAyrp82LcAs4KNPi7QOHqHXoKyOdB
         Ap/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkDE61A38BuP/ygTbozBgf5MHpH9Vo95SRLvSWO439k=;
        b=NxpRkQs/tBsy+rhQJqlO+1H9jxfuEW3HX6eDLcwkOcAEdUgh0ZCBRQpJlG2+hzz0Vi
         Nq+7oIDS33BxIttDdhuOmIrb3PfBW32Za98CNbeHNwdIkHQGWgx1oOoSYA9T24YAo89S
         DzXYnIRgU6Xv8SnuebYJYEazLm0pAZaMMecGfT9xma6SE/ST6j+aPKH2zQzTMW0JGvKV
         xYjyNCisYdWuaTP0SCCtco7BI6ank2KqXRBeoX56jsTYaEaxpPlc70Ea7aA2afGqdH0F
         tieG1ir8VfI5Usgk+horKT1VDTduT+X8Jvn01//drBQ0zer/5xBbk2JkfNu2Dw53yAZU
         953A==
X-Gm-Message-State: APjAAAVjKmaLdmqXrcFxaRhgMW7bxgCo/w7VeisMCNmO4/5/DuldPgcm
        mGpOK77BfN1wwd69Gw5fB1htevcq42UFCM+14Yni2A==
X-Google-Smtp-Source: APXvYqzecyE8QpYi6cdaz/TQalK+k7VYi+YdD5LPqzgQdo1IqXlfsRa0zlv4Hf96qBf+2V4EYlojhnrFM8/XTBOXs04=
X-Received: by 2002:a19:5e1d:: with SMTP id s29mr20122200lfb.21.1582294511956;
 Fri, 21 Feb 2020 06:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20200117213340.47714-1-samuel@sholland.org>
In-Reply-To: <20200117213340.47714-1-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:15:01 +0100
Message-ID: <CACRpkdYtmRWai8X4yAxNt57zT2eUyLdkDaYCmB=0BU62zAa81g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Forward calls to irq_set_irq_wake
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:33 PM Samuel Holland <samuel@sholland.org> wrote:

> The pinctrl irqchip may be connected to an irqchip that implements the
> .irq_set_wake callback, such as the R_INTC on A31 and newer sunxi SoCs.
> In order for GPIOs to be able to trigger wakeup, the IRQ from the
> pinctrl to the upper irqchip must also be enabled for wakeup. Since the
> kernel's IRQ core already manages the "wake_depth" of each IRQ, no
> additional accounting is needed in the pinctrl driver.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
