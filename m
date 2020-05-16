Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E4DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BEC20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589630258;
	bh=K7EtYXdMTNzKSL9u6ZM46DAAdiHLhw9RiBgsQRiVhWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=vH/OrUVyQvzEWqYJwtApm7me8rBOqUhW1d1WdZhN55C9NwapAM6s3TbRAfQ2CnSTy
	 gT1BIVHlZWqm9LhTPL8KDN1qUVB+NS/tUIHz7pn1X1/1eNn5pw3qtODEOkiF6tt0bd
	 3lD5fo9pqsXue3kLoiIcPWs7l//dIk3nd+dOmows=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEPL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbgEPL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:57:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B63C061A0C;
        Sat, 16 May 2020 04:57:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d21so4960090ljg.9;
        Sat, 16 May 2020 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=K7EtYXdMTNzKSL9u6ZM46DAAdiHLhw9RiBgsQRiVhWw=;
        b=nxh7l2ZnP3udZZsY6Klbl4JQkfQaj+Bo/Lo9618AKC99lkzYAXxKgfPLcxeZRMJjo9
         4Ahg7qm45oZuMRpep2JSDTVELGj4kemJTd33VPvt6mYuIjuOogxtjrcVR4F98xY7GhyI
         XxwObcERQ13KcOJ4TFPHzq3Z8E6og0ItZnFTwNCtVP3le/g0hKqzlCxCNpSo9vfS9iJn
         YT995fefFMYq+hhe9p/asDTEvSxucrkFTiD8IxT4ZRnis+S8u+T7WBTPM/pcZWhFd/BW
         s8PADkMnkTPV4FMMYzuy8iFVagl6yBoo8ugzKqSa/S5yVAcjkxxtUvaGBUab1uamQBe9
         GwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=K7EtYXdMTNzKSL9u6ZM46DAAdiHLhw9RiBgsQRiVhWw=;
        b=BS6cJ0ef7TJ1HkwhtTB/HWaRv54DKiw869323XT5rTOcp/v6+4fp8tg6YYBlq3uugm
         oh28UNqpVUc4Oe2EX41hICyxawg6INOPje7u+bs+BzRNJ0HiCfduqh54ReBQHa0+k1F5
         whd6EZJqj+wV5Epy3AvZv/dpRDwsHYeW/RkzxHG2Pp2gV3WgHayEH/yMsyBLqPUEdvTO
         BU2Lbheff7Enld5cqxNLwGFtEXRlQ8F/gpaCY8ajFB6iMBPpqlLGoCG1yb6B7818eZdB
         A5tQYPQUPKsmIXo5TWfVCYgq676y7+ZZOKZUxO+7Uw3+q1l/BOAr19Hl6ntJRSusXP+v
         3I8g==
X-Gm-Message-State: AOAM532yp03j+7XZBB4V0bNYrjCPTwK8XMe7iKYl2957+Fa7LXgKmLRt
        y5pHquFUhCBX1nIlm6nPvwBMPWofMek=
X-Google-Smtp-Source: ABdhPJz2P0qexY309WH6bQebCkuZJifgIsfaZd99/tUMgXb7ToO/nnip5VIXMpFwO/L5TGG1QMSlag==
X-Received: by 2002:a2e:8689:: with SMTP id l9mr5198526lji.193.1589630255011;
        Sat, 16 May 2020 04:57:35 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id x204sm3078968lff.21.2020.05.16.04.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 May 2020 04:57:34 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jun Li <jun.li@nxp.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: RE: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <87h7wqmwrv.fsf@kernel.org> <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com> <87imgx35pg.fsf@kernel.org> <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com> <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com> <87ftc0xsig.fsf@kernel.org> <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
Date:   Sat, 16 May 2020 14:57:29 +0300
Message-ID: <87d074xfbq.fsf@kernel.org>
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

Jun Li <jun.li@nxp.com> writes:
>> >> Hi Thinh, could you comment this?
>> >
>> > You only need to wake up the usb2 phy when issuing the command while
>> > running in highspeed or below. If you're running in SS or higher,
>> > internally the controller does it for you for usb3 phy. In Jun's case,
>> > it seems like it takes longer for his phy to wake up.
>> >
>> > IMO, in this case, I think it's fine to increase the command timeout.
>>=20
>> Is there an upper limit to this? Is 32k clock the slowest that can be fe=
d to the
>> PHY as a suspend clock?
>
> Yes, 32K clock is the slowest, Per DWC3 document on Power Down Scale
> (bits 31:19 of GCTL):
>
> "Power Down Scale (PwrDnScale)
> The USB3 suspend_clk input replaces pipe3_rx_pclk as a clock source
> to a small part of the USB3 controller that operates when the SS PHY
> is in its lowest power (P3) state, and therefore does not provide a clock.
> The Power Down Scale field specifies how many suspend_clk periods
> fit into a 16 kHz clock period. When performing the division, round up
> the remainder.
> For example, when using an 8-bit/16-bit/32-bit PHY and 25-MHz Suspend clo=
ck,
> Power Down Scale =3D 25000 kHz/16 kHz =3D 13'd1563 (rounder up)
> Note:
> - Minimum Suspend clock frequency is 32 kHz
> - Maximum Suspend clock frequency is 125 MHz"

Cool, now do we have an upper bound for how many clock cycles it takes
to wake up the PHY? Then we can just set the time to that upper bound.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6/1SkACgkQzL64meEa
mQZL+w/6AxOqdqZMxD6dJoy944O3y9M5glYLwe/tfeeCGMbA/mULQDUi9CSFu7iu
JTj+bJm3AMgWwzyJByWjEeOhw9M60ntIG2fztMEU/RuIsPCfSbXCxHHgccQx5JgW
atB9hxrMgI3BT41qqL98Ze+fJ540iii/0LA5/Dt1lw6NNjGKKxMC8dxipokcBUOc
oWqj4FS6J1JWrjjwLBna04l2UtrxM4NlFhSLxr5QCUx2ISVCDGB2nkW+lqjsPqoT
Ge4rKpUGqnJVbFHTR359GUnjbcPPzwp55LaQHfxxgvhQ+GlRpLBb6mFfeqj6a0JZ
EXvBxWDj9seVyvpL2xeLtOdhCzy5NCU5djHVEm4yckQ0I2yXccT9/SSQUJyD9I9o
2WomGpZZ1OxwKqL2XAcZyhvpstMXq+TvmJ8kjvaHIcEHROA1aFiIrxlyQQORssHH
8x4wZzwD7BuOCcZJy/W5cYyMi8dakbF4OhAKOOyg0AbU3weApPE2n2f5ZoYZVAFe
WJSlNC45benjGZdHrAMFvcNMuptBdIMF67oLXxoqa0gajL3zGvLateErsFqsJn1Z
jsZWNrVB5he+chQqraP37y5ZB2Nn95Et0/MPf1kgDO+JkVqkbyAX/HmuVILZ3Tgl
IBsFYDBphzkiWi0xTXGewtUUhSwerJL1PDPROdt4/wJkJqIXPEg=
=fLB9
-----END PGP SIGNATURE-----
--=-=-=--
