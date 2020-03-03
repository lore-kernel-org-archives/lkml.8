Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AF7208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583262708;
	bh=Gm97G7ePTvTA/2qImrmMfXs4ah+ywyggwz9iheWgI34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J21v8J/Trj+q6GGk/bWAYJAL95PJiFgnRIM8UpezlPy7oUj6fSlwQwVRUv4IWywA/
	 TfE34/9sDDqrdhd7iBtCMVkR3PfTIx81QIZr4Vg6UIPEnjLLoK2OxFOTcdTLQm8PBx
	 78rZQ/eNDGEsBfTiFBtuvOyM0UTtzugfPOPGxUGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgCCTLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgCCTLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:11:47 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B192073B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583262706;
        bh=Gm97G7ePTvTA/2qImrmMfXs4ah+ywyggwz9iheWgI34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zFNEdwSvQ65AQQj+EjXhFKyKnE4i/lJyYwLSS+ADHBpVaPtUkoLFAiyvHSC1cKiJh
         EYfrrxQmOXeBXtbvN9MopG2vxijGaxFQ4mmfFvLPzqxTudAwxoAj2HOPArIUTQ/Xaf
         L5pahdot351ChS+RD22FpHcjnYJhEpnrtZ3tQ/J0=
Received: by mail-wr1-f50.google.com with SMTP id h9so4883271wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:11:46 -0800 (PST)
X-Gm-Message-State: ANhLgQ04LOVmxut6iK24eKQS24t3dVSMpuSQSOhau2Djxq7RkyoMhCaW
        qRxlOQahbcb16buHjx+JsRgGmCAeuQvkkzTYycj0Og==
X-Google-Smtp-Source: ADFU+vvZpcv2G95Un+H8kNu0mF7hau3OQ+mlltuZfwIGzpAzdyWYqEdm4ZULNNH/bCnKgBNOLgwTiI9R4qt0HDehXj4=
X-Received: by 2002:adf:a411:: with SMTP id d17mr6691415wra.126.1583262705029;
 Tue, 03 Mar 2020 11:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200301230537.2247550-4-nivedita@alum.mit.edu>
In-Reply-To: <20200301230537.2247550-4-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 20:11:34 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_Xbw7SjdCvHMrDXW4o-XtM8FH4LAXPtro9cXSecVuFSA@mail.gmail.com>
Message-ID: <CAKv+Gu_Xbw7SjdCvHMrDXW4o-XtM8FH4LAXPtro9cXSecVuFSA@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi/x86: Add kernel preferred address to PE header
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 00:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Store the kernel's link address as ImageBase in the PE header. Note that
> the PE specification requires the ImageBase to be 64k aligned. The
> preferred address should almost always satisfy that, except for 32-bit
> kernel if the configuration has been customized.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/header.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4ee25e28996f..0d8d2cb28fd9 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -138,10 +138,12 @@ optional_header:
>  #endif
>
>  extra_header_fields:
> +       # PE specification requires ImageBase to be 64k-aligned
> +       .set    ImageBase, (LOAD_PHYSICAL_ADDR+0xffff) & ~0xffff

Could you call this image_base please, and put some spaces around the +

>  #ifdef CONFIG_X86_32
> -       .long   0                               # ImageBase
> +       .long   ImageBase                       # ImageBase
>  #else
> -       .quad   0                               # ImageBase
> +       .quad   ImageBase                       # ImageBase
>  #endif
>         .long   0x20                            # SectionAlignment
>         .long   0x20                            # FileAlignment
> --
> 2.24.1
>
