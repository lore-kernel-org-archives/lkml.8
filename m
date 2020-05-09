Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4905C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C3824953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKP8Lubb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEII23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgEII22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:28:28 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F839C061A0C;
        Sat,  9 May 2020 01:28:28 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id r2so1566536uam.7;
        Sat, 09 May 2020 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eINgDGJMaJIZgwxo+adBIzcEyirrmAf1qVa6/NMgfNs=;
        b=vKP8Lubbl0z88XrQwfs6SZq5llN00B3ztUYbaEbETAAj2GYGKkPDZu/CiBT1OFFpoK
         t+IYjQmZVREsAeNInCvkZM9V+bOrslUhFXsj6HpuJXDhCt11ivFoAvxFsdYTzAjo4sx3
         /lOZWa+1E4QivWA1KS09YzPYVnmg8oZxWhBu5WSo47+yoP5NBc0PdedqQIFlPdNRgwb4
         Ll0PSG8w2ULtX7TbomrtOOrR5D+72PUQY458IR8FbMyZCiM85xp3Oxqj4zWeTKKZpbEC
         aAOBElP7YkDxfGv9KYlkO7oZKqGETaby/DItJdpm/SHWfjbjLR9SlPZkSoXZVFbAno6h
         LrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eINgDGJMaJIZgwxo+adBIzcEyirrmAf1qVa6/NMgfNs=;
        b=nSvrmYlz4BuI+hLn6BrPnJ42/dU0nHmgKpHhXGh+Rll7GIlm6QKhiRy8D7a4WqLOdq
         D2u18R4YPqfUZIRhhm0kvKHt7LmxOwOfOH5ycF/5N5MPG91xJRDMee1UsJDrH6j1R839
         Z3GsUeRklk2IsUBiV2tmbwaiA7UrE5+olBKIsceZXp77ledMYreCftwU+ntYlK8ichPH
         FMT0Cx10kY1DihW8w3vi8lit7mUDMEQc13cttn9M5GM0Vpmo5PJITPWc/N6r9saJNdPf
         rIRYSDE88onBJ7c197rr7fhlsGJr6DGhf0QpEVoTWhkXqdyxE2onjb8XXj7CVZkKNnsc
         OnWA==
X-Gm-Message-State: AGi0PuYfS3G5QOwGSS9tETy2ZASjKedtlRGcrtw9zCHtzg4QFRPLjnml
        lF4Jx5o0jmEVr1F3g5BQpGQyRU/JiscCuA4fdNs=
X-Google-Smtp-Source: APiQypJUsNaJk8HtjBPKfp+oM0xWkicWbch5h0T78OsafAj5jw0ru7bBBx3YVBBUoe2KsnkTLSgQaB+Frq2cCKxlFQk=
X-Received: by 2002:a9f:2508:: with SMTP id 8mr5406078uaz.115.1589012907353;
 Sat, 09 May 2020 01:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <CALAqxLVXauXP0r4Hv2Axa4PNf_F9wp644peYV06bdsPtMKGmLA@mail.gmail.com>
 <CAKgpwJU7VDx90STE7bhx9VZ5p1jtqCyyLavmhXfpaicyDAYt_g@mail.gmail.com>
 <CAKgpwJVU9m6G8PRdray2fGCp_peOU9C-ZAVKTk7pmSdq6z4NiA@mail.gmail.com> <87eerumwok.fsf@kernel.org>
In-Reply-To: <87eerumwok.fsf@kernel.org>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Sat, 9 May 2020 16:28:16 +0800
Message-ID: <CAKgpwJU=w8Qn2PpNMyh7D1Ci6jJCmMianG1xjsi-p7-0uVKfTA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
To:     Felipe Balbi <balbi@kernel.org>
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Balbi <balbi@kernel.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:35=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Hi,
>
> Jun Li <lijun.kernel@gmail.com> writes:
> > Jun Li <lijun.kernel@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:08=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=
=9A
> >> >
> >> > On Wed, May 6, 2020 at 2:00 AM Jun Li <lijun.kernel@gmail.com> wrote=
:
> >> > > John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=
=93=EF=BC=9A
> >> > > > On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> =
wrote:
> >> > > > > John Stultz <john.stultz@linaro.org> writes:
> >> > > > > > From: Yu Chen <chenyu56@huawei.com>
> >> > > > > >
> >> > > > > > It needs more time for the device controller to clear the Cm=
dAct of
> >> > > > > > DEPCMD on Hisilicon Kirin Soc.
> >> > > > >
> >> > > > > Why does it need more time? Why is it so that no other platfor=
m needs
> >> > > > > more time, only this one? And which command, specifically, cau=
ses
> >> > > > > problem?
> >> > >
> >> > > Sorry for my back to this so late.
> >> > >
> >> > > This change is required on my dwc3 based HW too, I gave a check
> >> > > and the reason is suspend_clk is used in case the PIPE phy is at P=
3,
> >> > > this slow clock makes my EP command below timeout.
> >> > >
> >> > > dwc3_gadget_ep_cmd: ep0out: cmd 'Set Endpoint Configuration' [401]
> >> > > params 00001000 00000500 00000000 --> status: Timed Out
> >> > >
> >> > > Success case takes about 400us to complete, see below trace(44.286=
278
> >> > > - 44.285897 =3D 0.000381):
> >> > >
> >> > > configfs_acm.sh-822   [000] d..1    44.285896: dwc3_writel: addr
> >> > > 000000006d59aae1 value 00000401
> >> > > configfs_acm.sh-822   [000] d..1    44.285897: dwc3_readl: addr
> >> > > 000000006d59aae1 value 00000401
> >> > > ... ...
> >> > > configfs_acm.sh-822   [000] d..1    44.286278: dwc3_readl: addr
> >> > > 000000006d59aae1 value 00000001
> >> > > configfs_acm.sh-822   [000] d..1    44.286279: dwc3_gadget_ep_cmd:
> >> > > ep0out: cmd 'Set Endpoint Configuration' [401] params 00001000
> >> > > 00000500 00000000 --> status: Successful
> >> > >
> >> > > Hi John,
> >> > >
> >> > > Do you still have this problem? if yes, What's the value of
> >> > > USBLNKST[21:18] when the timeout happens?
> >> >
> >> > Sorry. As I mentioned, I was working to upstream a patchset that I
> >> > hadn't created, so the context I had was limited. As I couldn't
> >> > reproduce an issue without the change on the device I had, I figured
> >> > it would be best to drop it.
> >>
> >> That was fine.
> >> >
> >> > However, as you have some analysis and rational for why such a chang=
e
> >> > would be needed, I don't have an objection to it. Do you want to
> >> > resubmit the patch with your explanation and detailed log above in t=
he
> >> > commit message?
> >>
> >> Sure, I will resubmit the patch with my explanation added in commit me=
ssage.
> >
> > Hi John
> >
> > A second think of this, I feel use readl_poll_timeout_atomic() to wait =
by time
> > is more proper here, so I create a new patch to address this also other
> > registers polling, see below patch with you CCed:
> >
> > https://patchwork.kernel.org/patch/11536081/
>
> Fixing a bug has nothing to do with using
> readl_poll_timeout_atomic(). Please don't mix things as it just makes
> review time consuming.
>
> Let's find out what the bug is all about, only then should we consider
> moving over to readl_poll_timeout_atomic().

Agreed, sorry about that, I will hold on my readl_poll_timeout_atomic() cha=
nges
until we have a conclusion on this issue fix.

thanks
Li Jun
>
> --
> balbi
