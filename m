Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B99820768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DxcHdp4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgF3IFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:05:39 -0400
Received: from mout.web.de ([212.227.15.3]:38353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgF3IFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593504275;
        bh=0a2jDaPAta2pGBTBPrjgK6rNlIENB8BdbiDPwlDFeKo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DxcHdp4oR2P+7+3wDn9A7F2moCixZuHGPBmikMnttMS+TiGShuPZMPaWq9MGTk8Ax
         d34uc7eO1ZQB/CrEmh3xLffwJISqRWuFAcZd7PswTlWr7Ua0kBsl+X0r50CH7ZTN7P
         R//eI+bt//9Q7vVMVwFzHU6S1olouWgGv2gHomNs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.105.212]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1iuU9w2DZr-00wHfc; Tue, 30
 Jun 2020 10:04:35 +0200
Subject: Re: [PATCH v2] Documentation: Coccinelle: fix typos and command
 example
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3cedcc41-38b2-d17b-3ad5-5a5b8403f953@web.de>
Date:   Tue, 30 Jun 2020 10:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+jKo3ey1TaoZykU449FsWKzY5Ns7C+OliDsLZ/420n38YLVpSh
 mHX2nyrC6/COPCjq6wmUzIfUxb0VUJeZYsvMQM9hndq/GyBnwGQ3T41FXAoP0r8DAz1t9bf
 OUlKAb/kmikcmxQ4JDFPzzhotdi7u+uxfSechjjzY5772NmUpv2lUVEYp5GOKmoNRZPNcbQ
 jfajIejT7540a3sEQFBiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uh3H6WoO5Ho=:/binRVePZvRad/OrOa5v62
 6N5O3fZWaSB7wZ7q75GjYbC6EnDzQIdtG8K+5wY0u8/rukfVk6tGzbrmyPT2nzC/1ziRZjkjD
 CASfP/0GSlfz8fGMOtNqQMvtgpV4OnHAgSJbkcSUbYrBEX7Z6Ti9Q/cT8Pm1CKsvIl3IF3TPi
 wmANqjzzTlLLCDrQOABH18uFO/S/xXjKpZ0NuNakBfBGKuOjZWRkZ53oPee/8/g+kFXC1oA/I
 4cXL5EYkEvLn+ezVX1a5zDfEuDdjEOzWeipIOmyYrbzSMIoCizZr/WgUqbSTBCldKYXBnj1eB
 lzmNEGzF7K0Ax+ZJV7ZMHaswzSWHQclCktXN1CHinLcpnwC35tgrLCz7FRSQWmqeWb6LfoqeA
 y+LAMb1I4nHOxs4GwzHhsyVsL4jl4yJbmYu7hDD0QUkvNOKmDZHHewGcU2CbFjYX2FmRu4hEX
 zsgVvrphfXozMjxKdhi/fefMAKX4akjYu+MX/NnB9UIvyuBZtp5pC5vPzgXUb/KivbOHR9iVz
 55o255LxEj9+nlPiHmYjblpC1BJ7Y/meyv1p2MP1I/JQbo5HDsSppONFth5+vWDfA2wUQbKaF
 bVUGerzRZX6i3gSQ9SGhWUeBCuA3Lu8w3S/ATmBniaBcfOEeRQw1H/N2PM7aLX00HZQGa0s5t
 TE8OYe32u4ncu4hLah8aztFN6+kU3Hd0/4xVy76Jdry6P5ZWRRbC/d8s7PxnYK7+OhUc1MFgW
 o3uXwcwsgobSPScETDmYFvatHknYdYP+yYONNf6s1xcjVVaxtsuaM0iitbnZC3ZXRgNA3tNeE
 O8rkUTSntHzEGY1rCZQTAwy8nDqrKgSk308YDVsAzs4Rc153pcW6sp+ECM/HRBhNR9J1wTwLH
 NcBWwHlrgY72KxnTr39xkJyqv1oiJMsnNkspT5TS0EXileK280Vng+GkRyjSiUe6rX9kz/Ndf
 xuK0Z0MrUJvFcK+Z8mrQJDCZ98ZHiag5bw6cSOKdyJfk1Gijw2A79X7XW3xf6xOLaoy+RTwVV
 apGPmMJzzcgMMDalwGaiFoU+AFU8D+wsh6XHk0lQY2PAxytIdI02lAg/xC9dafaontIzn5SGz
 uL1O33zmRhhcQzElIcrq+ZtRJSTkIlDmZ4eyEiVXScUbqEhod8dh8734WjSZGHKve7VrWfdWa
 UHFlijxk9nVxxKRVi7Icz7CJFurOmas4s7/0V+eVV9dY1HRtvTSRqXvBqEwo22dID7NCYhl5a
 BdCmHtG1b9erZE9CV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
>  To apply Coccinelle on a file basis, instead of a directory basis, the
>  following command may be used::
>
> -    make C=3D1 CHECK=3D"scripts/coccicheck"
> +    make C=3D1 CHECK=3D"scripts/coccicheck" path/to/file.c

Can such information still be questionable according to usual make functio=
nality?

* Do you usually expect that such a source file does not need to be regene=
rated
  (because it should be up-to-date already according a selected revision)?

* Would you like to trigger the generation of a corresponding source code
  analysis log file (or a =E2=80=9Cdiff=E2=80=9D)?

* How do you think about to pass an other parameter to the build target =
=E2=80=9Ccoccicheck=E2=80=9D?

Regards,
Markus
