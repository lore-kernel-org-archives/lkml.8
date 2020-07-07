Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B70C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F1E206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGD2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:28:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgGGD2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:28:14 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jseHD-0006Av-QU
        for linux-kernel@vger.kernel.org; Tue, 07 Jul 2020 03:28:11 +0000
Received: by mail-oo1-f69.google.com with SMTP id a24so12104379oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 20:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWJ62s8035AwMjPdpYDA6UZDbxEpjF3hLCFmfSbPnhw=;
        b=V3/QZj3W/zdgj0f98OmlItDCrrws5o10QqS584150iTgF+FljXAo2DXTvxSWmsTNfi
         ZqPfWKtpBr2CXI6vBvXLprMeXoLhIhnA8GiQhaOkc/NPAk9PH4aB6bZ/YfFEmFd5MmFt
         516Gq6n91tOt+nbExwMnhKi/D7YIiPmP7LgEYJRT5tP3Tdve+dxPosPC2uTjyraoHQ7w
         +/hFWcLFf4234pQBiexL8d98Eavd4vkk2gT2JuPGFr5us8F5qeTVwqmMBZrH1mN+AXW+
         YPZT+1CYfGyPCgHqnKLLe6m4P6r1OgyyYUU/sO7E9rif2gaY66Ak+tXZMYfnAbEdT+JL
         TtQA==
X-Gm-Message-State: AOAM530JXbLeI0Gyyij26tAzRsA0Fs3OPhxVoubqSqEJn09K+pomMM9E
        eyrKWzcTowd1kGBzyVrFQRtxu9HO9a63jRu10ruO04lc54SRRbpw10T8OeXyKpx5X6pGPvF51RF
        VyUKRV4ITAptiDABEcg111KtLN4fvtXHW6y7aoe5Z9rRlgvCZ8+U1h0Erdw==
X-Received: by 2002:aca:8ce:: with SMTP id 197mr1899322oii.17.1594092490693;
        Mon, 06 Jul 2020 20:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyna30yFOPxRyadhhJOflPmmw2do7BPAlij7cxa7CDYjzknGb8L/FQ83wtloVUjfR2pfguLS/roP/8gqlN5e2k=
X-Received: by 2002:aca:8ce:: with SMTP id 197mr1899310oii.17.1594092490392;
 Mon, 06 Jul 2020 20:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com> <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
 <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
In-Reply-To: <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 7 Jul 2020 11:27:59 +0800
Message-ID: <CAJB-X+Uo2yw+SC6X2sfDsG9YusyL9iJAuR0wG_L+KYtSkz=Cmg@mail.gmail.com>
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

Dear Baolu,
On Tue, Jun 30, 2020 at 3:52 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Koba,
>
> On 2020/6/30 15:31, Koba Ko wrote:
> > On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >>
> >> Hi Koba Ko,
> >>
> >> On 2020/6/15 11:19, Koba Ko wrote:
> >>> hi All,
> >>> I have a machine and there's only intel gpu.
> >>> the secureboot and vt-d is enabled in BIOS.
> >>> On the Ubuntu desktop, I do s2idle first and restart the machine.
> >>> The machine can't restart successfully, so I need to press the
> >>> power button to shutdown.
> >>> I tried  each of the following and the issue can't be triggered.
> >>> 1. disable secure boot in BIOS.
> >>> 2. intel_iommu=off.
> >>> 3. intel_iomm=igfx_off.
> >>> 4. nomodeset
> >>> 5. i915.modeset=0.
> >>>
> >>> After I investigate further, find inte_iommu keeps checking the status
> >>> of DMA_GSTS_TES.
> >>> During the procedure of restart, the driver would disable iommu
> >>> translation and
> >>> check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >>>
> >>> If you need more information, I can provide it.
> >>
> >> Do you mind telling what platform is it?
> >>
> >> Best regards,
> >> baolu
> > Hi Baolu,
> > Sorry, i missed your email.
> > I'm running on TGL.
> > My colleague has reported this on bugzilla.
> > Have tested your patch and it works fine.
> > https://bugzilla.kernel.org/show_bug.cgi?id=208363
> >
> > Could you explain more about these patches!? Why do we need  a flag
> > for active iommu!?
> >
>
> We're still investigating this issue. If we find out more, I'll let you
> know. Thanks a lot for the reporting.
>
> Best regards,
> baolu
>
Sorry for disturbing,
Do you have any updates for this issue?!
https://bugzilla.kernel.org/show_bug.cgi?id=208363

Koba KO
