Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB3E20776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oOcSoJTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgFQOg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:36:27 -0400
Received: from mout.web.de ([212.227.15.14]:39997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592404568;
        bh=8tkdqoTug0PPzbs4QfCjTKdykujKDdZBaWTimOR2SlY=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=oOcSoJTWGbvT5FGFXxYm9ebzwXzHMsIxP88nDPXuw0bAkAHQIwVPL7MT+pYGRzDsj
         Q0gjgcvzNDrx0mFvXxltbX2fJWnVUioLwnL+atcjnloA2WhJCbNRJZ0XRcJ3fTvx7l
         CE+ccmBpXt1yB7Yw2Kdjv4IAAOL+VH3701RvT4R8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1jYS882KfY-00M1v9; Wed, 17
 Jun 2020 16:36:08 +0200
Cc:     linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] coccinelle: misc: Add array_size_dup script to detect
 missed overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0a3ae217-c58d-79d6-a164-20ef6392ebeb@web.de>
Date:   Wed, 17 Jun 2020 16:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9PLkx0OS7TgbZyUpfWY4AzjImvNQ/OG8NVVUM3Ye2O13znJJ/BD
 f0rKDVJ1bt5d12nK1R7zb/pXPFk3M26+5/+pn9lvOUS3oB/TQ/Rnhp1dI60J4uA4YUcFX+E
 Vi9RPpGMVSdkH7tU5OdegDkKZV/dGMGmnLgI2CDCbAA7WX/mQAjdhMvdsolBvSyEIJnAZpc
 jR4F+LMKGi4mgLvjyFayQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXcDwD+9VW4=:dEGXb88APLcl/5kFv3FaHz
 qbdfqapAjqxWcMXd6VUcAZeTg8WrO2/EfcNccE8mcpfRIR4Cv5GOqLi1tTXt1S1dPKytz7ql3
 /zUvNLcw2V7K+t1qEQhFZYpEmIeIGi1dMhY3QW/Yo8O4z9AbJs3J+niOp+oNKdHULm4C2peaW
 zdqMGspj1FhpoKWh6187cWKomgFGD9P+V5zow0UGgiomXI5t3qjB+vd3Yq+woFWNoQDiJTM6e
 uEqTAEGK6r/Wn4TAckk3K8PVMmrhj3lgS7PaJrYjbt657BxQyIqNb+kUAvebwEbXP/roX3/AY
 muPVJWfKH59TYtMClOnij7MVFtk5suG2QRcVdxZu93CCTAkQz8M4ppiDJh/qKmRgjd2Y4lnNk
 yopxqzBhR1mbmFupAsS/GrJ3fEs1DJ6VcISyMzyzYH2gZfthPXo2zhA2G0vWgIYg84uWEdl5r
 qN2Rlg7aJ120IPWAOBTcyV28cOzWptt8NwoxkOGwiavQsLc+O8CwYmFfxB9iB+RdtoPr/SRJZ
 U0NHIpLgYQmOx//veuN5ggbG1jcI7QVhGXGZGnz7O5w9S4p402sbS2NFsTXgx/wRjuBAOLROb
 KtkUq9rvz+w6kmgGbFFr9dKGNhHsZWb3VIwa080sv8GdNMTIfXgIeiOQLjXnmNjTntnRD+MjG
 AxCGr8TMRnUDP6LN8Zga66GCwInlhJM994G67SW1c4Iod+OrGP2kLqvJlK8FDMk3Saa3xiahk
 t9HVCC6BKlaZku+PpFs/Nr3U40cjtnA830NCSP9YKx03lqNkpuHBRNOPczVCaIx/xvX+Ls9b0
 DxfuX8jcRRqstOyox/2E4jm9BmTh09NgXMg4HIA1hAK9Z6ZnVYsObcaxQrv2FFSx0BHFq6wPF
 +I9boKMgVsxqnFSaAerm/E6GZvqFr9WowwSr29eiqoz5Q25zjHSkcuCzd3NB3bHMUQHBwJY7B
 K4/3ctFLIV/4lsoiF5b5bR324YHpyfaoMMNqyhwuHyDwnfhrRS9+TgBMjE3sqQM378sbo4hLn
 TIdUqJaBrIu3353lr79vPw2wLgCYkWkSD1H1RquHB+Wmug9RlTsBE6mPC+34x/C2X2/d49/oz
 UETC1oNroeMkkZ+RCRFHVmfeJHs+Mj+k7bTrCmZz/7c8amBlQMKTnatjYUSPtHtQkmdyAfWlq
 xczXumOG/LGuJeC3FAwET+niqTFlKSOUUfF+3zLNcCcH+sKkGYZA332MWypLh4MlR0Qlcfj/I
 palNgNB/LHojmSUvT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I propose once more to avoid a typo in the previous patch subject.


=E2=80=A6
> (
> - size =3D E1 * E2;
> + size =3D array_size(E1, E2);
> |
> - size =3D E1 * E2 * E3;
> + size =3D array3_size(E1, E2, E3);
> |
> - size =3D E1 * E2 + E3;
> + size =3D struct_size(E1, E2, E3);
> )

How do you think about to use SmPL disjunctions like the following?

 size =3D
(
-       (E1) * (E2)
+       array_size(E1, E2)
|
-       (E1) * (E2) * (E3)
+       array3_size(E1, E2, E3)
|
-       (E1) * (E2) + (E3)
+       struct_size(E1, E2, E3)
);


>   ... when !=3D size =3D E4
>       when !=3D size +=3D E4
=E2=80=A6

Can it become helpful to express a constraint for a metavariable of
the type =E2=80=9Cassignment operator=E2=80=9D?


> (
> * size =3D E1 * E2;@p
> |
> * size =3D E1 * E2 * E3;@p
> |
> * size =3D E1 * E2 + E3;@p
> )

*size =3D@p \( (E1) * (E2) \| (E1) * (E2) * (E3) \| (E1) * (E2) + (E3) \)

Regards,
Markus
