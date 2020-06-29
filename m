Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A0A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMQy1CXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbgF2VpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgF2Sho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:44 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81118C02F033
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:01:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q21so8255067otc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e77xl3a0rUVRcLQU1oC50Ds8tydYE4Dms5PHNqeAu/k=;
        b=XMQy1CXVlqSYhEurPprg8PGiPgE1Rib39cTW09WzQAffWwG7ga+mJUImPuQjU3hKBz
         aMiLQH+uoAR+QqXiAp7sDCqQr5VQgfujaZk/HxPsHQ7JWVFlBD9YOjNEm+KPNdPY1skY
         Xxgw8Lzy27lSZoIjcUaaMSZ5UJL7aK6dVQbrbBKi8z9t16Ir1bF/W+UCXVChiKMwnlVr
         pja+8G2+B0w9fCTjslr2a6pAc+tIpyLi2T0HkBtvPahOiKs0nUOFya8C5YPuohKNIija
         aS8Q7PqpakqtxX6a8KfLaVo8K1AGsc+9jZ4S0m/Wd/G5xXloS79fEavwA5t4Vjj11Fx+
         P9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e77xl3a0rUVRcLQU1oC50Ds8tydYE4Dms5PHNqeAu/k=;
        b=YhxriyKUHpDISbMtMUt6K3BKuDq6wph0LiPNUPuZBU7D7D+tN3joOerSDDWudRX+WZ
         J/WsbXL/fuzEckAHs+WWEOaXq2rSID29lB/ZvqxHk8oDAjSJXj7UDNriwM2i0p863TTa
         wRjPWsQzAkhKhr0UFVmGiA01RUKbA1v4xKTSOIDNMvCbhBIvC9BMSEVaK/FRRCeRAVXj
         xVNDRgAVvxQsKFbgnzNSlB9IgNWvnX9EFJyTZx2UtMLrW1dg93vkrpLDzi8w1/LCB/uy
         kRfGxDf/RXU1j0S63CDlxkVbiVM30KlcAfLmoi3gtUvkWY6C2tNE4KudrUG4uA2B2QL2
         MGUw==
X-Gm-Message-State: AOAM531BKxbPmendFzCoT8xwd/vBCx82lLhZJQSlsXOHykehgGeEhJG0
        JAvcxP/BdIY2R6n3I/j686dQAEXuO+ituB2luxs=
X-Google-Smtp-Source: ABdhPJxFZkCXG8p4u8jtirweZHRw3Zm3HpCOYXiTJk93I7XtfkyjfulYGVNkoX+Wbg3ThmFgvmNP5bQgChAlfrjYrN4=
X-Received: by 2002:a9d:6254:: with SMTP id i20mr13643292otk.145.1593442873894;
 Mon, 29 Jun 2020 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-8-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-8-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 18:00:45 +0300
Message-ID: <CAFCwf115Hm+Rf7r0bZmMbnGgz6jUm=ZK=Zvij_aD1WKEBUvOGw@mail.gmail.com>
Subject: Re: [PATCH 07/20] misc: habanalabs: pci: Scrub documentation for
 non-present function argument
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> 'dma_mask' is not passed directly into hl_pci_set_dma_mask() as
> an argument.  Instead, it is pulled from struct hl_device *hdev.
>
> Fixed the following W=1 warning:
>
>  drivers/misc/habanalabs/pci.c:328: warning: Excess function parameter 'dma_mask' description in 'hl_pci_set_dma_mask
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/pci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
> index 24073e8eb8df9..61a8bb07262cf 100644
> --- a/drivers/misc/habanalabs/pci.c
> +++ b/drivers/misc/habanalabs/pci.c
> @@ -317,7 +317,6 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
>  /**
>   * hl_pci_set_dma_mask() - Set DMA masks for the device.
>   * @hdev: Pointer to hl_device structure.
> - * @dma_mask: number of bits for the requested dma mask.
>   *
>   * This function sets the DMA masks (regular and consistent) for a specified
>   * value. If it doesn't succeed, it tries to set it to a fall-back value
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
