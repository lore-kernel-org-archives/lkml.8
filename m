Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEAAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8576208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 13:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9PbwoXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGDNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGDNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 09:33:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C25C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 06:33:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id r22so31048481qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qqa3e0bH9mYWgsFgBgRPrZcm1aqLiNbt8ATgIenPMgs=;
        b=Z9PbwoXQxnnRcbB2IxgjzSX8hyAmzVJHbf7vjs2Fq6fi4lrcmPjLlMegsugP6dZxNC
         5rmvFHFE0gFX6O52eMyIC50fBuymdhhovTnB8aArn34R2pNtZbW5Xx2KP2YiLgzHYTU9
         6AoOO7sYhcI7UzwyX+mkghjrN4KyPAxUVNwkXyFEQZCM4HurhUCTTluaooXtaHo2dPTP
         rrbrC/ZWIiy1jX3KXyxQmkg2iM6pMvgyva+DHG6GExtKFdAZBBZOCrNnRO5LZeVqtt0i
         sI9S/MxPXP/vEZKnVOMoh1xeUW3jz4S90OlUalNFT6E0RtHpWvg/k7jKZPm4Uu6Ke+8T
         z0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qqa3e0bH9mYWgsFgBgRPrZcm1aqLiNbt8ATgIenPMgs=;
        b=LwMePPHaeeAj1jCNCaWu2L7hTwt4hcP1XE8biuwa1AKAKIY1SU2HPpcF/W2ALZWcky
         QQmpBhiwZG+rs0hfwgaidyCGiWsU+oTv6AFaRn8Z+ZU5lbFZ27YJo1P26opfz2DUj59c
         1AcJX0XIb81zH9bg3XaTuEoIPZ19m4RrVlqdGlWyNmu3YVr+kxj/as213/m8gsr/3qIl
         kX1r1cvZ7ebWZ38BlDISySErHrhdC3m3XGe+DcVJ5vGHCxEFzU4Xwof0lPGNfMwLgEW5
         Q1KjlYzGj7JL4+sVxOvI6SuH1KKvq0S7LncHdhl3XWIxMrkWA/xf5muhRLYHBD2cq6WK
         gJoQ==
X-Gm-Message-State: AOAM533OphXqkYQnt0tcmLKb6MGYZuafWNHtyP3aUIGSivuOjl/2uxq8
        wWxBP+pzG2a2otm5Mob69zEIFTERS/kb5xxVU+NU+pxDr/XsrA==
X-Google-Smtp-Source: ABdhPJxsVNgyvpEzLtrpYL3cJRFl3j1H0kWbDB5FAaI7z4yY0OXzToum3fNGr7IUFUfwur1RGEhNAPIbT8OrKO/cxXA=
X-Received: by 2002:a05:620a:2155:: with SMTP id m21mr29324016qkm.14.1593869598572;
 Sat, 04 Jul 2020 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200704122222.GB15530@amd>
In-Reply-To: <20200704122222.GB15530@amd>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sat, 4 Jul 2020 21:34:36 +0800
Message-ID: <CAAvDm6bjTzcRXs0qMF2nTo_mfEDE1MYbh_ExMojOMNZ9H+iKVg@mail.gmail.com>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Cc:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking the time to respond to me.

>These machines are still mostly IBM-PC compatible, so it is likely to
>somehow work. You'll likely get worse power and thermal
>management. Try it.
It's an industrial personal computer with an Intel processor.
What I am worried about is that it may damage the hardware.

Thank you for your attention to this matter.
Best Regards.

Pavel Machek <pavel@ucw.cz> =E4=BA=8E2020=E5=B9=B47=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8B=E5=8D=888:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> > Are there some potentially serious problems that I should be aware of
> > if I totally disable the CONFIG_ACPI option on the X86_64 platform?
> >
> > Would it do harm to the hardware?
> >
> > Thank you for your attention to this matter.
>
> These machines are still mostly IBM-PC compatible, so it is likely to
> somehow work. You'll likely get worse power and thermal
> management. Try it.
>
>                                                                         P=
avel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
