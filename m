Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69114C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889720772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="cp6ZDCxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCZGW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:22:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:22:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so5249703wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkmDzl8QbMEyVDVqrUppr7SgDLQJmLXWVe0+y40YkLQ=;
        b=cp6ZDCxaq81LNJbQvsBg96fKgf6ZLLSfrJC1gse9F0mRsZJ/E/CfeduBoijTSjEgI8
         92mrlCu/QRyMwysaKbf3S10EvHDt3xUM1gltecPNi0NPXd1h9VYfQZXJv+14KaPehTfF
         XFK3y4zipTKxlxIC8qG+sIOvEhT843CIBDBrW5aDC3F7hOdzIeOrz9ZzqC452DR7QWml
         xaPM4bebCKBc7/yoCH1wWbDjIkZAK/JhY777wvCgQVvRpjtgWoNCP6i5HPlaC/1PiMM7
         utICdp6oJidA6sGO2ZBX0TwlySPeDBunBWrHQv719z6srOljbJY9NYkH6esvzH2qhB1C
         dY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkmDzl8QbMEyVDVqrUppr7SgDLQJmLXWVe0+y40YkLQ=;
        b=XecHdhyXQBj92xWBGrfjUcJiFOCNj7tV2vAEgohYcmkWhBxjH/RqTF9wTQg5fNLoh4
         IH9qftFE2Lb6znlj7GTaSx3w3etfk9U2yitQx43lqkJGuqXecmyBzz3Eo+UhT3XRmyuM
         7pEuqHOYusaOkdYKjDzl9DgvGAdM8ten8WZNyiBdZdL1uCIEafdmhUAwNbjvPHuyeC1u
         XszmKiMcDWEk2QV6tu39Us25qs80Mf+cBFFikNdg7EFmqLpi5ZeM8VJ+sRUOxAWjX9Tv
         SLitDyXeCfBd/GfSoQOI6UxQi0256eSB6fZtri9eqfqLf/m+OqxtONwMeLWN0pjLfYoI
         lGmQ==
X-Gm-Message-State: ANhLgQ3XyuYBuvKg2k1xuBNi+ySs6YCvPJt7L2VIDjF8rs9rCDAk/enW
        67iHbbyJtge/lh5dGSKvOWATq7E33xFAu+8x/wkfJQ==
X-Google-Smtp-Source: ADFU+vtinS1iUyTOVFsP36QDgeheDLi0Xo5es3e+rBfKshHjs5MZosDzi+17UBS5VghfWVwjpwhb64xgNFDR5B/lhSY=
X-Received: by 2002:a1c:5452:: with SMTP id p18mr1458497wmi.102.1585203774917;
 Wed, 25 Mar 2020 23:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-4-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-4-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 11:52:43 +0530
Message-ID: <CAAhSdy0+EYV3n3NPrJTkVZETm4SKrZLT1jLENJR9BAT5iGsCDw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] riscv: Simplify MAXPHYSMEM config
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

On Sun, Mar 22, 2020 at 4:33 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Either the user specifies maximum physical memory size of 2GB or the
> user lives with the system constraint which is 128GB in 64BIT for now.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8e4b1cbcf2c2..a475c78e66bc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,7 +104,7 @@ config PAGE_OFFSET
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>         default 0x80000000 if 64BIT && !MMU
>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> -       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> +       default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
>
>  config ARCH_FLATMEM_ENABLE
>         def_bool y
> @@ -216,19 +216,11 @@ config MODULE_SECTIONS
>         bool
>         select HAVE_MOD_ARCH_SPECIFIC
>
> -choice
> -       prompt "Maximum Physical Memory"
> -       default MAXPHYSMEM_2GB if 32BIT
> -       default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
> -       default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
> -
> -       config MAXPHYSMEM_2GB
> -               bool "2GiB"
> -       config MAXPHYSMEM_128GB
> -               depends on 64BIT && CMODEL_MEDANY
> -               bool "128GiB"
> -endchoice
> -
> +config MAXPHYSMEM_2GB
> +       bool "Maximum Physical Memory 2GiB"
> +       default y if 32BIT
> +       default y if 64BIT && CMODEL_MEDLOW
> +       default n
>
>  config SMP
>         bool "Symmetric Multi-Processing"
> --
> 2.20.1
>

Currently, we don't have systems with 256 GB or more memory
but I am sure quite a few organizations are working on server
class RISC-V.

Let's not force RV64 physical memory limit to 128GB by
removing MAXPHYSMEM_128GB. On the contrary, I suggest
to have more options such as MAXPHYSMEM_256GB,
MAXPHYSMEM_512GB, and MAXPHYSMEM_1TB.

Regards,
Anup
