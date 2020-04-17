Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A44C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B093420780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMBCf9rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgDQLvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730410AbgDQLvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:51:43 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF35C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:51:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v24so549028uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOHFM9elPBqZ53StmEbbuJGOBdc8SihR2GSmdzRs9uY=;
        b=fMBCf9rOwilC1Z6Zixv2jAkeDoBbxoQeuGNlsPNTLbDswvHwzz7iLxOphekUuKVqeF
         Qn0ggF1zoOm+Or2djEeeJGzuDDFRF7v1IClvr+VYsYw0IMCAkP04EfKMZRjblTi3rOJ7
         wYWU51MpN6ZElokLiqRmQN7mHlbC890Dl+mpo8TLTrcZzqyDcx4wjqHcSd2SApybyb8Q
         7Bewaw/qrHUFuEXg5kdULw5Dfr6ub2RuVOD6TU8NZyzuo02/mjevhpdMd53w6KaIvMFE
         MOXrJDBF6/Es0NfS4DM1SdeFWa+bj4mz/t//QzlwvAiUPZiGZkQlwsDIpD4Yc5vwJllI
         CzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOHFM9elPBqZ53StmEbbuJGOBdc8SihR2GSmdzRs9uY=;
        b=ZbJvxOKUnQqouH+EnUIcaNnTpYRHRcrGBdzhrbPeQef+MayOomfhbkfAcjB91cYmqD
         oFGE3PcuRTsdpVpScpAu+1e4FVUv1Adyaad3r2SUVk+ob5jWlvWN/hAgdXIfC536yRQo
         wAgHGXpAF1bTf+PXE3oVzEnoxS1I84H+fH58QL+qnRlg6RNXLZYggZlov1jODX59bj0i
         xfMRA3P4x4WKr+L2rgpIAl1EGBfbsKUuVL2aLyMKietx6QyuXDFwCi1PppJFg2roeq6j
         c3fGm2l7PWjVAgazP2kN1sfsWiIwSFP/VKOXWW+dMnh5TrIcsb5gA2si+4Po0n6VaQYO
         1uOA==
X-Gm-Message-State: AGi0Pua2k1JIbtmKcut22ptIc06a2opVvnm6glxlZ3XXlvBFPUum5aAm
        kJMIPep+MGgWC2J5Y3k4bhXccUp+ymbvDKdeDjUUfOL5z0k=
X-Google-Smtp-Source: APiQypJptyO3Q188LiC+lVglCDgxEqyyiuLnTQxJkuIYhQNrcbVh5T9dEoPww3VYf1pU7et5uyG7m7wgsnLScU++FZU=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr2012699uap.19.1587124302013;
 Fri, 17 Apr 2020 04:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200331183844.30488-1-ulf.hansson@linaro.org>
In-Reply-To: <20200331183844.30488-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:51:06 +0200
Message-ID: <CAPDyKFoVMBFTRJbEi-bjzeeMgi+z5xsBpBYteF=duCMb0Zxdhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] amba/platform: Initialize dma_parms at the bus level
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Greg, Arnd, Linus, etc,

On Tue, 31 Mar 2020 at 20:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's currently the amba/platform driver's responsibility to initialize the
> pointer, dma_parms, for its corresponding struct device. The benefit with this
> approach allows us to avoid the initialization and to not waste memory for the
> struct device_dma_parameters, as this can be decided on a case by case basis.
>
> However, it has turned out that this approach is not very practical. Not only
> does it lead to open coding, but also to real errors. In principle callers of
> dma_set_max_seg_size() doesn't check the error code, but just assumes it
> succeeds.
>
> For these reasons, this series initializes the dma_parms from the amba/platform
> bus at the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().
>
> If it turns out that this is an acceptable solution, we probably also want the
> changes for stable, but I am not sure if it applies without conflicts.
>
> The series is based on v5.6.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (2):
>   driver core: platform: Initialize dma_parms for platform devices
>   amba: Initialize dma_parms for amba devices
>
>  drivers/amba/bus.c              | 1 +
>  drivers/base/platform.c         | 2 ++
>  include/linux/amba/bus.h        | 1 +
>  include/linux/platform_device.h | 1 +
>  4 files changed, 5 insertions(+)
>
> --
> 2.20.1
>

Does this look okay or is there anything you would like me to change?

Kind regards
Uffe
