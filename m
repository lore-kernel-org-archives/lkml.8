Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86336C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65711207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VGYmVfaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgGAPc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:32:26 -0400
Received: from mout.web.de ([212.227.15.4]:44383 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732012AbgGAPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593617528;
        bh=ZQP7U94uAMtQ4nQN2HOSGtdVfRD6kx28RrF7YFrvEh8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VGYmVfaVvi7ro/uc+9j/TNpQIDWeqEuCoppIvDxx8kf8gXcFYdFzYNxK9XPHNTnmt
         ZlLgYF96hrT6nZuaHbqR0Rq7el1JwYiSpJO/C8q9CDoNIwsdGqL03KpDf3ph2KkVi3
         vi1imqV6kFeB3JMduMRBie4y3wrjXD4trj65F0jY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1jPBfQ0ICq-00RZdd; Wed, 01
 Jul 2020 17:32:08 +0200
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
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f4a8c007-f572-aee1-c0a0-9f1d97be8ace@web.de>
Date:   Wed, 1 Jul 2020 17:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0jT4cJr+FFZi5slUV8aCDn+1UCkkmOYDj7yJ9AnD7trAXVdObg
 95hXsFOOHihvCT85Asf8UIpLsiMxRrmBbsDj2KbaXfb+zYdOfkLRVG810nngHtdjiyedjDW
 3HRLGDtfszI/dyLkJwfuU6PdruVyOWEHmvL4PVSGB3gH54idOr3+2qNmGftsGQ7VpnyFSca
 O12TPJ3BuHtJPsqQ1VrZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wb1NpYodaAw=:XiCN4MggDKt6LjFvLLY+rs
 fWznTYgbEapNbAFkL9w4vbb5AtmCi99ZxXbkmPRD1Q16Lh/MZ/12thAFbxK32dr1LOaUf4pMz
 SkiB9D+32T4DSID48TSl/py2PJxkr/7kHq0zr/btZCEoMx2m32S2SEXWkJH7qKEyEAh3fWqzQ
 YMK3g6QzcO9FytOFrHgluJseYvD7rSsgoXUQ0LcdK8lNoYox4kBPw0YLRpSlECUwi7piNkwfb
 1vFd5y2d91erIfy8oOgl/rApczUpM1zahBAHQj2RGvjmrsCfNck4j/hmzqBQwI3YKTTF7Z/4F
 /4nvO/VNoYjws8g+pf+9yrrruwpAlJPPDdrS3sNJ1rdN+E7Diy9vhi6kfFCueDaNDrv2jUA7u
 A21oarOyvsWN9Eci3rOnlknXsG5HQTNsTPj+1cRJJq4C0OfS1RTaKxlONwwf+cswT8+/ngwmr
 67hhhoNpV542HqPIxCoLjEpnT4wBVI2Rbz4AyjJuI5M5nJNHC4Ce60LzK23oCqixR4HUAD+Ok
 kWjIkU36ubO8wc46ZxWvYgn8AmerIbimegk/QP5CF+BW0J3MZQusK2516p73AYpN9ietwO64q
 BjUXUU+9ISaziQlqEtzeH4LH4u5DONaAPVgF/zq8P+ttD4Bpr1e2/haLUx/D8nF6AnXS1hi8w
 3EFlHZM+7jeptfscOFJdetsqv8Ecmu2AQKCYwHvgLIyvltKCYDD7vX/aBROqjqp4S+4ptYjEi
 gNkvUF8vDkCt0C9joY2NE6AQvRGJhV0qP845vVzz+/1twD0wcY8IvnmloxJ/ll1qIU8en7FLh
 q1vjtrXuqvz8s6FzB7zM8+5aq6tn85j0rxB1dS2PH/sIdhXw2n42XCdiEW6OEjADNO3DhmwZr
 lbSMb9BGZFW5WUh13UZsqbv1gZYYHe0d1TA/aUmtuRvy9TP4yV4XE2XpRvIK+SBGcRarBMXx6
 zVFLZKus2QfYf3jx6jwdJL7rBgzdV7L9Q/NFtn9nuoru+pk9MzhDsTXXmYACPQC+6QZbSVi3m
 BXH5ZElkafGPJpM50lrSkHB6rLrwFOfuwk2euuPEriqnYCkwaOtgLDambxLMAsW412gOV/s2Z
 9pVaGK3S2gopgi6mt2YKgCZhOnGSJhSZU60Ci5EAoZZAAn++WdTeuc5GZEn/fdrY4RE6GXGfq
 lE80Dr7KWS8uLo4Yq7j7G2JLe+kq/7KQL/12QEyTZtSxp2f3jK9TsqepCTB0yWZvDM6HRpAY1
 EGZU9Z9xUCjulbfr8+ZD5ZssN+1KPsDxvci+bCcBaVwn+Ohhy44l8HgznQkqISfUMcRgYCqnC
 ttGuXW6C3rT/b50VJSZ0VYynuMlyTpFNMPnHSqA6Phmytw9pwKUNg7zfLd09pU9EyWkF3dXok
 ybRhv6WxA3uVoWiR6sPJ+xYgXCmm+O49IHi6YFzUT6yt0F9Wki70IpFEi4Y6jzieP06z4S/69
 txVCDf84yWV1Pw7MKECqmtZI7zIExg0XxtwDkw1EalvLQzlA8KN0If
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do we stumble on a target conflict according to a specific technical de=
tail?
>>
>> How do you think about to compare source code analysis results
>> from programs like =E2=80=9Csparse=E2=80=9D and =E2=80=9Cspatch=E2=80=
=9D (by the mentioned make command)?
>
> None of that has anything to do with the current patch.

Both analysis tools can (and should be) be invoked according to
the command parameter =E2=80=9CCHECK=E2=80=9D.
I hope that the relationship to the compilation of a single source file
will be clarified better.

Regards,
Markus
