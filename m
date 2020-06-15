Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E5207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TnauHkUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgFOQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:28:06 -0400
Received: from mout.web.de ([212.227.17.11]:55497 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbgFOQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592238473;
        bh=e/lJOtaL+2N+4pjgb8r5HbCYBQk8FFSd/yF+vwzzG2s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TnauHkUiMJStPu6u8jMFIZfrDg1p6Xn3j4hPXt5cA0AkLnNoQP0IvYQjYHkI55t0i
         9IhQQQSG8kfaCrDWK5JJDL74eYKob6GzZRYV8aBAByyCOTKL5iEZ2Sr9LrbvLx41ii
         dmUobb7dJi//osL1Pl11qy4FjXL/tOiF1kiwt8N4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYb8-1jHbxD1UD4-00gXy3; Mon, 15
 Jun 2020 18:27:53 +0200
Subject: Re: coccinelle: api: add device_attr_show script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1f028ee6-b014-c240-21d8-0c1950334fe6@web.de>
 <alpine.DEB.2.22.394.2006151742090.23306@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6ce5346f-127d-e2fd-c703-9adf21060e30@web.de>
Date:   Mon, 15 Jun 2020 18:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006151742090.23306@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bZzrFuVdGUgLdZzUXBBG0c9thtgiUwj8WaN6Q5o5jIrqNCip1Be
 dG1XHK3hC4sWWyK45HksQ3tuQ1TmIoB64NLLm3y5aMn/3xpX7iz3WpSHyaNA+7RMVZB6EGg
 JCPyPhApFHqFWxIwyVl78r1WZFaq0wo2Yetz3bxs7BxZ8NFiM5dAsRVd66gbqBvJz+95Jrn
 +jh9PELkddakMgCnV0jBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:il27v5Vtuc4=:4iYvsLpOR3sdm+6VeKsqlk
 p+siBA4y7tA9Jr9DA1fPcX7KX3iAclijagf2ZBOCvJQasSqIC8q3Um4iUsq+wLAkJZAly3EVv
 ZIS+mt3v0IzQr8JnJpj8WM+QrhG48I7FN4TNKWAAKESN4niOLKswRZrKWUAwxCZv2o6qctgur
 g4GId1sYmJIXA4SEEpwruiCa0a2DphSM52c5jAImKw248tP08CiL3y4rei9Si1VE9wEE/rsbL
 NvEwcebypEucRJSulpHTQlE3T/w2GVXrTX6+0obYWDMYSHHnm1t+gFpIIgPbG6GzMBX46s9s1
 S00AepUrrwVmyvBYc0DMYW8UAWPaHtQV7cPzYA2ElMGCzILwEOdYbeILXhzuIffnrD1wQREdw
 4XubRG6BkLPVziGUeX/JipQZTRXO2w89DCO80T9Jz7O30S+ILRZVQDYnwAfMn3kqxuWZlJyFE
 Gx35/cV7hiOr6yDAU0hYHYl8b7MCMTjn0ziPvpczJ/yj+zz9Mo84xIOciVQi6j03q8c+G9boN
 TPI0V/hA7ILrpAzWrhK9j/gcVjKx8rYvVADKxhrh01R92/tfSxH5y3RZ/eYiPcE9iW/QYctfW
 6axMYW19wMKA1itl3BvMfU85gdlrPkFQ+SykfM8D6jxvBU2S+scya5jVqi7VJRaWFqJhA0vfw
 a0uIPi2AGuC9C7qE1Jb9iYu3Slbo3KZujEFJoPyefTqpIPYBPBhDYdjZ1sjE4C43wcGNI5nDY
 twpYtDHL30Ij0qnyJhNyKlx2C9CRiNgCETMY3s4Szt5trRf2anu6JKhmKJcs2BkI1PoCbtLMh
 2/EIosAccRpwuZBpgmAW93Lo8YvH63W7a0vRZpVfZwFUeVEuvN7n/Iv8zrKO1WbhMO9ZlysMd
 /894emfoVyXGUqMG4jF9dyIz0fur1znxnfziNyU9JOWmQJIgqzLYPvWEWEPxzjQ223er87Ne5
 r9ZU5NBLuHN4tgfzkh43G+Pmh+tYH6nBBkiKgRwx4x357GKsaHquot9RDB8Fx8Z/8olCHkMm9
 BLGvo0jBE10wd2uIOzeEW7n4gyXN5z7jfmL4C+7JBNI3zuIaS7hBLn4n3T29LQBXJ7eMXivF4
 MDimnHN18QmQhGV2aIY0Vz5booNFDDt4xscSWeACc84gpCZhgrNbaTqKznoRq2vnZkhkEukzR
 svJoD1hY4yB5XiAzHnVImV94IMOGfGPaO9g8sIcnXlmva71njT+Thr8tcojZpO92V2rNcNajm
 6L4dnC7Q2JSONEmdL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +virtual report, org, context, patch
>>
>> Is such a SmPL code variant more succinct?
>
> This doens't matter.

Can less duplicate code be a bit nicer?


>>> +ssize_t show(struct device *dev, struct device_attribute *attr, char =
*buf)
>>> +{
>>> +	<...
>>> +*	return snprintf@p(...);
>>> +	...>
>>> +}
>>
>> I suggest to reconsider the selection of the SmPL nest construct.
>> https://github.com/coccinelle/coccinelle/blob/e06b9156dfa02a28cf3cbf091=
3a10513f3d163ab/docs/manual/cocci_syntax.tex#L783
>>
>> Can the construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=9D become releva=
nt here?
>
> <... ...> is fine if the only thing that will be used afterwards is what
> is inside the <... ...>

I propose once more to distinguish better if the shown return statement
may be really treated as optional for such a source code search approach
(or not).

Regards,
Markus
