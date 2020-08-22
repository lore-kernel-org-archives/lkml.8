Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB954C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C6520738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHBfyLmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHVQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHVQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:06:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F0C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:06:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h16so3943396oti.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZovCQ+rqtCvMx06pOFPJqm61Rle4b8JR+pVBL9mlEMg=;
        b=JHBfyLmxRgNntFQTN2I3ovvR0DpbT9Po7QdfQep96guv0tlCfl1DKGAA1F6E2tiJkp
         sPoxQgzaryVoxd4MX4VCuDHqY8QbjoSKD9lK1AOwsFe/UpVrDSh4LgsN3FlkklcH20Lf
         IRxT9FvkHlCpdpJuEHXM8EySH2cKA8bHep6cLjm5bL86SUwsbEXFWGolV4kS/hJhmiBI
         6BRR0WQUYeg6d7mWqgzAIJbomw880vQZ8E5uonZftbx1tY99LhwjyaLObj5+RDJEWsoP
         jU27qoMDZGQj8I9aaeWJUc1RBs/TMHFDQZGZSuKmVzvmzO0HJj6ezH6aqf4MedciA+Kw
         TNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZovCQ+rqtCvMx06pOFPJqm61Rle4b8JR+pVBL9mlEMg=;
        b=KNjeFxc0B/v6vRQt03ktHNdzjjgrw8JT8HceSxkqv8EqO0hP16cXrGr4sq99o+KxNR
         y7hlD2d8rWxWzJoeqiyrkqdqs1Yib+Y9qaE13FfUgDQzCpPDPQtb2I/2NxSYf/bG7+LD
         bykhcx1cIxgDdkixNvF0Xe1T8DsHcP/0zrtTXQOoBGQZwkbH34aI1OBtWqUy3hQG8fn1
         g7TKZECrK4zVrXMEy32KMRdiY42RP/tntmf3kZ0u9zpMlO3p4FrQkExT1VzegPMcDjCB
         eqH9vmRwBSD+CnCxzDtFBrqiZYbpFgBstpvXJiIpDngFp19eEl8VywO8qkT+qusI69yF
         0rVA==
X-Gm-Message-State: AOAM532U5ziu+eFpLj1PEuc3XtDW083KtJrI/oFU3bw8A7/tS64SBTHV
        khICxAwf2sf0pLQc7t0ZlWqleuFJMhZVNKyQLMJONYos2sc=
X-Google-Smtp-Source: ABdhPJzAPDj805lFBI1UjpNk6H7E1ni7ZwNiAWeSDnVwZabI+g2BykHD6LVWx4zupbdgja1CyAgdcT22l84ypUNyRBo=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr5386945otl.145.1598112376449;
 Sat, 22 Aug 2020 09:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200818120656.13823-1-ttayar@habana.ai>
In-Reply-To: <20200818120656.13823-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 22 Aug 2020 19:05:48 +0300
Message-ID: <CAFCwf13yahE3Mk2h5NhAk5rtiaBRjqLS1qkBUt3CZNfiQXoKaQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Include linux/bitfield.h only in habanalabs.h
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 3:07 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Include linux/bitfield.h only in habanalabs.h, instead of in each and
> every file that needs it, as habanalabs.h is already included by all.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/common/habanalabs.h         | 1 +
>  drivers/misc/habanalabs/common/hw_queue.c           | 1 -
>  drivers/misc/habanalabs/common/pci.c                | 1 -
>  drivers/misc/habanalabs/gaudi/gaudi.c               | 1 -
>  drivers/misc/habanalabs/include/gaudi/gaudi_masks.h | 1 -
>  5 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> index dbf214421ae1..0a422fd742e9 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -18,6 +18,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/scatterlist.h>
>  #include <linux/hashtable.h>
> +#include <linux/bitfield.h>
>
>  #define HL_NAME                                "habanalabs"
>
> diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
> index e2f9ba04b32d..5e66c98fb0d3 100644
> --- a/drivers/misc/habanalabs/common/hw_queue.c
> +++ b/drivers/misc/habanalabs/common/hw_queue.c
> @@ -8,7 +8,6 @@
>  #include "habanalabs.h"
>
>  #include <linux/slab.h>
> -#include <linux/bitfield.h>
>
>  /*
>   * hl_queue_add_ptr - add to pi or ci and checks if it wraps around
> diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
> index 7bd3737571f3..b054ed6c2141 100644
> --- a/drivers/misc/habanalabs/common/pci.c
> +++ b/drivers/misc/habanalabs/common/pci.c
> @@ -9,7 +9,6 @@
>  #include "../include/hw_ip/pci/pci_general.h"
>
>  #include <linux/pci.h>
> -#include <linux/bitfield.h>
>
>  #define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC  (HL_PCI_ELBI_TIMEOUT_MSEC * 10)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index e56f95e6c741..cbd8acceddbf 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -21,7 +21,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/iommu.h>
>  #include <linux/seq_file.h>
> -#include <linux/bitfield.h>
>
>  /*
>   * Gaudi security scheme:
> diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
> index 3d4f9aed41f1..504f3ad711b5 100644
> --- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
> +++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
> @@ -9,7 +9,6 @@
>  #define GAUDI_MASKS_H_
>
>  #include "asic_reg/gaudi_regs.h"
> -#include <linux/bitfield.h>
>
>  /* Useful masks for bits in various registers */
>  #define PCI_DMA_QMAN_ENABLE            (\
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
