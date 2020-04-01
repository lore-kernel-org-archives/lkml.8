Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4A9C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC07215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UGfBm0OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgDAIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:48:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43734 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:48:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so28632880edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFnQtMAv52vc67tP5TFOUo3bRsY9ihV28ROS9W2huxg=;
        b=UGfBm0OG6dm/aY2vbCbLWqdatsFbxQNSssJ6VGYhMiDq/OZ3CcwFMRXjdJP0AXYK7D
         qh0ra8EMgQmGzX4Fxxcv2zpRpA6bvmpNcGy3vpPXv3wvgBL5g1kIy0ijObNxfTpeqLe8
         zJQlvRgzdUnUwCw9a3vVQyhTkhOj1bGwFPHvgJUavxqHY6EN1biqXsQJEuRb2ZAx1+la
         bIBqqpPryQe7pXTndun8sNc9rg9fyRYz2RGUeOFAXiGwD9NEgCHUS1mhusff7WG/rzRe
         rFzKfqWGnLyr5HwxUXqFoo2mpn0Y5mBOQNJqTToIbYTuOKzCLXGk0bf6ytMk5SVA0IRX
         r6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFnQtMAv52vc67tP5TFOUo3bRsY9ihV28ROS9W2huxg=;
        b=cvBlApepoCjD/NNQHsdH/2+5FwWcqLzNRRS1N7Tvf4F4LRLoLZGwLbZvK9GruxxsYV
         24NPwz9n9z9eUTQ+pCN1YkywZkB77e7K1ud7n1055iyOlDoPE+KKuEiPLvZpQC6r5DTG
         wZ+JWd/97dJ/32wk/Rrwb3VxfvL2Yb/judfGxnKQ8ysW4FneSIhIDBHjWTM3JfnmtDNk
         cMk8+bYY5N/tkNXm19uEYlfXFl3sGAjrA6Z6IlDgnsEEv7dEtbGQ7STDQvXU4OftO6e7
         P2Sy3UyhZgO/ND33471Fve2RIfLHsjvTFM8HL9HacubkxtdzJ3Tbb7J7asmPrPaAutgh
         CdBQ==
X-Gm-Message-State: ANhLgQ1UViaBQjx5fdVBNbwrTwyCySNgZgL1Q1LGad91dh2cBScuOclE
        V263V2VxgolMAmyYcbSMFa2RZP/pGzvhN4gqcRZX5Q==
X-Google-Smtp-Source: ADFU+vudGlnJtN5ZeSeIRWxrez165WdBj7a1Bu0ZFHM+ccZlxf9ge6aKX/I8+gF5fOEuZLiG5EzKhnaDmM289WwDWgA=
X-Received: by 2002:a50:d847:: with SMTP id v7mr19478119edj.154.1585730924056;
 Wed, 01 Apr 2020 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-4-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-4-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 01:48:32 -0700
Message-ID: <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
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

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch adds OPAL calls to powernv so that the OpenCAPI
> driver can map & release LPC (Lowest Point of Coherency)  memory.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
>  arch/powerpc/platforms/powernv/ocxl.c | 43 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 7de82647e761..560a19bb71b7 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>
>  extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>  extern void pnv_ocxl_free_xive_irq(u32 irq);
> +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
> +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
>
>  #endif /* _ASM_PNV_OCXL_H */
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index 8c65aacda9c8..f13119a7c026 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,6 +475,49 @@ void pnv_ocxl_spa_release(void *platform_data)
>  }
>  EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
>
> +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
> +{
> +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +       struct pnv_phb *phb = hose->private_data;

Is calling the local variable 'hose' instead of 'host' on purpose?

> +       u32 bdfn = pci_dev_id(pdev);
> +       __be64 base_addr_be64;
> +       u64 base_addr;
> +       int rc;
> +
> +       rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr_be64);
> +       if (rc) {
> +               dev_warn(&pdev->dev,
> +                        "OPAL could not allocate LPC memory, rc=%d\n", rc);
> +               return 0;
> +       }
> +
> +       base_addr = be64_to_cpu(base_addr_be64);
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE

With the proposed cleanup in patch2 the ifdef can be elided here.

> +       rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
> +                                             size >> PAGE_SHIFT);
> +       if (rc)
> +               return 0;

Is this an error worth logging if someone is wondering why their
device is not showing up?


> +#endif
> +
> +       return base_addr;
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
> +
> +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
> +{
> +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +       struct pnv_phb *phb = hose->private_data;
> +       u32 bdfn = pci_dev_id(pdev);
> +       int rc;
> +
> +       rc = opal_npu_mem_release(phb->opal_id, bdfn);
> +       if (rc)
> +               dev_warn(&pdev->dev,
> +                        "OPAL reported rc=%d when releasing LPC memory\n", rc);
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
> +
>  int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>  {
>         struct spa_data *data = (struct spa_data *) platform_data;
> --
> 2.24.1
>
