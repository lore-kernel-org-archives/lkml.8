Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8263A2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylyyWluJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbgE1KOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgE1KOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:14:38 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A15C08C5C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:14:38 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id z3so6603499vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CX+u123nVjVuRZW6zRvLQzHDlGFq6dyKso1AdFfB1VU=;
        b=ylyyWluJV1udCPHKbUpBa9gzteEE9rpam5yb+9Qo5ZwIaIvYSKHGX3rwW8Qu1yRVbs
         s71Mhpbn4QTKCa9jPCBH3htvR2tWok5/1SRIeN1hxVVWT5gP564EBK2f09DGMHTsm88k
         E/1/Mm9s9RRLFrSj/olPzuvMcy35QUUaEA3viA62YTJSswW4ihcjUcj0j3CqjQk1t0Tw
         fOD6/+BDIpMYgME2I6zR07nY/c/eQBKM+cPSdHE+aeP51ba14fhxbL0ogMP3G7O7Ngvi
         MEJknki2sFvjerUF1dfNz5OXK1ad6hNSCiQ1ajt5pWLA71kvbSH7LxLetwkAl3aAifv+
         ZtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CX+u123nVjVuRZW6zRvLQzHDlGFq6dyKso1AdFfB1VU=;
        b=ZUOUM4jsaDf7sqUNLhgDEzqSZ6W/dJWQoVi1WDDLjlQvGlP1z4gwancB0sfDFaZEY0
         LNhhf5qaY3Pr3vZUcWMSnFl9bV+VgWWtkH0vWoE+mh0UjFjTOWfuE+f92ToW4I52lDhq
         P8ykLqblr2wN2gY/GtJ2B+6Oc+TJftpr+ax3AfrsVsyVUKbYOKwq8HhL9PJN+F5PRgnl
         FLDhUcHxiWfOA/6HDh1BfkrOlbof7LtiAsd1WL0cWhZwE7K7L7LsZ2+mRIoH9NqmGYiH
         /gIXFjzuWk0kQVomqnox0oVYCsmrhLeyRa2YcX0llTq9xvzDq5Q4vO/+p4OqNnFH7Svm
         xIEg==
X-Gm-Message-State: AOAM5329FdiMg2mhGWiE+OMkcoGBwVdObk3kEBhAbn/T9QdAtpad0rkl
        zib5WYv+bIMiFr1NYQA0liVpc425xBz4VNiqmqWWDg==
X-Google-Smtp-Source: ABdhPJzK0sB7xaJ5Xvcd9jk++euAwMqH3Mxp+8vmK46elIBGi117Z0Erqx3b1G/MIRgbK/NHLsfYjW544ZgBjhty6p4=
X-Received: by 2002:a1f:fc06:: with SMTP id a6mr1441822vki.101.1590660877077;
 Thu, 28 May 2020 03:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200522144412.19712-1-pali@kernel.org> <CAPDyKFqwrtJy2Ss0_KcBtpGP78d_BePTGJp01KtfuOaQqiwiHg@mail.gmail.com>
In-Reply-To: <CAPDyKFqwrtJy2Ss0_KcBtpGP78d_BePTGJp01KtfuOaQqiwiHg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:13:59 +0200
Message-ID: <CAPDyKFrT0bp+HHPZemFEVjhNXbWB_P2NWQxVU43rexzdYB3reg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: sdio: Move SDIO IDs from drivers to common
 include file
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 at 09:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 16:45, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >
> > Most SDIO IDs are defined in the common include file linux/mmc/sdio_ids=
.h.
> > But some drivers define IDs locally or do not use existing macros from =
the
> > common include file.
> >
> > This patch series fixes above inconsistency. It defines missing macro n=
ames
> > and moves all remaining SDIO IDs from drivers to the common include fil=
e.
> > Also some macro names are changed to follow existing naming conventions=
.
>
> Thanks - a nice cleanup!
>
> I guess this is best queued via my mmc tree, unless bluetooth/wireless
> maintainers think there are some problems with that. I will wait for
> an ack from them before applying.

It's getting late for v5.8, so I decided to queue this up as it's
rather trivial changes. If anyone has an objection, please let me
know.

Thanks!

Kind regards
Uffe


>
> Kind regards
> Uffe
>
> >
> > Pali Roh=C3=A1r (11):
> >   mmc: sdio: Fix macro name for Marvell device with ID 0x9134
> >   mmc: sdio: Change macro names for Marvell 8688 modules
> >   mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
> >   mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
> >   mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
> >   mmc: sdio: Move SDIO IDs from smssdio driver to common include file
> >   mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
> >   mmc: sdio: Move SDIO IDs from ath10k driver to common include file
> >   mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
> >   mmc: sdio: Fix Cypress SDIO IDs macros in common include file
> >   mmc: sdio: Sort all SDIO IDs in common include file
> >
> >  drivers/bluetooth/btmrvl_sdio.c               | 18 ++--
> >  drivers/bluetooth/btmtksdio.c                 |  4 +-
> >  drivers/media/mmc/siano/smssdio.c             | 10 +-
> >  drivers/mmc/core/quirks.h                     |  2 +-
> >  drivers/net/wireless/ath/ath10k/sdio.c        | 25 ++---
> >  drivers/net/wireless/ath/ath10k/sdio.h        |  8 --
> >  drivers/net/wireless/ath/ath6kl/hif.h         |  6 --
> >  drivers/net/wireless/ath/ath6kl/sdio.c        | 17 ++--
> >  drivers/net/wireless/broadcom/b43/sdio.c      |  4 +-
> >  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  6 +-
> >  .../broadcom/brcm80211/brcmfmac/sdio.c        |  4 +-
> >  .../net/wireless/marvell/libertas/if_sdio.c   |  2 +-
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 38 ++------
> >  include/linux/mmc/sdio_ids.h                  | 94 ++++++++++++++-----
> >  14 files changed, 120 insertions(+), 118 deletions(-)
> >
> > --
> > 2.20.1
> >
