Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDEDC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B815620675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597434519;
	bh=49/ymVCFq5phy1rc2KbPcsV+yZ5d4kVWmjeUsVuKKwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1CGRP6M5RcQ+URPrkjxWHyfvwhl+mGjlikqhLyiTkOTiA7xr+P534NJUaiTwq7b8C
	 WsifeWqNWqf5fjNod0gEkOZp56VEm1rD4KBmvpEYpj+XhaZaiSja5ol8E2eyAQT/V5
	 oq9G4cXx6dgoCeOKhaXadPGsTr1rVAgtZh06ud5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHNTsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNTsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:48:37 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2720C20675;
        Fri, 14 Aug 2020 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597434517;
        bh=49/ymVCFq5phy1rc2KbPcsV+yZ5d4kVWmjeUsVuKKwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y8/6CtNT/RWvMjmzXMLlevAkc4kqUJrzX5zkk8gjW5JhvpJ1jn74alNArmaoGUwtV
         BTjZ9v6pwhmIEORFU0lvPU4YQGGPs7aJeMb/EghGAS//amBYgvRyHv4Wog+/ny2Ozf
         i02tv8PtaXecGpHXvZP0PZMyZYXhfHMrfssd4K1g=
Received: by mail-ot1-f41.google.com with SMTP id k12so8517192otr.1;
        Fri, 14 Aug 2020 12:48:37 -0700 (PDT)
X-Gm-Message-State: AOAM530unYJ5UX9X5Kyz15gs69EIT6ECcpWz6Ykk624Rw2rtQYu0sgma
        44y1gDkl0ruVMtWOOvsc1x9Ywo/SZaLph3GqCQ==
X-Google-Smtp-Source: ABdhPJxrQSww6LTRkLkSM1un20zusfbbOrIU5xOzV9SZrRPaqPenXR84qBQ/ArA6cwl1NcJXao8AjghrDjG7SZuEgLo=
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr3111218oti.129.1597434516538;
 Fri, 14 Aug 2020 12:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200813114344.67730-1-colin.king@canonical.com>
In-Reply-To: <20200813114344.67730-1-colin.king@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Aug 2020 13:48:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hBnFui6fOoY9jv4YFYX7MdiPhdA_dWHiFrMzLXJOYbw@mail.gmail.com>
Message-ID: <CAL_Jsq+hBnFui6fOoY9jv4YFYX7MdiPhdA_dWHiFrMzLXJOYbw@mail.gmail.com>
Subject: Re: [PATCH][V2] of/address: check for invalid range.cpu_addr
To:     Colin King <colin.king@canonical.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 5:43 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently invalid CPU addresses are not being sanity checked resulting in
> SATA setup failure on a SynQuacer SC2A11 development machine. The original
> check was removed by and earlier commit, so add a sanity check back in
> to avoid this regression.
>
> Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/of/address.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 590493e04b01..6ffbf7b99e92 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -985,6 +985,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>                         /* Don't error out as we'd break some existing DTs */
>                         continue;
>                 }
> +               if (range.cpu_addr == OF_BAD_ADDR) {
> +                       pr_err("Translation of CPU address failed on node (%pOF)\n", node);
> +                       continue;
> +               }
>                 dma_offset = range.cpu_addr - range.bus_addr;
>
>                 /* Take lower and upper limits */
> --
>
> V2: print message using pr_err and don't print range.cpu_addr as it's always
>     going to be OF_BAD_ADDR so the information is pointless.

Shouldn't we print the bus_addr like the original message did?
Otherwise, we don't really know what entry is problematic.

Rob
