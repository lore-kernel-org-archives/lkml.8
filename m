Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACEC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D662087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQH6RfxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEGDIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:08:16 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17BC061A0F;
        Wed,  6 May 2020 20:08:16 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id b6so1346113uak.6;
        Wed, 06 May 2020 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5KrgkS9IpHYVnkrIf1m2LB5pieWU4ZRsegpvq8ZuNM=;
        b=nQH6RfxU7ceNQuXYXgG9OZlSHcATWEnjnhVkzSi1Bop+6sQlFdf2KboXe+5MRiTOPZ
         wXed/hWDipbbakcaTpb+kOKIbF7MLdB84XNqIhkkaPvWP3L2PD8d6D+Y6W+3gClHxG+H
         K8qib7WZguDpYxSbhB1djNjEJZks9oM9+/cMA+5mNycHbJfDzz+2S9eJ3vHO6jeQwId0
         0+m05MEFgioXDWBnkBJ4z8D1JeUYmsRs3wYGcbtrU9O1SkQVJQkFFR6PVHEai0Tx5iK7
         05Htbwrt6jmfcrguLgsyCehN71Ydh/PPSJsZoDLUibLmLwScZdvQU1ISgYZZKzOzc+4h
         AfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5KrgkS9IpHYVnkrIf1m2LB5pieWU4ZRsegpvq8ZuNM=;
        b=re5YeSuedIfPEN5jqxu2c6gGTtNBVJrqTEeXsp3pCNxKanjqE6l99v+ioBEJ9kjs0M
         hLZ1oLfmNbs0tz8KJtO55PNuWD5e6hZoCBn7pkECFydliFJJgYvGBw5DtYDdC0HwxIU3
         ndMY3BMfIyC8MSNlTUruowsZ2saGhRLDZzTnC5EJfrT138ZnANYoXaSqSjxZ/cZRrenS
         n/EcZw9YJpG2elSTJ6kVNb/hvYC+RUopsDr+yPE/z30faMBuuyEnPzAMVJ5mdMMzo+O4
         ET3gNiTGuoJGiPekpZZllJDuSFq30QYi2hEMF7Jr7KQjInlkupKHqO0Xx/T3WC0ZohAT
         ezug==
X-Gm-Message-State: AGi0PuYg2sQClTF1dkkeINThCeZWotKQ0UlVTcn+T3T3f2AMtFK8I4Uz
        pdJxx99gKeHwwGydY1mNQG8H6VrNpbqyEZanB/nxBknI
X-Google-Smtp-Source: APiQypLy2gZGyrB2039SyMEF5+hQSLSHuFESjGbmWh7/XJ2Fxp/FeHdyAqmT6q9hnYF5XM72W3uT7UPzgl0MM0NuEqg=
X-Received: by 2002:ab0:375a:: with SMTP id i26mr9842013uat.120.1588820895622;
 Wed, 06 May 2020 20:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <CALAqxLVXauXP0r4Hv2Axa4PNf_F9wp644peYV06bdsPtMKGmLA@mail.gmail.com>
In-Reply-To: <CALAqxLVXauXP0r4Hv2Axa4PNf_F9wp644peYV06bdsPtMKGmLA@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Thu, 7 May 2020 11:08:04 +0800
Message-ID: <CAKgpwJU7VDx90STE7bhx9VZ5p1jtqCyyLavmhXfpaicyDAYt_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
To:     John Stultz <john.stultz@linaro.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
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

John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 6, 2020 at 2:00 AM Jun Li <lijun.kernel@gmail.com> wrote:
> > John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=883=
0=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=
=9A
> > > On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote=
:
> > > > John Stultz <john.stultz@linaro.org> writes:
> > > > > From: Yu Chen <chenyu56@huawei.com>
> > > > >
> > > > > It needs more time for the device controller to clear the CmdAct =
of
> > > > > DEPCMD on Hisilicon Kirin Soc.
> > > >
> > > > Why does it need more time? Why is it so that no other platform nee=
ds
> > > > more time, only this one? And which command, specifically, causes
> > > > problem?
> >
> > Sorry for my back to this so late.
> >
> > This change is required on my dwc3 based HW too, I gave a check
> > and the reason is suspend_clk is used in case the PIPE phy is at P3,
> > this slow clock makes my EP command below timeout.
> >
> > dwc3_gadget_ep_cmd: ep0out: cmd 'Set Endpoint Configuration' [401]
> > params 00001000 00000500 00000000 --> status: Timed Out
> >
> > Success case takes about 400us to complete, see below trace(44.286278
> > - 44.285897 =3D 0.000381):
> >
> > configfs_acm.sh-822   [000] d..1    44.285896: dwc3_writel: addr
> > 000000006d59aae1 value 00000401
> > configfs_acm.sh-822   [000] d..1    44.285897: dwc3_readl: addr
> > 000000006d59aae1 value 00000401
> > ... ...
> > configfs_acm.sh-822   [000] d..1    44.286278: dwc3_readl: addr
> > 000000006d59aae1 value 00000001
> > configfs_acm.sh-822   [000] d..1    44.286279: dwc3_gadget_ep_cmd:
> > ep0out: cmd 'Set Endpoint Configuration' [401] params 00001000
> > 00000500 00000000 --> status: Successful
> >
> > Hi John,
> >
> > Do you still have this problem? if yes, What's the value of
> > USBLNKST[21:18] when the timeout happens?
>
> Sorry. As I mentioned, I was working to upstream a patchset that I
> hadn't created, so the context I had was limited. As I couldn't
> reproduce an issue without the change on the device I had, I figured
> it would be best to drop it.

That was fine.
>
> However, as you have some analysis and rational for why such a change
> would be needed, I don't have an objection to it. Do you want to
> resubmit the patch with your explanation and detailed log above in the
> commit message?

Sure, I will resubmit the patch with my explanation added in commit message=
.

thanks
Li Jun
>
> thanks
> -john
