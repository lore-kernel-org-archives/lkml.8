Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1326020792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI6TJXwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHEI2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgHEI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:28:07 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC7FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:28:06 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so17581565vsl.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsPXwyWsTau2EDU/u1Hk2SK//pn/XYCZgs8Tt7Pybic=;
        b=nI6TJXwdcL8bsQtueioGpxs1dnaTvpDVsDZvaDqlGBNhUdKfsh3Ax4gkI9R9KzByby
         8jJhFplzdD7cedGGornU3Sq/8xENfGxLhTdDZg0LMO0HRolLV3RoODT975OyxFwJK86M
         zxMyJhe38lQGPCZA7b8IcQANrGzmK+yhmW0cT2sZ1CqtxuhQmzOk2suo0PxTJaBiG7Ct
         q1skvui95tv+FxbN1SOWHbMuw9brQPG7q9Slbcj39DTVV4mNCn1jQZbG4kLwhf9+EKTr
         aY+EfjilP05q9s24WEegAZtXoiSsaDMQoKkKROzep7pMY1W1g9lsKFX+NBq6TVTiAqzo
         NHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsPXwyWsTau2EDU/u1Hk2SK//pn/XYCZgs8Tt7Pybic=;
        b=BM9VjxuQ1tcD8M28KLh9WYacC8GloPO0SAtsp36ovKYRllpGKwQ9qwBwUIZdkXohZ2
         7x02eVnueB9uwW2a3D/Kr+/CnEu2axyU/Wkd4D5r98Cbmk+JiIViHNeASVtJcASTXSDy
         NcTWvB8Yc9pYBeoJm/66Roo+u9XsPBmaLHYub7EXbIr6uhKZL55FjyZrmx4Pu4ULXPtv
         rIoiC3GbnPp+BeoumbskRGmD3Y3N+NCRKvkk8Ko7j2IhTyCb6xG8VLUPXTdmD1FoWKMb
         o5aW9wcR8dYcGwlMoksOB6I3Zll46N2PHiPgBmAHH8Nh7ON8xTI28DK09EhoZBSEUEEf
         dyew==
X-Gm-Message-State: AOAM530qsGEKFwu6wkHJVZoS2x8Z4yQOEBVKlDFvmJq2a9h++FhQnNdp
        wL2sC+egHZNFyAaBSSrXXR93513a6ItNQrc9whINWA==
X-Google-Smtp-Source: ABdhPJyg9sQvxmESDF5GTAUhEZ9bYbqPJ06XS1287lPwfK6Z0zf1NhIU0pmGvdrdGvyU2z29OrxDDMKAUUkXwCI166U=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr1130507vsd.200.1596616085611;
 Wed, 05 Aug 2020 01:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200721191718.29414-1-alcooperx@gmail.com> <CAPDyKFqLX8TvZHZ+0Ytu9BO_56vuPQ+9cvFQCez+mEG-AJWkqQ@mail.gmail.com>
 <CAOGqxeX=E6WrBUoy3cicFP-=uuxJZRTmyk_qODR=7Chzt9ixTw@mail.gmail.com>
In-Reply-To: <CAOGqxeX=E6WrBUoy3cicFP-=uuxJZRTmyk_qODR=7Chzt9ixTw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 10:27:29 +0200
Message-ID: <CAPDyKFp7UReGd1xZPidErgeL2rfFCKekGZ+Tc3+vP63WX=vWWg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Some Micron eMMC devices cause reboot to hang
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 at 15:07, Alan Cooper <alcooperx@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 7:03 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 21 Jul 2020 at 21:18, Al Cooper <alcooperx@gmail.com> wrote:
> > >
> > > When using eMMC as the boot device, some Micron eMMC devices will
> > > cause reboot to hang. This is a result of the eMMC device not going
> > > into boot mode after the hardware sends CMD0 to reset the eMMC
> > > device. This only happens if the kernel driver sends CMD5 (SLEEP_WAKE),
> > > to put the device into sleep state, before restarting the system.
> >
> > What do you mean by "boot mode"?
>
> I'm referring to the "Boot operation mode" described in Section 6.3 of
> the JEDEC spec.
> Our hardware will send a CMD0 with 0xf0f0f0f0 argument at powerup or
> when the SoC is reset, and then hold the CLK signal low for 74 clock
> cycles. This should put the eMMC device into boot mode where it
> streams consecutive blocks without additional commands. With this
> Micron device I find that if I send a CMD5 before trying to restart
> the system by resetting the SoC, that the system hangs. I worked with
> Micron on the issue and they finally said to either avoid sending the
> CMD5 on restart or use a newer version of the Micron eMMC device.

Thanks for clarifying the test sequence!

However, I am still not (yet) convinced that a card quirk is the right
thing to do. What does the eMMC spec say about sending a CMD0 with
0xf0f0f0f0 to a device that "sleeps"?

Moreover, how does your mmc host driver (and platform) treat VCC and
VCCQ at system suspend/resume, compared to when a reset is done? Is
there a difference?

The point is, if the eMMC spec is being violated, we should not make a
card quirk - as it may cause problems for other platforms.

>
>
> >
> > When the kernel sends the CMD0 to wake up the eMMC from sleep, at
> > system resume for example, it all works fine, I guess. What is the
> > difference?
>
> On system resume the hardware will not try to put the eMMC device back
> into boot mode.

I see.

Does your host driver support HW busy signalling, so DAT0 is monitored
for de-assertion to confirm the CMD5 is completed by the kernel - or
do you rely on the per card sleep timeout to be used in mmc_sleep()?

Additionally, I wonder about what options you have to reset the eMMC?
Can we use something along the lines of
drivers/mmc/core/pwrseq_emmc.c? If it's not possible to do a HW reset,
we could try sending CMD0 with argument being '0' in the reset path.

What do you think?

>
> Al
>
> >
> > > The fix is to add a quirk that avoids sending the SLEEP command
> > > and to use MMC_FIXUP to set the quirk for these Micron devices.
> >
> > I am not sure this is Micron device specific, but rather some it's a
> > driver/platform bug. Maybe on the kernel side or in the bootloader
> > code.
> >

Kind regards
Uffe

> >
> > >
> > > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > > ---
> > >  drivers/mmc/core/mmc.c    | 3 ++-
> > >  drivers/mmc/core/quirks.h | 8 ++++++++
> > >  include/linux/mmc/card.h  | 1 +
> > >  3 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 4203303f946a..4d69e8f8fe59 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1895,7 +1895,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> > >
> > >  static int mmc_can_sleep(struct mmc_card *card)
> > >  {
> > > -       return (card && card->ext_csd.rev >= 3);
> > > +       return card && card->ext_csd.rev >= 3 &&
> > > +               ((card->quirks & MMC_QUIRK_BROKEN_SLEEP) == 0);
> > >  }
> > >
> > >  static int mmc_sleep(struct mmc_host *host)
> > > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > > index 472fa2fdcf13..7263187b6323 100644
> > > --- a/drivers/mmc/core/quirks.h
> > > +++ b/drivers/mmc/core/quirks.h
> > > @@ -99,6 +99,14 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
> > >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> > >                   MMC_QUIRK_TRIM_BROKEN),
> > >
> > > +       /*
> > > +        * Some Micron eMMC devices will not go into boot mode on
> > > +        * CMD0 arg: 0XF0F0F0F0 after going into SLEEP state.
> > > +        * This will hang a reboot.
> > > +        */
> > > +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_NUMONYX, 0x014e, add_quirk_mmc,
> > > +                 MMC_QUIRK_BROKEN_SLEEP),
> > > +
> > >         END_FIXUP
> > >  };
> > >
> > > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > > index 7d46411ffaa2..0cdddcb5e17d 100644
> > > --- a/include/linux/mmc/card.h
> > > +++ b/include/linux/mmc/card.h
> > > @@ -270,6 +270,7 @@ struct mmc_card {
> > >  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
> > >  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
> > >  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> > > +#define MMC_QUIRK_BROKEN_SLEEP (1<<14)         /* Broken sleep mode */
> > >
> > >         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> > >
> > > --
> > > 2.17.1
> > >
