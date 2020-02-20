Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C21C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H62U5hBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBTGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:50:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40954 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBTGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:50:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id c18so2005968vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qjx6aSF/rYbAiv0EvUOF/ZsAzxN0pfEVgpw7b59ljRE=;
        b=H62U5hBEbjiE4TCDoMRdK1Jd86R01mh7rJVbO8yWo1j8QYD/F0egNJdaQLiP9Y68O5
         J/NusiLUwR1RZUPv/eH48umnaBo3GiMrY2T0F2hqxf7/FPBwgnWh9uliywhNTtlQ9pFl
         OoDa0qXB5F1ze2QjirWfLhJsuDuYbP/eA6fYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qjx6aSF/rYbAiv0EvUOF/ZsAzxN0pfEVgpw7b59ljRE=;
        b=Bbdn0sSAdduzQQlDeKVzo1bo27rifUI8dlDxMbx5JRd21l0KKk/bHVtIMfjoOpGps2
         l1in3ic2ligdoSHvDJGyXdAGTXIUPG2s1F/4/F5eNbqz73ja9l+tF1YjEWaKYc/8TPRH
         LjSZ1AQA6UjQxC9E1oQv3ZPh4BEYKGnO1wgKb+YJ23sx692y4TDJmWy+ghhALnOCffof
         xLsG+uz2V5xKtoN0jwh51ppG7HyxH4moe6GEc+zZj4Pz0Q+fcItxy3xV9qwDenAWMG0j
         G5PgC7dKmNq1Zw8P8rUtA/CKw2OW8xNOWb7Y+qMbstyS3PippJB6xsz2j2llO/hqFmgE
         KH3g==
X-Gm-Message-State: APjAAAUrp5xCtJU0qYPmJ+FTZ1jZjpzxCyBV0ww8BZm+QGijTRiHOG+s
        F2teuE4sRwG1LACzVhj1DGU03EWuS+jMUw==
X-Google-Smtp-Source: APXvYqwW3TAPM5ChCWYRL/AlXwv306athEsLZd3+VvJrh+1obXHSyoHaOWxoXSyzLjvZNNq2Ll0wmw==
X-Received: by 2002:a67:ed93:: with SMTP id d19mr16537324vsp.60.1582181431696;
        Wed, 19 Feb 2020 22:50:31 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id m11sm559090vkm.52.2020.02.19.22.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 22:50:30 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id n27so2042423vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:50:30 -0800 (PST)
X-Received: by 2002:a67:fdd3:: with SMTP id l19mr15726222vsq.42.1582181429665;
 Wed, 19 Feb 2020 22:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.2.I7c8247c29891a538f258cb47828d58acf22c95a2@changeid> <804d3cc5-688d-7025-cb87-10b9616f4d9b@roeck-us.net>
In-Reply-To: <804d3cc5-688d-7025-cb87-10b9616f4d9b@roeck-us.net>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Thu, 20 Feb 2020 17:50:03 +1100
X-Gmail-Original-Message-ID: <CAKz_xw0fHgVBLdEoEoQ7OSAgBcvYBAowV0obWLsDUGNPotP55Q@mail.gmail.com>
Message-ID: <CAKz_xw0fHgVBLdEoEoQ7OSAgBcvYBAowV0obWLsDUGNPotP55Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     if ((int)res->a0 == PSCI_RET_NOT_SUPPORTED)
> > +             return -ENOTSUPP;
>
> -ENODEV would be better here.
>
> > +     if ((int)res->a0 == PSCI_RET_INVALID_PARAMS)
> > +             return -EINVAL;
> > +     if ((int)res->a0 < 0)
> > +             return -EIO;

In fixing this I found drivers/firmware/psci/psci.c:145
Which also translates psci codes to errno codes, but uses EOPNOTSUPP:

    switch (errno) {
    case PSCI_RET_SUCCESS:
        return 0;
    case PSCI_RET_NOT_SUPPORTED:
        return -EOPNOTSUPP;
    case PSCI_RET_INVALID_PARAMS:
    case PSCI_RET_INVALID_ADDRESS:
        return -EINVAL;
    case PSCI_RET_DENIED:
        return -EPERM;
    };

    return -EINVAL;

Are these more appropriate?

Evan
