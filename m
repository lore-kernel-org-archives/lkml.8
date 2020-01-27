Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58868C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30021739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="gB8aH9bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgA0PKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:10:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45462 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgA0PKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:10:04 -0500
Received: by mail-vs1-f65.google.com with SMTP id v141so2178103vsv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NkoAUVzWFZjHMMtEdPmvHpOHaSeOlTobo/dhUR4U2mI=;
        b=gB8aH9bXLODaT5xi6+YHilW7T0QWwBAAdJXLkkbJnINh/xj60xu3s2hA6DzCwXv+DS
         3aQFGUF9eIk05QAu4EhBap3BxPNU4qG6au51QwFeTW6qPx1AckH1AbWL8k1K0WsC5wu5
         vHie2JLP6hSf9W+59v383Hpr35ojnQNblt8gf+ozgUyd/GQzPax1JGQbCOCSA1sbpmxe
         x2bjcvOhEjsaSKEZ25/CkFgazKBSIvHnyz1d+6VQBFH8EKS4Kj7vHhlyZAZJPYd2084W
         UeUtrhvCVukGhxtzatJIyWhVYMlrdc0lzhy8m5b9p8BUVYRi/aH2dGrsABVOrOYg3PeH
         dilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NkoAUVzWFZjHMMtEdPmvHpOHaSeOlTobo/dhUR4U2mI=;
        b=NNb0paFXcxQARqJFlnE04uli62lAC4d1XHCB67OcMgHXNFz1jTN00s8fsMsnakOJVP
         xfHWFiFW6Sj3NruWB+gVFKb/9GXFpl4C4u+xLjd+xTt1ChqJG+9xCN8+ISjBtHCOUnni
         U6qd01qYEN4/zSZMM+AmREdR6TJZTS6tErd0FW3l+cuBJKEtF4Q0976y8p5abXWVqYvF
         4CVXa0wAUHmUmUeB1y4AhGgDRtzl2VnyT2J0GKE1QDwRJ6FQDDCq0G+Ac8X2wA6M4zgr
         p8IfTPKrSE4GuvsDnU8NdgDwKwZG0d7gSRvzHCW1oNVZtZYMIdGQceT+ZvhW3dKZ5EyM
         p0KQ==
X-Gm-Message-State: APjAAAVbGOq7fGvpIKthye7wrs1q08IdcTglKKQt9sbTf+S0DxLNGzsH
        nbWrLUCNz3VU7Gjxpyt75XH9I+GkyI4kRLha5GbByg==
X-Google-Smtp-Source: APXvYqwXtEK+nyeYN+ImrtWqCwzLW1sUUPSn17lF3dhK2jYXgmqlEoxWUYBw5LsFIOvXnu7JeeiZnw8mTYQ34xHNQug=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr9765471vsr.136.1580137803056;
 Mon, 27 Jan 2020 07:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20200127122939.6952-1-gilad@benyossef.com> <CAMuHMdVrQh-1cEncfWoAjhd6SjJRHZPg9Qt7yVyw5Qrdo+-nrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVrQh-1cEncfWoAjhd6SjJRHZPg9Qt7yVyw5Qrdo+-nrQ@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 27 Jan 2020 17:09:51 +0200
Message-ID: <CAOtvUMcmw_W-WVMGusCnkKBg71540c8Bo7LCMhz+t+dOsPUG3Q@mail.gmail.com>
Subject: Re: [RFC] crypto: ccree - protect against short scatterlists
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 2:52 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Gilad,
>
> On Mon, Jan 27, 2020 at 1:29 PM Gilad Ben-Yossef <gilad@benyossef.com> wr=
ote:
> > Deal gracefully with the event of being handed a scatterlist
> > which is shorter than expected.
> >
> > This mitigates a crash in some cases of Crypto API calls due with
> > scatterlists with a NULL first buffer, despite the aead.h
> > forbidding doing so.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks for your patch!
>
> Unable to handle kernel paging request at virtual address fffeffffc000000=
0

OK, this is a progress of a sort.
We now crash during unmap, not map.

Sent another go. If this doesn't work I'll wait till I reunite with the boa=
rd.
Blind debugging is hard...

Thanks again!
Gilad


values of =CE=B2 will give rise to dom!
