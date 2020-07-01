Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A183C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3922067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MMATqvjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgGAL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:57:35 -0400
Received: from mout.web.de ([212.227.15.14]:36843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbgGAL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593604623;
        bh=MJhrn2cdlrt7Qx9hBjLPKnYFygrahbIVi7CqzIBheuY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MMATqvjFNq4nxUoLaxDHDyhjpn1R2I8wyX49A/alYUD0RNUzmUUNKGTs8hhlg9X3m
         0/0kfreB72d34C/HKKOOHCcjBMz+XyHYYf6SHpNWwhTLMhGThVwCX/LLqDINtoA4aK
         uaF41Z7gZmknfZEoMEC/XzGn3/jxMXtEViK0HZgw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MINMF-1jo7aC0alT-0049fI; Wed, 01
 Jul 2020 13:57:03 +0200
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
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
Date:   Wed, 1 Jul 2020 13:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ILeakol73ZTXKUQktvj5+NSQtndgKM6AQvYqq1nQ9Agj6GXpDKL
 E7r5OplG5TOyd+IpY67cr6ESgn7yAxBYhurIpmGb0PPA5Sc7zQOgN66KMDSnNHOuWROyhld
 JnJjbg+5Wy3QZI7Wae4n6SuCwD2OUQpXZvJEWi54LUHQPQzEKMC73DiZFXiyqiwssvJskvQ
 E/KNiB+govQoyJA62ZEIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cqQqmEVnEdU=:X1XRqib8EnB89nojwJyPD5
 O+QraE5QysmwGXh1D4EYs19NTl3bOd1f+d8pZvNdz58Vbo3yB0keRkCtm5Mqv1AGC4Sufzb5k
 zAZAqLO0DYgDFUFLf6/4lpSHsVBTGTQemH4AZUetJnj61/M24tOU3a0bgBd+G8F2JdPFO3za2
 VLmya4nG6fNp6FzCgBwfZHwK6ZdI3345noUSsjo+oqzuNy3dImv2sYH4brHk31nTjJx8cY1sa
 axRYZcduwQRcrk4lUHY+Q6qdPuEl6w1MzRUC3KBZjf8MIpaU74iUE2UCIdPL9Lps2kYSfk+dB
 tyTHkym9OXxumPu3HQ9uwp5NXzLvuHzCI71+/cz8RvP/Qxg8ArWEwM3bxdEbZLyTQY4Ea5KZr
 //OBgxKhY0U8N9zBcXmo+PGIPOk/c7RKQBQUXNX2Dfx+cNDWesqaJFtpnmfcmDDzVqom9xIga
 dILqjktIVqecktaUPNSzKWRsRMlr6Cov39FjpgelsiNRj4d6MrX702GltCvKGlXPuGtBeP6Jy
 IeWGoqNMAfYHPUl0x45ODWLNsxtVRA0Z91uJ6JWfjZuhUB1GMS+a8NrG5iMOItzbcX3YbxYy/
 PzQExtivIEzAl3141NuBjNwWVuLWcjQ42Mx7uMLd1UhpG6k7ew/tbl/+L1DSNuM1wr4ozhHgX
 DlbiSur/sh4sAIjJGhdpdI+Zu3dFVdWH1VZdi8pW4obfT+pOpmL92u1pn5KgyVZC9pZjU6eir
 KgIN01fjPCy6ZrcHgi5uc++Jg8h5AkeMlQCdL0nWJsYEjCsYBct1lcTkATw7vyo9D9YxRPqc2
 OtQOeJtvjYLv8oQ9qOne+22R/Jig1YIxngPBRgMlTSwtOlyPH96dg7OVzvN9ofkskQgK2SOa9
 b3DBx1oBsVa8dqyaFfyHJDlcPesfFLdqlFZWx4BIrTVcivBjlvlVOlaD7DoOSpxeMH1Knqp5x
 bo2gJlV6S7+UjCTQpriZdU9UopGFs94i8lyxiGpLtONLLViGGxmHQzivLXOGN3unpx9P/K5Vb
 Pyv1C4N9OeTUC7oQjUmrL5lyhTSC8hbzT+m/+QmyCQKD1gsWQq9mm8VDApQQkUj80jS7DjDo0
 u36Sbmpj1FJmysiWLaincWXWTYwKpCWpcsIyCW5FrX3eQ1JETUirFvZulffXz6tyHWsBMKkPK
 0keXPXdDGv3kRpee4HBVFFp/xJ6YKXdEBKM8Qx+z8xdgGlVUZ10FbGRa7ji71cZJI8uhvG5MK
 L8uZmla2t2AzuBXkA9mrYfp4tJflvS2oz0vm+oA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> =E2=80=A6
>>> +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
>> =E2=80=A6
>> > @@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
>>>  To apply Coccinelle on a file basis, instead of a directory basis, th=
e
>>>  following command may be used::
>>>
>>> -    make C=3D1 CHECK=3D"scripts/coccicheck"
>>> +    make C=3D1 CHECK=3D"scripts/coccicheck" path/to/file.c
=E2=80=A6
>> We might stumble on different interpretations according to the wording =
=E2=80=9Cfile basis=E2=80=9D.
>> Do you find a message like =E2=80=9Cmake: Nothing to be done for 'path/=
to/file.c'.=E2=80=9D interesting then?
>>
>> * Would you like to add any links for information around the support fo=
r
>>   source code checkers?
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?id=3D7c30b859a947535f2213277e827d7ac7dcff9c84#n198
=E2=80=A6
> Feel free to submit patches.

How do you think about to use the following command variant
for the adjustment of the software documentation?

+    make C=3D1 CHECK=3D'scripts/coccicheck' 'path/to/file.o'

Regards,
Markus
