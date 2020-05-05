Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0DC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2B020663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dM75wwRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgEESTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:19:05 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:19:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so1870354vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iMevh+q5WmqdjJ+8dhPwbuny1aAHLTbtJzElqtJNQLA=;
        b=dM75wwRqwLfXvV2NFBkhEaaOUL2+xvNELpzsJDzJHT8oDPiKHT0iiiDl6TMOSPz6bp
         pUl2UlCuO5F6UVfvrnAAlSqELpw7QPw77Y3oEmjRhPFjU6QDA2nRD7QA/vDldxwfrcp8
         WNEnLb7Ii38R6f53WYYkLjcLSYbaflmY7DeYZ+oNNHWQWcoR6RbuidHc05hvvaDXft8E
         FljByUfJgCMf8huL0jbHW1H8xT11Hl8hSMCHvl/P1Hti1JmFZ85pEZdnPWs479ZgK7xs
         owYKrlwvjvk9c/HrfVcWmhxuWC3ezO7U/QeUWikL1ccgg4o/mg95We/fIH5tB8l1eXuT
         QsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iMevh+q5WmqdjJ+8dhPwbuny1aAHLTbtJzElqtJNQLA=;
        b=QaA/r6+trnH8hCNA57YrR+4JzsGkxZ7ug9oO6QCjx+ztnWCdBKlpHCVKGAiWK+lFm1
         RzrKWIqbdj9xUEuZnoe9ZFCs9m9C9IYliZnBRtCHPfNSPh2RpRJRMgV3oyBO9OdnU2Zt
         VUKT3pCypXdNKSfCsXS0QVTSuxXlcBsxP8goxCQzjpLrSdIWeIM2q/gTVl23YPyBqm8f
         soUhW6PK217aqP5UmvuV+PZM+78FU9ziXB8PQ4Of8aQHapF8dWkOhfd1HmytX7MlbeQZ
         zoDysCjwPxyhfQaFuk6gQjo0iiThD/qBVj9cvADEhdnMcic7dL3Lg+ua77XXqHmSxAiP
         H9+g==
X-Gm-Message-State: AGi0Pubq7FpicTofh0J1QT9UHa+80iWiqKa63vYu1XfxIJH94Idn2hvj
        v0O5/Q/B6w2T0O/d+jM/NW0wO1vYfvWv8DEoqQm1TA==
X-Google-Smtp-Source: APiQypLkRqmfvllv5PPbqDQjAWaZCy24mQebQQByb044v803OzCPzzKsqCPnKGfqRGyOOOI4iTVdJADbVneL5utmVTI=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr4314656vso.200.1588702743389;
 Tue, 05 May 2020 11:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org> <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
 <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com> <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 20:18:26 +0200
Message-ID: <CAPDyKFqWAzzHDtCwaUUBVvzxX0cf46V-6RZrZ-jvnxpptNKppA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 05:44, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> >
> > On Mon, Apr 27, 2020 at 11:41 AM =E5=86=AF=E9=94=90 <rui_feng@realsil.c=
om.cn> wrote:
> > >
> > >
> > > > On Sun, Apr 26, 2020 at 09:25:46AM +0800, rui_feng@realsil.com.cn
> > wrote:
> > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > >
> > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > In SD7.x, SD association introduce SD Express as a new mode.
> > > > > SD Express mode is distinguished by CMD8.
> > > > > Therefore, CMD8 has new bit for SD Express.
> > > > > SD Express is based on PCIe/NVMe.
> > > > > RTS5261 uses CMD8 to switch to SD Express mode.
> > > >
> > > > So how does this bit work?  They way I imagined SD Express to work
> > > > is that the actual SD Card just shows up as a real PCIe device,
> > > > similar to say Thunderbolt.
> > >
> > > New SD Express card has dual mode. One is SD mode and another is PCIe
> > mode.
> > > In PCIe mode, it act as a PCIe device and use PCIe protocol not Thund=
erbolt
> > protocol.
> >
> > I think what Christoph was asking about is why you need to issue any
> > commands at all in SD mode when you want to use PCIe mode instead. What
> > happens if you load the NVMe dthriver before loading the rts5261 driver=
?
> >
> >        Arnd
> >
> > ------Please consider the environment before printing this e-mail.
>
> RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
> 1.RTS5261 work in SD mode.
> 2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.

This sounds like the card insert/removal needs to be managed by the
rtsx_pci_sdmmc driver (mmc).

> 3.If the card has PCIe availability, RTS5261 switch to PCIe/NVMe mode.

This switch is done by the mmc driver, but how does the PCIe/NVMe
driver know when to take over? Isn't there a synchronization point
needed?

> 4.Mmc driver exit and NVMe driver start working.

Having the mmc driver to exit seems wrong to me. Else how would you
handle a card being removed and inserted again?

In principle you want the mmc core to fail to detect the card and then
do a handover, somehow. No?

Although, to make this work there are a couple of problems you need to
deal with.

1. If the mmc core doesn't successfully detect a card, it will request
the mmc host to power off the card. In this situation, you want to
keep the power to the card, but leave it to be managed by the
PCIe/NVMe driver in some way.

2. During system resume, the mmc core may try to restore power for a
card, especially if it's a removable slot, as to make sure it gets
detected if someone inserted a card while the system was suspended.
Not sure if this plays well with the PCIe/NVMe driver's behaviour.
Again, I think some kind of synchronization is needed.

> 5.If card is unplugged, RTS5261 will switch to SD mode.

Alright, clearly the mmc driver is needed to manage card insert/removal.

> We should send CMD8 in SD mode to ask card's PCIe availability, and the o=
rder of NVMe driver and rts5261 driver doesn't matter.

That assumes there's another synchronization mechanism. Maybe there
is, but I don't understand how.

Kind regards
Uffe
