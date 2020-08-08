Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6B20759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="a27s0HjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHHMKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHHMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:10:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A43C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 05:10:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so2302534pgh.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EuDMSmp04hSHSVLRHL1PUWBPuYB4U3JnGDB9t2qv6ho=;
        b=a27s0HjDAgd0N2W+2hyaEb/r9U8rPWgKPcToKVqzsY6g1RHey3lP/n73NLKJYe/Ok9
         55O55oJSSu9auuHd0IZZMeayaFYrB0XkDdzao+sYMQoIml9w00hFjBH8r/pwdPpew/sz
         D4U3ycTuRW2hhSyGQ/+vQPPBrkxE9ZKOeqrJhg7L0PM3vPL7tG3pJcxpNVs3aBK4ByJe
         KCqGQqzLjn/hShsU0zUkoh4exC0lP0KHzK4vtrIfJ3N9ohkhYUxOT1oj/NDw/OG3J1d+
         9y8hysX2pQorUHhg24RtZ6E+WgR2WN28nXtkQnzysvPpbbsZGt1ljbQWW59Kk3ViJl54
         tcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EuDMSmp04hSHSVLRHL1PUWBPuYB4U3JnGDB9t2qv6ho=;
        b=n37rJubn47mfXO02SZg5GcsruowDOmntFMxvYmViQOUiAmSQ2tl5q0awil9PKjnFpY
         aQ2qZrrPc2DyW7ZSHxYH7BDZijC/YbLkkVni+qaNKiOfFIipiQyExXOl31a75S55qDRy
         AhzWjyzlEIHaZ7K4iu4L2HVPecxVok7wpTlaGaIbfZzUBZBJ6SvtOhxp9IjKkMe5jjRU
         eemuq6a+KTOS0AK/EoPMTAlnqgXXfo3PZc/gO9Wm2M+IF7x7V0oasYDfu1FCUbFZfMbA
         WGzvy1TA12zhQpZ6jFlghrx25JCnipBKMQDlnTp1MT/y5zBHyhphuwpe2egj9hEhz9Ap
         mqLw==
X-Gm-Message-State: AOAM531Sd+LHiPMiXvFLz/gGesles7hFNRKRuxvwsltVqI7U57LBoVin
        KptGHnK4AmdxzoD+I9SQ45i5jg3IUBVB6586v26OLg==
X-Google-Smtp-Source: ABdhPJzM1muWFLwLDSvo0MoNAYjZ2t7+UNajWvXxXMkjymrpkaeIPbZuHepCLbtxZZBVSatO1nbVYIIZ+/IHe775HYM=
X-Received: by 2002:a63:4b44:: with SMTP id k4mr15861573pgl.305.1596888644708;
 Sat, 08 Aug 2020 05:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com> <20200807162010.18979-17-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-17-andrei.botila@oss.nxp.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sat, 8 Aug 2020 15:10:33 +0300
Message-ID: <CAOtvUMero-gF5ZE1unnD_wcDnzZX_SL0tQ2yJNqzc3rg5RhuDA@mail.gmail.com>
Subject: Re: [PATCH 16/22] crypto: ccree - add check for xts input length
 equal to zero
To:     Andrei Botila <andrei.botila@oss.nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 7:22 PM Andrei Botila <andrei.botila@oss.nxp.com> wr=
ote:
>
> From: Andrei Botila <andrei.botila@nxp.com>
>
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
> This change has implications not only for xts(aes) but also for cts(cbc(a=
es))
> and cts(cbc(paes)).
>
> Cc: Gilad Ben-Yossef <gilad@benyossef.com>
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index 076669dc1035..112bb8b4dce6 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -912,17 +912,18 @@ static int cc_cipher_process(struct skcipher_reques=
t *req,
>
>         /* STAT_PHASE_0: Init and sanity checks */
>
> -       if (validate_data_size(ctx_p, nbytes)) {
> -               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> -               rc =3D -EINVAL;
> -               goto exit_process;
> -       }
>         if (nbytes =3D=3D 0) {
>                 /* No data to process is valid */
>                 rc =3D 0;
>                 goto exit_process;
>         }
>
> +       if (validate_data_size(ctx_p, nbytes)) {
> +               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> +               rc =3D -EINVAL;
> +               goto exit_process;
> +       }
> +
>         if (ctx_p->fallback_on) {
>                 struct skcipher_request *subreq =3D skcipher_request_ctx(=
req);
>
> --
> 2.17.1
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
