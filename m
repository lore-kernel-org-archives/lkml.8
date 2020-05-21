Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B35820829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590042060;
	bh=lmK2PiZ17OdMrnL1rIUQEyERyyHltYL6X8n438Rq9WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=g4ESwhqclztM6b7pT8StNwlXh+660a+svLqhYtu6M4TYlPMeMeTCLKA0eX5tDycBb
	 e5a+FC0YxizE6bYBsiRzIMoXYMUcuvlBw1ZJWKhuRNEB9YPQ3QW/HxHIGYt4L/h8I7
	 Ac3z1UycJXPzuGyr/V+D8YXMcljlYq/wfqdFdVIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEUGU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUGU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:20:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D1C061A0E;
        Wed, 20 May 2020 23:20:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z6so6811136ljm.13;
        Wed, 20 May 2020 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lmK2PiZ17OdMrnL1rIUQEyERyyHltYL6X8n438Rq9WU=;
        b=F8H0wQiPawU6VT6EyZ+CmJrq0ZagIFaJLv47FUfBstXo6AIOfQDuQcA9P8WFdYajsK
         o5Bsl+IfMJiWVASvqvrvWPSCdvD+Op7UmSd/JZsvyZgB3eAcvgrxmJ5rOMHhRku6NfWM
         XbM8nVxBwFEVKtZk//yQ0PY34fdt3M4OenmeVz3L8V5D5TLAjzwxm7cqRqo4sMW78Ks3
         ebnboRBMYXDuHvLHNDNgJxN2P+9cj2ZkS2QHaUE3+it9iKmf+LffEQDQq2tIfmHnjXcG
         Xh058C7tMxib3hPMIVHizRZM32tyN4cNO33OzyVGJqKhcT/xEvTsOsK6y/+nOYMqQKee
         02NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=lmK2PiZ17OdMrnL1rIUQEyERyyHltYL6X8n438Rq9WU=;
        b=pCiwA7o0WXEn8Fxy95s0QWNzy1MjiYDNNvyigq5U+U2mPdIowcPP9bcUPhTgdEIYYh
         YDpvjHj0EN/kTJVyiq4SLKRwp0iXtvD4Kj9TRdpNYKkdQsEZRMBSxhVY2ZM4zFh5fmWp
         mAOmrHxkyqMeSVIbht0QPJWt1ZVNwvP89vjSlN80kAnER9XfthXetM4VqezVlAhyt7S4
         XWFrTrHapBbzXi80v3C0g80N5LDoSknmOfjnJdmyjG0RYYkFg30xPd64DU3iJzGaSpud
         opWThQUws5JuNAmXLBGDxhjumml5z9aybwZN2xMQEugstqTB05WANd+zeu8hVMAuNOgH
         5SWQ==
X-Gm-Message-State: AOAM531liE4sacNy/wL1jlfKDERleBkefXxxBrqivtWdh+mYJkU58G9X
        OqVckCfB7/+qO/29ak87WKo=
X-Google-Smtp-Source: ABdhPJynjVWZxieHDotU4xC1GI2NuI5cB79Qa6B9zPra9thuuRMxgD2ZBZ6t3SU8T/rJrlKBIRYpcA==
X-Received: by 2002:a2e:8ed7:: with SMTP id e23mr4257000ljl.32.1590042056891;
        Wed, 20 May 2020 23:20:56 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k9sm1515408lja.52.2020.05.20.23.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 23:20:55 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jun Li <jun.li@nxp.com>,
        Jun Li <lijun.kernel@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
 <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <87d074xfbq.fsf@kernel.org>
 <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
 <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
 <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
 <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
Date:   Thu, 21 May 2020 09:20:50 +0300
Message-ID: <87v9kpx0zh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>>>>>> "Power Down Scale (PwrDnScale)
>>>>>>>> The USB3 suspend_clk input replaces pipe3_rx_pclk as a clock source
>>>>>>>> to a small part of the USB3 controller that operates when the SS
>>>>>>>> PHY is in its lowest power (P3) state, and therefore does not prov=
ide a clock.
>>>>>>>> The Power Down Scale field specifies how many suspend_clk periods
>>>>>>>> fit into a 16 kHz clock period. When performing the division, round
>>>>>>>> up the remainder.
>>>>>>>> For example, when using an 8-bit/16-bit/32-bit PHY and 25-MHz
>>>>>>>> Suspend clock, Power Down Scale =3D 25000 kHz/16 kHz =3D 13'd1563
>>>>>>>> (rounder up)
>>>>>>>> Note:
>>>>>>>> - Minimum Suspend clock frequency is 32 kHz
>>>>>>>> - Maximum Suspend clock frequency is 125 MHz"
>>>>>>> Cool, now do we have an upper bound for how many clock cycles it
>>>>>>> takes to wake up the PHY?
>>>>>> My understanding is this ep command does not wake up the SS PHY, the
>>>>>> SS PHY still stays at P3 when execute this ep command. The time
>>>>>> required here is to wait controller complete something for this ep
>>>>>> command with 32K clock.
>>>>> Sorry I made a mistake. You're right. Just checked with one of the RTL
>>>>> engineers, and it doesn't need to wake up the phy. However, if it is
>>>>> eSS speed, it may take longer time as the command may be completing
>>>>> with the suspend clock.
>>>>>
>>>> What's the value for GCTL[7:6]?
>>> 2'b00
>>>
>>> Thanks
>>> Li Jun
>> (Sorry for the delay reply)
>>
>> If it's 0, then the ram clock should be the same as the bus_clk, which
>> is odd since you mentioned that the suspend_clk is used instead while in=
 P3.
>
> Just checked with the RTL engineer, even if GCTL[7:6] is set to 0,=20
> internally it can still run with suspend clock during P3.
>
>> Anyway, I was looking for a way maybe to improve the speed during
>> issuing a command. One way is to set GUSB3PIPECTL[17]=3D0, and it should
>> wakeup the phy anytime. I think Felipe suggested it. It's odd that it
>> doesn't work for you. I don't have other ideas beside increasing the
>> command timeout.
>>
>
> In any case, increasing the timeout should be fine with me. It maybe=20
> difficult to determine the max timeout base on the slowest clock rate=20
> and number of cycles. Different controller and controller versions=20
> behave differently and may have different number of clock cycles to=20
> complete a command.
>
> The RTL engineer recommended timeout to be at least 1ms (which maybe=20
> more than the polling rate of this patch). I'm fine with either the rate=
=20
> provided by this tested patch or higher.

A whole ms waiting for a command to complete? Wow, that's a lot of time
blocking the CPU. It looks like, perhaps, we should move to command
completion interrupts. The difficulty here is that we issue commands
from within the interrupt handler and, as such, can't
wait_for_completion().

Meanwhile, we will take the timeout increase I guess, otherwise NXP
won't have a working setup.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7GHcIACgkQzL64meEa
mQZLig//Rs81H23b5/i0Jgjr01CjLiebl7wzrGjYvhhSGOa4tet7/6LUwxXzw/MA
rcLOO9sDAfITi6syuCJLuRfb9YiXW6bqf3WH2h/pk1GEx6Gs8tIrw0qQ4pvM84Co
uSX+5NTg8vCwgYLOpPhhukJjXhKT9oYHDSR4R+DGp38JJNmc3ue+6ptKumvcaXCt
ZoWt3qdifNYuqtu/Pm+rm74DUbPzh9WKKmOIguNNnEeSIWwgCZGXQajYTdcV52l8
QVC89WHOE3SP9TjjmuYSlzrGTIUooqS24fZCz9Q+IGo8TItxW07EMfzkHOiH6TAU
IVySZHVI3PQmN2ByoZu2BDLKndvwFfvEqrpR/R/AwQ1MtxDm3iRczrmBaEffY/6c
z89AR6LG8V6cw2I0VR9xvLIbTurQhdSjnrphMBrMeq5Q6FfAPmFO+TM0u85AU4ed
K6R1/6/4F9k+a7ReXL3r7Sn0wlnqq5ep86O6djMgwf68AGrt+dn97C5Dd+GiYJFR
wUQ1BJQ1Ak/81BPR5yqkjnY9uPtaCmnzISad4il2hYVN2otm1YlHtkZ6HYhAXDmg
99rNmGLZpTz5eU9OzuR/AhSC5LIXepUHfhYc4fJnuJJLpWF4ak/snL5Ix8Im3Xkq
zW4X3krc6OKVSlufY0muomjiTm1FrBZwXQoOjXEOjhd1Cp5Fvb8=
=DFKC
-----END PGP SIGNATURE-----
--=-=-=--
