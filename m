Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B7B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mFtzbb0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbgF3MXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:23:35 -0400
Received: from mout.web.de ([212.227.15.3]:60261 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387468AbgF3MXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593519793;
        bh=KN9lDrbA86gs3XxUjlxxnYb0gsbmKZvmCWqYjfRY1Hg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mFtzbb0UgDZsFrAjiQMea1POucy9DqQnjuYFlJIznAZXt1wyJGeswjjrY/oc0fRSr
         7BTwETTc3MMA1ibqhpBJEfaoO2KqNJ6WGa/rDi+1VGDRLOC5CNTncEaTdMFtlQ4C2q
         O1/3WsHCjtxh3Dg45tI+Ibx905Qfb1yZCnnhPQJA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.105.212]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1j8tWB232k-00ju2X; Tue, 30
 Jun 2020 14:23:13 +0200
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
Message-ID: <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
Date:   Tue, 30 Jun 2020 14:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:any8T7vXFwitFUoBzHoq5KuVfYyHIIxOQg9JKGyvLaHIT8xRLqJ
 VUFRfLzX8x8n4+nkAifer9zyCAiTzvodPdn3sTUpty0R5QaNIS4sMxDkpmBR3IKiKqXfJax
 3SUQjUmzZOp0yYLe/m2GgAeaPGYWRK921jGT6sNInA13eeSIAIE/NjvV4SqnokqyDFPrtsa
 vGY8z4bWrGSx9iIcqLZAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0wNTQzukaY=:+2o9ufJx4Maeaa5IwaZ3b1
 vxRGdE2j8neNYJMm4b1qtbgRe7ZaiS58QkS8egJf5yFruUvoCrxSE4EPjvF0MG6+TEWD1+R/e
 40tiUWDdl/BkXkdsXw7xvG0zSqaCmjvQpoGf9xGiSz001OstCUAn/R63MBxwAm4txDmcmS8HH
 NWmtmc8v0mCI7QEcfTSGXlDUvIwtD/v0+ljQH1LiFy9R8vYGS6AqzK39wZ00URWBS8znZJz+7
 YIdUxgt4tEonPO6r9tXtOj6XMOG7uW0q4zDLl4jzN+s594AzxlbT5pR4SQEYdLjVxld2w5z+Z
 KrWQteCJjUYSNAsY9XsutE9dKHLAxz0iFZ2EtEcIA6rrCyv4fc9pdZz9c7NpIKDZ/GjssvlhG
 7Q1RgI+VgypO9l6g08hR3LUqp/vvef1BJ5dqjCYMp2F0V6Glpmy0EYpwZPHms5xzYc6Vp3HEc
 s/+xT6gcVqrM4nxjuCosB0jvn9LN73Pd0JM8cxRYSTNvGOqh0X6NAVtDApjg4WDj0tEa4m5Qn
 Jp93Xlp5fJDSgkMZNZK9sQ3px7LahczY2OP12Rx8hKHQwxsdjSPuJScAq4awFP1ew1zdWUVXW
 Den0xDiwi9rHzHe2PxPFZhI9A4Nshmo9KM63l2MCOYK8xIrWDLkDhf/R0DoBt344vxxwK1QDC
 NgerS2enEkLSR354s4PbzVeWyzmf2i2mhVCEkfWBZS01XBUm78BOd26kAa/1Od4VkOuALLtS7
 RHjmBlB+9s5Q9HpKxP/lqbsSSyZ5mxlavOYy6CS4yVlOsCozEqPUoacmwOZxgP0yG5XpCvTQN
 UEX1E2cAeFtCT2tqHt0pGfekXaW42/zQrrGvXcPNzs3l545BuHcqwnR/tWeXedtqR1YonA705
 Y26S/K5kqj/qZJ2qxbiUyJFpVqM+tu07+hnUFpk9F4zcHt7qYL4zpG1ujdJMVtWhlUnoFNcDp
 KxnsK3UTpM+T+xHGnvHk7MpBPuIH09PZGNseCGWg4/Npt5kN4zu/8UeBTr8SBurjZZ+l6gaPN
 3nOPgsqgSmY4HR9YLSuoW5aadEF1pjkIwgkK/rL4yzcaWzXmw6tdybiSewaUM55xiUeXOZZgo
 iVQEdvRklNIw8AaqHwHI/MCFIvxD6PeBaDOE/jFXhF0Iqw/4BAyAFVanW14/cQwb44ZqAprRg
 uE9K0anKFo4s2CWXzBAlclxMfTgYOExo8FKlDviFoObWiRyxMWAzZW3CEKdQ5Rt165IRHkvXU
 HEaqX0kSc4TqywwjZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
=E2=80=A6> @@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
>  To apply Coccinelle on a file basis, instead of a directory basis, the
>  following command may be used::
>
> -    make C=3D1 CHECK=3D"scripts/coccicheck"
> +    make C=3D1 CHECK=3D"scripts/coccicheck" path/to/file.c

I would like to clarify further software design aspects around such make f=
unctionality.

We might stumble on different interpretations according to the wording =E2=
=80=9Cfile basis=E2=80=9D.
Do you find a message like =E2=80=9Cmake: Nothing to be done for 'path/to/=
file.c'.=E2=80=9D interesting then?

* Would you like to add any links for information around the support for
  source code checkers?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Makefile?id=3D7c30b859a947535f2213277e827d7ac7dcff9c84#n198

* How do you think about to enclose the path for the shown parameter
  by single quotes instead of double quotes?

* Can such path specifications become more interesting occasionally
  if also an other file extension would be chosen than =E2=80=9C.c=E2=80=
=9D?
  Would you like to achieve any software extensions around suffix rules?

Regards,
Markus
