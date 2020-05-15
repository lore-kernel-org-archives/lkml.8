Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B2EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7B42065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589539292;
	bh=QjfAJaPZ5OOB+YJYFaytKz473Txp1a89ByaiNj93ueQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=L5z9I6zqqUBrc4yBVReAOEkaXNE0g3ZyFRjtQr8I9kqEU5mszChMy6ovZ/tdgkvIj
	 89+tiHwSYhydWSXvo51IRIKqWgXKasLSBDxZ8ckhRNUWMJycp3VCo78GZ6wrj7NaE4
	 e5idsNIHmo/DiWzaGuaV7bYVsYS7lgzleVOkO/JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEOKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:41:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37772C061A0C;
        Fri, 15 May 2020 03:41:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a4so1383536lfh.12;
        Fri, 15 May 2020 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IuV69pJbmeb25IQL0aSFJ0UEC0q8gcPDy0lgWN6OqZE=;
        b=soNtbApqsD+cgPilkRoeQA4ln881xLdHuq6YTIxSaUN+teZMhygQno0fhmf2Ycxih2
         he2CT4nyTLFpQF3HevAvm+IGS8ooZdqWbv4LmKplMWK4pmwKVRtDUD+7N4CTisZkmJox
         VBEDsQ3Otj+uQBzMqtXkpfodnZ6p7VqNiFnh2rnsfvFHF/rtQitpJIUKOATLu+Dm5K02
         BbzFPJXMwdyAS1KIbYCYUZl+wsHUCAbYiMhMb56FN0feEmPSYYE7Ll+KwXxvJQTwiLg5
         iONb4CIqT9LwmmcC8wNIji33FdHJ1OSu+LuBMih5ytIAhMx0B+3qBCma9ismvU5sU7fR
         casg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=IuV69pJbmeb25IQL0aSFJ0UEC0q8gcPDy0lgWN6OqZE=;
        b=PDeD/JhCygDSlJLu0DAsrPuINGry2kX6BOsuTaDkysWwRtAqMG6nLyXsiQh11ciwX4
         30IKT0r2tcEotkWipCjzJkiQz2B0FtbGSIm2q93GNUZePJzgiR+uJCYG3KapgEoYU+9+
         pgOw1AOXE0S0SRvZ3rfwsu9uBRQAxNdxouDhwVGZmFVEHddMrmJhYaSdjM1PZOdHuQ6b
         lFEWi8fN2hRbWjmqwHl/VNMSZfXNYIOa8KEyC+IWQKKDt31KoB9b+4tQ+9jPsvCzPLCv
         vJepGP8xIvtLl3xG7QAVEHlDZpQaSsmHIH8Xun1c/AcTJ+85hwT8KedXBRynap2t4FkD
         G+vg==
X-Gm-Message-State: AOAM5324W/+EVX1VEshGt9Mwbm/z7SNOL6yiusjp17dUw023L6SellHY
        Sd6GyFo3RT9cTTON0yhh8d8=
X-Google-Smtp-Source: ABdhPJyyuyuD9RduQc6EDqDlE3JsblyuUG+arIWzoNUFnUhg54klEKgbLEeXrMbzd7IAh9TZXrgSWw==
X-Received: by 2002:a19:b8d:: with SMTP id 135mr1935506lfl.145.1589539288473;
        Fri, 15 May 2020 03:41:28 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r19sm992094ljp.68.2020.05.15.03.41.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 03:41:27 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jun Li <jun.li@nxp.com>, Jun Li <lijun.kernel@gmail.com>
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
In-Reply-To: <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <87h7wqmwrv.fsf@kernel.org> <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com> <87imgx35pg.fsf@kernel.org> <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
Date:   Fri, 15 May 2020 13:41:23 +0300
Message-ID: <87d07532gc.fsf@kernel.org>
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
>> Jun Li <lijun.kernel@gmail.com> writes:
>> >> @@ -397,12 +407,18 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep=
, unsigned
>> cmd,
>> >>                         dwc3_gadget_ep_get_transfer_index(dep);
>> >>         }
>> >>
>> >> -       if (saved_config) {
>> >> +       if (saved_hs_config) {
>> >>                 reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> >> -               reg |=3D saved_config;
>> >> +               reg |=3D saved_hs_config;
>> >>                 dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> >>         }
>> >>
>> >> +       if (saved_ss_config) {
>> >> +               reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>> >> +               reg |=3D saved_ss_config;
>> >> +               dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
>> >> +       }
>> >> +
>> >>         return ret;
>> >>  }
>> >
>> > Unfortunately this way can't work, once the SS PHY enters P3, disable
>> > suspend_en can't force SS PHY exit P3, unless do this at the very
>> > beginning to prevent SS PHY entering P3(e.g. add "snps,dis_u3_susphy_q=
uirk" for
>> test).
>>=20
>> It sounds like you have a quirky PHY.=20
>
> From what I got from the IC design, the behavior of DWC3_GUSB3PIPECTL_SUS=
PHY
> bit should be as what I said, not a quirky.
>
> Hi Thinh, could you comment this?
>
>> If that's the case, then you probably need
>> to use the flag you mentioned above. Please verify with that.
>
> With quirk of "snps,dis_u3_susphy_quirk", I had verified it can
> resolve the problem, but this will make USB3 Super Speed PHY
> never enter P3, this is a huge impact on USB power consumption.
>
> The timeout increase has no impact on those platforms which have
> no this problem, but can give chance for platform with very low
> supspend clk(like my case 32k) to work.

I was under the impression that issuing a command would wake the PHY
up. I don't have access to DWC3 documentation to verify, but that's as I
remember. Is that not the case?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6+cdMACgkQzL64meEa
mQYMMQ//ReGJl+YwiKBw2I8knemHDYhudQuGQSG6s78dfTKTJkH84XJ197AGxIPm
s4vOk6VAuXpsWmota81ZU57GGC+NZqPLVQMXsrEE08HgFrHjjIriIv6AwoQ8rHfi
pVQHdma8yaZRFRLYtzpGUf0lEHbgIgcy50gnGpjcQKc/FvChJNCbBNVvp8IVJPIA
L/Zi5Vsl+lyLYSHYYYIDXU3EhPEbel8GmDYwNqn+N8jgxdDqF+vxwx+t1uXy584S
EdVTnJZihL6TcTwck7//mrGfvIZ04sLtrGgbaUcmw/QotlfmrkWcmUN1P4as2A51
A/+z0NcV6FQBIKj8lnDlYUjSL36qYw32mCvb1TTp6JnZ/khMclrYd/5o8C+beRna
OUS0dhOy2/ygBfuiUiw2x15pe0GQ24EN0ZiLmTWrjd49whqkqheM7PWKNLxtnnmP
2/10rAdQpD5STJSHiQi6YZSQaMsRPDlQasyVcrlAgOqNBfA3pRXz6rqRYD4NTLL0
1IGl4EtzZlEfQpIqpZlaLtirz6iPkqMrRXROaTiZC55tHoItwaJ+wqZ47n8QQWyG
NehsGGD3dk9LyGjiIpXnZ3HIalOTLXKwagEpfD39sgQsTBuzSfexUYER3diNe93k
X4exS7gdYwhTfbYPiFbY9HcyQqRDckgC5p0k/qEdpeqw+WsQ3MQ=
=ljzj
-----END PGP SIGNATURE-----
--=-=-=--
