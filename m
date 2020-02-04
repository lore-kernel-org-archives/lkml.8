Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B63AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24DD21927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="wRaKb9GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgBDKce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:32:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50509 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBDKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:32:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so2653772wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1SYMxKK3rfeZvqEbPZchRaPU1qcwRe9ko80AsNTrp6g=;
        b=wRaKb9GCH1iII+N1vEDR1HM/dAgxMJ+SGP4LqJ2mJHZoVnCjHS0/Z3oE7ardXiyCJ0
         GSKGusmqT2WTzHuTnFf20V5rVq6OUvGTGkanJ893QHoqxN6uPf6Yo4m2b+du/ydfNShD
         0qejGLeiuCr97p4mJ5WyaF2Sqrb4Ip5TxXLTxiLt7FJVLW4EuAcR/B/Q74CpUtI1MxGD
         IySZZWMzNO8aMzvJW+uigwBkfZNSkC3CmaxtNvDPR6vbcBT/NMKX6PtwTni/Pv9uG2vJ
         LwQjr59K5JVwLK2B0Pj23MGYFhx3k8JGB07IrssBD7HVCh8YyiGx8ahREa/jZe7DEx41
         E0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1SYMxKK3rfeZvqEbPZchRaPU1qcwRe9ko80AsNTrp6g=;
        b=G8TxsMXbc1DQ2NLTfwwx+Di7qdqh8ZHWO8XolBh1WoCM9RnZiv6JfIoDK63+/NSOru
         R/9G7KzVXiiAMMfDCWvikkPjPX5Vj9JHPCAtCcSZQOHHs3Dmi72AWs7Y4f2mMYhyIO2l
         v1rmtx4HAzH+nEO4i8YWwnZkbSUy5o4kzyI+vEIMpsSQyd5XyFKh8tWRZiqpnrQkO2sJ
         O0yo5oQoLIag4SVqXyoZRysnRfxbB+1q+IHFeiCh7/CD4lIScUJZQ9KmYNgIRDO8euMb
         kSMjY3B2APHwXIuDZX1WTwGEH3zatQW4iG3Mqhy31zpTLc9VfpJ5AI2ocgczu5Lo/3mP
         AwTg==
X-Gm-Message-State: APjAAAUXdfkD2J5H0dlsATpzHQjrl6FAjNYg9WqmjUpBvDAFI+ZulWvB
        oAvuYhxWo+M/coF6DoxlB7/GP8NvdIcbOty8SYZP9Whievk=
X-Google-Smtp-Source: APXvYqzoXmXCV29YylA4DEA+wVOoa8ZXDKE78e085e0LER8wyWz4HraH+l06llspk8nHKA8qk7ONB1aFvkw8pLG4EKY=
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr5331338wmg.144.1580812351649;
 Tue, 04 Feb 2020 02:32:31 -0800 (PST)
MIME-Version: 1.0
References: <15fd2e90780c08fe1a2989cdbbe69e95f46904a5.1578492549.git.michal.simek@xilinx.com>
In-Reply-To: <15fd2e90780c08fe1a2989cdbbe69e95f46904a5.1578492549.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:32:20 +0100
Message-ID: <CAHTX3dKUf0RPDt7WerPOe-4fGhqJZ4cAOTjWtrNG8oZu4iU-_Q@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Align comments with register usage
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 8. 1. 2020 v 15:09 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.com=
> napsal:
>
> Trivial patch.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/head.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.=
S
> index 7d2894418691..14b276406153 100644
> --- a/arch/microblaze/kernel/head.S
> +++ b/arch/microblaze/kernel/head.S
> @@ -121,10 +121,10 @@ no_fdt_arg:
>         tophys(r4,r4)                   /* convert to phys address */
>         ori     r3, r0, COMMAND_LINE_SIZE - 1 /* number of loops */
>  _copy_command_line:
> -       /* r2=3Dr5+r6 - r5 contain pointer to command line */
> +       /* r2=3Dr5+r11 - r5 contain pointer to command line */
>         lbu     r2, r5, r11
>         beqid   r2, skip                /* Skip if no data */
> -       sb      r2, r4, r11             /* addr[r4+r6]=3D r2 */
> +       sb      r2, r4, r11             /* addr[r4+r11]=3D r2 */
>         addik   r11, r11, 1             /* increment counting */
>         bgtid   r3, _copy_command_line  /* loop for all entries       */
>         addik   r3, r3, -1              /* decrement loop */
> @@ -139,8 +139,8 @@ skip:
>         ori     r4, r0, TOPHYS(_bram_load_start)        /* save bram cont=
ext */
>         ori     r3, r0, (LMB_SIZE - 4)
>  _copy_bram:
> -       lw      r7, r0, r11             /* r7 =3D r0 + r6 */
> -       sw      r7, r4, r11             /* addr[r4 + r6] =3D r7 */
> +       lw      r7, r0, r11             /* r7 =3D r0 + r11 */
> +       sw      r7, r4, r11             /* addr[r4 + r11] =3D r7 */
>         addik   r11, r11, 4             /* increment counting */
>         bgtid   r3, _copy_bram          /* loop for all entries */
>         addik   r3, r3, -4              /* descrement loop */
> --
> 2.24.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
