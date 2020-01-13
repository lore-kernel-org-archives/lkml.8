Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3792080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7+aPgbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgAMJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:47:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41004 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgAMJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:47:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so3617571plb.8;
        Mon, 13 Jan 2020 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCMNSM2YWU7OdfPY0KDWK/UsBJTsJh3PQ6XKci9NR5g=;
        b=n7+aPgbKNmWCktCGNGApcuXwJCTY3dFaS3uFoKybzke/8+bwhjyxinixvHaHmJKPgP
         DasXUQQCY/I9oEI2KjSGenR9hyqEQIl+aHliVZLmmOReAgpIBH/7ZCGel+ScjHrWHVfx
         2kcMoNQDPlFtfHekTfBIrvXZFPbzXSZflg7XDyHduRvUHRPSav6u6CxikDZZYdDk8qEr
         yUeFMfCXNLu1BorZzGt3Q7Jrd9USEOLi2Wnp2DkhjN6U25VhHgdQXbX8t58Gc0i/qj41
         Oqie0I/v8Ek5F4nMwF2yNmUDe7FG/Bez3MgkITb48/0AKsJV1H4AECdQMASGAmqQLG+r
         TuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCMNSM2YWU7OdfPY0KDWK/UsBJTsJh3PQ6XKci9NR5g=;
        b=cMwV5Wfj+cZxwbSz+gULOlg2KRIO+Ik+Bx08B0ZR+mtgBk4O2+HvpRSNVk3npl1Fyu
         3OZjRHFXw7m68Wtq1fB3sfh2/GCPT9Gz5iTDii1d4ZZv4aUzmOM2oi1CxggZqWZHexmm
         lzmuXkL4EaSlFD0+Eye86tFTzJeJTTIoYlv5YPpJJouPymyH/nVwa/BjiM0GfG9+8C0u
         gbif7frcf/N3uFUuq5X5E0oUrl3RjDEvQxyaTT3+Tz7UkdJG984M2jCrlbemq3sm2q+c
         Za4Jiby+DFuMtnTzB9HGcV/ObsPpOp5gclhWH5XTaufBzC34MR/STJRKoEuvwYHXp5zD
         JRZw==
X-Gm-Message-State: APjAAAX+OR0LwEIVkBMmC3312e8sIKckfCODo2p2vzbohMEc+8bz+iqx
        2W5PNLT8VHoyTfO5ML4/0flwrumW+qtR+uxDv0I=
X-Google-Smtp-Source: APXvYqxNrNWCLL6w3pQ5BzobULESjpTm7i7g5N84Rx1bsmE2KzfIyPXehRvkcqQHNfZoTcUWO1vcPnX8xEewxJ27ZJ0=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr21855651pjq.132.1578908841355;
 Mon, 13 Jan 2020 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20191230083044.11582-1-jian-hong@endlessm.com>
 <CAD8Lp45Le=s=1Q9oi0JCJTPepNmX002hK7W6UwKztTq09QBUgw@mail.gmail.com> <CAD8Lp44Vd6Moi+UmbdZDsQx-e_CHoHbgtZHpf8sV_yuHwzRrBA@mail.gmail.com>
In-Reply-To: <CAD8Lp44Vd6Moi+UmbdZDsQx-e_CHoHbgtZHpf8sV_yuHwzRrBA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jan 2020 11:47:12 +0200
Message-ID: <CAHp75VcPuhRJ8q4x7UUrJV5AMEGV2iMm6_KrVaH8+GtE3AjaOQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Fix keyboard brightness cannot be
 set to 0
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nweibley@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 5:47 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Tue, Dec 31, 2019 at 2:53 PM Daniel Drake <drake@endlessm.com> wrote:
> > Here, writing 0x80 to turn off the keyboard LED will result in an
> > additional WRAM(0x9f0, 0) call that was not there before. I think we
> > should double check this detail.
> >
> > Let's see if we can borrow one of the affected models and double check
> > this patch there before proceeding. I'll follow up internally.
>
> Asus were unable to find a product sample with the affected behaviour.
> They did provide us with one from the list I had made, but with a
> newer BIOS version where that behaviour has been eliminated. They also
> advised that always setting bit 7 is the way they do it on Windows. So
> I don't think we have the opportunity for extra verification, but it
> should be safe.
>

> Reviewed-by: Daniel Drake <drake@endlessm.com>

Thank you, Daniel! I'll queue it soon to my tree.

-- 
With Best Regards,
Andy Shevchenko
