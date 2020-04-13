Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:34:17 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D5E20735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VndDFV/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D5E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgDMFeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgDMFeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:34:00 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22CBC00860C;
        Sun, 12 Apr 2020 22:33:59 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F762076A;
        Mon, 13 Apr 2020 05:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586756039;
        bh=qt4NrQHfEP5adB0UUWrWKeKpLWTnRpj9zG8trfqPOIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VndDFV/LAmxNxyZTDsCrBrgVrIh/nLeNPouMebChS7yrWETkr5J8Nnx2q88B5oV0E
         XsD3CAqnUwg6xPP+bXZX0hYv0gLkJVr9SyFZIe4OOvGxL0QjRr703qXbA49oohR1yf
         w25tl0GPD5wC7YgRTjLx24o6+SWxXKPHrbvqagkU=
Received: by mail-wr1-f46.google.com with SMTP id s8so9035786wrt.7;
        Sun, 12 Apr 2020 22:33:59 -0700 (PDT)
X-Gm-Message-State: AGi0PubkCeFK3gOg7DjXrEvsKkodUQyISKh62B2UI6JuHespvmq68F1a
        nVsYfeBxCGOMmqDq+S3RLmsrtMjJz6mkYJVzaSk=
X-Google-Smtp-Source: APiQypLgboXHD3XZiUO90AwxZLJ/yV/Vrt0c+3sy6PCwIvSdLMeJ7KtlYHXP+6JpGZSwGC046WzmNEMiiA47Tvr5sAU=
X-Received: by 2002:adf:f04a:: with SMTP id t10mr4827742wro.64.1586756037667;
 Sun, 12 Apr 2020 22:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200327030414.5903-2-wens@kernel.org> <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
 <CAGb2v65ayZwN14S-Pzu2ip1K=fgzTbNB=ZzUcpou-jtv8m6vBA@mail.gmail.com>
 <ccf35a92-7005-9c6d-a8a2-c17b714a60bc@arm.com> <20200406091313.GF31120@duo.ucw.cz>
In-Reply-To: <20200406091313.GF31120@duo.ucw.cz>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 13 Apr 2020 13:33:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64bcVLmQPxfAUafa-Grbr1MRCVb0j=HYUrXdihbmVB2Mw@mail.gmail.com>
Message-ID: <CAGb2v64bcVLmQPxfAUafa-Grbr1MRCVb0j=HYUrXdihbmVB2Mw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC
 numbering for LED triggers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        jacek.anaszewski@gmail.com, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Apr 6, 2020 at 5:13 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> > > > diy-led:linux,default-trigger:0: 'mmc2' is not one of ['backlight',
> > > > 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > > > arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> > > > yellow-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
> > > > 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > >
> > > Maybe we should just get rid of linux,default-trigger then?
> >
> > In this particular case, I'd say it's probably time to reevaluate the rather
> > out-of-date binding. The apparent intent of the "linux,default-trigger"
> > property seems to be to describe any trigger supported by Linux, so either
> > the binding wants to be kept in sync with all the triggers Linux actually
> > supports, or perhaps it should just be redefined as a free-form
>
> It is enough to keep it in sync with all the triggers we actually use :-).
>
> > I'd be slightly inclined towards the latter, since the schema validator
> > can't know whether the given trigger actually corresponds to the correct
> > thing for whatever the LED is physically labelled on the board/case, nor
> > whether the version(s) of Linux that people intend to use actually support
> > that trigger (since it doesn't have to be the version contemporary with the
> > schema definition), so strict validation of this particular property seems
> > to be of limited value.
>
> But freeform seems acceptable, too.

I'd say free form is easier to manage. Being in the list of valid triggers
doesn't mean the kernel actually has support for it enabled.

> > > > > -             diy-led {
> > > > > +             diy_led: diy-led {
> > > > >                        label = "red:diy";
> > > > >                        gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> > > > >                        default-state = "off";
> > > > >                        linux,default-trigger = "mmc1";
> > > > >                };
>
> This label probably should be "mmc1:red:activity" or something like that.

Is changing this after it has been in some kernel releases OK? Wouldn't
it be considered a break of sysfs ABI?

Also, is there some guideline on how to name the labels? For sunxi we've
been doing "${vendor}:${color}:${function}" since forever.

As far as I can tell, the hardware vendor [1] has no specific uses for
these two (red and yellow) LEDs designed in. And their GPIO lines are
simply labeled "DIY" (for the red one) and "YELLOW". So I'm not sure
if putting "our" interpretations and the default-trigger into the
label is wise.

For reference, the green one has its GPIO line labeled "WORK", and their
intention from [1] is to have it as some sort of power / activity indicator.
Hence it is named / labeled "work".

As for the node names, I think we can keep it as is for now. It's not
the preferred form, but there's really no need to change it either.
And some overlay or script might actually expect that name.

Regards
ChenYu


[1] http://wiki.t-firefly.com/en/ROC-RK3399-PC/driver_led.html

> > > > > -             yellow-led {
> > > > > +             yellow_led: yellow-led {
> > > > >                        label = "yellow:yellow-led";
> > > > >                        gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> > > > >                        default-state = "off";
>
> And this label should be changed, too.
>
> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
