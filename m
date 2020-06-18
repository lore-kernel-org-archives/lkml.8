Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D12C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671212075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ry020ELX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgFRPCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:02:24 -0400
Received: from mout.web.de ([212.227.15.4]:58979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgFRPCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592492514;
        bh=ePFt1NaB0yTJgDkxR/IDTmQFz/CnzVh+Xg5R1uhijFk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ry020ELXtl0z/pAtCXuzFRnDM3fqOY0uR9AzmeSRAHWClxgKdTAiz/D/TEeKQDTG8
         hzmVB+mezZsI/AUkwejccr+qDX2OGqczcfmXuwGswAkiwo8FXrjmFDe6FNTNPE3d5N
         NZfyLIExvxiY9yfxwWrhZhzw9QR4gFevEWGn3kI8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.102.18]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqXBp-1jGjy70oFd-00e2d3; Thu, 18
 Jun 2020 17:01:54 +0200
Subject: Re: [PATCH v2] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
References: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
 <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1200eae3-a6b0-cd6a-02b1-4f3034bb0fb5@web.de>
Date:   Thu, 18 Jun 2020 17:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+ViFxfeXZ9S5ROcxv3lmRd6vTIG5czXtm7Nk3LuVS9Av9fnQAn
 ie0VNDofdjwemS9Ytv/VgAi0DUPFXJS7E6i2OmGP5u00VmbvaM3AW2JK4Bm1+vFaWBj9sJs
 pbPj37PP/ntyTCjkfntjthJY7sA/ohZRetDDayA8yybH1S91kye4hiLT6lfxZvnAmO3RjoD
 BYkKCG5iZt1IoWNXoyzQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yPmHyyo2o5k=:3iurbzCizuaehlwwjWdgRF
 X0VJqWFAsV26wJVDNRDzPEveSZrKBK3l3ypOFF3OouI4vLrTo1DajcsgAjxB0fOHErKFYz3Ml
 Atu3zm6wIcCuKSHFzXtQBHU2Gx6rD4a3HQ8z+tvI5ZkK4FMup1QNz2iTv4qUvFc7ZBZCOAd6N
 9Pycf6zl/txAOMLUuOwhnZwN88RjQhxE+ZmhR2Yun4IuC2vZUUlRE3inzwnLnE9EzXvLhOciZ
 FFHYa7bU9PHMhubNXN5NQQzGpH/Y96vUYpkhytm11Oh26ACKAbWqWpTc1EUMCOvGLSVypdnsd
 2he8BZ5VUbNdoHB3pLQxmT7j6iqA6aaP0489pzZZr3NhPOKBzE+6vT7BveyM3XV/n6j5/QTxD
 DPQsIj8myI9HI/vfG2wkmDjdVVeEeUZ8rLMmUHpk8vzWiTKD/7eusqKD4MNdi8fNZdGUEphNC
 ZfMT8VFtPrpiDG95e3qmN4bH9ZIE1o+Iq6fioT+DoI6t6IUEi19/qlCAs+BYbOzJcvGi0li3V
 Idtu2BwGgGmMPYivqedPBtE42ku6NsJnxXLYurV1F5CzNIpIsjeCPjBq+B9kl307FzdWMd4G2
 QC9EfStvnRzrcZ5XHkhbJrlC2PzROOh9Pk+QEsEtmZa4kZxjcq/wMbtmwOQCoBihdcYwKmOrO
 rFGgvzHUT6eIBJwofYg3nkRaOLk0Bpuy9xVK5nnrEo7kfdr5MQl2kq899qPbi0Y5ZbD1NafQQ
 Iw1tsff9BBrt60373g+ADwfFq0V9eURqZxCRYXC2QKhF0/CgZJib0XC9nf1AHMhh8VSdm0deO
 9YmwZAvNGKLF/GKzuJwvy5fxm/bNSIgJQnXMbJ8HPYhtt7U4jkO6s/zqJnZpf9hWdu1BTxfGz
 tcYPWTtK8OeRfQtp05Nrj4cgTX45jsOSl690/H4mJjGlhBDHcQWuM4HRZRztqM9YpgnFIDW74
 SFX3XOIC5VFqNEXmlVPAwAng4qNBfZKZAT2aE42ZCktHG59v8yzZpP+v/wiHmTpsQA68Kq0u5
 9JXSzphZ9qP/3P4Z5MFdOI8SYW4+A5io/6aj7giVdL743d/I5A1QBen2cr7Cx9wjoIzTJMsTU
 it7WcFlZj9PpYEvpI/LqjzZzliEG8JKXjNzFcRxzvQoPi+KDFAtCwx7kJBAywzCcxynuotxNU
 y9E5ef0PHEacEwVbuGOkM/UcsSqEikoHOx/cJgjXPDT1Gt6fft8V4Tpu6GiJOUyHGxGnJhUho
 WM6PuunLt9IOdSdFK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Where is the typo?

I tried to point a possible replacement out for the word =E2=80=9Coverlow=
=E2=80=9D by =E2=80=9Coverflow=E2=80=9D.


> I can't handle your suggestions

I hope that you got chances to take also my patch review comments into acc=
ount.


> because your mails constantly break the threads. I just can't find them
> after due to missed/wrong In-Reply-To headers.

There are some factors involved for this undesirable effect.

* My software selection contains open issues in the handling of mail links
  according to the communication interface =E2=80=9Cpublic inbox=E2=80=9D.

* Mailing list settings hinder more direct participation (for me).

* If you would specify more mail addresses for reviewers (like me) explici=
tly
  as recipients, the impression can hopefully become more positive again.


>>> +expression subE1 <=3D as.E1;
>>> +expression subE2 <=3D as.E2;
>>> +expression as.E1, as.E2, E3;
>>
>> How do you think about to use the following SmPL code variant?
>>
>> expression subE1 <=3D as.E1, subE2 <=3D as.E2, as.E1, as.E2, E3;
>
> It's less readable and harder to review.

Can a different code formatting help then?

expression subE1 <=3D as.E1, subE2 <=3D as.E2,
           as.E1, as.E2, E3;


>> I suggest to move the ampersand before the disjunction in such
>> SmPL code exclusion specifications.
>>
>> +      when !=3D & \(E1 \| E2 \| subE1 \| subE2\)
>
> Ok, I will fix this if there will be next version.

Other software extensions which you proposed recently were similarly affec=
ted
at a few places.


>> I would prefer an other code formatting at such places.
>>
>> +coccilib.report.print_report(p2[0],
>> +                             f"WARNING: array_size is already used (li=
ne {p1[0].line}) to compute the same size.")
>
> No. It's pointless to break the line to save 5 chars this way.

Did we get used to function parameter alignment?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D1b5044021070efa3259f3e9548dc35d1=
eb6aa844#n93

I suggest to reconsider potential concerns for line length limitations
according to such message strings.

Regards,
Markus
