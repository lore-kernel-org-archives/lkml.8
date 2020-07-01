Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D6EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA10320663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ndSbaaSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgGAPPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:15:40 -0400
Received: from mout.web.de ([212.227.15.3]:36769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731804AbgGAPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593616511;
        bh=mYyt+czBz/JjrHxGH28ejngDa9fCpCF5RDmPyJ1eELU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ndSbaaSYZkzO6L02YU1biqCTfJsQ65scUbQiJaK0tWazQ5DYRRrZ244naPTb1xWt4
         SOtrNyaxRYBqRLJfqi8CEGGQJjq/BMRanpN1HiVvXrYqSx6eKVaWkdDIRLh7hwZLFl
         KdrRNXEKKW/UNR+HFgPfi+/d6/HYGMy1pIEoMcA8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1jUjqZ2fmS-00M7ml; Wed, 01
 Jul 2020 17:15:11 +0200
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
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
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <35c7a2b7-a54c-ecd5-9903-efbb6e3c01d2@web.de>
Date:   Wed, 1 Jul 2020 17:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RY12JdU7m8+i1sTWBDxHFCY+edH/BqsXpFJKxljSNoni/uHI3GO
 ok0qvRnVr2kVtwXLZhlLfJx4OX+VOvcWukdfExcMRVQ095l2BWTag3wWmrHOHqhypA7uXZN
 H7AoTw+DMXa2BzYcSfVrfWZao7pGQ86mIjD3r3tIf9ghDyx/D7W312Gfvvc8ZXeul1ifPFn
 QRBM/aKotEqH3GnvPVjWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0gjBZHObxY=:QZ7uxDAG9XSD57ou8ItKxF
 lfM9qZhMT3InCnZtTECnLIaNhoW1NIh1PAND5voFGoeVbjkQiR/m8p4C3B9U7sjBlESPEUcsj
 zJg7YjedpIOxx1gPGr2lP99FCS/aPDaacnbqHrEdytkB6utbfSTJt6wF8TEdO7hxIplGvLtuW
 pZmb+AIBPuajgr+WpClYz102ym7N305maJaPJu3Ysk65skhD6kqwOquypcScL2vaKjj07uJLw
 XIbUmyTtsgYl3qkUsaEXbsLwWZeyudEqEvwYfPGpEjgzOuhtLClwaJjF7l8Z5+vS16lGbn6q4
 Uh41ouJapB+mz9mx3AFxSgHqRSG6TMsNUBteSu3EPgcfziTFhsBckuBnE22WEQrmd3UhOUiS+
 6co3FLjvQ6igBUYI+Bn4Ij5HtkrrsytBMngduALb5gaRbbfy0voRu9xbh/CF9MMYWaBv+2Wh3
 QcgclZkmNQVtq8KSODu6L6GoC3VSeGlQtYNhOSlFcQhy5r5jqg1ASoXq6YVij8x4EvTeiK6vM
 kzGkkEpHpdzUMfI/1B9m5POHNPVT/28KW5FEtuRn2OFPJ7vzqtIuv1ZpUT0cuZR0A0foFr7fU
 LuICRpkEXKk+xFZbxwwIPTWq0RDAaw1iIBv2z7p9et6dvnw66Kf0h68xM1/JYMzFCM5Q3LMbA
 T9ZiisgiBFCTgOIkXD/Zs4SCSL+ev2MWhYqr/s5Pyme6y4lBXWljqEm3s/plPT5rAN4h26uvT
 8H7BQZrC3o207hhVoXXWmxAdMSa65UPL283hvlGQxIKtvXlMWmbSM6mB8e1QHJKnjHD1fGe7/
 axZTNPvjw/Iz6keo9Br0/AUBhB7fTozxU3FpOuS24EzatOiFJY82McYit+y2/twJAd5Or8GOD
 iAXl/ScPn9nQ+t5d0SL759vk2VsvaZcyoyZJi1paU20/VrDIoKqxP2qPzfTqYMBGMTBbgTe2G
 A5l9gnTCgyAH5fYzpVd0pTOtejWSCyYpKNUeNj5wcGMhqVR1FV14YmKCgrMWr5WCHUgftWk08
 cf1IoTdYWU2evGtQFV/Y3nQkWYLRLwT3wnMXX5nnGt/cdSzisbVSiuL94J+dZEi/H0oe1d418
 EZwayu+/sYqvLQ6QGzSSYTRzPcX6uwqDoaDV5o59RZcbLWMKJwLnAM4dvJtlWoLBwQPf56Ms8
 ZZWUyeHRb4KXFJiooSndvlmaVJFiyaOx8cutKiVr1vKpFv56vjf848a0IYKA4b550n3QVMZo8
 Lb6L0RpttldKrckZ6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you like to integrate any more details from the running patch rev=
iew?
>
> I am satisfied with the current patch.

I got an other software development impression.


> No doubt that any documentation can be improved, almost ad infinitum,
> but I'm not trying to do that.

Do we stumble on a target conflict according to a specific technical detai=
l?

How do you think about to compare source code analysis results
from programs like =E2=80=9Csparse=E2=80=9D and =E2=80=9Cspatch=E2=80=9D (=
by the mentioned make command)?

Regards,
Markus
