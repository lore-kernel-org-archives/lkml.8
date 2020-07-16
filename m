Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CDC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7342065D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594915005;
	bh=jJqrTNbkQoxcAWYZupWzp871YfiDMozrRJ2TOMEZhYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcLYndBp9XFJ+xlJG/NtdqsMB4eg2ItFu//5GU7HV+6CEGxM/eUfr7kBl4BFWfaC3
	 N6EZDqGb8+VnVLJAoh6KEHE1rEilMA90N9/Vi7l/FeML9WMNrwEmU+bcULSWLFz8EM
	 AIioRh4Fvv0Iy15CnCNp3fiwSpydiRA4y3PuoBAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgGPP4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgGPP4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:56:43 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9D82065D;
        Thu, 16 Jul 2020 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594915003;
        bh=jJqrTNbkQoxcAWYZupWzp871YfiDMozrRJ2TOMEZhYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovNPcAOcMxsNl3/H4OnTt/3Y3PM1kwDwZjH1Zf/fiJFIH+5Wm/WNqlwlDp5fq4SRP
         BnhGAzcJ2Nl3fnJNQAhtRFdrXThUDzYd4MU3aLuOsKDyT65YYR6BdmKPpkln1uwb6z
         TG02wqIGy65ryBJl7Glad3OXoN4uRVuV23UVJGCE=
Received: by mail-oo1-f43.google.com with SMTP id t6so1269136ooh.4;
        Thu, 16 Jul 2020 08:56:43 -0700 (PDT)
X-Gm-Message-State: AOAM530QyulxfttKS9ovNJJ8wS48CqAJk6c3rzER0bF2sGyzZm24wmyY
        dc1SROC3ECkRoIRt3naFkUvSSgFqVjVsiYpCiMs=
X-Google-Smtp-Source: ABdhPJxeJ6PQM06OfuW17AZW1S09ijhVmwxYQsAwizY5gDnabvoEEg1DshcxF5n1QkCmEFR05Wh1iXa3yal7FrHGtaU=
X-Received: by 2002:a4a:de8d:: with SMTP id v13mr4799786oou.45.1594915002430;
 Thu, 16 Jul 2020 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200716152900.1709694-1-colin.king@canonical.com>
In-Reply-To: <20200716152900.1709694-1-colin.king@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jul 2020 18:56:30 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEWyweZ0E3WHthEG9oiOpOS9UxtTB7xskAsF8FeinNg9w@mail.gmail.com>
Message-ID: <CAMj1kXEWyweZ0E3WHthEG9oiOpOS9UxtTB7xskAsF8FeinNg9w@mail.gmail.com>
Subject: Re: [PATCH] crypto: xts: use memmove to avoid overlapped memory copy
To:     Colin King <colin.king@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 at 18:29, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a memcpy that performs a potential overlapped memory copy
> from source b to destination b + 1.  Fix this by using the safer
> memmove instead.
>
> Addresses-Coverity: ("Overlapping buffer in memory copy")
> Fixes: 8083b1bf8163 ("crypto: xts - add support for ciphertext stealing")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  crypto/xts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/xts.c b/crypto/xts.c
> index 3565f3b863a6..fa3e6e7b7043 100644
> --- a/crypto/xts.c
> +++ b/crypto/xts.c
> @@ -169,7 +169,7 @@ static int cts_final(struct skcipher_request *req,
>                                       offset - XTS_BLOCK_SIZE);
>
>         scatterwalk_map_and_copy(b, rctx->tail, 0, XTS_BLOCK_SIZE, 0);
> -       memcpy(b + 1, b, tail);
> +       memmove(b + 1, b, tail);

This is a false positive: tail is guaranteed to be smaller than
sizeof(*b), so memmove() is unnecessary here.

If changing to memcpy(&b[1], &b[0], tail) makes the warning go away, i
am fine with it, but otherwise we should just leave it as is.


>         scatterwalk_map_and_copy(b, req->src, offset, tail, 0);
>
>         le128_xor(b, &rctx->t, b);
> --
> 2.27.0
>
