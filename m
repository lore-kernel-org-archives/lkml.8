Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11843C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FD4207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piFqKHIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:26:13 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34621 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:26:12 -0500
Received: by mail-lj1-f182.google.com with SMTP id z22so33286917ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8QaAxRvpIp1ZDk7uOnezFQpia7qFMkTmHcIdFJK54Y=;
        b=piFqKHIhM1NPhef3UI4sHxEpVBFCVeduqD5372fh4X+KCsRGy5ASYUBoaRWZlGoW0j
         +n0mVb1HzJ9uDXvZHCVUYbAeixx0Z36wUwBfScwmZ9B92wYPcPG/M7H1/u9X4lbYP+xg
         VorMekBszSESzPhDCJeYR3OHBeBw5ZDnB0xI+qe00Q4ZrejqWQTLeJBZ1wBavOyjmjGm
         9BT+F4LsA/RRLVf9YS0310lqVsFDHpRygWhcX/XtX8TbtC8y7Yqa9fD3GNI1jvnsMedS
         YEIxwAHt+BxYfKfoluelikxXoe6k2LzrQlrjH3+EU8kbEa1D7gpS8fa4EHkISSCAXxDX
         JQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8QaAxRvpIp1ZDk7uOnezFQpia7qFMkTmHcIdFJK54Y=;
        b=QQ6vdIkHF0uUClv99cZlqVLyFI4ANlvgwUmQKqkoLIwAX+3KDq0AEk8Bubshq4ytSf
         PaEOnbElIfzKISgPUSs47LvGbYljike2QKQUo35XYIsZbATdUdH772W1Bkl1jSIPv3+m
         O4OoK8foApbQR7BBCJR7AFFtspYS2etmeii7hXpINXYjdeIqQ1uIKcFMmVK3FTv+pcZ8
         ZV8iGJq9oYlOU1gBeyd43UALjfs5tVPngVofFcb6ARYMtHoOJLds/oGYTF2NQHue+DoX
         JMyZQ/rN9y33NWR6SLjpK4ZQu9ATrfpOwses1fckN6MA1HiRNnN107CUMLLW8mN2PTXq
         IO4Q==
X-Gm-Message-State: APjAAAXNNy30m7/MuAfY/SBCJletWcewsv2DBKl/whT53nt9UWkU0FQz
        98+BCfUtHOrzomoRynFgyWeHhdtJ7WFufZMSDaTXTA==
X-Google-Smtp-Source: APXvYqxoZ48A2hf1Aa4C9g05YCW5bi4mSa6lw9jNrci7DdKXWB3iLA9uQ8QvNAW4AM5D0qt0d8NydBQcZpAQ/YDC164=
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr13412186ljk.245.1579515970733;
 Mon, 20 Jan 2020 02:26:10 -0800 (PST)
MIME-Version: 1.0
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 20 Jan 2020 18:25:58 +0800
Message-ID: <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
Subject: Re: Question about dynamic minor number of misc device
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 6:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 20, 2020 at 9:33 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> >
> > Hi Maintainers,
> >
> > I see there are 64 free slots(0-63) used for misc devices with dynamic
> > minor number. But PSMOUSE_MINOR(1) overlaps with that dynamic range.
> >
> > So if the dynamic minor number exhaust, psaux driver will fail with
> > "could not register psaux device, error: -16", is this expected?
> > Should we preserve a slot for psaux and serio_raw which use static
> > minor number PSMOUSE_MINOR?
>
> Is this a theoretical question, or are you actually running out of dynamic
> minor numbers? I would guess that if we change the limit to only allow
> dynamic minors 2 through 63, that would technically be a correct
> change, but the result would be that in the same situation another random
> driver fails, which is not much of an improvement, unless the dynamic
> minor numbers also continue into the range above 255.

It's theoretical question. Thanks for your explanation.

>
> On a  related note, I checked for drivers that call misc_register()
> with a minor number that is not defined in include/linux/misc.h
> and found a bunch, including some that have conflicting numbers,
> conflicting names  or numbers from the dynamic range:
>
> drivers/staging/speakup/devsynth.c:#define SYNTH_MINOR 25
> drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTH_MINOR 26 /*
> might as well give it one more than /dev/synth */
> drivers/staging/speakup/speakup_soft.c:#define SOFTSYNTHU_MINOR 27 /*
> might as well give it one more than /dev/synth */
> drivers/macintosh/via-pmu.c:#define PMU_MINOR           154
> drivers/macintosh/ans-lcd.h:#define ANSLCD_MINOR                156
> drivers/auxdisplay/charlcd.c:#define LCD_MINOR          156
> drivers/char/applicom.c:#define AC_MINOR 157
> drivers/char/nwbutton.h:#define BUTTON_MINOR 158
> arch/arm/include/asm/nwflash.h:#define FLASH_MINOR               160
> drivers/sbus/char/envctrl.c:#define ENVCTRL_MINOR       162
> drivers/sbus/char/flash.c:#define FLASH_MINOR   152
> drivers/sbus/char/uctrl.c:#define UCTRL_MINOR   174
> drivers/char/toshiba.c:#define TOSH_MINOR_DEV 181
> arch/um/drivers/random.c:#define RNG_MISCDEV_MINOR              183 /*
> official */
> drivers/auxdisplay/panel.c:#define KEYPAD_MINOR         185
> drivers/video/fbdev/pxa3xx-gcu.c:#define MISCDEV_MINOR  197
> kernel/power/user.c:#define SNAPSHOT_MINOR      231
> drivers/parisc/eisa_eeprom.c:#define    EISA_EEPROM_MINOR 241
>
> If you would like to help clean that up, you are definitely welcome
> to send patches.

Ok, should that be a patch for all drivers or seperate patch for each driver?

Thanks
Zhenzhong
