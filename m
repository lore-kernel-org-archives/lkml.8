Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98BC20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgF3HcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:32:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgF3HcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:32:06 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jqAkO-0003Lf-CH
        for linux-kernel@vger.kernel.org; Tue, 30 Jun 2020 07:32:04 +0000
Received: by mail-oi1-f198.google.com with SMTP id 18so5483858ois.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e90/+4iquf4bsRpUW7KG7qb5zPqy3erpE91QO7pcqc=;
        b=barjiEnx1E2gQbuHSvqICxemKqgw8Sm4vULBU4bWrDnHE8lOOTPIz3rdMnsqm0/RJJ
         aS+Rrf03CIbJtmpPz0Xfuy0iJdW7+XWmlT/P7GfmjE+H7WWpmfAjLXMqXp5CJbI9Sdzd
         o6ucyK3rZ4PAaP2VymFhIDTQnAcwY4zT1jwvDIkH7skBz6HLGUCKmV4PcXgmeQwyXAu3
         hNCBxljy6g+2nkuLpiLh9xDIy1R0i8DWMNem0F+Sl6r/O7Wf9/SQfr/SwxkdXpvpgPTb
         /gVQp1Ckvdco/bVxs3TPbd4pdgNxpzqBJcBjrIo51cHyCEJbRB7TTu7UN6K4hS6mWVVB
         ETHw==
X-Gm-Message-State: AOAM533M+NEFqYthRWUOMZK4Gf60STBQX1dDBVImqibu2JaiYIE1AjxY
        n4pMwuxPZQP913DBoKO1KAtD39CGYbaCEmVkuLc800v2yYt64BHef4GBwGdahY+cj6p9LiYunH/
        Wn0n1vQB5dS2AT+gXGaNXgqa6SrQHecLgAPDCeAewb5TgrCADiLRXrRLBXA==
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr7387351oiy.139.1593502323394;
        Tue, 30 Jun 2020 00:32:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4MBpSJvuvgywq8t5PrqtCbKxzRmN0WXCifmMIybV7JAtO6jgJKdYKFA7CM/DWXsLhR93b3DeAR3NGRnwawE=
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr7387336oiy.139.1593502323155;
 Tue, 30 Jun 2020 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
In-Reply-To: <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 30 Jun 2020 15:31:52 +0800
Message-ID: <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Sun, Jian" <jian.sun@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Koba Ko,
>
> On 2020/6/15 11:19, Koba Ko wrote:
> > hi All,
> > I have a machine and there's only intel gpu.
> > the secureboot and vt-d is enabled in BIOS.
> > On the Ubuntu desktop, I do s2idle first and restart the machine.
> > The machine can't restart successfully, so I need to press the
> > power button to shutdown.
> > I tried  each of the following and the issue can't be triggered.
> > 1. disable secure boot in BIOS.
> > 2. intel_iommu=off.
> > 3. intel_iomm=igfx_off.
> > 4. nomodeset
> > 5. i915.modeset=0.
> >
> > After I investigate further, find inte_iommu keeps checking the status
> > of DMA_GSTS_TES.
> > During the procedure of restart, the driver would disable iommu
> > translation and
> > check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >
> > If you need more information, I can provide it.
>
> Do you mind telling what platform is it?
>
> Best regards,
> baolu
Hi Baolu,
Sorry, i missed your email.
I'm running on TGL.
My colleague has reported this on bugzilla.
Have tested your patch and it works fine.
https://bugzilla.kernel.org/show_bug.cgi?id=208363

Could you explain more about these patches!? Why do we need  a flag
for active iommu!?

Koba Ko
