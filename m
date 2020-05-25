Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0E2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="UwMWBaBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbgEYFzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388203AbgEYFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:55:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:54:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so15604832wmu.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnsfvH/wASXEXJznW6JfADs4WQzB6hvTXGajXl2onWo=;
        b=UwMWBaBU1COmbyJPENUModAWxX2O8P1YQO+8h5YFvp5c2cEWl5zfpKZ07FrxqaNPsc
         oUliNnEtworQRoom4LJ99pmkrDkxPO5wzKtutFZcJtFw/9OwyxxBmuP5L2/FFhvSkLZR
         drfVuLVtassSkB43SuR7AlJ43QBj71ym2stcEcR5P4iNOg4D0l5Vw7bOb18jygqjWv8F
         cE2ggaeUadpaPWTTN/qScBc496I2tA66YtcHI1h0GCE1/Em2wtURIbOQ3hkWZWfV2uXR
         PDJV32D+cNDObSZI2qsb/LwzAC9YkYTXO2o88ejwV98Vdwf1Z7nU0yJ2BFqk8S8wkCU9
         sIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnsfvH/wASXEXJznW6JfADs4WQzB6hvTXGajXl2onWo=;
        b=Er5xNWOWucmMbi/1WKvOURqKjxYaU8OLDYn35zgb/STl9ju7H8QGNVmQMlg3eDzR+7
         ZlswzZHHl9w1wwL6voVdSYfW9tiGVSa/r+LowUFDfnuH7B+Uc2whdhBWGXKymOQ/QV6D
         dG8XqA74IYWl/hTX88XaLMnS9lPcddXjGBe8CIPOgumiQtntHnCLsxmdkv1IJVe5LKIY
         do7jcnhssTyz4Y4hQvfwSyviSjw2m+vNhSUbbkzoYEIFpmuWpFh0YSskIspYo1/6lpd9
         IoHE3xsXrQPzvYjlYwZpSLsQfTak94INJoJg/8UINIUSJeIwHzbW0hkB2xUaQylqxzak
         uEig==
X-Gm-Message-State: AOAM5307iglGy6qS5RuhclLwIZMMUQqEsQkSlwtq0PgTZKpv7AxX/D5s
        A77sBvurg93u41bhXOsJosFFwNky1KKft5MvBuPVDsPp
X-Google-Smtp-Source: ABdhPJwESrGsLIl9D8TIYjJyCxhMlsR2C/SeTL03tl84X40a5EYSrPjswldE5qbLIJJvLlaFCMahJd2s2yMH4BCzTcA=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr23239862wmk.3.1590386098126;
 Sun, 24 May 2020 22:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200524091008.25587-1-alex@ghiti.fr> <20200524091008.25587-5-alex@ghiti.fr>
In-Reply-To: <20200524091008.25587-5-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 May 2020 11:24:46 +0530
Message-ID: <CAAhSdy2-BXxopmTX-UVxpNv8dhMa8K3hT+K3j2aECZ0SmA4TvQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] riscv: Prepare ptdump for vm layout dynamic addresses
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 2:44 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This is a preparatory patch for sv48 support that will introduce
> dynamic PAGE_OFFSET.
>
> Dynamic PAGE_OFFSET implies that all zones (vmalloc, vmemmap, fixaddr...)
> whose addresses depend on PAGE_OFFSET become dynamic and can't be used
> to statically initialize the array used by ptdump to identify the
> different zones of the vm layout.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/ptdump.c | 49 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 7eab76a93106..7d9386a7f5c2 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -49,22 +49,41 @@ struct addr_marker {
>         const char *name;
>  };
>
> +enum address_markers_idx {
> +#ifdef CONFIG_KASAN
> +       KASAN_SHADOW_START_NR,
> +       KASAN_SHADOW_END_NR,
> +#endif
> +       FIXMAP_START_NR,
> +       FIXMAP_END_NR,
> +       PCI_IO_START_NR,
> +       PCI_IO_END_NR,
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +       VMEMMAP_START_NR,
> +       VMEMMAP_END_NR,
> +#endif
> +       VMALLOC_START_NR,
> +       VMALLOC_END_NR,
> +       PAGE_OFFSET_NR,
> +       END_OF_SPACE_NR
> +};
> +
>  static struct addr_marker address_markers[] = {
>  #ifdef CONFIG_KASAN
>         {KASAN_SHADOW_START,    "Kasan shadow start"},
>         {KASAN_SHADOW_END,      "Kasan shadow end"},
>  #endif
> -       {FIXADDR_START,         "Fixmap start"},
> -       {FIXADDR_TOP,           "Fixmap end"},
> -       {PCI_IO_START,          "PCI I/O start"},
> -       {PCI_IO_END,            "PCI I/O end"},
> +       {0,                     "Fixmap start"},
> +       {0,                     "Fixmap end"},
> +       {0,                     "PCI I/O start"},
> +       {0,                     "PCI I/O end"},
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -       {VMEMMAP_START,         "vmemmap start"},
> -       {VMEMMAP_END,           "vmemmap end"},
> +       {0,                     "vmemmap start"},
> +       {0,                     "vmemmap end"},
>  #endif
> -       {VMALLOC_START,         "vmalloc() area"},
> -       {VMALLOC_END,           "vmalloc() end"},
> -       {PAGE_OFFSET,           "Linear mapping"},
> +       {0,                     "vmalloc() area"},
> +       {0,                     "vmalloc() end"},
> +       {0,                     "Linear mapping"},
>         {-1, NULL},
>  };
>
> @@ -304,6 +323,18 @@ static int ptdump_init(void)
>  {
>         unsigned int i, j;
>
> +       address_markers[FIXMAP_START_NR].start_address = FIXADDR_START;
> +       address_markers[FIXMAP_END_NR].start_address = FIXADDR_TOP;
> +       address_markers[PCI_IO_START_NR].start_address = PCI_IO_START;
> +       address_markers[PCI_IO_END_NR].start_address = PCI_IO_END;
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +       address_markers[VMEMMAP_START_NR].start_address = VMEMMAP_START;
> +       address_markers[VMEMMAP_END_NR].start_address = VMEMMAP_END;
> +#endif
> +       address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
> +       address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
> +       address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
> +
>         for (i = 0; i < ARRAY_SIZE(pg_level); i++)
>                 for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
>                         pg_level[i].mask |= pte_bits[j].mask;
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
