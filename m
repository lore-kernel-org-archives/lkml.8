Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE3EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF400215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVzWZ0PL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIHIn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgIHInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:43:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA9C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:43:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jw11so1772761pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=OXlcroGke2HNevojS8gO7AGdbKr5HayaXxgh0v0a9Rw=;
        b=VVzWZ0PLhoBOyRnLqIhBP8KlfFI1wesE/ceDJIN6T0dgy7xPyIv2MSxmQkM/5WqrTI
         CFU0k8luUZ6jx5bUjXraLG3G3v1aUp5DWnYzAckklhZatgNFvBRMP8G1bzLRwmUMQ/M0
         PYyMPqh2IN0GJ0D6oJTzBd42wd9VCjv+SxeubQlPrU8G6nL2DQlHoxGas0g2MmPNJuYf
         jNUkMDi95Xfdu5HXwvf/SFKXlsv4hdCtz4HZ8itfx96TewzGNl5b32ilpqFKNr97eC44
         EWfDRmXwk+OGeJhaEDqBuHIlDO4cI5awDYMI2K0bmd5V6Oned79/6dnQ+TEbTTg+rtwM
         +wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=OXlcroGke2HNevojS8gO7AGdbKr5HayaXxgh0v0a9Rw=;
        b=gnyw7Tz1a9Ozl7aympS95cv1UpSK2ZBTVaK+mnokKhmZuHZGFECuYE3ZhBRbb9onv1
         DPLcu//+dJ5DGRN/v9iKZUSufQegEcJR1RIzQhwtbuU+2aBBGuqvea6x+bXGKm9QQzLq
         4hTRGI8gZsck5LTZY+GcBRjDsL5/2eK/q8crFV1KSca4y2LKtEZrBl43krsWMjtnMfMd
         yE/90XzqEALxhUAHjic/hIig7p9VHyTG++k0i8Qynl585Rkd5ebvCuyr0RKq31811hm+
         U3DWxwaQ7Yeuy3cZgUTQC8QpvXP42BszaHfjcVjNrOp+mbVY+6qWPiBa+iLOq0RAeHcy
         MB9Q==
X-Gm-Message-State: AOAM5333lNpLIlsrwfTm8sgrQqlktpUqJqdsIn5hx/sy9qd+3MoqQxB+
        sG4g8KITiTvNevJ7eSTxvghWtolZzrc=
X-Google-Smtp-Source: ABdhPJxzyS9TfAzWvwCFoho2mIVMNDIB0pBbFX9ag1Dk5md5II1gAiOC+3ef0morgOeUwDCSINndIw==
X-Received: by 2002:a17:90a:e795:: with SMTP id iz21mr2979053pjb.8.1599554634620;
        Tue, 08 Sep 2020 01:43:54 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id b10sm16891473pff.85.2020.09.08.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:43:54 -0700 (PDT)
Date:   Tue, 08 Sep 2020 18:43:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 1/5] powerpc/mm: sanity_check_fault() should work for
 all, not only BOOK3S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1599554359.m174sr2fhg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 7, 2020 3:15 am:
> The verification and message introduced by commit 374f3f5979f9
> ("powerpc/mm/hash: Handle user access of kernel address gracefully")
> applies to all platforms, it should not be limited to BOOK3S.
>=20
> Make the BOOK3S version of sanity_check_fault() the one for all,
> and bail out earlier if not BOOK3S.
>=20
> Fixes: 374f3f5979f9 ("powerpc/mm/hash: Handle user access of kernel addre=
ss gracefully")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/fault.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 925a7231abb3..2efa34d7e644 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -303,7 +303,6 @@ static inline void cmo_account_page_fault(void)
>  static inline void cmo_account_page_fault(void) { }
>  #endif /* CONFIG_PPC_SMLPAR */
> =20
> -#ifdef CONFIG_PPC_BOOK3S
>  static void sanity_check_fault(bool is_write, bool is_user,
>  			       unsigned long error_code, unsigned long address)
>  {
> @@ -320,6 +319,9 @@ static void sanity_check_fault(bool is_write, bool is=
_user,
>  		return;
>  	}
> =20
> +	if (!IS_ENABLED(CONFIG_PPC_BOOK3S))
> +		return;

Seems okay. Why is address =3D=3D -1 special though? I guess it's because=20
it may not be an exploit kernel reference but a buggy pointer underflow?=20
In that case -1 doesn't seem like it would catch very much. Would it be=20
better to test for high bit set for example ((long)address < 0) ?

Anyway for your patch

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
>  	/*
>  	 * For hash translation mode, we should never get a
>  	 * PROTFAULT. Any update to pte to reduce access will result in us
> @@ -354,10 +356,6 @@ static void sanity_check_fault(bool is_write, bool i=
s_user,
> =20
>  	WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
>  }
> -#else
> -static void sanity_check_fault(bool is_write, bool is_user,
> -			       unsigned long error_code, unsigned long address) { }
> -#endif /* CONFIG_PPC_BOOK3S */
> =20
>  /*
>   * Define the correct "is_write" bit in error_code based
> --=20
> 2.25.0
>=20
>=20
