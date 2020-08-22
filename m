Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED34C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2F02067C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GedEl8Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgHVQKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHVQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:10:37 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DEC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:10:37 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a6so999118oog.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BweRWaKbFIFa4QmS8gBlGKUWXB3lSkHTZLxEjlyi0k=;
        b=GedEl8OgsuM4HtK9wfGC/0t9kfEvZR88iaIFw4EUT/GRfyfsAP6OdwFOscqMJsEwcY
         C6cjifLumjiDbTNf6AyeaGufYel0H3yZ1NccMkZL6qv4+PC8OCcjYdxqvVxPgeWVcVgb
         s/glmDDsPEkkdlxwtAHCftvzzhotrNtPkcXwUUX6wHr25CmYxJSJtr9NgJOlbeHir00u
         ZpPJcPa5CXzHZ2XYDWOqPFltcq1Rb7BUstPu6cEAZY2m3xYzC24jF87H25kklVhHJcd2
         +Aue8rsh1AZQpJEbCiMiXWP70d14CmvOWb1tbz1wdqk1XFwvv5jgG3zPFzhym3Tmp6cv
         lq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BweRWaKbFIFa4QmS8gBlGKUWXB3lSkHTZLxEjlyi0k=;
        b=ADRXZG4OlMv6vlrDkI+XWQHjuQSc0o68SJQ/0eA8Vr5LIrHi0tN7xo73EQKwHDkYUv
         Au+pXhR2kqNVnU7+UWNpDThGxA1KEWaxKP9101EtiCkoavZZNV+4jYlWlBoTLaW8aROb
         LWyki9UCg8MJasPcueVwjCgXGS5lZTQgSaxflqCb75CQxCojI0TH3Qyrv2Im5ujuJ8lX
         daqVvfp48Zzaw/NrPcPqXg5BhxgPAPPalWXGhJ7OIc/HPXSFvo+XwEQOu3Eny4+pC0PR
         juN1OkAdVFrKL2d3FR+IBAhr2msNuqoLN6S/P6G9l9zHuv7REFCefV4p/0fH7IC/uUZ5
         MASg==
X-Gm-Message-State: AOAM532H/MO5NuL5ShN78oVV1Mwpm0JSHLqDYbMh9znsxPClks7pLUTg
        DApVy4lh8GqkVt/+yAo+KZQTu9P+OXUTrcHASI+xPAKmWrmmsA==
X-Google-Smtp-Source: ABdhPJztOR5Hq5BVs8zEsdkWUMr+WtihNvZAmQ+ADZHM378E3Ey+eqSZQKIy34uyUCAyYiTJtWZUDOBE7U02+gpEMb4=
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr6029479oom.27.1598112635530;
 Sat, 22 Aug 2020 09:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200817134752.11344-1-hdanton@sina.com>
In-Reply-To: <20200817134752.11344-1-hdanton@sina.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 22 Aug 2020 19:10:07 +0300
Message-ID: <CAFCwf13BGZC86iWdL4msO5=0TbUm=HVwgHsqfxCSJzVKr1FqpA@mail.gmail.com>
Subject: Re: [RFC PATCH] habanalabs: goya: make use of dma_mmap_coherent
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>,
        Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:48 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Add dma_mmap_coherent() to match dma_alloc_coherent(), see the Link tag
> for why.
>
> Link: https://lore.kernel.org/lkml/20200609091727.GA23814@lst.de/
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -679,7 +679,7 @@ struct hl_asic_funcs {
>         int (*suspend)(struct hl_device *hdev);
>         int (*resume)(struct hl_device *hdev);
>         int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
> -                       u64 kaddress, phys_addr_t paddress, u32 size);
> +                       void *cpu_addr, dma_addr_t dma_addr, size_t size);
>         void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
>         void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
>                         struct hl_bd *bd);
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2642,15 +2642,14 @@ int goya_resume(struct hl_device *hdev)
>  }
>
>  static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> -               u64 kaddress, phys_addr_t paddress, u32 size)
> +                       void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
>         int rc;
>
>         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
>                         VM_DONTCOPY | VM_NORESERVE;
>
> -       rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
> -                               size, vma->vm_page_prot);
> +       rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
>         if (rc)
>                 dev_err(hdev->dev, "remap_pfn_range error %d", rc);
>
> --- a/drivers/misc/habanalabs/common/command_buffer.c
> +++ b/drivers/misc/habanalabs/common/command_buffer.c
> @@ -299,7 +299,6 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
>  {
>         struct hl_device *hdev = hpriv->hdev;
>         struct hl_cb *cb;
> -       phys_addr_t address;
>         u32 handle;
>         int rc;
>
> @@ -344,12 +343,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, s
>
>         vma->vm_private_data = cb;
>
> -       /* Calculate address for CB */
> -       address = virt_to_phys((void *) (uintptr_t) cb->kernel_address);
> -
> -       rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
> -                                       address, cb->size);
> -
> +       rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
> +                                       cb->bus_address, cb->size);
>         if (rc) {
>                 spin_lock(&cb->lock);
>                 cb->mmap = false;
>

Hi Hillf,
Could you please also fix gaudi_cb_mmap() and resend this patch ?
Thanks,
Oded
