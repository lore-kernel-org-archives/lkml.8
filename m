Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32593C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F13F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgATKDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:03:49 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:03:49 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MmlGg-1jJR4f17pu-00jpkW for <linux-kernel@vger.kernel.org>; Mon, 20 Jan
 2020 11:03:47 +0100
Received: by mail-qt1-f172.google.com with SMTP id k40so27189316qtk.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:03:47 -0800 (PST)
X-Gm-Message-State: APjAAAUoaxsMv/IdRMPEuHNKtW0KmbA9J2fIoDh6FalnrUajdWbVSJbE
        MIsLT3FeJTiqjWgK14MtiIom9Ze4hLrHcYpKbvM=
X-Google-Smtp-Source: APXvYqzuD+ia4TeuoIu8AvPBeT4uvB5VA/ctMprlhEJuuELxxjRelaI7mLhjpYkeZFRt5AnGsonhlPEo9nsDyZNe/hA=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr19426566qtm.18.1579514626114;
 Mon, 20 Jan 2020 02:03:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
In-Reply-To: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jan 2020 11:03:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
Message-ID: <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
Subject: Re: Question about dynamic minor number of misc device
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:axvGa0SVBkQotRREvZnUecy/yzRvvTyzKYydtXOYoXC5ht0nnhL
 3K91MDLeGLpiQwJTXNu8sqlNHi8WCzm3MKD1cF2wa8QEy534WmWoj+ZKHkiheuKI3K990WW
 go8aOoKv0zTUr3KwdnPuxfw95zRoDwicjq0jlVGVEFEPFWzfb8jE1ihLGUbE8bdvbomdrIL
 Pgfx7HHVLpy45ArAz1IIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3HOqjbKXyTM=:YAxCiIZcto5vBEZ5l7MS3R
 xbymjNV5GLM8N7mSxhdLc6MADHHQif9XrQwRAByftGWAyf/J9/Cl79YCMaFivqFJAzwpMYlZo
 TP3jMPyB4HgC5pG6mI3H+1e5eYggwP73CGn1i5umMFj7Q6VjX2ucRfK0f/815fWb+CH4PAgXG
 nG8hGN0BlKiNTJh8cOb6iQmEXJYEGAr0JVPSc0tc8sFRdLBtOYHsdM45eCnlLwv4pv2921xxd
 WxIepSECXhY183BOFDS1ZWG9ZhFDHdZN1rys4Hp6kdJQy9YOedNlsLOuFD7ukLfx1zpQccSTf
 P6KL69dBZgHQfh0pci0PmNGJgP6OezzHs2otVf9oPjzD203WFXfMauH5gUmBSZoKfInYZpW1p
 o+tnwoRlmqGT6zJDV6ezpxSbJoDI2ADlLXqP0xL6jnQ+9UvwOInJrNVNwhp1LQeJJYCDNPMTq
 38fHZ7TtK8ghZ3dlm4NlXw/j26kpWRFvpT2yGGY753mtaeIx0/e6o+28QW3xrMS1mBO4lx/YD
 WLCqauJehkDZNUfswvzdo/7UNpF0TrZsJwrfbAvfLP6G5UgWfHkh5Y0e70YKjZAp1pf1hwlNE
 eMW6zeVFriwi/YlaDtxKysbJ8ysICShKl1njuhQ1ojmWRd8+iWHj+/z2hb85YEzR03flRkt0e
 n3m7X1TcQ7JRF6xgPzorhob54+VKS4N9wQqCbNWm32TZFAERMjAxd1MYrMrtzOPoD74qOv39R
 S4e18A0/Xo3Z5u9w3KhPuaQpcqRSa7BVOYoCRECfcqvRp3dC+j1KpC4LFekWzCzAvkoKK9jQS
 HNAk9XrDETSDS2SLWv8Y9AFXxtXk2jUA7QYnOCUAdC5fvvQAmna3tM72ZKsxV0WZbnOZPX5O9
 29uB/S6Epbc+aHXUDhEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 9:33 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>
> Hi Maintainers,
>
> I see there are 64 free slots(0-63) used for misc devices with dynamic
> minor number. But PSMOUSE_MINOR(1) overlaps with that dynamic range.
>
> So if the dynamic minor number exhaust, psaux driver will fail with
> "could not register psaux device, error: -16", is this expected?
> Should we preserve a slot for psaux and serio_raw which use static
> minor number PSMOUSE_MINOR?

Is this a theoretical question, or are you actually running out of dynamic
minor numbers? I would guess that if we change the limit to only allow
dynamic minors 2 through 63, that would technically be a correct
change, but the result would be that in the same situation another random
driver fails, which is not much of an improvement, unless the dynamic
minor numbers also continue into the range above 255.

On a  related note, I checked for drivers that call misc_register()
with a minor number that is not defined in include/linux/misc.h
and found a bunch, including some that have conflicting numbers,
conflicting names  or numbers from the dynamic range:

drivers/staging/speakup/devsynth.c:#define SYNTH_MINOR 25
drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTH_MINOR 26 /*
might as well give it one more than /dev/synth */
drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTHU_MINOR 27 /*
might as well give it one more than /dev/synth */
drivers/macintosh/via-pmu.c:#define PMU_MINOR           154
drivers/macintosh/ans-lcd.h:#define ANSLCD_MINOR                156
drivers/auxdisplay/charlcd.c:#define LCD_MINOR          156
drivers/char/applicom.c:#define AC_MINOR 157
drivers/char/nwbutton.h:#define BUTTON_MINOR 158
arch/arm/include/asm/nwflash.h:#define FLASH_MINOR               160
drivers/sbus/char/envctrl.c:#define ENVCTRL_MINOR       162
drivers/sbus/char/flash.c:#define FLASH_MINOR   152
drivers/sbus/char/uctrl.c:#define UCTRL_MINOR   174
drivers/char/toshiba.c:#define TOSH_MINOR_DEV 181
arch/um/drivers/random.c:#define RNG_MISCDEV_MINOR              183 /*
official */
drivers/auxdisplay/panel.c:#define KEYPAD_MINOR         185
drivers/video/fbdev/pxa3xx-gcu.c:#define MISCDEV_MINOR  197
kernel/power/user.c:#define SNAPSHOT_MINOR      231
drivers/parisc/eisa_eeprom.c:#define    EISA_EEPROM_MINOR 241

If you would like to help clean that up, you are definitely welcome
to send patches.

      Arnd
