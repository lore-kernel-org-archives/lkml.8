Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C10206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgG0Pfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:35:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgG0Pfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:35:31 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MD9Gh-1k97ia2Nij-0095Zf for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 17:35:29 +0200
Received: by mail-qk1-f170.google.com with SMTP id g26so15645170qka.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:35:29 -0700 (PDT)
X-Gm-Message-State: AOAM532WVumWIFn8JG9R6iY/W1j6mf1qRQb5Yz0ZbD8qUA11k5VFe7G8
        WjQnECL96fHnRa3Y3d8Pm3ZSE+KzvnhpK9WJX2c=
X-Google-Smtp-Source: ABdhPJyVQdveqzi3+Zb7UJcBadCVqyMgS/2llv9C5krFaKnCxaCdt2m5GnZ6CZHjLDH5JnzHZKBsLh1LbsXT3UyAjOs=
X-Received: by 2002:a37:b484:: with SMTP id d126mr23352046qkf.394.1595864128427;
 Mon, 27 Jul 2020 08:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200727151537.315023-1-yepeilin.cs@gmail.com>
In-Reply-To: <20200727151537.315023-1-yepeilin.cs@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 17:35:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3zz-xfz2jwUpEU5R7GyCK735PFQK7OjFmmTESgnSzq=Q@mail.gmail.com>
Message-ID: <CAK8P3a3zz-xfz2jwUpEU5R7GyCK735PFQK7OjFmmTESgnSzq=Q@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] firewire: Prevent kernel-infoleak
 in ioctl_get_info()
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux1394-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zbOxuSIsI5mjZrgdzMRoJRr329VZYfnzrW3OumMbzpug6f2xYra
 5lDDoU8xEj67l5752hoIPmaQSEVrMvI0T5D+LX1ZLixjUdpW0GyrmpGqNzpgm334sY3B0i/
 hcy5Cuu8T26rdwyS0/Bho4YE2vyTdkZ6XhWrl7FIGhlbHBamAd1HDHfLLoprTzvtaS5xPZV
 SgjEbgnGtR1qXBTD+M64g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ezjon7aq/c=:PkUl8pQ6sR4wL1bXY6sbnl
 c/K7G2fjj2WhgpX3X8PAxNakJr59x+oXR6a8O/DthBSznPDxkmHiJzwfGQ2546WyJFCsGyCtL
 akQy8dz0Hqp9EQxWrEZcnU1CwSBRTlQhqfMbSJpvSovBtodJ04J5oLPlKUwqV5VmBDeqJmdpu
 l/pabICFLIsBHSHPq6Ry80+sh3rWBVB/WInhWHBp6jnqlcyj/1SxEYJf9sQNEB+FAncIiEP/V
 YaHe/KnGCHUrNxVSC/fXEvUqp9OjPwNqAV4VAAVT5B3dy6fNlfgYA75QnDuGK5EdbA7BbBrtZ
 dbLP6NG08xkHXAmotVSlbieySW4FPEov0Zk87tjlz3Uo8snNkD1qVl+EUex96KqIY3dGduPsd
 B6oxtP8CNpx58/DaYptvgdIKezUgxqmPS6LxFYtvAeucUAYWnnd/Ow7U4CEdvMytIKyZPqgnk
 fHCgiUuQIap7/cTU2EPeIEYL8PqFp+SUplao6zintP1O1oaMbHqvM6luCqGnTxdWjCaGi8vd9
 k2hmZd+U0PkOrcbEsMPmRG10KQdwvjeYJkS+vR89Rcc5H06TUqaRrJd8zEKrWO3Rck3TDcJcN
 9HjKOJMgdmv1u9vvad5EZsXCBPJW1Ig9V6uDL15J6czPUuM1OxNPkvytPvBib/kUwmDtr9USi
 baNp79RRb1IZMdZMkPRCc7/LcdIFFOjWuOThrGPUVCi6vUAgZzTj31IQBWMkRJHUEYXJi63vM
 0Z5/g0/GpHVdfRvB29y7YfcZIH52ZQKBriwYm5Pa3GXVozzRQPSWHKLpxnjBLYr08s4I3nTxw
 Wrz6rnzZeT/ZW4QNfgwmfmGICaSxtNTtlqba2uBESzJ3kq6ZmTmdLfOYUTzPZx7cDgvmPwqYE
 slffCg3o3JJwogDrRczjpLHMw6Rn6xev5e4v1E8OWeMszfilsp8VVD8bPFGXg3Z8aQExt/YZB
 su+8+Qsg8mAo39hkZg4UFamGUUoynt15K8q8F85EFvZETCXL5PoNX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 5:18 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> ioctl_get_info() is copying uninitialized stack memory to userspace due to
> the compiler not initializing holes in statically allocated structures.
> Fix it by initializing `event` using memset() in fill_bus_reset_event().
>
> Cc: stable@vger.kernel.org
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I would recommend always looking through the git history of the
file to come up with an appropriate 'Fixes' tag. In this case

$ git log -p --follow drivers/firewire/core-cdev.c

searching for any mention of fill_bus_reset_event leads you to
commit 344bbc4de14e.

In my ~/.gitconfig I have this alias:

[core]
        abbrev = 12
[alias]
        fixes = show --format='Fixes: %h (\"%s\")' -s

With something like that, calling 'git fixes 344bbc4de14e' produces
the line to copy:

Fixes: 344bbc4de14e ("firewire: Generalize get_config_rom to get_info.")

     Arnd

> ---
>  drivers/firewire/core-cdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index fb6c651214f3..2341d762df5b 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -340,6 +340,8 @@ static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
>  {
>         struct fw_card *card = client->device->card;
>
> +       memset(event, 0, sizeof(*event));
> +
>         spin_lock_irq(&card->lock);
>
>         event->closure       = client->bus_reset_closure;
> --
> 2.25.1
>
