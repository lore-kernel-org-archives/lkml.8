Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C07218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="YEUqwvK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDKdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:33:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43357 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgBDKdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:33:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id z9so10076740wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fh+Fz2HoFQ6H3A8aHY+rVg+mCYQeKifvHzFlIFzIYfY=;
        b=YEUqwvK/s8pF37Shh5/PC1KA6qPDPt1R8EqVEru3t2BNlRgaD4UureZul4q1Phb/c6
         MF2Uhdy1lIKP/o0K+CS5rw0KNZyM502c/r9xk5e2QMtMEjZKtNHlES/HxuTWCi9lcSL2
         2RWfcctbZE/oPlaqKl5jkkHjRDbuLrex6bz+f61H+dtZ2FdVWnlssOIfEaE/kSxPPuoe
         a5tDi+CkYF0gWy0AFkBdy9CrjVKgMrTCT5e4Qh8iWKyc/H5k6LZW+c+Kl6yQtVsnbScD
         9V3OmaKQZQpqOcL68+8pgqy6jVM3TQ7+jALy5TKrZW089L8UwnuEnxqOqHO/gACtwWI9
         XcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fh+Fz2HoFQ6H3A8aHY+rVg+mCYQeKifvHzFlIFzIYfY=;
        b=b9Qh8WRzRgdxaYhmAUi9yO0+B/W5iTyf/fq10GY9AozRLJsnvlGI6mcLJHhIO+fj4x
         nngQKMSnLHgqsMuagCtk78Lh5LtXWDwnW96tO2duQ/RtnPih+Q0cKEvADWt2ouZcbFn7
         11+b1WXwk/0nPnCcuFzSyP2rorDlmIAd629ZS9+EsYwiAMnQ2viZFDFybZsQfCTH4bMJ
         b9953yK4vwlrUruyRBIJjY7fd3Jz/3n0b7xljQnMs16TdGw1qYN7c+c+zghntYlhDXJi
         A4AdejqcnlkFWDYHHMHcJTVPIF9SENtVfzMJ9sPqggwCpzVbZLWRXN4KOkLk50awwK1J
         8q1A==
X-Gm-Message-State: APjAAAXjvxu/2yyPLFGSOTDMwHbdVyPVFpcXUc4YZOX6k95pnXaQB/A2
        VcqqVjkPoJoOtS9KVoZTtV/rawM8sfLmmSWIfPu8w0Z7Fqg=
X-Google-Smtp-Source: APXvYqwgLlGpJ9DILDIcv/14HdRd/hbAtv4XENN2QIrqGPBJbmAp3G/grG33+wUcLASrCgyGW6VR1ECueNm0fmrWBic=
X-Received: by 2002:a5d:4651:: with SMTP id j17mr22084012wrs.237.1580812432922;
 Tue, 04 Feb 2020 02:33:52 -0800 (PST)
MIME-Version: 1.0
References: <4a229093aa94f3191810fc2671e43875bc1de3f5.1579000423.git.michal.simek@xilinx.com>
In-Reply-To: <4a229093aa94f3191810fc2671e43875bc1de3f5.1579000423.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:33:41 +0100
Message-ID: <CAHTX3d+8C1qe-j6Xy4zf1gsG-jvFwF-aosj9NBYXk0B6JSnLVg@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Sync defconfig with latest Kconfig layout
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 14. 1. 2020 v 12:13 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Layout was changed by commit 6210b6402f58
> ("kernel-hacking: group sysrq/kgdb/ubsan into 'Generic Kernel Debugging I=
nstruments'")
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/configs/mmu_defconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/conf=
igs/mmu_defconfig
> index 0e2f5e1fd1ef..dd63766c2d19 100644
> --- a/arch/microblaze/configs/mmu_defconfig
> +++ b/arch/microblaze/configs/mmu_defconfig
> @@ -83,9 +83,9 @@ CONFIG_CIFS=3Dy
>  CONFIG_CIFS_STATS2=3Dy
>  CONFIG_ENCRYPTED_KEYS=3Dy
>  CONFIG_DEBUG_INFO=3Dy
> -CONFIG_DEBUG_SLAB=3Dy
> -CONFIG_DETECT_HUNG_TASK=3Dy
> -CONFIG_DEBUG_SPINLOCK=3Dy
>  CONFIG_KGDB=3Dy
>  CONFIG_KGDB_TESTS=3Dy
>  CONFIG_KGDB_KDB=3Dy
> +CONFIG_DEBUG_SLAB=3Dy
> +CONFIG_DETECT_HUNG_TASK=3Dy
> +CONFIG_DEBUG_SPINLOCK=3Dy
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
