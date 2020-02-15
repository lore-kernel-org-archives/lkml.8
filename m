Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EFC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 07:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A5920718
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 07:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO1+UJHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgBOHGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 02:06:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45193 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgBOHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 02:06:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so11771035oic.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N39DpKb1zbYGk+aZJAg5ol/qxHEEKsb4pngbw2grk9s=;
        b=eO1+UJHmEcsV312SYhyJA6ak1KgsL1IbKBC7k9lGGUS0lBeBXhmo3YzawaHWqAWyZ8
         lo8ZMI9LO1z5FQyujtSwxlkfO6OhBVAupZvzFT8DkFENJZSpAH3NQqSGkd0vNsxLJ0si
         fR6kzV4L18SUTUbIeA9ftt2ou9EIFAQQhpX3CR3HY1kp0iOHGYH2ZoZeCvmS2BRDAv9/
         fJrD/Twt6Odo36Y1Vq08UPJGR1yXvwX5MJsS5PupJ+7aCl/TwrT7ndyuPtrqNjADNJBS
         +yWBrd23XHbuOYXxdzD23HQBmSagx3bIq1jvzbO7lOmD4YkQ/TcJs5RYE7SkqJxUVdug
         kQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N39DpKb1zbYGk+aZJAg5ol/qxHEEKsb4pngbw2grk9s=;
        b=h3HeVQy4VgbcXB1wAhrP4EDcQGe8/hy8KuYMZH13vYolZQyFMAQB3agqWV0bVpM5zF
         IYeIQz75cE+ntr3Av8LOzoQyD40lP4lIENEnEwoUytOldqcr3cXvqLXukkFa+FPiCMcc
         Q8KlhMh7vgVeY+nMZTAfZ5RI/O7mEHuqSGbOKIfkEMu445RihaYqxxcXmXkX653PcfQR
         UOhGdKZiPcBP1jYeRjJGutpt3z3PT4TEEjmH6P0LnFCnVuq+LbXsXgTx0+zrQ7o5PHFc
         WdVxhdiqLxFU6I1yRsIuYE4Tbzct+s6T1FwbIfHVh7QW5GTcVxORO12lpPD/P/Zv9t3O
         VuxQ==
X-Gm-Message-State: APjAAAV+d8NUZ06e7AAnbEWiInt7rcgdOtKfHHPDXBgHrIjfO1qWv5Rv
        1Lxdx1ov0sqR6WDIEf/T6/ElWUhr0fBPis/l/XU=
X-Google-Smtp-Source: APXvYqwhjU5dgKNQUhaU81ajtzZqAULg8B7LoPW3kj8BrNcj9xvKsmTDYAJmCamWkh8NnkFhEtNK/Sac+2BzYkL9izs=
X-Received: by 2002:aca:bc0a:: with SMTP id m10mr4335479oif.77.1581750376487;
 Fri, 14 Feb 2020 23:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20200208084022.193231-1-gch981213@gmail.com>
In-Reply-To: <20200208084022.193231-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 15 Feb 2020 15:06:05 +0800
Message-ID: <CAJsYDVJ9JGGpDm-FWvqDsS_ffwQ4FzY_cbVFpnEKt6B_Ab=TMQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: mtk-quadspi: add support for DMA reading
To:     linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Sat, Feb 8, 2020 at 4:41 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> PIO reading mode on this controller is pretty inefficient
> (one cmd+addr+dummy sequence reads only one byte)
> This patch adds support for reading using DMA mode which increases
> reading speed from 1MB/s to 4MB/s
>
> DMA busy checking is implemented with readl_poll_timeout because
> I don't have access to IRQ-related docs. The speed increment comes
> from those saved cmd+addr+dummy clocks.
>
> This controller requires that DMA source/destination address and
> reading length should be 16-byte aligned. We use a bounce buffer if
> one of them is not aligned, read more than what we need, and copy
> data from corresponding buffer offset.
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

This patch is deprecated. I wrote a new spi-mem driver for this
controller:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=158701
and will be focus on getting that one merged instead.
-- 
Regards,
Chuanhong Guo
