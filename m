Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492AEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E42073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PYHQk0DP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgFFPKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:10:22 -0400
Received: from mout.web.de ([212.227.15.3]:60517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFFPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591456211;
        bh=6fW7VUy9mklmmSQ/+6DG1NwuXH1Jy+lzF+Irl174hpc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PYHQk0DP3XIcSLOE5JBhqpqvWBoD/XSJAQ5159qRZPMdkOu+uss2a1jnRqxdlxAdW
         2gpbN+yJ1pO2DMYEyVlcFA0W1RUP2VlR1pLTCZZhld+E9NSKY1UrimTilODSbk2Ncs
         haXcFbnRj2AW7BRWjGMgHk3g2m3r+jjbG4Ubpu+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1jDhh92Wwu-00nlQY; Sat, 06
 Jun 2020 17:10:11 +0200
Subject: Re: coccinelle: api: add kvfree script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <119d91fd-1ad0-8842-10eb-ee8fa16da1b0@web.de>
 <alpine.DEB.2.21.2006061634130.19534@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c0cfb9da-16a5-f37d-e98c-a57fc303fcc5@web.de>
Date:   Sat, 6 Jun 2020 17:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006061634130.19534@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R/R72b2s4gtn5A8vF3jKHug5SzNs8itbWuKUMSshRsZNvsVFWyW
 8809uSZtZg7h+FZn58hZnqmcORdph63RGFtDcpEJZo6nWN8MTMCyJt4v+ZzjP2lI1gjIwRP
 B1Br0QUBbBC+MNtF9xwx6f/zNdTLRSZgHb1D3tyl5qIWKMVf/hwWIY6TOyHG1xy0klG1An1
 MACm3i1HSc3Pz6+/SAr8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gs3QPmg9l/8=:Y5sVRawGfArRKk3eaVFPDF
 MFjkPerwl1M/LfEC4o6zLAKBwOfWALQM+Xk+Qap1H67H50j3hfage8QeZD0m4RXhnTkggCoiu
 7JBEjLXQNKC7AUUfn9FIv9GI6WQZt7wnTGr7u5s1JGUhxLidPHCcU5ajfjKldML3od7Cee1D8
 kSSDVe0dFSXQlISQ1YNSPy3wo2rexPkQyuufZOzU2/FAeWeTT6/UgYzzZ0MZjpoXCUnnFAow3
 qPnSL8kzog3rFmT7QDDqWSNe8wKghgWeY4SL6RlGP9ECmB9okfaJ6+m9BH14OT97gdrOMT3C/
 cwQzbS2Bc48aKrI6HOR/R0EOZ9QuN6DI8ZwANgWkrGudFBzI8Lrzhwg/N6F6JrqclPqJ/hMws
 M0ZCnH3NvEP6SInyLBd4BlNJ6XHHjwcGVt1G7qbus1a9QPUmY69WGZw13pJ7A2ZBIQ+khXUxa
 Nt00T2bDnrAgcqbhHSHoWwe7ktZYYFfRNXjLP5xQ/J09A0j24qCdwwMyymQsDSmsUL9G8KCbM
 RJT8BqOZFU719gQGAdRpGEvGtzuX1ZV4680zkbJKwJcUY6x661rqeQRxn49eL2qPhr7XxmXUe
 t32w3J+UDyUD1R9MRdEtAh4+dzUWbyq8mFLl646QVSTwGfhv35SaPWiTaJ67BvhPcyul579Ds
 bvFPpDPxddFaLS3UbqONYuraf33gR/p0iVafEaN4FKgC11ovp87mjYoPXsR3aNuvAKN/F12UB
 8/mKX8QIbUyYzXyID0bvni0tBiBNyZBsyxyXozxBHj7rivNVwazz9URiVlRw0+Y42uSV4pFBN
 jmenYnUD5BOPhzpUgdGVEJ5Kh5qXUUqYZjPEx1F9hFD+mringxs9vCeRZXLrv+ed/7fW6R4vZ
 CzrXi+3vNUHHU3itjEheujQYMAV/ZicqGrGYcT7NcnuFU0bsYDBmoX6xTvwm0wHS2nmuevYCu
 TVYeRwyoziLmIad0tAZawSpDvQdPR78m7cAAXAVXkqlUxmkQqh5BA4G1mqmiHWqBeaEjX99Y2
 mZIxHnmqxrSonSWizBJxxAjLqk4BvkjGRD6tcJVHuW1amN5ZnlIbH5m0Bse9NZx/0/2iEMW/B
 cTF55Yl6Xplar5JJ/z1R3/7Dy4XKVsyvmTZtPbWRQ+/57+ZpK0/vcmu/zhGXKURfA0NWiRZS4
 dhyiPZphYr8OaE+d0CbA6HQZJsL28nizDqzN7caz9vg8KqH3WQWMPN9PZIT61j1nT7Uhn1Wut
 8YT5hQH5RHXX20/Kj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * A limited search approach was expressed. Will additional source code =
variations
>>   become relevant?
>>   + switch statement
>>   + if branches with single statements
>>   + conditional operator
>
> The point is that there is a kmalloc in one branch and a vmalloc in
> another branch, so a if with a single branch doesn't seem relevant.

Is an other wording more appropriate to handle if/else statements
without curly brackets?


> The other cases sem highly improbable.

This can be.

But how much do such details influence the confidence level
for such a SmPL script?


>>> +@opportunity depends on !patch =E2=80=A6@
>> =E2=80=A6
>>> +  E =3D \(kmalloc\|=E2=80=A6\)(..., size, ...)
>>> +  ... when !=3D E =3D E1
>>> +      when !=3D size =3D E1
>>
>> I wonder that two assignments should be excluded here according to
>> the same expression metavariable.
>
> Doesn't matter.

Would different variable names reduce the potential for confusion?


> The metavariables are considered separately in the different whens.

Is this information relevant for a better software documentation?


>>> +@pkfree depends on patch exists@
>> =E2=80=A6
>>> +- \(kfree\|kvfree\)(E)
>>> ++ vfree(E)
>>
>> Would you like to use a SmPL code variant like the following
>> at any more places?
>> (Is it occasionally helpful to increase the change precision?)
>>
>> +-\(kfree\|kvfree\)
>> ++vfree
>> +      (E)
>
> "increase the change precision" seems to be an obscure way to say "impro=
ve
> the formatting".

We come along a different understanding of such a transformation approach
once more.


> Indeed, leaving (E) as is would have the effect of not changing the form=
atting.

I just propose to leave source code unmodified as much as possible here.


> But the problem seems unlikely for a functoin with such a short name.

This can be.


> And this presentation will likely run afoul of the fact
> that you can't attach + code to a disjunction.

There is a minus character before such SmPL disjunctions.


> So the original presentation was more concise, and should be fine in pra=
ctice.

Is less duplicated SmPL code useful?

I point a design alternative out.
Would you like to integrate it anyhow?

Regards,
Markus
