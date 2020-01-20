Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8BC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8508217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgATWNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:13:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43360 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726607AbgATWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:13:52 -0500
Received: from callcc.thunk.org ([38.98.37.142])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00KMDPGJ012247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 17:13:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 31643420057; Mon, 20 Jan 2020 17:13:23 -0500 (EST)
Date:   Mon, 20 Jan 2020 17:13:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about dynamic minor number of misc device
Message-ID: <20200120221323.GJ15860@mit.edu>
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
 <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
 <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:59:32AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 20, 2020 at 11:26 AM Zhenzhong Duan
> <zhenzhong.duan@gmail.com> wrote:
> > On Mon, Jan 20, 2020 at 6:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Jan 20, 2020 at 9:33 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> > > On a  related note, I checked for drivers that call misc_register()
> > > with a minor number that is not defined in include/linux/misc.h
> > > and found a bunch, including some that have conflicting numbers,
> > > conflicting names  or numbers from the dynamic range:
> > >
> > > drivers/staging/speakup/devsynth.c:#define SYNTH_MINOR 25
> > > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTH_MINOR 26 /*
> > > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTHU_MINOR 27 /*
> > > drivers/macintosh/via-pmu.c:#define PMU_MINOR           154
> > > drivers/macintosh/ans-lcd.h:#define ANSLCD_MINOR                156
> > > drivers/auxdisplay/charlcd.c:#define LCD_MINOR          156
> > > drivers/char/applicom.c:#define AC_MINOR 157
> > > drivers/char/nwbutton.h:#define BUTTON_MINOR 158
> > > arch/arm/include/asm/nwflash.h:#define FLASH_MINOR               160
> > > drivers/sbus/char/envctrl.c:#define ENVCTRL_MINOR       162
> > > drivers/sbus/char/flash.c:#define FLASH_MINOR   152
> > > drivers/sbus/char/uctrl.c:#define UCTRL_MINOR   174
> > > drivers/char/toshiba.c:#define TOSH_MINOR_DEV 181
> > > arch/um/drivers/random.c:#define RNG_MISCDEV_MINOR
> > > drivers/auxdisplay/panel.c:#define KEYPAD_MINOR         185
> > > drivers/video/fbdev/pxa3xx-gcu.c:#define MISCDEV_MINOR  197
> > > kernel/power/user.c:#define SNAPSHOT_MINOR      231
> > > drivers/parisc/eisa_eeprom.c:#define    EISA_EEPROM_MINOR 241
> > >
> > > If you would like to help clean that up, you are definitely welcome
> > > to send patches.
> >
> > Ok, should that be a patch for all drivers or seperate patch for each driver?
> 
> I think one patch to move the ones with unique names would be fine,
> but then separate patches for
> 
> - FLASH_MINOR move and rename to avoid conflict
> - change speakup to dynamic minors
> - support for high dynamic minor numbers if you are really motivated
>   (probably nobody needs these)

Are we sure that reassigning minor device number conflits isn't going
to break systems?  Especially those on random, older, architectures
they might not be using udev.

						- Ted
