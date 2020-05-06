Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9BC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68ECA206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAAlQvsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgEFJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgEFJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:00:33 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CACC061A0F;
        Wed,  6 May 2020 02:00:33 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v192so462026vkd.3;
        Wed, 06 May 2020 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ddpk1lu00oD2AyV95KOz/fIHVyPTBjyGkcMJSMpWXFw=;
        b=uAAlQvsnz3kU5bLV7QeRFAEh7KCNIWHYtNlnGKJS4z49EUJ6kSYlTfW+pxV/+QnXTH
         DXFBRxl/LosFAM2M1fCtsbZ2DJwyBd5KmxVYGMxH770Muse4jVox0+ou8kdWisdLJCcJ
         ngsvMVxYD2A7HoEbLj2mWApuVFXOh5NpwgWekMuk2RE7hU37RuRoow4UlATaxX8Ozw3F
         NZpnXC6HQ5UZgkhGuud5knBhDJDdDxf4yfjgAUvH1+hBeTCe8r2ZhNKfHAVxnYYzUElz
         j2ZHunyTKHP0ZHXhvVd7ZmgBhmqfDnIimZQn6rC4PSyu86pTNSHyM5qCCqXUSeQo+iC8
         pLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ddpk1lu00oD2AyV95KOz/fIHVyPTBjyGkcMJSMpWXFw=;
        b=SnUr+ms11wKQ4SPRvnQWjw323hUIMftVr9xYfUgYgFaJy1Ht0r9hnDcTqV15cOO8sU
         RL++N/J8WQZsV8eRwkeTfgCQH2/h4WVs09c3l26aZ69yvYYOU8wvqcm9P6+gqWIO7zZ+
         zz80NSc7z+9oVnsKcyMfWaPPsXRFmDlVAW8HlFAeYm4H8bbSw35Hh0TJNTTtqNMSY/MV
         pJ/8rrLL3Y9aPSlFQqypwj3wmZI68bDm6oZnFLfYxpdDIaJfJIkUtRb1Owl/BGf+b8u8
         F7UHGSfIz2tCDvMA+JmoH0+4ovxeVpD0UrW9F07D4vOeJjCNC+wmbkRjqp6pjxkQ+tZw
         AgtQ==
X-Gm-Message-State: AGi0PubQGDGjZHSDL7+1GEB4bWw2BSYW64A0OoNXxUXsf43XejD55m5d
        t7zLWAMR9fFIv/NgyJrI0CJQTbxj2u533F0zBVo=
X-Google-Smtp-Source: APiQypIYvRQ8smnXeM1zpo5Hjcy8PquYWk6+Q+YZXiYn7hiaoaKuBBSES1F/4uMU2IZrDJHEulDGf4SLrZT9e4ZeeI8=
X-Received: by 2002:ac5:c76d:: with SMTP id c13mr6000223vkn.3.1588755632159;
 Wed, 06 May 2020 02:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
In-Reply-To: <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 6 May 2020 17:00:20 +0800
Message-ID: <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
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

John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote:
> > John Stultz <john.stultz@linaro.org> writes:
> > > From: Yu Chen <chenyu56@huawei.com>
> > >
> > > It needs more time for the device controller to clear the CmdAct of
> > > DEPCMD on Hisilicon Kirin Soc.
> >
> > Why does it need more time? Why is it so that no other platform needs
> > more time, only this one? And which command, specifically, causes
> > problem?

Sorry for my back to this so late.

This change is required on my dwc3 based HW too, I gave a check
and the reason is suspend_clk is used in case the PIPE phy is at P3,
this slow clock makes my EP command below timeout.

dwc3_gadget_ep_cmd: ep0out: cmd 'Set Endpoint Configuration' [401]
params 00001000 00000500 00000000 --> status: Timed Out

Success case takes about 400us to complete, see below trace(44.286278
- 44.285897 =3D 0.000381):

configfs_acm.sh-822   [000] d..1    44.285896: dwc3_writel: addr
000000006d59aae1 value 00000401
configfs_acm.sh-822   [000] d..1    44.285897: dwc3_readl: addr
000000006d59aae1 value 00000401
... ...
configfs_acm.sh-822   [000] d..1    44.286278: dwc3_readl: addr
000000006d59aae1 value 00000001
configfs_acm.sh-822   [000] d..1    44.286279: dwc3_gadget_ep_cmd:
ep0out: cmd 'Set Endpoint Configuration' [401] params 00001000
00000500 00000000 --> status: Successful

Hi John,

Do you still have this problem? if yes, What's the value of
USBLNKST[21:18] when the timeout happens?

thanks
Li Jun
>
> Hrm. Sadly I don't have that context (again I'm picking up a
> semi-abandoned patchset here), which is unfortunate, as I'm sure
> someone spent a number of hours debugging things to come up with this.
> :)
>
> But alas, I've dropped this for now in my stack, and things seem to be
> working ok so far. I suspect there's some edge case I'll run into, but
> hopefully I'll be able to debug and get more details when that
> happens.
>
> I do appreciate the review and pushback here!
>
> thanks
> -john
