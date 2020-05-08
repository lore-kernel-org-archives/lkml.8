Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA037C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90BC2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941213;
	bh=ejhiM8NHJMuTZXdqdOyX+hekGsnaDmTfDNSbpquUrn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=aWrhBqpb9WriNvKPKK+Jl+qIPk1FHKgvLYDHhJnvQJQFRs29n7siCOaE1+wB3CByQ
	 Zg+Liv/BdHKVNHu1+q6M8E8SrtebyPKBZz/PcB+67uH4hqtGtPcF7QhEejc2MTE3Hg
	 FN5oiCxzday1EDMzrrf67ZdsMUJJjGVot4WqXo4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgEHMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:33:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82FCC05BD43;
        Fri,  8 May 2020 05:33:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x73so1283125lfa.2;
        Fri, 08 May 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CoSvhOk2TKxABz0OmqmQcHc5OuF6+RsHZpa58OAH/34=;
        b=dD2k5/Ek6KnRUsU+D+ixqMe1EQuf5h0tF+3dioSM7wkRSEjx+4vp/B1zd5bHXluPQd
         bsYjRQQt8xrsPSVRb+8cH+jbwv2KBo6yFu4enTdoU0gazvbJV7eFrqAIFKIgef7elGrq
         7Rc2tBiTQegQpq3p25FaHzFU/+rvrfus8tKmmnuDi9HW8pc7s3tclNN/ycGTF5CmOUh3
         6imGTdiQsq9epMc/lDOLrdcSBeJjsuQSL2smwb/AyVR6J5n7fIytsWTqR+gU1e9KGGV3
         EBkOaw1pB5i4hcKoN0ow0YFqbsWGULcJp2S61TPEdv6/HnKpBO6SG29KXeGGc/VfB9er
         pwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=CoSvhOk2TKxABz0OmqmQcHc5OuF6+RsHZpa58OAH/34=;
        b=GX6gcFfyyjeyTzWyPzquZngGwahEvbfTV9mmHaWJCnq6xcy6Jq/K3/GYnZD59Kld3o
         NHhH2hoU14+GaDU3BaHFzdy5iOGB4UTovdxXM3zBYdRoak6SZldBoncMjJl/8K7n8K8b
         XKJADILlU1SAHUOhSFZ7rSnjylYQI4olU8RwDtL3OwH0UPadCRbJ4ogj1DzGqY/IQ9Ia
         dw38Jm1hLGyY9phX2YVlr6Adfh4jc1WSqSpWGIjI6gi/gjOf9+T++Xt7vbK+6H7rfnS1
         gXrtuSDAmKfu4buNygW9/7BkwrE76chUGR73C9CmybQiDJYGHfZj7XqpVDO1aNfiZr3Q
         Lqlg==
X-Gm-Message-State: AOAM532k4hbCYw0tkIzltV/vIZq3Oo4xUZ8xrj9pHyzhvI+2FCqoI4Ab
        RIt5/OjfFn+9wG6EEc2OuX2h3+x3
X-Google-Smtp-Source: ABdhPJzvr4X/AYv0DFeKOuTzzREeoVyCg2dgEh0XOr/ZLDML8Syvgltrw72JoJfWZFFQnW4pDJcuEg==
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr1755034lfo.104.1588941209929;
        Fri, 08 May 2020 05:33:29 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id u9sm1098992lfl.74.2020.05.08.05.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 05:33:29 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jun Li <lijun.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
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
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
Date:   Fri, 08 May 2020 15:33:24 +0300
Message-ID: <87h7wqmwrv.fsf@kernel.org>
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

Jun Li <lijun.kernel@gmail.com> writes:
> John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote:
>> > John Stultz <john.stultz@linaro.org> writes:
>> > > From: Yu Chen <chenyu56@huawei.com>
>> > >
>> > > It needs more time for the device controller to clear the CmdAct of
>> > > DEPCMD on Hisilicon Kirin Soc.
>> >
>> > Why does it need more time? Why is it so that no other platform needs
>> > more time, only this one? And which command, specifically, causes
>> > problem?
>
> Sorry for my back to this so late.
>
> This change is required on my dwc3 based HW too, I gave a check
> and the reason is suspend_clk is used in case the PIPE phy is at P3,
> this slow clock makes my EP command below timeout.

The phy needs to woken up before the command is triggered. Currently we
only wake up the HS PHY. Does it help you if we wake up the SS phy as
well?

Something like below ought to do it:

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0555252dee0..ee46c2dacaeb 100644
=2D-- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -274,7 +274,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsign=
ed cmd,
 	const struct usb_endpoint_descriptor *desc =3D dep->endpoint.desc;
 	struct dwc3		*dwc =3D dep->dwc;
 	u32			timeout =3D 1000;
=2D	u32			saved_config =3D 0;
+	u32			saved_hs_config =3D 0;
+	u32			saved_ss_config =3D 0;
 	u32			reg;
=20
 	int			cmd_status =3D 0;
@@ -293,19 +294,28 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsi=
gned cmd,
 	if (dwc->gadget.speed <=3D USB_SPEED_HIGH) {
 		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
=2D			saved_config |=3D DWC3_GUSB2PHYCFG_SUSPHY;
+			saved_hs_config |=3D DWC3_GUSB2PHYCFG_SUSPHY;
 			reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
 		}
=20
 		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
=2D			saved_config |=3D DWC3_GUSB2PHYCFG_ENBLSLPM;
+			saved_hs_config |=3D DWC3_GUSB2PHYCFG_ENBLSLPM;
 			reg &=3D ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 		}
=20
=2D		if (saved_config)
+		if (saved_hs_config)
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
=20
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	if (unlikely(reg & DWC3_GUSB3PIPECTL_SUSPHY)) {
+		saved_ss_config |=3D DWC3_GUSB3PIPECTL_SUSPHY;
+		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+	}
+
+	if (saved_ss_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
 	if (DWC3_DEPCMD_CMD(cmd) =3D=3D DWC3_DEPCMD_STARTTRANSFER) {
 		int		needs_wakeup;
=20
@@ -397,12 +407,18 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsi=
gned cmd,
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
=20
=2D	if (saved_config) {
+	if (saved_hs_config) {
 		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
=2D		reg |=3D saved_config;
+		reg |=3D saved_hs_config;
 		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
=20
+	if (saved_ss_config) {
+		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		reg |=3D saved_ss_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	}
+
 	return ret;
 }
=20
=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl61UZQACgkQzL64meEa
mQYYqA//Z42qLNqOG3w2DrxTaXdF//8YPssyoW2RRP5UxCzi5dMdj3f17kk5HFet
RAC4SiFXowUV+MpoDUfKzeu72KPWPSfXYEA1AnSuZ8X4U5yfETQgJsO7dbAO+Y5B
AmgwfNde96HbOgNWywrVoX5t5ipKZwiHubsqVFeVG8r/PMwd0dT5DxPlGzoRa0JF
fXDbbBlujt4hvCZR3LZf2Vn3i5P2BcbtYgZlCTmqUc1xV9f2lJw3JHlkM2t0dASF
h0cLMps3GfwuhpaBZ0se/s4HI6giSYYqPx7nFy42/YdX7fOB/+OduzB2xeJ3vG+f
ZGMv2K7i6tfVYn+3NA9OmulV1ZQiIUN4M3KdQggf0Mga+1CxsxeWLVYzTxrVY3bI
koGBm2I5FYk3h079D1LyduZqfFfk6h0CexDKvncDiqnVm8RkZUxPQI5Iaq4l5cE1
YRyvREYkdD9tz5tcjo0Y1C+Fex6R7Mw4cHSHIc44wmwLcJ0lP/T0kKFbA1axw/+P
72Jw0/w7tjNyGteE8FL03/0gj9s7iVbP9sD6G4rDTD7QEURXbp2HkvETmqPvXchv
EeCtW38EhL2MuTzRRtHoetRn7ldi7iqqsthLanqGHJoTY/Q/Qe5mu9ED4bI8TLZR
OO7k9SjUAE7ur6mBp4mVqMYoLWf9kpzLwAUsJd0jfFSMax7nJoI=
=yq+4
-----END PGP SIGNATURE-----
--=-=-=--
