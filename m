Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2052C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8270220637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="tRlCSEkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgBKNL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:11:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54888 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBKNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:11:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so3455848wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UA2beqx54fjO5bKZyYU4NwJP5Rv5VfOGPf4QXCsMCsQ=;
        b=tRlCSEkTLWVkuZ2x7II5PMHiNXEp+jsbcFS9rtGPRIrvMoJ8CKFXAoQpoirL2AxmHA
         bTcMlWGPVklAGpDhcozMQad0sbRQDJ57rVrqM0Q6wT5NA7aw31azy0FDSj7uVphSogqH
         veisg3Z6r7cmHdX0JwUm0aklAnjjsIgsN1Q6zFautoRd2YA4pZirfP3IcRFCJ7hpSzX3
         sDGPAIeub0+xHJnIar2p16e34t0PpVYqrIg0kewKChJv9Gesqtzn2Ot0qM4GRp8wXFGb
         tvI/fXqvjQrRSHDnTQAG0n/TPrFZD0IqBbjm2MOSUL+5PVTjXZClEssqG9RDz0SifaWS
         +MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UA2beqx54fjO5bKZyYU4NwJP5Rv5VfOGPf4QXCsMCsQ=;
        b=EfJpm5qvY8YpFXIiuKcwvsru/sMSdh7VB5wxyAFlbz8bViSRqGh3cTXW1wDBRVEwdL
         boF/0BHJomDiuPoRadlXmFJ43qvbBmV9c2b4zMKF+waufveDNIj9RxGc+MydfvNs491m
         ttBEkjLW3osQtrUSKjkgdgUxZLtumiNIaaDyWL54KSrp7CLbGxvx5pCJXpFatBXBZ1Ek
         miJJAaWTadvm+9cUAiPR6BfJfIfIW+rIFOOF8kSZiiWK5fKywtsUjIN6Gc9kigqNt/j4
         57y7lj5ez37hLZweyxhj/Hbsk4u2Ejz4/km27YvHA4PUn2MNGT4xP/DSPyiSopuEFVbV
         4/kw==
X-Gm-Message-State: APjAAAVxkjP2NFoVmwyv3NxZhsB3w7QDQtFw8B8Fm4bAvY5lsETTNDjR
        a5ArS6Xevzr4eZYXwAoDD0faqva1BWpJtGNw6LVGrlDGxx4=
X-Google-Smtp-Source: APXvYqxvM7qrw/QIMcKN3V7aaR4Z2qEAHd99+tqYYcNGmDV8Id7gU7BMQ9V1GXU6KsiBR+rDjFZoQsFDBDa4dYfmrqw=
X-Received: by 2002:a1c:7919:: with SMTP id l25mr5441871wme.135.1581426713763;
 Tue, 11 Feb 2020 05:11:53 -0800 (PST)
MIME-Version: 1.0
References: <a0f1570686e4cb99025d0c0b571f07a84d6467d9.1579004658.git.michal.simek@xilinx.com>
In-Reply-To: <a0f1570686e4cb99025d0c0b571f07a84d6467d9.1579004658.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 11 Feb 2020 14:11:42 +0100
Message-ID: <CAHTX3dLd_0G3x-bXYSAcad=9-1f3+ujQt8+Nm=7MZ=KwYY7C_Q@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Kernel parameters should be parsed earlier
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 14. 1. 2020 v 13:24 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Kernel command line should be parsed before mmu_init is called to be able
> to get for example cma sizes from command line. That's why call
> parse_early_param() earlier in machine_early_init().
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setu=
p.c
> index effed14eee06..34a082b17a01 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -54,7 +54,6 @@ void __init setup_arch(char **cmdline_p)
>         *cmdline_p =3D boot_command_line;
>
>         setup_memory();
> -       parse_early_param();
>
>         console_verbose();
>
> @@ -177,6 +176,8 @@ void __init machine_early_init(const char *cmdline, u=
nsigned int ram,
>         /* Initialize global data */
>         per_cpu(KM, 0) =3D 0x1;   /* We start in kernel mode */
>         per_cpu(CURRENT_SAVE, 0) =3D (unsigned long)current;
> +
> +       parse_early_param();
>  }
>
>  void __init time_init(void)
> --
> 2.24.0
>

We found that this breaks earlycon support that's why v2 is necessary.

M





--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
