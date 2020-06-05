Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE9520659
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="L791aE3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFEJDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgFEJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:03:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C767C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:03:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so8923709wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDj9WPcNLZafw1WmCK+2jcLNB/38A0yqskAegYjl94o=;
        b=L791aE3WH7eHH5Ud9SodquObe0Rf3VNwry6R6ETImhgYqgaFcDTrVTaqAEszODVG9U
         V7KiznfSLrsgB6/r4vIL0iH+FjvDrRi54/aOm+r1kQWavmu2cxx47l22jhyunt/N2DCE
         +Nkon3Htr7qa4Q+6JAed2WDZ9xZ/Mtp992K0CXGJpv3caso3RaL8JETxQa1IBYoZYpYM
         +fU53HMrFbdI9GpnQAde6XrsxiB+AvUbHE+XRi9us/wJew26IRsIr9BfVfRnk5ZFJHwn
         N9qbSfdDGvfYbfdmM8l7BxZL5iQ6ILtch2SDdf2hGG44aInhPFOfoQsZ7F5gHVDfmDjk
         VFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDj9WPcNLZafw1WmCK+2jcLNB/38A0yqskAegYjl94o=;
        b=hfsDE31DGM8/POB8RaEf2g785DxL9cvepDzVjvOcKv8D7nI29ew4CUpeG9ZjGt107w
         +Icy1JWgHe7YAmE9fh2rrRC3PnYrZEZTbdiSNqdUgQtdvWBbVFntamMBau0bHvdUN9Na
         +ATj7r1pPLo8xG9baLbqNiHZOBbXbmxOex1RQGcIihRCZL75HcknTIxKroSJcL9yNQzf
         H9eIrhExvm8oRULzNM/3xMzQnBkWAHJgBcTUBeRjF6zlitKK+czU7IpsAFCCJDAENuaC
         Z6HPN9YrAhYtPE/M316rupdRH5x7YViH08IFldfF5U4MeZVLPnSwiJyuYwr2Z47vgpir
         U3vw==
X-Gm-Message-State: AOAM5326ly6yzVMX8/UiQApgksQko+KK5HV1Hi3Vqhfu6bLOz4zB5WTM
        ByemZIbwib0ULGG/NTI0ZZ77zcCIpI+Hbr/UJTs6fA==
X-Google-Smtp-Source: ABdhPJzk8in9iVVH/gT2I+8ebgUy8sF8Z9mm7veJlYeOaMoj9Cnc2GY6BnNJrMm5kTSAhOZB9DkhbShDr3iNesnkVqM=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr8393249wrq.325.1591347807880;
 Fri, 05 Jun 2020 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200605051510.51590-1-maochenxi@eswin.com>
In-Reply-To: <20200605051510.51590-1-maochenxi@eswin.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 5 Jun 2020 14:33:01 +0530
Message-ID: <CAAhSdy0qP6iNY9cDkyCZ65-DmketizjSQsuwk1wHyyQj5GKcAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
To:     Chenxi Mao <maochenxi@eswin.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 10:45 AM Chenxi Mao <maochenxi@eswin.com> wrote:
>
> Select ARCH_SUPPORTS_ATOMIC_RMW by default to enabel osqlocks.
>
> PS2: Add signed off info.
>
> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a31e1a41913a..cbdc605d20d9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select HAVE_COPY_THREAD_TLS
>         select HAVE_ARCH_KASAN if MMU && 64BIT
> +       select ARCH_SUPPORTS_ATOMIC_RMW
>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> --
> 2.25.1
>
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

This is a good candidate for Linux-5.8. Palmer ??

Regards,
Anup
