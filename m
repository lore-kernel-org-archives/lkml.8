Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15771C54E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEE120753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAKq1HaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgEFW1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgEFW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:27:54 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259AC061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:27:53 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so2791527otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wh9X0viLAqBaCyOgkq5YZkPRFay/niTUsTksW/b9xjc=;
        b=CAKq1HaIvs35k+7NyjoxmcRuziq+i6ov82ilXW4wZMUrNej7UtuwNVQkHNOAAco+1a
         /J3br1yYIYX9Km9PQxhLbZpUvZ/GqUlB3+M+8J9JbMZjxzl0G2OjtqJtB5FaBfgaoaZn
         UryVxJEI2uuCRYFnpd/5B2GsjBEVaXH1rfs3eoq8ysS464Ra+2ZrJhZ/gC5Vnlu6+kQY
         bQcTHmZfYWxG0eIqV8XgfJzNYhI0tR0jvpAAkUfkxnHlVYWptgMRtH6WKJHpe5Z5xAct
         43LCYejXAM+DK03Qq7PKwjxh0eNyHgAnaNWFOPysYGKRgP17kqZQhn/jVllhC+UlScTB
         ZulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wh9X0viLAqBaCyOgkq5YZkPRFay/niTUsTksW/b9xjc=;
        b=I6X3yTNKhKTEWUODh6Eq/KhXjvRHbMhjkwnquwPYDyM5fNIv2t2A29vMFVP2e7SC0/
         Dtd2Ez4PnxoaKf2OiHY+bsW85Y8vXiVlt4A4QbMNcLJlqmnellOKSZb0c65vxB3Ox63U
         NS+A6JmjhXTmpgY+AH90L9WiDKqTvityWyt0D+YjeCPvHRcJO69eHZNo2QVWqama/rFy
         CBiRwXwFOks6WBR9N02pEJxpBeMjebb9AA0ciy9IwrfSFa4Xla+ztuMWJv/C+tcq/B/8
         TjKb7kILeF6tJFVgMrfRtRVSvMlkr1psipYc7cMZEvnnFKHuHDK3EUSwkEfkBuvzeKs5
         FokA==
X-Gm-Message-State: AGi0PuY/+QIUT7ux6kJgXlpdxGcx/H3wnmRNAU4/HAHDQVDSv9Z4tM/r
        RVX5oN9i4XDZQHYXR8f9vVUGXHpFeBlLmC0SRZTlHg==
X-Google-Smtp-Source: APiQypI20QdEI7sgKDFAHfmiXS/vC1g/OfTgcmywmGuTIvYN+hRDogr8IPcoVqlopplBf2ONeVdv9YUQFAZMnjd9558=
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr8813654otr.102.1588804072594;
 Wed, 06 May 2020 15:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
In-Reply-To: <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 May 2020 15:27:40 -0700
Message-ID: <CALAqxLVXauXP0r4Hv2Axa4PNf_F9wp644peYV06bdsPtMKGmLA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
To:     Jun Li <lijun.kernel@gmail.com>
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

On Wed, May 6, 2020 at 2:00 AM Jun Li <lijun.kernel@gmail.com> wrote:
> John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=
=9A
> > On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote:
> > > John Stultz <john.stultz@linaro.org> writes:
> > > > From: Yu Chen <chenyu56@huawei.com>
> > > >
> > > > It needs more time for the device controller to clear the CmdAct of
> > > > DEPCMD on Hisilicon Kirin Soc.
> > >
> > > Why does it need more time? Why is it so that no other platform needs
> > > more time, only this one? And which command, specifically, causes
> > > problem?
>
> Sorry for my back to this so late.
>
> This change is required on my dwc3 based HW too, I gave a check
> and the reason is suspend_clk is used in case the PIPE phy is at P3,
> this slow clock makes my EP command below timeout.
>
> dwc3_gadget_ep_cmd: ep0out: cmd 'Set Endpoint Configuration' [401]
> params 00001000 00000500 00000000 --> status: Timed Out
>
> Success case takes about 400us to complete, see below trace(44.286278
> - 44.285897 =3D 0.000381):
>
> configfs_acm.sh-822   [000] d..1    44.285896: dwc3_writel: addr
> 000000006d59aae1 value 00000401
> configfs_acm.sh-822   [000] d..1    44.285897: dwc3_readl: addr
> 000000006d59aae1 value 00000401
> ... ...
> configfs_acm.sh-822   [000] d..1    44.286278: dwc3_readl: addr
> 000000006d59aae1 value 00000001
> configfs_acm.sh-822   [000] d..1    44.286279: dwc3_gadget_ep_cmd:
> ep0out: cmd 'Set Endpoint Configuration' [401] params 00001000
> 00000500 00000000 --> status: Successful
>
> Hi John,
>
> Do you still have this problem? if yes, What's the value of
> USBLNKST[21:18] when the timeout happens?

Sorry. As I mentioned, I was working to upstream a patchset that I
hadn't created, so the context I had was limited. As I couldn't
reproduce an issue without the change on the device I had, I figured
it would be best to drop it.

However, as you have some analysis and rational for why such a change
would be needed, I don't have an objection to it. Do you want to
resubmit the patch with your explanation and detailed log above in the
commit message?

thanks
-john
