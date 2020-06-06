Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE22C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC06206DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="O5xTD3Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgFFLGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 07:06:36 -0400
Received: from mout.web.de ([212.227.15.3]:34195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgFFLGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 07:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591441584;
        bh=x5zYb+eKVaM9gvk0PWnw2iXwjVCPnu6NCQ8qjBh5Qqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O5xTD3AlbHFyfmWRFCRkSIEyzXatPWTqQklOK6goCUie+/a6uw8EeDn0Ej6B+0Nwh
         BgmQAlF1lxc/jm68VXaD7RWLVzIVURFxIo3M+v5hxQ7rS5NujqUUq99BNQxvOaklgZ
         0XZbnsoKyp12IR9ZbhR80uhLn6/A9AYyAkpd8fOE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZUnl-1jOTq10vUb-00LFdS; Sat, 06
 Jun 2020 13:06:24 +0200
Subject: Re: coccinelle: api: add kvfree script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
 <alpine.DEB.2.21.2006060944320.2578@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <51a176d4-8c59-5da1-b4d2-c97b17b691a7@web.de>
Date:   Sat, 6 Jun 2020 13:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006060944320.2578@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0Oagf4uiB6g1QaTD/WYWjzFovYRqF7b52zH2NrVGJ2IcG7yPLz
 IEgZD2ZFdI9VZziO8Bd4xGDGLBItMUPMucaftiyKk1CQ7iESNEifCayXDVGN+uYpvGpqv7j
 xFYBSc8o4b5V7GSpNvPzuwNshzy8uGZdCIDzV0/RdOZtvmFwtpXO096Tj6mjyHN/8qfkOZK
 xlbSARMDIgLl7NVg6Mz1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ch7TljRlw+8=:j7DxN154LqEYP/s9UDfTu/
 dp0pDW3jNdaiFQhbSa0uq18CdR+0qIpJO07cWkw7RZR4vRzmB2gCb4Q9RYZu03vieuHIe492z
 IDaXKWKgcvYbeBWsKzztQUcO4hEWJwi+GvBJDKTgel3MKQoHVuWkdgU+xH2leY2xjuXjzNYVq
 qRkryYi+j8TS2ie1lGsC8d2UxWN7+zFAFJI7zK4+WZ32NEFTyf+iVZ1b0Elm6/PmZffDTEGXf
 a/WxEw5CQOOnVRaNh90pAKhT4vnu0Z2GKWcofqlGa4IPR6jfNwPRGm+jy46OYIdIbnAo3T/HP
 70yLqUPGNujfrgsfLWTHHzLkdaqWt4qy/siblV2+y/BAXUAyuas+dyOiD1kL5grgio8gBlOLB
 CAh2tc6rf1oxWsqSf7XdPkgQe5dMKsvuyKw+XpjZ4pSsA9cP8IfreRRuMtxkLhYcu6oej6HC/
 E67NCFqkarptqN3Us6rF3uYIiQPd3odRaqeCf/ZjTQB7aaD3oKsynU2LokiWEPEUFLwiLe09C
 qnQpMshuGOHP/ktBYID+bU7OQisqodBiH0P6D430j4oHSfGFo8IPVTeTN4p4gTZyergToJiAV
 GQf1W3S+MCz3m3hRoh6BS7uahicmrg/7h9jjRxDcQmMvDyaRxlEnonVXLBp4rHPkHl++BaxvR
 9QaJY7rOE+6a1z2RFXnOQ4OwrMyLZ8aeFWU+RYdvwQjlZSw2QJI252h7FNob1cvlm9D0/N7qR
 KxGGi3rs82PxPGItr7R12X4WWfFt8h+uIPD8cMPpQ28mqibFEkwGmF/+pTVMMT7IrXcYLMYEx
 5rvYqNVc24HOlgWHAFV46mF3y7+V0oL6G5iUzMDipZdUkQs7ucoFqnH6iZ0ie2xrq7NZK75zc
 r2QXtBhqmH/NOruvnlE8ErKk3mr3pNm378lOCoWMuPSXsMjYXFn7UBW+I+hnnw3GgK3TVlzYb
 jWjBP2yJgCF+k3pYQsYEeiMXgqsUVRisSxUE8CRoPmFmHwo+oeY/39hjQ0VLHARNG4BkJjNi7
 ILH+iMEq5uTOeL2SZxWk9N+TkBkFjGprmoG3XM3bEUfxvx0siUBbSml5+TcFLrz9QKt4NCfzu
 Wzs0hwoKKnYbzPiSmue8Pf08DXmeU1frKluexHrjYESYx2ICrpYqHkRlNFT7m9SO0jNWTWwBa
 4ThnlOwNwSB8qr8gjDBxxf2Iijciu5sQdBR8/ESPdP0FUlY0fm2MbF5S0/tMvoSddxLUgvHsB
 bgNLGZ1RUMvucc9Qc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +    E =3D \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmal=
loc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\=
|kcalloc_node@kok\)(...)
>>
>> I would prefer an other coding style here.
>>
>> * Items for such SmPL disjunctions can be specified also on multiple li=
nes.
>>
>> * The semantic patch language supports further means to handle function=
 name lists
>>   in more convenient ways.
>>   Would you like to work with customised constraints?
>
> Please don't follow this advice.

I have got recurring understanding difficulties with such a response.
Will quoted patch review issues clarified in any other ways?


> Coccinelle is not able to optimize its search process according to
> the information in constraints.  It will needlessly parse many files.

The software supports also SmPL constraints for some reasons.
Why should such functionality be used at all if the immediate reminder is
there seem to be more important optimisation aspects to consider before?

Regards,
Markus
