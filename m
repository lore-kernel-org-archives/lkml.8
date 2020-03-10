Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780BC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4645820637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjWV2H+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCJBA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:00:58 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42492 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCJBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:00:57 -0400
Received: by mail-ua1-f67.google.com with SMTP id p2so4054217uao.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5xnWgJ5omzmZiku6UfaNj8qU529m5YfhrjX1iEpn4A=;
        b=kjWV2H+ENIYP82wnkfLeoFh/cu0d6WCJIUEmu3ujdQeJGhIXy/5G1boCNlFG8g0qBr
         +2e4zj+IUgMgrGGmx8xi/SpqcykgxdFjE8+INLu57lfr0OaK5tzabI36l1MbeHx1erNT
         dYDE3RDADynW72cXRucYvQhJa+Zy4oyvr3wGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5xnWgJ5omzmZiku6UfaNj8qU529m5YfhrjX1iEpn4A=;
        b=oXHnzdUE5+41GwxT2Mr8bB3XNSo52I8A0x4R6AF9wM3Wor66GUWlcEOrvcOEjwP0XM
         jtldGokjEQPKzJ30gA7ZAX5gyUMpyUsXOAvktdQZ2U4RS95eP6Uvy9pOh+5Le5jSLmlX
         yNwSxymc6JIMlcq9B++n3ZkpdgF12j8Mh2SzTOkXbYdgYWvChPgvW6eUe0qOcl2p/E36
         /rLZ/W+9WddmJmLhP3Dr0sAL+QnQ9NdRVFzME+rhqoi89icM1fYSplV1c+s8C4L/NKgh
         PyihQpFlcvDc7b9ATkrqKWagp9O6lmaadiEwXFaqrLjesy6pGUeNCcmD/V6rNCdgL3TB
         E+MA==
X-Gm-Message-State: ANhLgQ1j6jx+ARSTrgYQQQttC946uxnqm05abSXvnoU7Wqc6hKauXdFQ
        gthKryQ91b2dasQ/S5a9Xg5ELslwJvM=
X-Google-Smtp-Source: ADFU+vtKQEAia7lCOED4awPSJrAkd9u/P4rl+hUDC1/BBhGP6fkrHf66vmdg2sX+kHtn/DftpJZ2ng==
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr10514342uar.72.1583802056024;
        Mon, 09 Mar 2020 18:00:56 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x12sm5831080vke.29.2020.03.09.18.00.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 18:00:54 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id 94so4067197uat.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 18:00:54 -0700 (PDT)
X-Received: by 2002:ab0:3392:: with SMTP id y18mr2111560uap.66.1583802054012;
 Mon, 09 Mar 2020 18:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <20200219223046.GA16537@bogus> <CAODwPW8JspiUtyU4CC95w9rbNRyUF-Aeb9TuPm1PzmP6u=y1EA@mail.gmail.com>
 <20200219232005.GA9737@roeck-us.net> <CAKz_xw2hvHL=a4s37dmuCTWDbxefQFR3rfcaNiWYJY4T+jqabA@mail.gmail.com>
 <e42320b8-266f-0b0e-b20b-b72228510e81@amlogic.com> <CAODwPW94KX46PzSrf_uuEFPKudXor=26d=g3Qta5veRfxmMDUA@mail.gmail.com>
 <1326f594-3cfd-c03d-4f2c-50eeb75724b2@amlogic.com> <CAODwPW8WwntWb_=dg2J3AMy-gHw2QvNj_g98SufN13+AuGnUSg@mail.gmail.com>
 <b4ba821a-eef6-4aea-1eba-897171b92c41@amlogic.com>
In-Reply-To: <b4ba821a-eef6-4aea-1eba-897171b92c41@amlogic.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Tue, 10 Mar 2020 12:00:27 +1100
X-Gmail-Original-Message-ID: <CAKz_xw2T1UceCwFZnBxg6WVp2D4+MziyvQPdU6tEnR_BdLh-PQ@mail.gmail.com>
Message-ID: <CAKz_xw2T1UceCwFZnBxg6WVp2D4+MziyvQPdU6tEnR_BdLh-PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog
 arm,smc-wdt compatible
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yonghui Yu <yonghui.yu@amlogic.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingyu,

I am trying to establish some clarity about what to do here.

The trusted firmware review has now been accepted
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.

I could try to add your mentioned extra operation indexes to the ATF
watchdog, to try to establish a standard ATF smc watchdog interface.
Hypothetically then your linux driver could connect to any of the ATF
watchdogs, apart from the meson indirection layer.
I do not quite understand the meson layer to be honest, would we run
the meson layer on non-amlogic SOCs?

It looks feasible to strip the meson part from your driver so that it
works on more socs, please correct me if I am wrong.

Alternatively we could also add these extra operation indexes to this
linux driver. Unfortunately I would not have a way to test that.

Thanks

Evan

On Tue, Feb 25, 2020 at 6:43 PM Xingyu Chen <xingyu.chen@amlogic.com> wrote:
>
> Hi, Julius
>
> On 2020/2/25 9:23, Julius Werner wrote:
> >> The SMC function ID may be solved by the DTS, but the wdt indexs(Eg:
> >> SMCWD_INFO) are also different
> >> for each vendor. The imx_sc_wdt.c is also use the SMC to operate the
> >> WDT, but the wdt indexs(Eg: IMX_SIP_TIMER_START_WDOG)
> >> are different from ours. IMO, If the ATF can implement a common hal
> >> interface and index for watchdog, then writing a
> >> common smc wdt driver will be easier to compatible with all vendors.
> > The MediaTek driver is still in flux (e.g. still being reviewed in
> > Trusted Firmware here:
> > https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405),
> > we can still change it. So if we can now decide on making this a
> > "standard" driver, we can change the MediaTek interface to match IMX
> > and standardize on that. (There are existing Chromebooks shipped with
> > a different interface, but we could handle those separately with
> > downstream patches. I think having a unified interface that will
> > prevent this problem in the future would be worth some extra
> > complication right now.)
> If the ATF provides a common watchdog hal interface and index, I am
> happy to match
> the generic sec wdt driver. Compared to the current MTK wdt index [0],
> the following
> indexes need to be supported for meson wdt [1].
> - *_INIT.
> - *_GETTIMEOUT.
> - *_RESETNOW.  It is used to reset the system right now, similar to your
> SOFT RESET.
>
> For another platform-specific parameter "SMC function ID", the generic
> sec wdt driver can get it from the dts, but if
> the driver want to compatible with more vendors in the future, maybe we
> should consider Guenter's suggestion at [2]
>
> [0]: https://patchwork.kernel.org/patch/11395579/
> [1]: https://patchwork.kernel.org/patch/11331271/
> [2]:
> https://lore.kernel.org/linux-watchdog/20200220155159.GB29658@roeck-us.net/T/#md00328548222965054cd19ec7dda074f8fc09fe2
>
> Best Regards
> > .
