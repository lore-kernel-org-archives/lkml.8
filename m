Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08109C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89D822522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUH45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:56:57 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:56:56 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MrQN5-1jN4gy1L1j-00oVpR for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 08:56:55 +0100
Received: by mail-qk1-f176.google.com with SMTP id x129so1804996qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 23:56:55 -0800 (PST)
X-Gm-Message-State: APjAAAWtYuRWYftvoxM0Q9pnIOkIRr9Ox23ymBFxDj78bM6AN/2YTdda
        LypIvFKlPKgKKU7e6kYtqNzrk4vg/2DelfsWAT8=
X-Google-Smtp-Source: APXvYqz4tiDJoI2migNnImA2omna2zj+7OgcgTO5jqY48X4PjHVty245HTtfMAVLuNHgqnoCcyHNuiGdUN5ZOP4kl94=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr3229598qkh.3.1579593414178;
 Mon, 20 Jan 2020 23:56:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
 <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
 <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com> <20200120221323.GJ15860@mit.edu>
In-Reply-To: <20200120221323.GJ15860@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 08:56:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2aLxAgjp2_Vb0bKw-0PMVRXKtFw=2giF0MY6hgAQpQRg@mail.gmail.com>
Message-ID: <CAK8P3a2aLxAgjp2_Vb0bKw-0PMVRXKtFw=2giF0MY6hgAQpQRg@mail.gmail.com>
Subject: Re: Question about dynamic minor number of misc device
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UcYfFRlinOqwCjCCYDRzvoYlDPafztP3ta4y9slIdqm2BtQ8Mtk
 Lhp5V7Ve2x7fahWEBguMbjl9B9tSfOSdfq1dxkh0DnzO/CKQSJAvccm//s5yKKSjWK+cxfW
 uv41vNAKiGTzcZ7J7nAtkFKPx1A9lKxeajsssmEOv99iCjjkrD4VN8FHP1wmPyfyzaMbKIB
 ezgRLlhqUezCfF9f4juSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tmR6Eac6mUY=:ej3nGrtUr/oiI8d3CFxebz
 08Mm+FUmhHmaCjg7Rb53ecpIDQe1vYQr8W/Hc2g3Ryb7JSyu5teN20jxl8Syt5tb4GmynWhBG
 hpd7KFiCsPM9Dx5GaMbwKXXySZqEI8dBgeB0wAhRadgD3HmXt4E8N9okFOvxRtfVUwEH08fse
 GoxdoxfCOmqax/RGdTGEDGM6TvXlH63aEwIKLt/RzsP2TYGkoDX/lAwc5DuEaZ9D75W8uVf6K
 fCzF27QQn73lmYeVp9NY6a2jH0w/TSTiJyIyleaU79EL5TgLwcUE0wWM0NThl17MP60rx0Akd
 6HjU46KUTQVekFIqVKtVfaTmxipZfyH7YqJ5v3hVqZrB63vwezl+G6/kKPAmRcDJBn4xjkj7T
 qquSO+YkxO+a99GUZocIiZ7fdyxzv3+tUwYZU5mlX9dghDMVxg3DYGSRYaDSy1ib31phyWjpS
 1wKi4427kF1wOTQYyVfHfVSuwQyo5PmTY4g/XTEVREsp3CtPzzMd+pw/qLgwqE1OMyuNJyhdW
 F1pRaR8JllHBPO1neLg5y+7G2p26T35ITC6eIrzBWWS3+CBaqIUfyF6dHYMtfkcCAD3g3ajdF
 SYiKy0zXE9z/PsR9CoxUjrSbRfbRejgrUP7N3xxjbQzHHTieGFl0Y3yQsnEvVQqjis8CtC/I8
 I7nrfWY4UuBm/ROOjNwJiebNPDefnkT8keNhyh86HXXJsRkTH+VzpHO667Dor/Dhdd9vs5oHF
 UMRafpjwX7B3u00DbUuSjgl0+SKgRPNdhE9y1B2pkdoEWC+j14VlqFEkM6SClyA1PVbc6FtgH
 X1R6axf4nCP5AC+QDf2dYhhbwBuwcuHhizqx7/SVUAk+kg8wiAZvp8HSNyiv5kzPDtPDIMkie
 v6yIlgyvTGu3RLWH+XOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:13 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jan 20, 2020 at 11:59:32AM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 20, 2020 at 11:26 AM Zhenzhong Duan
> > <zhenzhong.duan@gmail.com> wrote:
> > > On Mon, Jan 20, 2020 at 6:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Mon, Jan 20, 2020 at 9:33 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> > > > On a  related note, I checked for drivers that call misc_register()
> > > > with a minor number that is not defined in include/linux/misc.h
> > > > and found a bunch, including some that have conflicting numbers,
> > > > conflicting names  or numbers from the dynamic range:
> > > >
> > > > drivers/staging/speakup/devsynth.c:#define SYNTH_MINOR 25
> > > > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTH_MINOR 26 /*
> > > > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTHU_MINOR 27 /*
> > > > drivers/macintosh/via-pmu.c:#define PMU_MINOR           154
> > > > drivers/macintosh/ans-lcd.h:#define ANSLCD_MINOR                156
> > > > drivers/auxdisplay/charlcd.c:#define LCD_MINOR          156
> > > > drivers/char/applicom.c:#define AC_MINOR 157
> > > > drivers/char/nwbutton.h:#define BUTTON_MINOR 158
> > > > arch/arm/include/asm/nwflash.h:#define FLASH_MINOR               160
> > > > drivers/sbus/char/envctrl.c:#define ENVCTRL_MINOR       162
> > > > drivers/sbus/char/flash.c:#define FLASH_MINOR   152
> > > > drivers/sbus/char/uctrl.c:#define UCTRL_MINOR   174
> > > > drivers/char/toshiba.c:#define TOSH_MINOR_DEV 181
> > > > arch/um/drivers/random.c:#define RNG_MISCDEV_MINOR
> > > > drivers/auxdisplay/panel.c:#define KEYPAD_MINOR         185
> > > > drivers/video/fbdev/pxa3xx-gcu.c:#define MISCDEV_MINOR  197
> > > > kernel/power/user.c:#define SNAPSHOT_MINOR      231
> > > > drivers/parisc/eisa_eeprom.c:#define    EISA_EEPROM_MINOR 241
> > > >
> > > > If you would like to help clean that up, you are definitely welcome
> > > > to send patches.
> > >
> > > Ok, should that be a patch for all drivers or seperate patch for each driver?
> >
> > I think one patch to move the ones with unique names would be fine,
> > but then separate patches for
> >
> > - FLASH_MINOR move and rename to avoid conflict
> > - change speakup to dynamic minors
> > - support for high dynamic minor numbers if you are really motivated
> >   (probably nobody needs these)
>
> Are we sure that reassigning minor device number conflits isn't going
> to break systems?  Especially those on random, older, architectures
> they might not be using udev.

To clarify: the only numbers that I think should be changed to dynamic
allocation are for drivers/staging/speakup. While this is a fairly old
subsystem, I would expect that it being staging means we can be a
little more progressive with the changes.

      Arnd
