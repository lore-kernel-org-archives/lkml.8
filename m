Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58606C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C29522269
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6kQ1xVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgF2Si6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgF2Sh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8ACC02F02E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:59:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n24so13534265otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+wiN6kC/DjgaNoRWNSnoT4CpuTTMIyv7NQFDoFlBYY=;
        b=D6kQ1xVxKVEpv5wF2Z/S1gababOOW1eDOPTD8K/TtYxAjmo/0/Xg1kYwKAZuyjDJCt
         7/x+zMqCST6RXF21CVSCbLvGsj6kRs7OC2+yamJF8rn1/CcNL1hCwOTIQIB0Esvp9mMb
         edTG8WQv4qdJOePha/AnDZMeF5yQn9uuc8wn+8QXUO2yaA05ia8HZI0NWzMxwYxR90Kj
         aNErLm4ODlry+IBH/gh/w2Vmh/fqHPSr7g2K2ZLAgqe9QJ7Ht7A01imSbRs5rwYHwX3m
         9XX56rlSBnCSNHKHdJDtwBmM/r91gaFCff4uxguWPYH3wjzK1ejs9ounvnWbBFGQDZNP
         guig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+wiN6kC/DjgaNoRWNSnoT4CpuTTMIyv7NQFDoFlBYY=;
        b=rAUh5J4iU7lnO8K8X+9jOmPCNiwA7qVsEnq10HFqLljHGwkAE27tC2cz/JOetpmNoI
         PVlyb7tgXeYmtjwr+FTPO7CM1ddKI9TwVKDktQVctsFuic6P28rOHrC7Q4VQ19HzNDKR
         6LWz3KZmVAkpL76b4RSyAIEsFujQ9eM46+1v4MzYmmeFZE8B0qi8bGTvOSIpNcFB/KBz
         YFoJHiXQ6c8PGuB+R4+UUGY8S9iNdT15f8c28JesbLa4puDidudp7CncN13MBedK1W5t
         lwZuBp8eiwHXMja0KwCiUzPWPxmM4XbiceaJIxbSkpod8+xIV0K2LgIaP+Rjl8WDyaKN
         fnOA==
X-Gm-Message-State: AOAM533FpRk1I2El5oz7uHkVJG44IL0gGRbt8Bw9h1v+nOo8J0omyHR3
        fPyWC6vk13sZ1I5l5dHMl3p0jC4wuS7y2gBx/YI=
X-Google-Smtp-Source: ABdhPJx4j8C3DCkyeK5VOvjJtskgAzLvJiWC+iG4z7sCB0UWpNf+3VfUm/fld1jO2tMOzSWysR5fus9BBTP+NINpGTA=
X-Received: by 2002:a4a:3054:: with SMTP id z20mr1309567ooz.77.1593442741473;
 Mon, 29 Jun 2020 07:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-5-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-5-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 17:58:33 +0300
Message-ID: <CAFCwf13tmWXVQvX_AaW=EXbhyODDQq1D+LD0wwqy-hx_fiTYbA@mail.gmail.com>
Subject: Re: [PATCH 04/20] misc: habanalabs: pci: Fix a variety of kerneldoc issues
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
> hl_pci_bars_map() has a miss-typed argument name in the function
> description.  hl_pci_elbi_write() was missing documented arguments.
> The headers for functions hl_pci_bars_unmap(), hl_pci_elbi_write()
> and hl_pci_reset_link_through_bridge() were written in kerneldoc
> format, but lack the kerneldoc identifier '/**'.  Let's promote
> them so they can gain access to the checker.
>
> These changes fix the following W=1 kernel build warnings:
>
>  drivers/misc/habanalabs/pci.c:27: warning: Function parameter or member 'name' not described in 'hl_pci_bars_map'
>  drivers/misc/habanalabs/pci.c:27: warning: Excess function parameter 'bar_name' description in 'hl_pci_bars_map'
>  drivers/misc/habanalabs/pci.c:147: warning: Function parameter or member 'addr' not described in 'hl_pci_iatu_write'
>  drivers/misc/habanalabs/pci.c:147: warning: Function parameter or member 'data' not described in 'hl_pci_iatu_write'
>  drivers/misc/habanalabs/pci.c:324: warning: Excess function parameter 'dma_mask' description in 'hl_pci_set_dma_mask'
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/pci.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
> index 9f634ef6f5b37..24073e8eb8df9 100644
> --- a/drivers/misc/habanalabs/pci.c
> +++ b/drivers/misc/habanalabs/pci.c
> @@ -15,7 +15,7 @@
>  /**
>   * hl_pci_bars_map() - Map PCI BARs.
>   * @hdev: Pointer to hl_device structure.
> - * @bar_name: Array of BAR names.
> + * @name: Array of BAR names.
>   * @is_wc: Array with flag per BAR whether a write-combined mapping is needed.
>   *
>   * Request PCI regions and map them to kernel virtual addresses.
> @@ -61,7 +61,7 @@ int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
>         return rc;
>  }
>
> -/*
> +/**
>   * hl_pci_bars_unmap() - Unmap PCI BARS.
>   * @hdev: Pointer to hl_device structure.
>   *
> @@ -80,9 +80,11 @@ static void hl_pci_bars_unmap(struct hl_device *hdev)
>         pci_release_regions(pdev);
>  }
>
> -/*
> +/**
>   * hl_pci_elbi_write() - Write through the ELBI interface.
>   * @hdev: Pointer to hl_device structure.
> + * @addr: Address to write to
> + * @data: Data to write
>   *
>   * Return: 0 on success, negative value for failure.
>   */
> @@ -140,6 +142,8 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
>  /**
>   * hl_pci_iatu_write() - iatu write routine.
>   * @hdev: Pointer to hl_device structure.
> + * @addr: Address to write to
> + * @data: Data to write
>   *
>   * Return: 0 on success, negative value for failure.
>   */
> @@ -161,7 +165,7 @@ int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
>         return 0;
>  }
>
> -/*
> +/**
>   * hl_pci_reset_link_through_bridge() - Reset PCI link.
>   * @hdev: Pointer to hl_device structure.
>   */
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
