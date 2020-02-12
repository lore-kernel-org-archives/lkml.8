Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F20BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D59320661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgBLIpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:45:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgBLIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:45:23 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MeTkC-1jbxsT3Bxc-00aRVf for <linux-kernel@vger.kernel.org>; Wed, 12 Feb
 2020 09:45:21 +0100
Received: by mail-qt1-f181.google.com with SMTP id w47so1006266qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:45:21 -0800 (PST)
X-Gm-Message-State: APjAAAWZDsNYAMO9JWoL7ZxWUTgbF03wL97zE6AI1ETKgGn1GPDhlf0R
        eAGOc8yN9i89i0eFXvMCGsyNRZWEvTahxId0+UY=
X-Google-Smtp-Source: APXvYqyoiB7A3Z5YLF1Wd53jS5LTIXRFVCQ9olFobFpEFDhS8r385QfNMcHJIzO+HEvxYQEIiKZQU5rVVXj9rzffIH0=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr18306021qte.204.1581497120610;
 Wed, 12 Feb 2020 00:45:20 -0800 (PST)
MIME-Version: 1.0
References: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
 <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com> <6c931ed2-b03b-2e38-a10b-2d238e4b7a22@xilinx.com>
In-Reply-To: <6c931ed2-b03b-2e38-a10b-2d238e4b7a22@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 09:45:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3xxu1wFKdsAHfuy2vpLigbuPR878mq75hh8HR=Tg=7LA@mail.gmail.com>
Message-ID: <CAK8P3a3xxu1wFKdsAHfuy2vpLigbuPR878mq75hh8HR=Tg=7LA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Firoz Khan <firoz.khan@linaro.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rNqGHMEjq0UvwIEDTO1Ijp9rnzU/a+F58iTCsxtVF2RkSipmwUN
 xv4m+RAQe7Qr2HNYywbwHPJePDkaq9OXVjINbn9yCOIYOk8Kopb5HthS19a0heJMtckh4Ni
 CWEX4wXvN0Ws5RN22j4Uz6rQQzNXS2dm9LU/JjkaufyaCj7wfjg/8SEkvPx7LO7AKklqhA/
 m2L2E1sI6ZOt1oZRLt9sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I3GsEcsbuVY=:soUIOb8xaHVdalQWpanHIV
 agou2lApAnNHu6oYNaE8bDK2aj3CHEofuFyBp2z4Kawx0hRV2V/PfitR72rACVO1OOWksbGyh
 F1Qk5fPSx7rB+8CjufvchhX8hvm5mkcf9xNkBCCaib/xntMlEGvHp72ZoiNHt6BUW+VmeWidb
 LPPUc7gclWZ3M04P7cdNOpk7qaE5GS5I2u+jqCkgLOoh5bEHGZQdvxXEy+KdaVo6GTiBA9FTh
 r6VfBiJhhnbeweEcsJFBFyPiKlo+USmCe1nBAqSYltc3gG7wJ/8zvjJzwWnWilS0IfoM7czsv
 utpUxAJAsGjw/o+ATDSHtVXc8NSPrtK37imo2ZuEpaosEG6M5b/Akmc4TfODoI29uvBKcM9lF
 d3xdfj7QU9Fhd2doucORvvkgH1obOl/o2/zU2d3b7GDX230ApleIB8Be+SPrXINjiYE/BadUq
 OqB9BYDHSKob3lJaZ10741Cx9lOHJn7kvcPE7ZIq/sosFyTZuiN5CyCJmcIRp/zHg97SjwGz8
 +phgL3RQGjcJwLLbAcsyVRHkNuEIaQ8ydNNK0xz23TXNbae1exRh5clHy0i4xRnpX3QRzQ57h
 /KBtT0yaEvia56Nb7i7Z9CZdjAVjQMsrU2zrnWXFWSOYWs2AVycbQD4CcBP6m6Bd0RAch1ksL
 BuuSuaq6j6klXjqqgV8PcZJt7mdO71G247AzNYxXwWErylgoWzoauQDBh/dwBmIteZXt8arwG
 6ZkOi9H6RSVrw9bTEUHMWqM7CmF8ACyVnTuwNVqCo0OqvXTGLsk8gZbPFuSOaWTFmnusY/oy2
 uvh5VFU5Yhag0/95SsDFFTQvFOjN/TRgzPhxcg5YwfYx86YQm0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 12. 02. 20 9:38, Arnd Bergmann wrote:
> > On Wed, Feb 12, 2020 at 8:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> Generated files are also checked by sparse that's why add newline
> >> to remove sparse (C=1) warning:
> >> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> >> warning: no newline at end of file
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > The patch looks good, but if you don't mind respinning it, could respin
> > it to do the same thing for all architectures at once? I see that  some
> > already have it, but most don't.
>
> I have not a problem to do so. I expect that this can be taken via your
> tree that I can create only one patch. If this should go via
> architectures tree would be better to create separate one.

Yes, I can take that into the asm-generic tree, or maybe you can just send it
to Andrew Morton.

       Arnd
