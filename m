Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6147AC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3982A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XIw3VO3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZGea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:34:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:34:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so6309150wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvC8QWnRmOzqEdjQGHBaXkBEi8rPPx/mAf1Yd60724Y=;
        b=XIw3VO3hEq6zt6MobHP3j6xdFLWc2Kvz+WkoIGGpWwNupn9Ca+EHaMd4PFTAYiX3JF
         k04sBP/lyz1jna9TM5k623xovRZWs/idDiR7Vq1/XxFBL6Frwxh58SS9ZLh82gYkqK68
         22zXeAgdVzWpYw78loeATN75/nyVZiyA1BoYxagrTGxnLo5iH8VWiKlcognYINb8mKgY
         TnR2/JtNKJ9bN3uUzBkee2ZXz6XDEjFj76aQrvHP1Ikfxm0y1ZK2nHNoFBZIJSbn0Bey
         4rPOS3WPldP0qzjR6x+3fgfRXeg4rwhYo8AzdkcVZV6fXq6LySqDJiPED/YPT9OzsGfr
         y6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvC8QWnRmOzqEdjQGHBaXkBEi8rPPx/mAf1Yd60724Y=;
        b=eqPbzEzP3LMEQlmX7h0h+Lalqy3w44JEPkhkdsXiS5PJ1GpctBVt2SOnjkzodF96jH
         3RJWqLTvSiJwMe72kpVSkmu/vvmelGbSdzPzSXqhGQiHa1l+dZfN2onh9J4Y2G+gG7O1
         gVpgJCLkflipWGxdw+Q7uC0hiOyta6VHLbMbmC1FBbv9gsILfnM8Sq1QnmhgY9fRK8rU
         gp0w8053ieA9eRYjLOKHW0PMke07XfJwfGbX25IeYwqfBvC6l1N9e7rziDCTgsu1QAPK
         vgzFPFupdusrPJpLACn9zylB5A0DCcph5ioPjUCm+waliRpuExLc0tULhhrxlUi8hnAl
         IWWA==
X-Gm-Message-State: ANhLgQ2VFo/HPjuE9A5u0Egafx305FYPDLREsA78ZsEbc0LlDjpHdZuQ
        cx1X1iAuqCehCtm/3WoqpizGEsFOW/9Do5Xe1RbcZg==
X-Google-Smtp-Source: ADFU+vsiJgPSCiiXl/cDr34/UNTviPAKRXDPbZPPuu9MODq9paMGa63OoHZu701MwEKlLAyjK8g1W7zW9+jmlKg88zI=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr7464097wrs.61.1585204467653;
 Wed, 25 Mar 2020 23:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-4-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-4-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 12:04:15 +0530
Message-ID: <CAAhSdy1cNY2OwZaPVaDFzoPsB_omfeyjUZ0O9zdAXcZPjO1b9A@mail.gmail.com>
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

Ignore my previous comment. I see that you are setting the
PAGE_OFFSET to 0xffffc00000000000 in the next PATCH.

The commit description is can bit improved as follows:

Either the user specifies maximum physical memory size of 2GB or the
user lives with the current system constraint which is 1/4th of maximum
addressable memory in Sv39 MMU mode (i.e. 128GB) for now.

Other than above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
