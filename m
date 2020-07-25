Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4735CC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264DB20674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLdQphfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgGYO4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgGYO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:56:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02316C08C5DB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:56:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so12801650ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=Z3BO379AIIOQgwO3FCcZpz1irg2T698dYZqqZ6uG+R4=;
        b=tLdQphfJzsVs9dJ2Glsq2n5VdjG1lRATm6bxyUBb27Dch67O62baUNJo/untsiHJSZ
         BPpQPAVJqkp+glVjPi5umUBc9fbT6Pj2lrotfhMrcPMR9NAlf1npGa/vRjGlKxriVrYT
         GACmDPnCqmoh6O346YthLBMpOyqs2cW8g+7aFpDigBBkygHDwrTBRleB+Jrnd3YrtprR
         drf7qCqYbQf+8CmIZDjFejZwfeSrwnMKwMfRQqvoh4yn3J9mD7dDfqhlDMNekD7RuGeI
         q+pRM6LUaQQsYg9neVCqiCbwS9ifDndBqX497Npz6hgW9oNHCRKjiyKoFyV8RdcVPACp
         v5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=Z3BO379AIIOQgwO3FCcZpz1irg2T698dYZqqZ6uG+R4=;
        b=K+Ba34NDXLndR/yJhm96a3O7ulISYhdsplgH3lz4fTjEAhQUWTxGRY/zarJZ6OUdfx
         elzX41YnqlvaERhe27Zu7nqju9rqQ8FmCXNNs+XGnvkI3Xcro4K+G5xPxjaJjJ4CWHbC
         zxuYNj4nMTBVFuKXhl6t3d50v70JFoho5e1LkncIKDOkr9LHTpAFOwGA56unlyWJEYs0
         QKaTyD2ueA+WGFu0PqpQoJESs3u7FqJTw0qrN4qFxaXf9dxKWcJyB0WOauW5WwtmJsJF
         6EwffHTnTTAD3K4II204teKk7kgI52uEfoaLbuBaD1umLdTQPdDnB9FLexdaMwSDRWLB
         BHEQ==
X-Gm-Message-State: AOAM531mkdgcY2EBPXwMfXinfztNBtF4P2xoX+bMbODE86h0Xs9KFtR8
        wCL1VFRxsHEpsfMX7FSdLwlhHoeAjBDWkSgakio=
X-Received: by 2002:a17:906:b787:: with SMTP id dt7mt11099293ejb.320.1595688968572;
 Sat, 25 Jul 2020 07:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com> <20200724213659.273599-3-martin.botka1@gmail.com>
In-Reply-To: <20200724213659.273599-3-martin.botka1@gmail.com>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 25 Jul 2020 16:55:33 +0200
Message-ID: <CADQ2G_G7N_iH523urk3wOieZ0bT7O88Vnnbq6r_h9A4GLXQ5Nw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As can be seen this divides llu by llu in few warnings and error.
At the time of sending i didn't realize it but this fails on 32 bit
architectures.

So i would like to ask how would you like this fixed ?
Using macro or some other way ?

Thank you.

Best regards,
Martin
