Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70881C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A4B208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qsKCME/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgEAQJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:09:14 -0400
Received: from mout.web.de ([212.227.15.3]:47767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588349339;
        bh=/TjmOCm4U0aWExTuVbPsQ0mTyVz8+ljFawrobEnR4z0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=qsKCME/QdThfQyStH5d/787h/PCtM8k8tV3U7rBtoHozXf+pNNBBWnLIRW96o9sMe
         TGtfBMoHjdSEoi+molzLDsdCPnlga01qH/5Wbc8wMcnLeRcfWMLR2EADtGnA2MoM01
         5s2ExntaK1QSHWpqg0f6il+ZcolhG5WMpPSN08e0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHt7-1jguZq261l-00WECr; Fri, 01
 May 2020 18:08:59 +0200
Subject: Re: [PATCH v3] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200501154033.GA25730@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <a4e38d72-ae8f-9a20-b7c5-7e6880f6642c@web.de>
Date:   Fri, 1 May 2020 18:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501154033.GA25730@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWttA53POdSBxnfuj1b+jNXk0xE0ekoiggjTqo3Owre4QTarTYn
 g4Q1BSgC4Haunipt3etnURAiZbfXSeDThtUcHFrf3hNcoupK/6XdLTgbBRIyCI93D4sV9oO
 RtMFjac5IlAqP13+umL68p7UrAU5GzjbzHTpxouSihd5zhTH3nyQ96y075IlGygim4x26rp
 cVfN9Gx8KXa43JR6spobw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dGGch+bDEcQ=:CafIuNrMYialCFIakjG+DN
 /tqJVuZvD2YuW//cj4I1a/JQAcA0tgar+NkN9ViyXkD7NDkIs2OqwYsIrlXc3dO7Grf8wW8IG
 7eZpSe9AEg/SAuiDbZaxY5qiFKa8be6JW9MLH5Ccv7WyFtIJ2Ec6dCmHlFlei7W6RHO7xvWrI
 UFHaWLivvjyZcPQKx3EKq5BIOpbxmfphXFuSAmjPjHNgBVizfYwKVBZNBWHIXUV60EnnyCxAJ
 xMsQwqnzjk87N4I669w/Ya244aBR6ns+NFxBvkGwH8IOaUeDXqkynYorKuP3Sfc4ncFjeWJuM
 Hi+PdD6NKtImZxXfkoqQJ3AZ8dl1FRMrV2hR0sclt24QU02IBZY8giwaSiXxyZeMjI6S9hwCs
 b8w2GvIUuHaY8+KA6ntknJ9YIfjn78tCn8VLG8UN0y1/qjA5lLRH4Tmdb4IICFO9NO71DeExR
 mO8bD0DlXjZkZsFIyY6OnianlPM69uGh5Hvum0kZnPYfWEjBDX6t+jAx8OfOd0iGybEcDCc8z
 bVYhMPqI2rPZ77Uxl9PE6b3xEXSGjG2VHNdxvoKt6PtkX94ydiCbYvIpR2OYX6FwYq3oYmuKw
 bz76SK0VN4DhZYt8AKHFQkc0Rn6bfRUzs8htB6//UwZ4MEJ1lRJOchMuBWNqs+oFcYYG6dsPe
 7QGfw0Filj7ZRoNKNSCcsftmgQayM+tMDyF3KPSYBk80XX2WuqUAYv5p1jdyA9sd0hBXs7nxX
 4RbZaHnqGOfBxv9i3fVyzM27EEUbYO6/+qR4k9Ddj40jmQ3Ji7ueLJjA8JYYCY+202MxJurlL
 PsgbqrKBKj1s37fk6Sc+4VtpUDA/B4Go0RNWs9U/NY/9+0qkt8xx+ytbchCVfc10ybqwFToCa
 bBKDihgc/P0Fp7/Y1XegckQWlNIPX+TodyeKmiD6NVU3XOKxe+C/C5TJ+SILb0F/C7GX4wnjS
 D1+7oDkWiJ4dHxKxpAKcDKyU8alao9VUNZ/Fotlfm9ZY7CXkZ2y+7DrQzfcKVaDmhdx20X1ql
 w1KNv+2vCXco1ZDeOYlgrbLP3UV6uqzvHhy/MD5tQr4ZA8D8WJRPYWk6PpcaUNXe+c7Z0vh1S
 p73wlzzfl87XK06G9gDtftkDBIf2SGR7pjVVZGlSjxYxiZySrkViq00FLjNPodk2OPY/qyDF2
 8q+Terfk6Ggegx9W2DG+TmWJ+7QGW8AgSZGcTOYusqoSjG94CPnSq5yL4mhYDzqyumSewiCeR
 9RG6riIPr38LyglwW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The check supports below formats:

I suggest to omit the concrete examples.
I would prefer the explicit wording for the support of (Unicode) ellipses
also in the shown commit titles.

Will the document =E2=80=9Csubmitting-patches.rst=E2=80=9D need a correspo=
nding adjustment?


> The check doesn't support below formats:

How do you think about to extend error diagnostics for patch checking?


> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"

Missing closing parenthesis


> Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors

Missing enclosing delimiters


> Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power ampl=
ifiers)
> Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU d=
evices nodes)

Missing quotation characters


> Fixes: ba35f8588f47 (=E2=80=9Cipvlan: Defer multicast / broadcast proces=
sing to a work-queue=E2=80=9D)
=E2=80=A6
> Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')

Would we like to tolerate such quotation character alternatives?


> Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd co=
mpletion")

How do you think about to tolerate extra white-space characters around
the commit identifier?


> Note: this patch also fixes double quotation mark issue for normal git
>       commit description, and now it supports double quotation mark in
>       title line, for example:
>       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by defa=
ult
>       when checking usable channels"")

I find that such an example should trigger further software development co=
nsiderations
for a safe data format description.


>  v2:
>  1: Add support for double quotation mark in title line, suggested by Ma=
rkus Elfring.

I guess that the clarification is still evolving also around this aspect.

Regards,
Markus
