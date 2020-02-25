Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D8C35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6402072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cpUBPuKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBYBYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:24:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35835 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgBYBYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:24:00 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so9422830ild.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 17:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIbp8wKGXVLLxHhTy31TRd9NVAkz0p3dg03obFlrOdo=;
        b=cpUBPuKWaRuBRB9AUcAXjl3OxvWKcMY4ENFehlzSMbeMTdlP0YOoJTcPxN3/4bl9iN
         y9szjZKNXJ4UqMrX6E0+0aiSkCMadw20DJuQk6IEO3ouJpLd4MgEZuCv4MVqKwNnRNTT
         b6VQbn8bPxwvWbnqID6P7n5DHk4H+xn+aUMpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIbp8wKGXVLLxHhTy31TRd9NVAkz0p3dg03obFlrOdo=;
        b=GxJIz//FqznoTa0zfchdu4zy3ytrAi9k4AzD3FPr2A+rMQDnCy+7aEj7uG/NnV34Ci
         65SU68NNqthrz+OmoQNJsmU9cQuzUzk3oXI4N2V17LnKTZQl25IUJAuu22VK0RDiR15o
         07oceKylIceClI99VzODroy5l2c/JTBXfc2NQ0QSw7JeFqrXNDJ+7nqaCoZbIjVA2fJg
         L91ZaMGrUhvVZi5KVmNL5LFlacr1QPcJO9iArcxkYEYNwapxIGzcC3ka5ILHVbkNgdoL
         1lIy/mzKnBzm1SBuSxE9UOdGh27hC4bZBlyqKTYy2+ZNC5CIpV02R61l96UigCUdKQbm
         kYfw==
X-Gm-Message-State: APjAAAVcGaMcAt79r4n/0/BWLfNIAyQB9RWkNmurlXnVp3mHoTi/2fQz
        5Y0+eAxNtWOwD7Ccx9U1dWeDOZmngi1Om6fP0JPQDA==
X-Google-Smtp-Source: APXvYqwk3gGDLKOY5+TapjWkIPZbrjyID3V+8fj4TgU6xXiz08LdytMmg+WEESMfXROgp17tvnMMjHdeReWEj3LGYBg=
X-Received: by 2002:a92:cc04:: with SMTP id s4mr40784855ilp.193.1582593837805;
 Mon, 24 Feb 2020 17:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <20200219223046.GA16537@bogus> <CAODwPW8JspiUtyU4CC95w9rbNRyUF-Aeb9TuPm1PzmP6u=y1EA@mail.gmail.com>
 <20200219232005.GA9737@roeck-us.net> <CAKz_xw2hvHL=a4s37dmuCTWDbxefQFR3rfcaNiWYJY4T+jqabA@mail.gmail.com>
 <e42320b8-266f-0b0e-b20b-b72228510e81@amlogic.com> <CAODwPW94KX46PzSrf_uuEFPKudXor=26d=g3Qta5veRfxmMDUA@mail.gmail.com>
 <1326f594-3cfd-c03d-4f2c-50eeb75724b2@amlogic.com>
In-Reply-To: <1326f594-3cfd-c03d-4f2c-50eeb75724b2@amlogic.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 24 Feb 2020 17:23:46 -0800
Message-ID: <CAODwPW8WwntWb_=dg2J3AMy-gHw2QvNj_g98SufN13+AuGnUSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog
 arm,smc-wdt compatible
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yonghui Yu <yonghui.yu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The SMC function ID may be solved by the DTS, but the wdt indexs(Eg:
> SMCWD_INFO) are also different
> for each vendor. The imx_sc_wdt.c is also use the SMC to operate the
> WDT, but the wdt indexs(Eg: IMX_SIP_TIMER_START_WDOG)
> are different from ours. IMO, If the ATF can implement a common hal
> interface and index for watchdog, then writing a
> common smc wdt driver will be easier to compatible with all vendors.

The MediaTek driver is still in flux (e.g. still being reviewed in
Trusted Firmware here:
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405),
we can still change it. So if we can now decide on making this a
"standard" driver, we can change the MediaTek interface to match IMX
and standardize on that. (There are existing Chromebooks shipped with
a different interface, but we could handle those separately with
downstream patches. I think having a unified interface that will
prevent this problem in the future would be worth some extra
complication right now.)
