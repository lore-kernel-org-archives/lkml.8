Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D77C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839EF20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="mAn8yNeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBDKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:34:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgBDKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:34:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so11389259wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HgQeQwoib86MddFqeLqOm0fyxZAN0jXSuJfjQMWlMmE=;
        b=mAn8yNeO73OxIWDplWTweaT2fEQ+AU2pnxx5itVBpnwq834FQdanmPPCLy6h3lc/zG
         tSPo1hN2snWZniz0bphZnwK4+1VCKRNBtnPp1AZ7/Id1S2F4TmPnbt6VCcq8Io5s4+ec
         F8YI9MlNfukki57kktNlMRJWqe0IINHQ944yNsgl8m4oCzjtbOE6IMEA88C9cufkt9Fp
         0KV7LUHs7LxHGCoLlLGvgy9agp9cYmERlpiymhh1+50koNezAKd14lmbHuYwGWNbel+e
         cg3iK0/DWlQqAlmXvOm1/YKqcj2t5ocD+nlfLfK3QRkdcUVVkiGk8F0B4Yo4/7zwsDmj
         Ds9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HgQeQwoib86MddFqeLqOm0fyxZAN0jXSuJfjQMWlMmE=;
        b=TTR6OfEMyI/+hoRpoItmPD46eCRCcTrozhZIPzxXVk2dmB4rfZ8hC2bFRbkMxmXYzq
         Greb1mf5WgiMtTLPqErekmfuAphESwa/hemWfapXNQV3tMzHvJV+wMUQPeqx1IefGMCZ
         9eOqRqbESQQlLcH2mcGOA1jMK/otccFtz93ebRcTn3NeGGiqIRdw80Uy5bNNkW3Enb4I
         26f5gL5yveKAUdIUYV1VQjUCghuYWYc02aor/hgvCU49CvcrlCayB5UIZnp/6QfILNS2
         JsV5toFFQFwb2tprBqIMhBHpf45UsJzyE2FEBB5UwsaJ1t4/mCxQ72UA0E7iU0Vwjpjm
         /4FQ==
X-Gm-Message-State: APjAAAV8D1lLPiDa4KbmJbZfVOKns8kszrKDAGPD+Ed1XDULGPKES402
        kLtixKtI8uwGLbw57Y8cSrItsWsEAYbtfly14Oq04EapO/c=
X-Google-Smtp-Source: APXvYqyUxjhWou/ECziQ2dasIf3wMAHvVGgnh0UbpYZ4aCoxZXfi1vmFl1hEk5X3awSEPnDHZ9eJAzel8JsETrJexqQ=
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr23383267wrx.153.1580812461793;
 Tue, 04 Feb 2020 02:34:21 -0800 (PST)
MIME-Version: 1.0
References: <e24752dd9ea739c86bca9cfe79f7f29b0afa0182.1579005255.git.michal.simek@xilinx.com>
In-Reply-To: <e24752dd9ea739c86bca9cfe79f7f29b0afa0182.1579005255.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:34:10 +0100
Message-ID: <CAHTX3dJa09azvz=J4FbMAspt1x2wTaG3SWGWAzsDtOiEm7x5+Q@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Prevent the overflow of the start
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 14. 1. 2020 v 13:34 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> In case the start + cache size is more than the max int the
> start overflows.
> Prevent the same.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/cpu/cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/cpu/cache.c b/arch/microblaze/kernel/=
cpu/cache.c
> index 0bde47e4fa69..dcba53803fa5 100644
> --- a/arch/microblaze/kernel/cpu/cache.c
> +++ b/arch/microblaze/kernel/cpu/cache.c
> @@ -92,7 +92,8 @@ static inline void __disable_dcache_nomsr(void)
>  #define CACHE_LOOP_LIMITS(start, end, cache_line_length, cache_size)   \
>  do {                                                                   \
>         int align =3D ~(cache_line_length - 1);                          =
 \
> -       end =3D min(start + cache_size, end);                            =
 \
> +       if (start <  UINT_MAX - cache_size)                             \
> +               end =3D min(start + cache_size, end);                    =
 \
>         start &=3D align;                                                =
 \
>  } while (0)
>
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
