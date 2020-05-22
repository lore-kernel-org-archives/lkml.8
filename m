Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0859C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D62A206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEVKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:32:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEVKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:32:42 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MJFpj-1jLujr2a3H-00KhZt for <linux-kernel@vger.kernel.org>; Fri, 22 May
 2020 12:32:40 +0200
Received: by mail-qt1-f182.google.com with SMTP id l1so7867219qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:32:40 -0700 (PDT)
X-Gm-Message-State: AOAM532SQFvQb5Npeooaj/NR2QiPmLkkotBG9MODvJkOCWwNzqOTNK3y
        uzzFI40i3uBgXkOPnwfF2+xtdqGv0pdHQX4otmI=
X-Google-Smtp-Source: ABdhPJx3hTz75T2uRAsIR+aHsu7gwQoqja1c5DNkOk1IRLuC7aeyHNKFyXWHA+1jIeu3+InnHhI/3Fa2HJxOhi6YbnU=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr14983624qtr.7.1590143559480;
 Fri, 22 May 2020 03:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn> <20200522091646.GA1201234@kroah.com>
In-Reply-To: <20200522091646.GA1201234@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 12:32:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
Message-ID: <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
Subject: Re: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mj5QO1v09rogAwkUgtqZF9liaU6XrO+Krpm3vvsxolto+Uj8tNO
 dLDxl1qcjFDlapRFg0HKsFhmZFI5VMsAID1ZoYqleY98VgOkjwIhSMiKIQUyTu3eJnuInsn
 vu6t7XYVtn6nM8PIR/aXx/ESBor7JsixKbfk570cPcx8pm3+fQkdD4Vm4+LD7d7qmF5wyb8
 lUdiAXc7lmyxtSIF5lx0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jz+blxUtmQU=:cB2SKbLKX2vITmd6yx/non
 vK9Wcca3pdE+6b85rhkaw0ZRGmU8tTdo1R22W1dqY4bmgJnYCoxGuE4p7b5JwCe2H7tQgRikJ
 78Oqd6G7p5vOmZQVNj6THOVoYbag3cXKsWDI9MIsIB/weRYNOJAEbuvS0CuOW2zPSXlmmtemv
 Cb0RZFEOLsCNb3HkLP7IFqRNh++y3t+STZCqDJ/uHpjTED38DJ9juRnwHcg7jzxOoRbiaJMb2
 9z3qfPGPcT9pE++wNQuYfyBtZtI6lwVIyWTI9qyYzyHDgq/k/9aVZnKNH4i26cmJgddwh42Cd
 uEX9EpatoSTJl9tF1iSrlGvIXGlJPFn2/oqXtY6YpNUkrbhXvqqL+XPUKvc6raC3Owk3w6b8W
 tBRS/YqQAOrSSdJCcOP9hjuRg7hFZSYditOODcaj/sGmW3KfEG38xNQzAefRi4aqT1cc4bwho
 SoXoQXuNamqvAtDqlTm2FRthyFmirFWmmFMK0bsA9qRwYR/pN2RyhfCvvgUAyeg12vSpjITVq
 wdqDDi4FgTDBwhXPXO1+R1sb2umltIZz+acUHJx9tqZUn9gSvP0lyia0a9HqEH2imNrj/Vntp
 //+2lFKlvjpP9/U6uzjgu/JEkoTihceXKMfIvWV+x7LiSyn1VA7xnDCQ/GPk8z9cQsDMufOtN
 Js6oRSSVGwlxrXhhq7D6m4Xuepl5zBEWuGuBNttNKheyrgyATjLSb3OZyNicvKa2IvXZY/fG3
 8LkgVUZXHLfzqf9x15REsu5vDRBmuT9IuestP45kd8+UoRAJRSIXOy3U9hebgnJCiOFwIu0SZ
 ngi2Y15p9zNJv6Shxl986XWFc+pDv3G4zJF7biiUU3ZvlKtQFo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 19, 2020 at 03:59:23PM +0800, rui_feng@realsil.com.cn wrote:
> > From: rui_feng <rui_feng@realsil.com.cn>
> >
> > RTS5261 support legacy SD mode and SD Express mode.
> > In SD7.x, SD association introduce SD Express as a new mode.
> > SD Express mode is distinguished by CMD8.
> > Therefore, CMD8 has new bit for SD Express.
> > SD Express is based on PCIe/NVMe.
> > RTS5261 uses CMD8 to switch to SD Express mode.
> >
> > Signed-off-by: rui_feng <rui_feng@realsil.com.cn>
> > ---
> > v2: remove config option MISC_RTSX_PCI_SD_EXPRESS
> > ---
> >
> >  drivers/misc/cardreader/rts5261.c  |  5 ++++
> >  drivers/misc/cardreader/rts5261.h  | 23 ----------------
> >  drivers/misc/cardreader/rtsx_pcr.c |  5 ++++
> >  drivers/mmc/core/sd_ops.c          |  9 ++++++-
> >  drivers/mmc/host/rtsx_pci_sdmmc.c  | 43 ++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h           |  1 +
> >  include/linux/rtsx_pci.h           | 27 +++++++++++++++++++
> >  7 files changed, 89 insertions(+), 24 deletions(-)
>
> If I can get an ack from the MMC maintainer, I can take this in my
> tree...
>
> {hint}

I think this feature needs much more discussion to make sure we
get a good user experience when it gets added to all mmc controllers.

rtsx is a bit of a special case for mmc controllers already, but we will
likely see the same requirements for a lot more mmc host drivers.

I suspect we need to tie in both the mmc block and nvme device
drivers to properly do a handover, to ensure that there is a way to
identify the block device as reliably getting probed as at least one
of the two (sd or nvme) and to get identified as the same device
during the handover, in particular across a suspend or hibernate
event.

I understand that this patch is very desirable for users, but let's
not rush it.

     Arnd
