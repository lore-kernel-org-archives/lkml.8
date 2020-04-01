Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954ECC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5452521924
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Nox6OXWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgDAItD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:49:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35211 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:49:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20so28752331edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jG4wOYVYC+k6uIDCHQ8wcXaTiCDZtncKRBQcnse1vfY=;
        b=Nox6OXWGA798Cr52xBMr6YHpFOgZ7GP4CUrcEL/TAjbaMmfb/e8Zq882nUJlst3xBC
         lRz42jYj7FddMpixYXtQgSC96iREDWwS/FzvP3U4+2OMv3r9/9omUEZ8lHaLCPchiKOQ
         QPvUwGlYZT0Xon0Q/LupecuVEt+A1WIAhR6LeV/v1+xa4/C9wpYDQUb4Fv+rb9x00T9h
         ED5TXU8f8rgLSSIXyzx2rP22L7pZXROOGddOLANi4qfl6m48TCJTIzm/F0kJ1jhGQZKu
         oW5Tpq7m5kP0iB3iChoW//Mw34MO1wRRyqjxvkSy5ucVyDc2vYNXewxaxLLT1YUg7VkA
         /78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG4wOYVYC+k6uIDCHQ8wcXaTiCDZtncKRBQcnse1vfY=;
        b=uck5/k9JReqbLpDzO7op4cQQ2ZtRtiD8aYBDFIhARoBsdLkjLPMSEVrY137v23JdBa
         QEV8CR2VQyrlPu8iUIipeZaQxQwuelno3kso0O+x7zc9+UMV0BD7sO26Evf6N96fco8i
         8OXCfZrvzNsJhYeQukKqmooNPh1j6QDg5NVpUFiFXeDdh/iJMjn1Z4b5lTc/QXjL26Ft
         lMy+nTzaJmr9x59Z1/HF8vcPQR16MlVja9Hq0gKlVq4kgPG8UZYUR6YSXeBaHUa8WELQ
         A1WGd1WBDhjFp0QUfyvMMBOWRPX9CYEWW4hOYtESbdI/DsnkhgcyVdXR/zqvvXeQy2ij
         q8tQ==
X-Gm-Message-State: ANhLgQ31dZuZtFYQzx0HBIEvG/gxoFN2zcTN2WmCKGXNYqVeBABw+1oh
        wiKIojUpBxGVCLfDFSm46Bfb/BT0nGCFHxIQlTlTLQ==
X-Google-Smtp-Source: ADFU+vtYDJ13Duz6ckwhGdZm21tZ+Kg6VHjBFgfaPtTtPJACd+l6/VGlHTLDhLEcu8EYuwx1H1IWNeYptubQg4xr5hI=
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr19203222edb.383.1585730941065;
 Wed, 01 Apr 2020 01:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-7-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-7-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 01:48:50 -0700
Message-ID: <CAPcyv4jyFQa5BDPCSQ6kmFY8CvWgbydePcn8B4M_Zyc1c7MGpg@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ocxl: Tally up the LPC memory on a link & allow
 it to be mapped
To:     "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> OpenCAPI LPC memory is allocated per link, but each link supports
> multiple AFUs, and each AFU can have LPC memory assigned to it.

Is there an OpenCAPI primer to decode these objects and their
associations that I can reference?


>
> This patch tallys the memory for all AFUs on a link, allowing it
> to be mapped in a single operation after the AFUs have been
> enumerated.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/misc/ocxl/core.c          | 10 ++++++
>  drivers/misc/ocxl/link.c          | 60 +++++++++++++++++++++++++++++++
>  drivers/misc/ocxl/ocxl_internal.h | 33 +++++++++++++++++
>  3 files changed, 103 insertions(+)
>
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index b7a09b21ab36..2531c6cf19a0 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -230,8 +230,18 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>         if (rc)
>                 goto err_free_pasid;
>
> +       if (afu->config.lpc_mem_size || afu->config.special_purpose_mem_size) {
> +               rc = ocxl_link_add_lpc_mem(afu->fn->link, afu->config.lpc_mem_offset,
> +                                          afu->config.lpc_mem_size +
> +                                          afu->config.special_purpose_mem_size);
> +               if (rc)
> +                       goto err_free_mmio;
> +       }
> +
>         return 0;
>
> +err_free_mmio:
> +       unmap_mmio_areas(afu);
>  err_free_pasid:
>         reclaim_afu_pasid(afu);
>  err_free_actag:
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 58d111afd9f6..af119d3ef79a 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -84,6 +84,11 @@ struct ocxl_link {
>         int dev;
>         atomic_t irq_available;
>         struct spa *spa;
> +       struct mutex lpc_mem_lock; /* protects lpc_mem & lpc_mem_sz */
> +       u64 lpc_mem_sz; /* Total amount of LPC memory presented on the link */
> +       u64 lpc_mem;
> +       int lpc_consumers;
> +
>         void *platform_data;
>  };
>  static struct list_head links_list = LIST_HEAD_INIT(links_list);
> @@ -396,6 +401,8 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_l
>         if (rc)
>                 goto err_spa;
>
> +       mutex_init(&link->lpc_mem_lock);
> +
>         /* platform specific hook */
>         rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
>                                 &link->platform_data);
> @@ -711,3 +718,56 @@ void ocxl_link_free_irq(void *link_handle, int hw_irq)
>         atomic_inc(&link->irq_available);
>  }
>  EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
> +
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       // Check for overflow
> +       if (offset > (offset + size))
> +               return -EINVAL;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +       link->lpc_mem_sz = max(link->lpc_mem_sz, offset + size);
> +
> +       mutex_unlock(&link->lpc_mem_lock);
> +
> +       return 0;
> +}
> +
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +
> +       if (!link->lpc_mem)
> +               link->lpc_mem = pnv_ocxl_platform_lpc_setup(pdev, link->lpc_mem_sz);
> +
> +       if (link->lpc_mem)
> +               link->lpc_consumers++;
> +       mutex_unlock(&link->lpc_mem_lock);
> +
> +       return link->lpc_mem;
> +}
> +
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev)
> +{
> +       struct ocxl_link *link = (struct ocxl_link *)link_handle;
> +
> +       mutex_lock(&link->lpc_mem_lock);
> +
> +       if (!link->lpc_mem) {
> +               mutex_unlock(&link->lpc_mem_lock);
> +               return;
> +       }
> +
> +       WARN_ON(--link->lpc_consumers < 0);
> +
> +       if (link->lpc_consumers == 0) {
> +               pnv_ocxl_platform_lpc_release(pdev);
> +               link->lpc_mem = 0;
> +       }
> +
> +       mutex_unlock(&link->lpc_mem_lock);
> +}
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 198e4e4bc51d..2d7575225bd7 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -142,4 +142,37 @@ int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
>  u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
>  void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
>
> +/**
> + * ocxl_link_add_lpc_mem() - Increment the amount of memory required by an OpenCAPI link
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @offset: The offset of the memory to add
> + * @size: The number of bytes to increment memory on the link by
> + *
> + * Returns 0 on success, -EINVAL on overflow
> + */
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size);
> +
> +/**
> + * ocxl_link_lpc_map() - Map the LPC memory for an OpenCAPI device
> + * Since LPC memory belongs to a link, the whole LPC memory available
> + * on the link must be mapped in order to make it accessible to a device.
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + *
> + * Returns the address of the mapped LPC memory, or 0 on error
> + */
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
> +
> +/**
> + * ocxl_link_lpc_release() - Release the LPC memory device for an OpenCAPI device
> + *
> + * Offlines LPC memory on an OpenCAPI link for a device. If this is the
> + * last device on the link to release the memory, unmap it from the link.
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + */
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev);
> +
>  #endif /* _OCXL_INTERNAL_H_ */
> --
> 2.24.1
>
