Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA50C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCBC206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKxVLScN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgG1L72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgG1L70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:59:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C3AC0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:59:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so20399730ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tl/xK5nksFGek4I0hJhjtnSKtWmsm7mD8uEP3H8tAJc=;
        b=dKxVLScNmH+IxfLYOJHi2FyLa1HeUI2rsPJTmMupKBaQWimNey/qP3/d62lN/wRW/l
         eQ4lrfidDx/qDiuCsBs8jqw6PRXawqwMoVVC3s9ak2gMfUMN+L9SwWpIE/lgtTa/OWao
         ZE7kRtmQ9VEQjfKvpIUMjvlPOFlq1JqJQiEEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl/xK5nksFGek4I0hJhjtnSKtWmsm7mD8uEP3H8tAJc=;
        b=ayNVO+vKt8ky2FVH9aGbpYxLlrjeZ9c9DwZeR9fhAi8LuGLLVN9XFlSS1KCyDtcK0U
         f1h7fmkT3y0V3XZkLPcJGc0j2jLnrcEmN/oq+40eh/IMwJq2oUurr7VJIypP5mnzqnWQ
         lfJ8tDnLHYKz7YUnKS35z/FKJ4b6t5fFrAXvis0Ip+ye70DgjVS6TzG/AR4opyn5kCjK
         WIF9rKbTJIPx7ORFE4/cmnpojevcBUgc3Z6W9UWcD7hUsiQ/FDN2T2pItVeFRayYT2C9
         SMCgpQIOqxy4n+21hNKptCvZhZ+ULJAzY8MMt0G+Z/cFpCwLUV1mXMbvhMb/3vsmPmKo
         xPYw==
X-Gm-Message-State: AOAM53221QsxQLBIkGlkkmdqKMgFPMqV57/hxvrRjbq5wYAyAb/btbsg
        ouU7gCfGjkIVrw9Ek+50eGFMlOL7rBk=
X-Google-Smtp-Source: ABdhPJyK9IS7G0M7uNqroNfAWhGL7gX+NyJZw+3D1C/JLr3QzNJh6J2ipA81OdhbskVV10x/Um9dkQ==
X-Received: by 2002:a02:b106:: with SMTP id r6mr29478069jah.9.1595937565694;
        Tue, 28 Jul 2020 04:59:25 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id r15sm5846743ilq.16.2020.07.28.04.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 04:59:24 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id j8so8054250ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:59:23 -0700 (PDT)
X-Received: by 2002:a02:6947:: with SMTP id e68mr17279172jac.3.1595937563294;
 Tue, 28 Jul 2020 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org>
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 28 Jul 2020 19:59:12 +0800
X-Gmail-Original-Message-ID: <CALiNf28XXGpJ=hV-S3dLyq1U18_trr4e4rr6OPr5W5DxHD9XcA@mail.gmail.com>
Message-ID: <CALiNf28XXGpJ=hV-S3dLyq1U18_trr4e4rr6OPr5W5DxHD9XcA@mail.gmail.com>
Subject: Re: [RFC v2 0/5] Restricted DMA
To:     Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>
Cc:     treding@nvidia.com, Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Nicolas Boichat <drinkcat@chromium.org>, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that I didn't rebase the patchset properly. There are some
build test errors.
Sorry about that. Please kindly ignore those rebase issues. I'll fix
them in the next version.


On Tue, Jul 28, 2020 at 1:01 PM Claire Chang <tientzu@chromium.org> wrote:
>
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
>
> For example, we plan to use the PCI-e bus for Wi-Fi on one MTK platform and
> that PCI-e bus is not behind an IOMMU. As PCI-e, by design, gives the
> device full access to system memory, a vulnerability in the Wi-Fi firmware
> could easily escalate to a full system exploit (remote wifi exploits: [1a],
> [1b] that shows a full chain of exploits; [2], [3]).
>
> To mitigate the security concerns, we introduce restricted DMA. The
> restricted DMA is implemented by per-device swiotlb and coherent memory
> pools. The feature on its own provides a basic level of protection against
> the DMA overwriting buffer contents at unexpected times. However, to
> protect against general data leakage and system memory corruption, the
> system needs to provide a way to restrict the DMA to a predefined memory
> region (this is usually done at firmware level, e.g. in ATF on some ARM
> platforms).
>
> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
>
>
> Claire Chang (5):
>   swiotlb: Add io_tlb_mem struct
>   swiotlb: Add device swiotlb pool
>   swiotlb: Use device swiotlb pool if available
>   dt-bindings: of: Add plumbing for restricted DMA pool
>   of: Add plumbing for restricted DMA pool
>
>  .../reserved-memory/reserved-memory.txt       |  35 ++
>  drivers/iommu/intel/iommu.c                   |   8 +-
>  drivers/of/address.c                          |  39 ++
>  drivers/of/device.c                           |   3 +
>  drivers/of/of_private.h                       |   6 +
>  drivers/xen/swiotlb-xen.c                     |   4 +-
>  include/linux/device.h                        |   4 +
>  include/linux/dma-direct.h                    |   8 +-
>  include/linux/swiotlb.h                       |  49 +-
>  kernel/dma/direct.c                           |   8 +-
>  kernel/dma/swiotlb.c                          | 418 +++++++++++-------
>  11 files changed, 393 insertions(+), 189 deletions(-)
>
> --
> v1: https://lore.kernel.org/patchwork/cover/1271660/
> Changes in v2:
> - build on top of swiotlb
>
> 2.28.0.rc0.142.g3c755180ce-goog
>
