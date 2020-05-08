Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78B8C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4582051A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ajfVEzn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgEHVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:40:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:33551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588974040;
        bh=XJmya1y8SnT4hBUSXuXigAogkzQtp1rc1Z/Frb1VJLQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ajfVEzn+zwtAE5OVl5TsC4IL/96ZzmKl/VbUT0ZYSWUl6cBfatf2+PWYt3tiDy6JH
         HaVY/NOMpSYcAWaL41L8Yhpkk2DWqrSeCfr80XEz4rcsCnd0V9AJ2FmtQD/7RNltzm
         7gG5LMjBcS+wSiT/hffoIndgDK6YjtDalUzHDFZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.246]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1joyhX2ZiV-00IUyI; Fri, 08
 May 2020 23:40:40 +0200
Subject: Re: [PATCH] parisc: use -fno-strict-aliasing for decompressor
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     kbuild test robot <lkp@intel.com>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200508093553.2742898-1-arnd@arndb.de>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <5849978b-7330-1dae-0896-7ecbc6083d34@gmx.de>
Date:   Fri, 8 May 2020 23:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200508093553.2742898-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UGxuUXaGz7NpVCArGrRLq1hDnXA3xUz/E/hZufP40aiZUtJOkWN
 HKrtUYg9G5Ti4HDNj+wm8TRUpcTlhKSRcH3Dg12PPy7jej1y6rGT1zIDe2w8WChliEDjOu1
 hVzEXg5svuZz14Ck9rY6a4AfSj1cZbxYFyi3EeuT0AKgCCYEbjAfufvprsG0aele8mViLon
 jK9SP2ICpoyu72jURiW1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vwuBalWZn4w=:nvPLEcsuviK4pyboNNdPrw
 Wc66mib7ze5EVSjnCdQuUq8Fcx+r8xLULhrMI19A86sVEcAq5M0eLSNOau6wXggSX5czIKd1D
 VKvBPu0JGYVC2Hlpg/8iUlZHy5qFgU59fjzvuFRexQ3AZlnw+CQoy0NW3VNn4/2DZFZHJA2Cx
 +v1aEKSpwhrunwETAhe2nkLm32X6DjVZg8EZRtgw0lYQ5yL3ubJ33lcgwNLk5/RAbRV5NumDZ
 JTR2C+JGP5rdvRtiJS8XKyaons98aqBb3avJLtbXCZakPT9TJeqT4rKpvi72KSOn37ZracSpi
 iuc0ZjpRqE091os2jTjSfrV3laiD6hBg3luPR1+RYUUlH9pr9qHdXXRtVkVg1u/+T+w4446LF
 U+TEhSz2nd+k4lEzw2oGGaBgIRHSaTPytcYWHBg9oxp3rIsTqxFobwZu6g3SvDevxlfIo2lQ2
 xUyyqJ5tKdF89A32apAaNiO/OI9r8f3pmIQFKQZrbbg5VM8aOQvdA9vjV3CeN2MI7znL9fQnF
 Lx9Kdxsx88NqjgGgWWtJuZXXfm3TxYpJWKjvqebfeyu4MAop8EPaf5FrFCzp4l8ngsm+zSEQ7
 HudfblVcW4alUm71ufLLitG7A8whNs5XQ2exINYbSm54Le0ooogpWMLwg/v+K5dbtK7FKn5v1
 Ncb7UkXHuGPvywYDqNvhAYOn1F/bRvMQbLwZ2vFW4is2U0qWL3Rw3R+QDsMXHJVkA08GnLjRi
 dDZER5s2ysIx3jpizIyah4OVe9LK+Utn5BPiS9S70myXtwCrCB3OuNGchpDEWX4NSuG1s/pxz
 j5ORpXpgxZebKULgFBwEiiReXzZ70vaCQ3qRyhc+6WlnDrAme8yikc+zAOXZz9N3XXyIm4r0v
 zBxU+QdxJ3WT+z2atkro2IkHSIBjE/VBQdCNPUPPTROmD0fujlSYItWKVjOUJiFclU0+LLRDD
 gpFpucQGeljbgwfYVhzqk5Mlb8FhlTLtyORYr7UpNKDmythLW1p+f685wNQuv7FX5dU64DXCG
 UMg1SnwIkdDRhmIzSA7/kYD4AY/DdrtvWNNFoTgoj0NroE30X50O43gV7wfk6czb1nY3oB2cF
 9wfQV3Ll2mycJlFJoH7e9yrYlMOkjql2IYVOC+PM6SxZdCPu9KzcgrpdsM/9xxkiYqzOHchHA
 cibcZKhb7AKPcFLcHPS6ceh8PsaEboKIicAgaxZBquRPXRiRw4Gw8bxl+Io/ps05fULAwatGe
 nRuXakZNiswcEsCuj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.20 11:35, Arnd Bergmann wrote:
> An experimental patch series of mine reworks how warnings are processed
> in Kbuild. A side effect is a new warning about a harmless aliasing
> rule violation in an inline function:
>
> In file included from
> include/linux/rhashtable-types.h:15:0,
>                  from include/linux/ipc.h:7,
>                  from include/uapi/linux/sem.h:5,
>                  from include/linux/sem.h:5,
>                  from include/linux/sched.h:15,
>                  from include/linux/uaccess.h:6,
>                  from arch/parisc/boot/compressed/misc.c:7:
> include/linux/workqueue.h: In function 'work_static':
> include/linux/workqueue.h:212:2: warning: dereferencing
> type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   return *work_data_bits(work) & WORK_STRUCT_STATIC;
>
> Make the decompressor use -fno-strict-aliasing like the rest of
> the kernel for consistency, and to ensure this warning never makes
> it into a release.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Helge Deller <deller@gmx.de>

Arnd, will you take it through your trees when you push your experimental
patches, or do you want me to take it through the parisc tree?

Helge

> ---
>  arch/parisc/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/com=
pressed/Makefile
> index 1e5879c6a752..dff453687530 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -16,6 +16,7 @@ targets +=3D real2.S firmware.c
>
>  KBUILD_CFLAGS :=3D -D__KERNEL__ -O2 -DBOOTLOADER
>  KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
> +KBUILD_CFLAGS +=3D -fno-strict-aliasing
>  KBUILD_CFLAGS +=3D $(cflags-y) -fno-delete-null-pointer-checks -fno-bui=
ltin-printf
>  KBUILD_CFLAGS +=3D -fno-PIE -mno-space-regs -mdisable-fpregs -Os
>  ifndef CONFIG_64BIT
>

