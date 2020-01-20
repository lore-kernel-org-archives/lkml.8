Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A5D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATK7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:59:52 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:59333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:59:52 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7auJ-1iyjaC3BjZ-0082pz for <linux-kernel@vger.kernel.org>; Mon, 20 Jan
 2020 11:59:49 +0100
Received: by mail-qv1-f42.google.com with SMTP id u1so13769608qvk.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:59:49 -0800 (PST)
X-Gm-Message-State: APjAAAW/j4iAxaX1pgZAI4Sjxm7x2DBaTOF2Fds3uHpQgC1zEJt7mxW0
        WVGK+HPQh6b6+W8iplNLByVlE2vAcZDk9Ct6+os=
X-Google-Smtp-Source: APXvYqzQ1MvMqg+hoJdxvZCu816eN+yyJcaaU/qIVUUfYGEOqB3mVriBM3UpWcgYozrKpF4M3hDisExBQ1RIB2aqcKE=
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr20095619qvb.4.1579517988617;
 Mon, 20 Jan 2020 02:59:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com> <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
In-Reply-To: <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jan 2020 11:59:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
Message-ID: <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
Subject: Re: Question about dynamic minor number of misc device
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oUuVCRVWt0NAiOBBkbU5zLjXESwHtBqBVnH3fc4p8P41XXXVIW8
 XSDB8rTl3mUerkzkTnIZiyL1heoj98CWzm7QuRA2NxYBFJN3LWlsO8mfEyoJ/dsTKrGgeKG
 i6IH17tOJXQWNQ4AsLPNnyEKiRfqp7JdhJlIqWQG8R1ZqW7tRXh+qjXfv9N2rVujtn2jMfn
 ddfpudDwI3USen5Q4AJMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sg2/3O7aNec=:VghGxn/Th/V7iDoH4bHI07
 /I603fPIDsrJH1ZnYgqPnHI3TRReC4+vwpayatAeBv03Gbnknx81aK6zswV3zhPKlpXBw2ZiQ
 njFJkzIcauekMsPgfJyCmp8GOkzH2KlJjNE5/TGgQdEEEOPr6e/lgH/VUiKc8zkJgtV7IFN0k
 BByA+nBOmaGdLfv4AMCKKdrCikd+YTt90xbVEVcvk6Zh6G4sHw4y5nDKZ9TkJ1xGIPTO0xyzA
 z/NyHEorPSRKNmahJDBlsDI/3AbBsw6OCkUh56N29iNDivxizBsZ1SVpMRAqK8KzPqF+DJYHl
 duytp8Dvf8Qx+lt5p+JgnwxEDi1N1oZiGxaKb8MnrUwuOCO7XyzDYRpzwJqJGWt9onQM78flO
 6mpdWZCtudMXVr80HtYB+kd50J5BddCn4+UuZ8Rw5UckB3OhkZw4K95I24SY1uJ3n7hNlw6Jm
 cd4n2Dianj2cmoJGZtWI9qPpIb1iziIhBklqojSsl8GzLCkRmpOksgVGXus5iWcmK3QhW7c8H
 N+wyBybbNzhRMm38FLitjoU3qBa1cnTfLTC7lJe24Zlpe5smuZFqVgYr70nDtAQUhh0n2jBVr
 rZuG5p4iKq5gKSCoucc521ghBbXAsbLbMq7G2O57kKiHSGxseWg8MQAyLBRi/SgSFdAnUBIEn
 /7t0cmrSH3Q/YGlPDTMzDTFQyff3B4B0idv+BjsPiZSY9qBrlEcWkW3ZE4Sio/A5/5v/TtmRK
 3W8PZ6oM19gkjCFY+1fSReuIFeaqKyPQtQb1yCGVIlNJvUeb9TR8Hus8OBUMiC43FEKlQvbvX
 SE1eKMzGhgkNIWoEWgfLNqkouRm4LXRM7I5DPFD9aSU48jkifR146Shv0Ri+0DZwb4hNkcZzm
 iYe4+CaW0dY//OYsvjhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:26 AM Zhenzhong Duan
<zhenzhong.duan@gmail.com> wrote:
> On Mon, Jan 20, 2020 at 6:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 20, 2020 at 9:33 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> > On a  related note, I checked for drivers that call misc_register()
> > with a minor number that is not defined in include/linux/misc.h
> > and found a bunch, including some that have conflicting numbers,
> > conflicting names  or numbers from the dynamic range:
> >
> > drivers/staging/speakup/devsynth.c:#define SYNTH_MINOR 25
> > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTH_MINOR 26 /*
> > drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTHU_MINOR 27 /*
> > drivers/macintosh/via-pmu.c:#define PMU_MINOR           154
> > drivers/macintosh/ans-lcd.h:#define ANSLCD_MINOR                156
> > drivers/auxdisplay/charlcd.c:#define LCD_MINOR          156
> > drivers/char/applicom.c:#define AC_MINOR 157
> > drivers/char/nwbutton.h:#define BUTTON_MINOR 158
> > arch/arm/include/asm/nwflash.h:#define FLASH_MINOR               160
> > drivers/sbus/char/envctrl.c:#define ENVCTRL_MINOR       162
> > drivers/sbus/char/flash.c:#define FLASH_MINOR   152
> > drivers/sbus/char/uctrl.c:#define UCTRL_MINOR   174
> > drivers/char/toshiba.c:#define TOSH_MINOR_DEV 181
> > arch/um/drivers/random.c:#define RNG_MISCDEV_MINOR
> > drivers/auxdisplay/panel.c:#define KEYPAD_MINOR         185
> > drivers/video/fbdev/pxa3xx-gcu.c:#define MISCDEV_MINOR  197
> > kernel/power/user.c:#define SNAPSHOT_MINOR      231
> > drivers/parisc/eisa_eeprom.c:#define    EISA_EEPROM_MINOR 241
> >
> > If you would like to help clean that up, you are definitely welcome
> > to send patches.
>
> Ok, should that be a patch for all drivers or seperate patch for each driver?

I think one patch to move the ones with unique names would be fine,
but then separate patches for

- FLASH_MINOR move and rename to avoid conflict
- change speakup to dynamic minors
- support for high dynamic minor numbers if you are really motivated
  (probably nobody needs these)

      Arnd
