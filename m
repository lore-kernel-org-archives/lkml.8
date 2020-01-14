Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B59AC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E165207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ReZikxMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgANGio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:38:44 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgANGin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:38:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47xglP3VjHz9sP6;
        Tue, 14 Jan 2020 17:38:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1578983921;
        bh=8Xd/62pEsfJImxqU2Q8fAGyIgUR8Q6dVQGOz7mkkj+0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ReZikxMRCgXPcN9LdjIiMWt82hBEotcBTQOdAbmt2qPC9Lrkg/f+Z+D/cEKkP6Amk
         UFwMxtvq0GIdH4xoE44foW8horARE0i044FMZuEqBONDLczM/PNke2/o7+5J5mj0rt
         JXd6kA5Jx4bwzQkdrwzgRBMYx0jT7uTcwlCTyH4JNJCtz1Dhd+XsUIN/2xRYrfD+UK
         kEEZVwRPwS9j1efhcLoFCbj0njF0XumxKFnoZYCVNGS9ZOELAb44iGefQrK84QqoU+
         nWsJRdDlQVzU8AHUz+bnysKK/cx6Gc8RiPwDiADwjdbW785iRb90jDv6PBztwR7GeB
         Wz8ZmW5+MOwgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH -next] powerpc/pmac/smp: Fix old-style declaration
In-Reply-To: <20191226222202.Horde.0xaecj7x1FoNwm4fHxlH0Q2@messagerie.si.c-s.fr>
References: <20191226222202.Horde.0xaecj7x1FoNwm4fHxlH0Q2@messagerie.si.c-s.fr>
Date:   Tue, 14 Jan 2020 16:38:44 +1000
Message-ID: <87k15ua6ff.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> YueHaibing <yuehaibing@huawei.com> a =C3=A9crit=C2=A0:
>
>> There expect the 'static' keyword to come first in a declaration
>>
>> arch/powerpc/platforms/powermac/smp.c:664:1: warning: static is not=20=20
>> at beginning of declaration [-Wold-style-declaration]
>> arch/powerpc/platforms/powermac/smp.c:665:1: warning: static is not=20=20
>> at beginning of declaration [-Wold-style-declaration]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/powerpc/platforms/powermac/smp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powermac/smp.c=20=20
>> b/arch/powerpc/platforms/powermac/smp.c
>> index f95fbde..7233b85 100644
>> --- a/arch/powerpc/platforms/powermac/smp.c
>> +++ b/arch/powerpc/platforms/powermac/smp.c
>> @@ -661,8 +661,8 @@ static void smp_core99_gpio_tb_freeze(int freeze)
>>  #endif /* !CONFIG_PPC64 */
>>
>>  /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
>> -volatile static long int core99_l2_cache;
>> -volatile static long int core99_l3_cache;
>> +static volatile long int core99_l2_cache;
>> +static volatile long int core99_l3_cache;
>
> Is it correct to declare it as volatile ?

I don't see any reason why it needs to be volatile, so I think we can
just remove that?

cheers
