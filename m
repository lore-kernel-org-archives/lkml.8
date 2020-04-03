Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3062C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE71C2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ps9PQGj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgDCE6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:58:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52369 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbgDCE6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:58:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48tnkP0CG9z9sP7;
        Fri,  3 Apr 2020 15:58:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585889886;
        bh=myGZfk5+8kS9+3QY0Gl2TRS7UtcpQlBFRKPmNbN1p7s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ps9PQGj8CIphQ8f5Qa14U0D7vOz/gHTuS9BaJxS6PEQUpS+iOJFCLkwAME/wax0Ug
         jfgoCogWTOd3CwQpMIEdVDJhXzTtVzSA1ZHk3vbAXoW1A0arU0j/n3es3H/Hc2D0xG
         z+MwMmXtUn0Li0aslk9CPXPgyLl5ymQWREN6zjoM2RV317YMpahnCglxCM9JvXNj1V
         snwJoA1+gpb/rXvU/rYhWGIi1btHk7R4xDvczEjmN4ErXWMKbweSSBPdujKVtd2LFP
         l6YmHVLfBhPQmzFojjdBh4BIkTIawqzAUjhWbJPxs2zFtS4tA18lcyiYH2gyUOQ4eO
         mnRTdO+EHFTRw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, gregkh@linuxfoundation.org,
        christophe.leroy@c-s.fr, allison@lohutok.net, armijn@tjaldur.nl,
        tglx@linutronix.de, aneesh.kumar@linux.ibm.com,
        yuehaibing@huawei.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: ptdump: Add missing include <asm/vio.h>
In-Reply-To: <20200402135828.37308-1-yuehaibing@huawei.com>
References: <20200402135828.37308-1-yuehaibing@huawei.com>
Date:   Fri, 03 Apr 2020 15:58:12 +1100
Message-ID: <87sghlrwrf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:
> gcc build fails:

What config? Custom?

> arch/powerpc/mm/ptdump/hashpagetable.c: In function =E2=80=98pseries_find=
=E2=80=99:
> arch/powerpc/mm/ptdump/hashpagetable.c:262:18: error: =E2=80=98H_SUCCESS=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98FL=
_ACCESS=E2=80=99?
>    if (lpar_rc !=3D H_SUCCESS)
>                   ^~~~~~~~~
>                   FL_ACCESS
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 65e701b2d2a8 ("powerpc/ptdump: drop non vital #ifdefs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/mm/ptdump/hashpagetable.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptd=
ump/hashpagetable.c
> index b6ed9578382f..8ea5f9a3b658 100644
> --- a/arch/powerpc/mm/ptdump/hashpagetable.c
> +++ b/arch/powerpc/mm/ptdump/hashpagetable.c
> @@ -20,6 +20,7 @@
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
>  #include <asm/plpar_wrappers.h>
> +#include <asm/vio.h>

I don't think you want vio.h, hvcall.h has the definition of H_SUCCESS.

cheers
