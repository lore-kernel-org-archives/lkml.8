Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA52C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022EC2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qb5LQbET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgGRJQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:16:23 -0400
Received: from mout.web.de ([212.227.15.14]:39095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgGRJQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595063772;
        bh=G3d+RngEWuIQntAf7cEcSzMBapLG41kym5mlirB0PaA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qb5LQbETcvjZva3gUgwVu1LIu0BXV5mX3InI8euedf0XBA1OxICGFRDchWsD2wYCP
         UcmraxoatY3emTLEqiNqx0J6QLWzq7OTc2CaYWpDmyiZX2/Chlu8fayD+6LO5FvCY3
         GGwSDMh8r/Zf1hnNgWCRCZ6kiFo8ueGZYrxBdZV0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.120.168]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJTHn-1jydpA3S2t-0033Jb; Sat, 18
 Jul 2020 11:16:11 +0200
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
 <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
 <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
 <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f77f6eb1-9a07-c38d-e6b9-c7cdca119f3b@web.de>
Date:   Sat, 18 Jul 2020 11:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zYJyk8NQpn2E/HiuBb26U1nxdi8leQ40ukxxgsEDgwndICZt8M1
 0VDXOei73XlSwk6wZkR7FnDweA/klEKlACSA3PH90UjHyBDuucLPBI+88Kt3h9NmZxRHoeW
 9ztNybwpiCg/xrewhnqX3uUsMzb0Xqiy22YMllgSCL2fd3xjYWG46Oyl/xdFNReAxICxpOQ
 /tesiJ7N6GUzmYXF+L5LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iqzgbM0mFQg=:MxQCy2q/CJQlxQBrDGuBT5
 fDvnsVFMU67DpQT1ndpPrIQwWrMxyUCBjszNtH21vbjizV/6CCfvHl1c6+ASqpLToCYH0U3ZQ
 lpUZJJBZIl3LMprbXNfd8nhjp9xJg7ZaUk6Rn9E4CukH5MJlWIK872+2cOElY1Rat1VN7hShr
 y+lWwiaxy8zCewmf838MvFn1K4YQljuevdk+n2jBrn+yRa6qywbC+1hENjHJEtvJ9ktIMP1dz
 g06f7+IJ6ru6IO6JgtBVm9xmcwRy+ZBiHVCy8DU+qUzmDilojEmr0WCdGovAKuvYLU0nHeji6
 zwx4lV15z/bsYOL6eEzPAvnOfKRdUa/GKT9xBVL5ZUNqTbVLVnJEYPNouk5Wr2pPtmvY4uTvj
 aSSr+1S3nDmhScPocdf+Z5AnWQw/ipUf2AnTlUbSSFGkEsRfnOpBy4joJSq0JFE4ZZJq33Jza
 wFUe/zUeUmE9s3WKbhY1Sk1sofGW6YeWaSo0znVweUbj4H3xWSEM+vPqWSQvMHhfXIHKbSJqJ
 L/m5YcmpJ2OZ6y/7uTYisADiggH55oCEByVXrTdFukQ/YPNzjP8AIxWMQdvjghqBEzKohrYZJ
 tgxep0pktxufCJzHPYN6M8neWWzXlpnlVOj9gJhfu/cUoq2WL0yAT1RM/vZADEW4afJRNE2C9
 0qjBLAkU43r1+oLVJXNWv0k7J7YUxMEMUtMvEHti3cz83j3KfAasbw51uPbVvkPdXOkze+d8U
 CLPAUUfcWKKWclxC7nGAdscJnwdpuxZcWB68khEYiUKZtPGp3R2kPj6UFZCyuB0gHSblH2O/p
 KEn1mD6aioPZpw/aACugp8fAsiQo/C3Tu+tkk8h6dwH87zTEjsJNs04LWYERDswEZT1Ogrkq8
 ly+8/c5NZVfTGbFGWJIB+4JxYrWT7Ge8Jhn9TMm0RNm9L27gVUvR/TM48b2mEWYS9CYAIe5xK
 tG6JyXjNTiv1DWn/cFin5Z+5IpV9rD84DzG1ruIPgmWEyuYWwtnh4OaAHmTH33q+WNv2ou/ll
 UIUPECnEPkMbOKxHyIuWkx3KVWkuhJUeAMq1uMptLx+wOl31ToXHvo1vLYNfnuHluAOBdkKrt
 xFtbotWhoKscZnLuWj9lozZie3+8Klb/93MMcRLXSOs5VquxHBiF6IUO80Yer7Fe2qQEjTTkk
 1w4X7CoWgL6FW9ODHBiNzM+1nzJrcHypONwnJEQSyeZ4uRLYzdpLsp5kznyGvou56cmzKnh4r
 fRyaKw1dxcm77Hv4yW73j93cG59BDNjrIlRvGzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> * https://lore.kernel.org/cocci/5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@=
web.de/
>>>>   https://lkml.org/lkml/2020/6/9/568
>>>
>>> This one it complete nonsense.
>>
>> I hope that different views can be clarified for such a software situat=
ion
>> in more constructive ways.
>
> You proposed essentially  \( A \| B \) \( | C \| \)

I suggested also another adjustment.

Can additional minus characters be avoided if such a source code search pa=
ttern
would be specified in a single line?


> This is not valid syntax in the semantic patch language.

I hope that a solution can be found by our discussion.


> The branches of a \( \| \) have to be a valid expression, statement, typ=
e, etc,

Such information can become more interesting for safe application of
SmPL disjunctions.


> not some random string of tokens.

I got further imaginations in this software area.

Will the handling of optional transformation parameters be clarified bette=
r?


>> Patch reviews contain usual risks that suggestions are presented
>> which can be still questionable.
>
> These are not "usual risks".  You can easily test out your suggestion by
> yourself to see if it produces valid code.

Such an expectation can be reasonable in some cases.


> If it doesn't, then don't make the suggestion.

Would software limitations hinder any more improvements then?


>>> like that putting all of the virtual declarations on
>>> the same line would save space (it does, but who cares),
>>
>> It seems that you admit a possibly desirable effect.
>
> No, I don't consider the effect to be desirable.

I propose to take another look at variations around source code verbosity.


>> Your change acceptance is varying to your development mood
>> (and other factors), isn't it?
>
> Not really.  My "change acceptance" increases when the person reporting
> them raises real problems that is blocking them in some work.

I presented open issues accordingly.


> And it decreases rapidly when the changes are almost all related to pres=
umed
> "efficiencies" that have no impact in practice.

Change possibilities can get varying attention and corresponding developme=
nt priorities.

Regards,
Markus
