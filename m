Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79808C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C63921556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2RHZfPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCEIoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:44:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38449 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCEIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:44:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so5111763ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbdyI132YwoclqRAqQFcdVx80Hpq+rOO83F3M2/coUY=;
        b=M2RHZfPPLjF7FpMQLcCbqr8EN9g6Ic3+vH8uz+umLS+RFof6hkjjSGWTRM6jNNndox
         k6DtkldAR/CFy6cPpqVUsaG5ysOvTdmV7xhr9qA9AOwkMQXVfMLnhkq0azy7efyPI+aS
         4qvbMDOoeAen2vmmUdCuD6AsTPljasQC9vX32+eqQCBMytLYsMIKUzY+wwBi6asEtwH2
         xVmjHtapMbyBHpM3bGAW48hfzKoqNSC7wyVR6U/+RZMWp9vtaHXNEHufluU0DVURs3tI
         W+N/AWsbjr/pRCMw/XP/p0QATrMAgRglWks0u8wK+Dm4YFWcWgccy753zPXixcUkMkKf
         kfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbdyI132YwoclqRAqQFcdVx80Hpq+rOO83F3M2/coUY=;
        b=Cx7KoqhZhUBcxVG4lz6lZDX+o5EmuPyiwE3elGjI7QHjVF+vpDWZFXICJN+dD7U3M3
         Fzl6BEoXktYkvTTmCwinPS/OQMoQHvMB+CpkB2YB3XiVcka9JKCkS2D6zZIKkKpOD5NA
         fIbuKEhhs61kx6PdGJumb2wEN/W9KaFnMOlQyH0EwyMAh1KpDqixjEAULc0vFTvU5sm4
         scmMOo+mpP4IBkCCdy8FbkYtCY+D0E3a9IUAiK01L1NPNHM+m3+wUY3In0/xeMu9jJ/j
         gi9gBcIgEIw3aD1wB0YUdYOx+zP0tCvb4MriBcLgD1jFdyBntjuuhJ/5WUbkzxL4NzdG
         ivsg==
X-Gm-Message-State: ANhLgQ1WMZKaHt3euVRdQf+KETUH57SfrN0YzZeaMKJbeFDrxZMRIX9H
        kMdmF5g01ubjQw1lczQ7uh/enIfUpeax4r8yTTvJ8g==
X-Google-Smtp-Source: ADFU+vvRFk8g3wXnA/A8ma/dUQb4x8dS4Zxl9FCH95G0Ve3S38UAd/rE7NSBOFGF0YuUMSSw1xX1W7Ho7mX9olGU4y8=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr4675395ljo.39.1583397839207;
 Thu, 05 Mar 2020 00:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <20191114181243.q37rxoo3seds6oxy@pengutronix.de>
 <7322163f-e08e-a6b7-b143-e9d59917ee5b@gmail.com> <20191115070842.2x7psp243nfo76co@pengutronix.de>
 <20191115114416.ba6lmwb7q4gmepzc@pengutronix.de> <60bda4a9-f4f8-3641-2612-17fab3173b29@gmail.com>
 <CACRpkdYJR3gQCb4WXwF4tGzk+tT7jMcV9=nDK0PFkeh+0G11bA@mail.gmail.com> <2639dfb0-9e48-cc0f-27e5-34308f790293@gmail.com>
In-Reply-To: <2639dfb0-9e48-cc0f-27e5-34308f790293@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Mar 2020 09:43:48 +0100
Message-ID: <CACRpkdZ8JA=DXOxzYwyvBxCMd2Q5uzLTn87AVK7wdrxHFo5ydQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        drjones@redhat.com, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>, philip@cog.systems,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, Jan 17, 2020 at 8:55 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> Let me submit and rebase v7 get the auto builders some days to see if it
> exposes a new build issue and then we toss it to RMK's patch tracker and
> fix bugs from there?

Sorry for hammering, can we get some initial patches going into
Russell's patch tracker here? I can sign them off and put them in
if you don't have time.

Thanks,
Linus Walleij
