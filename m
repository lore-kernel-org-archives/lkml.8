Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9C22084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArQfiR1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgDKHeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:34:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42068 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDKHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:34:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id j20so3243555otl.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqkq+tfhW8sM0fKfjRkqpvBmR846mOQRNokFVoJ4Ogg=;
        b=ArQfiR1ksIv5Drbppk5N1ycmnyrXlWoZJhWOyf5NkwIBq6p9LgifSjDkJa9hhfxXct
         hIo1G3Vdvxwp0JJ+5uqlrhdSjpauJ0ORVADY6ZbtUJGRk5qxuOsuCZc6Lv97dc09+6cv
         wEcYrtrp50TpOp7SLpWIdzrBEWm8kMF5wwh3fGYA9MfRXkJXzJhXe3oofVqycq/wqHuH
         JtrxA+KsHSJ+uo+Z28kuH03sLArtE5VdK2RSgA57+3pqPh2NiQnuOEQj51TPTeo6b78Y
         BvcaTeGHHUojbCVOwK7HsquNNOXVCnSFqGliI8TaqLAgu6VOSZmkkui9GCqcPpCr1N5c
         r0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqkq+tfhW8sM0fKfjRkqpvBmR846mOQRNokFVoJ4Ogg=;
        b=pAbX2u/1KbtOaX7/m3YOq40lHoHAYO78/B3SXHDYQfCh2faUSzbyeCBOfY5TnVG4Qm
         OBzaaf+GIBszWRJhitCeBoE8kfnD4yAiL9txOWfdAZGZw7Xsy0fTNZRe1UegfEAs8W30
         XiniiL9J7K5vkYNPze0dPI2/b2uFQv97y9IsUBxb4Bc2f5UzbXFGiPk4G12eYJjUls2R
         28LBi3XvqR36zAj0/6B9Ehx1DbdZnOwvSHhAI92LlM7bxUgUPnzdDstRAsg55nJlaniH
         cWXrhNOqch6N18wceTRb7c4vIqoGKWn4nyegxWeaJINC6d8kFcN9NQWNUTSxw3Rc9Lfs
         X6cw==
X-Gm-Message-State: AGi0PuY4wFszGC9PdHubuQEyEUgWE8kqwApHaCxB6Z1sxmZjjvmNxzsZ
        FIBVrj4h5n5WK88z0AU6wDXJN9feSMHNbm+LXFE=
X-Google-Smtp-Source: APiQypJ5nKoVwnXg+7PaF5uV1DcYPyDtvvEaUQ2zeKHJcCZAWdQq8paRtYmqX6XmPzUodCf2c4oe870CUBVCi9sv+fs=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr6338392otk.201.1586590447608;
 Sat, 11 Apr 2020 00:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200225073731.465270-1-avagin@gmail.com> <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
In-Reply-To: <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sat, 11 Apr 2020 00:33:56 -0700
Message-ID: <CANaxB-xUYOrVnfLPRYVBiASzCH89sZkD6vTdy8EFjT16ZJhLfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 6:23 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrei,
>
> On 2/25/20 7:37 AM, Andrei Vagin wrote:
> > Allocate the time namespace page among VVAR pages and add the logic
> > to handle faults on VVAR properly.
> >
> > If a task belongs to a time namespace then the VVAR page which contains
> > the system wide VDSO data is replaced with a namespace specific page
> > which has the same layout as the VVAR page. That page has vdso_data->seq
> > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > VCLOCK_TIMENS to enforce the time namespace handling path.
> >
> > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > update of the VDSO data is in progress, is not really affecting regular
> > tasks which are not part of a time namespace as the task is spin waiting
> > for the update to finish and vdso_data->seq to become even again.
> >
> > If a time namespace task hits that code path, it invokes the corresponding
> > time getter function which retrieves the real VVAR page, reads host time
> > and then adds the offset for the requested clock which is stored in the
> > special VVAR page.
> >
> > v2: Code cleanups suggested by Vincenzo.
> >
>
> Sorry for the delay, I completed this morning the review of your patches and I
> do not have anymore comments on them. Thank you for making the effort and
> bringing the time namespace support to arm64.

Thank you for the review of these patches.

>
> I have though a question on something I encountered during the testing of the
> patches: I noticed that all the tests related to CLOCK_BOOTTIME_ALARM fail on
> arm64 (please find the results below the scissors). Is this expected?

static int alarm_clock_get_timespec(clockid_t which_clock, struct
timespec64 *tp)
{
        struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];

        if (!alarmtimer_get_rtcdev())
                return -EINVAL;

It is probably that you get EINVAL from here ^^^. I will send a
separate patch to handle this case in tests properly.

Thanks,
Andrei
