Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF51C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893A320657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589613173;
	bh=k/yXtBhXrOAYKQBxHdq+bTr8v9BdLB83tJbvLnmKTto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=W5nO2J8x+WW32F/M3N5iejiQLKnPesD5Lh2o4pPn7Zdijs4xeJ5BOXRDn5nZqrxm4
	 19FNoZ0YKeyjn+m6eREtLU5hgXvU7LVr813quq0Actc9FfehsopcngcEHWln1JyDQx
	 p+M1rSepbYYSkUizHVRnnFLaqT3r7BPhOR5rTy38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgEPHMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:12:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955FC061A0C;
        Sat, 16 May 2020 00:12:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so4568602ljd.3;
        Sat, 16 May 2020 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IOxzq4pXb20ghuJII/vuhNWPBMV9khxCASyeFAGn/u8=;
        b=ZjUKkDvI80I0GIbHj2uKyxq5qUCCvPIndQYqaqg+1uBFHezkwjzyO0xpmylHbdi5tz
         ph1w5ve1cMH4TfwLmn/RuzL1xbA1P9JoO6V/xDZRfSzmeSQ2rsirqgiSXzPf5hKTQC73
         CAZNsjoEdFTQITICHcoXVNDmUUXmv+ECFjBtyhxLlWp8iZinBX0sppgesGwwEcDxGx5Y
         M/w/23LL8LKq72QGCyH1VdHOQI8e/o93sVm2fHzz1IjoymB5REG6U2RveXCF9x+SSfFf
         MWTg6l6M/oFstyFrJ6rotR5ihie/HE8BJN8g2VdkrmoM0ovuf1rAJjGq1271YtHdwWXA
         +0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=IOxzq4pXb20ghuJII/vuhNWPBMV9khxCASyeFAGn/u8=;
        b=Y8cPWNbseh8mfp1XV0I9bsTa5bS/ebm6HrAwZ9EhMNRBogusBpeVblemGaEUNGxbBE
         RGz7qAoF8Fd86xMRsr3eRfPDh9dqmLcvFhm5vZvqNCG97bKSi3oBKQaIY1wYvHAcUtDz
         T5XOJTipV5nOgzqIrjiuu4JyvMalLi7RTj1iALiZUpWpq+00uNmQwvcykdrF05r6Zerf
         Xq8Ab5iKq7gyHnHlojinziVHdmYekWGBWWtgW3qH5rqJNkfn/K7bc/QUXYa2qvbHeGt4
         8LGmMQWRZisG9IZUfMDIjzp9MH5ky0jVz/0Rklr1KdmxkIFu2te+jLKopcfK9snqpJCS
         szMg==
X-Gm-Message-State: AOAM533vZUzEBAimVQIJYKD/TsXSBCQG4vxDwRJFFxY+Z75CNeXnJNbs
        oU5IJzleYlJdWNtbYcnyIbs=
X-Google-Smtp-Source: ABdhPJwkmVEbqYby99dcYqDzK9o/iWq/ECtvJc7YEZOPPlmtb0mVNs4QXHPlPW6iMw6j8B3z0kmLKw==
X-Received: by 2002:a05:651c:1069:: with SMTP id y9mr894497ljm.172.1589613166147;
        Sat, 16 May 2020 00:12:46 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id n8sm2169141lfb.20.2020.05.16.00.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 May 2020 00:12:44 -0700 (PDT)
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
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <87h7wqmwrv.fsf@kernel.org> <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com> <87imgx35pg.fsf@kernel.org> <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com> <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
Date:   Sat, 16 May 2020 10:12:39 +0300
Message-ID: <87ftc0xsig.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
> Jun Li wrote:
>>> -----Original Message-----
>>> From: Felipe Balbi <balbif@gmail.com> On Behalf Of Felipe Balbi
>>> Sent: 2020=E5=B9=B45=E6=9C=8815=E6=97=A5 17:31
>>> To: Jun Li <lijun.kernel@gmail.com>
>>> Cc: John Stultz <john.stultz@linaro.org>; lkml <linux-kernel@vger.kerne=
l.org>; Yu
>>> Chen <chenyu56@huawei.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.=
org>; Rob
>>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; ShuF=
an Lee
>>> <shufan_lee@richtek.com>; Heikki Krogerus <heikki.krogerus@linux.intel.=
com>;
>>> Suzuki K Poulose <suzuki.poulose@arm.com>; Chunfeng Yun
>>> <chunfeng.yun@mediatek.com>; Hans de Goede <hdegoede@redhat.com>; Andy =
Shevchenko
>>> <andy.shevchenko@gmail.com>; Valentin Schneider <valentin.schneider@arm=
.com>;
>>> Jack Pham <jackp@codeaurora.org>; Linux USB List <linux-usb@vger.kernel=
.org>; open
>>> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.=
kernel.org>;
>>> Peter Chen <peter.chen@nxp.com>; Jun Li <jun.li@nxp.com>; Thinh Nguyen
>>> <Thinh.Nguyen@synopsys.com>
>>> Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct clea=
red by device
>>> controller
>>>
>>>
>>> Hi,
>>>
>>> Jun Li <lijun.kernel@gmail.com> writes:
>>>>> @@ -397,12 +407,18 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep=
, unsigned
>>> cmd,
>>>>>                          dwc3_gadget_ep_get_transfer_index(dep);
>>>>>          }
>>>>>
>>>>> -       if (saved_config) {
>>>>> +       if (saved_hs_config) {
>>>>>                  reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>>>>> -               reg |=3D saved_config;
>>>>> +               reg |=3D saved_hs_config;
>>>>>                  dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>>>>>          }
>>>>>
>>>>> +       if (saved_ss_config) {
>>>>> +               reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>>>>> +               reg |=3D saved_ss_config;
>>>>> +               dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
>>>>> +       }
>>>>> +
>>>>>          return ret;
>>>>>   }
>>>> Unfortunately this way can't work, once the SS PHY enters P3, disable
>>>> suspend_en can't force SS PHY exit P3, unless do this at the very
>>>> beginning to prevent SS PHY entering P3(e.g. add "snps,dis_u3_susphy_q=
uirk" for
>>> test).
>>>
>>> It sounds like you have a quirky PHY.
>>  From what I got from the IC design, the behavior of DWC3_GUSB3PIPECTL_S=
USPHY
>> bit should be as what I said, not a quirky.
>>
>> Hi Thinh, could you comment this?
>
> You only need to wake up the usb2 phy when issuing the command while=20
> running in highspeed or below. If you're running in SS or higher,=20
> internally the controller does it for you for usb3 phy. In Jun's case,=20
> it seems like it takes longer for his phy to wake up.
>
> IMO, in this case, I think it's fine to increase the command timeout.

Is there an upper limit to this? Is 32k clock the slowest that can be
fed to the PHY as a suspend clock?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6/kmgACgkQzL64meEa
mQZPzg//SndhNJAHs+B8hIUZs7TBOhhXxP3SFlby7sJDCnNl0FGiLKLKxkl7iCIU
yldT1BQtclJYagTq0quUqloI9U+4omEo5ILtEWEf+0HPem2CrouOzWoqhni7WnaH
BhkzJVs6EFvDrU7dsMwbpF3+zrvSJ8XGmFbfp6YiHwYLqdA6ifkNXvAGIyngb5HB
/vlUNUWhDY5ItLqbaEoWQ4Q9UwUjK1WqqVTHWwAUnUnXp2ekl3iNNQut8+EqTeW9
4088GvSzAnpSJGihNeY8v7UnxC8xXkc96rXkaTUGXKjyIz92O6tJBA9ACPk2mZ9B
kuQHJibcFJjUG9v9ij2pltigUdKA2kwTnb/G/U+sD3fiEV4tNYjwt8vX6OwdLhri
fZc/oTmzVPTq1zkjj/UzwPpvM6yPyvDIMePNx1DPflnVASeY2NbAYBEfegst0aJ7
OnD65M+FlfpIe4pQbC55f5k2bNN+GrsMOEz8vn6Ohdpfe17ESvtP/hjEwRyg1P9K
st1rmVtt4EtX3yeNzqfSgo430TvVONGd4x6vrtkMvXFUtzfqfv6uuTYDRU2Io8EE
mnjHyYPu4vuYVcrCy3yxvFdpqiX+RffYjoDr9/r3ovzwoLMG0eUSPFEW784gaqpJ
eVC22+EJG5VWyjx6wRmXopXfs8umoGtdX7FfvKw0p+0W1Z40co4=
=nzbb
-----END PGP SIGNATURE-----
--=-=-=--
