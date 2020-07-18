Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD602076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="swJKJEYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgGRHJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:09:21 -0400
Received: from mout.web.de ([212.227.15.4]:41305 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgGRHJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595056151;
        bh=Lg53zZ/EkD4Xjs0dLB9/V5tVQtWj7O0vdS46kMAnCrg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=swJKJEYPmSsAwdPA1CBCHHO2jz5oOB6FrXN1OxtqTu6k3XqpPxCjRknn0PoIkt/PO
         t7KkxFKLwaBeHpObuzziCqdnAQFyWSozUeD2zJ3+tNxMblKFXzrC0/qyRP5IWKTxlY
         LctgX9XbMQOd50bDDBx6NMYI8njJzcNy0OTRT/zM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.120.168]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPpD8-1jrlHZ344Y-0052vt; Sat, 18
 Jul 2020 09:09:11 +0200
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
Date:   Sat, 18 Jul 2020 09:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuSTGgloxgMFk/a1JCAIibqq2ZpgzEmIx2kJACEQKcwQT62rayx
 5Nx5NZxYtZAQXQgy0oEvoj45x/7LuJc8LkAhOWFx61YuLagBR4V6Twa9me7tpXDYz8mVR5y
 G5bFvxE/cUZYbkijeyvDWmO+grGLHdClE1u0HZT+rkafXshdK4JqyZtjpx4s5ng2HGuYz6C
 AO+byByOX3txR32XCOBVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6GHEvMedRg=:fTtgyM3XyRg56fZiPLFIk4
 CV7UwfnB0TKcv+ebyoAMPPjVGXvs2RZP9W3YFOUSw4Syl7CvVUK0ArxPNQb+55kUJktO2DtJ3
 mzrHpU0VXO0bXuO1Nsiut8U2DhECnBZp8D3sIFrU7ytXRKoY5msBzErS5ej4k3S7zcV2QWf2n
 VBKRgfwPs6UwRvpeJg4hsHbNwU1oWtqqiU8I5RvpFU+HOnpLmwcha2nJV1sSr6zI3SOfl1xJc
 +Xw+11qzYAQ2g7qY0bK51Y0pO6ZIHlKuyu9c2oTWkM7uICPzpIhwOb59aKoNE7YMEueYcLH1f
 Mq7Y/6PUbOlYLnTGn6s2Med+OXDxQNCmyWr8VjS7foS1EYktbmlyVRFevSLDlQZNofxp15hQV
 IZcRDgLpEj5N1i3hvup2KkNzJwjKfGHOq26h2IM9crsfLhhW7qx/qgaRrOWpqGV6oUtsQsGBA
 c4HSE6ik6jC8RGx6vmoxwy83dzA+V62gfYhO6LVb/gqwtZV1RTG9oPs4vEDFwnqrSnoLFEFeg
 v8u0EA+xJP41/ABfJCvClv5VjHVycs/m8tTktGCQy6C+xGw3KRSKyediCIsQ88SPnXowNxsEw
 v7eN5EZVRR+F49WQ377PVuxglIxvTZ7a3CPLG04biQw/rVnuqXkzMSfxkic+rjsFSX90J2N21
 yOaqe1GMVkkEpNjMnjT/xZL5uHK8JcHjQZ0gPjKZQKa2mkozahtmO/8nyLHmBrT/1es+lFHQE
 WS/K7Z0HQpZs5MOQiKAt66ExzbHKBYF8jSmWWrDYWiJjiqa51eYgg5+7GA7iX1qYvMfYX3g3J
 MD5QJUwYqqz0Z6sUET4Dtk5rFg88U2WV9+Ke3ugd41dyYXanHjXQc/HtO4Glew/pkEGrLUH5q
 Gk8P2bRFTLqHVTsukfkVuNmz4PkuIXPc7JK+ur0SAhJcXiXZ09BgOqh8N9KYDrv+/zxvf6PC6
 DrVa3/YAceezcKdvxfSX6hFGATbBQ72Qi2l4Y0XxDYn1/Gl5ku0XM9wRk973JE6H0i+AenR27
 gHK5A6yFeP0cmJ/ZRrRLMyxoMehHnYLyX5DfpktAb+rO5DqGQX1IZdBYnt4PM0qzXhbDsNWqb
 9MYZoBRjniE9afl+Hlfo2R+pp+nhkH/47TsqeEl39bCcXVQbmiOsaYPslTRbXZTiMBoG85KZU
 XJH7VRfCKLGYYPquWn55EszfECwGPODs8Ldex/E9BPtkb+Igup1Kd87pU1lEGUo4q3jBESXYW
 huGj6Horg3Een3nZCiK4fq1yl+BAM4LbOGquSOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Applied.
>>
>> Do you care for patch review concerns according to this SmPL script adj=
ustment?
>>
>> * https://lore.kernel.org/cocci/5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@we=
b.de/
>>   https://lkml.org/lkml/2020/6/9/568
>
> This one it complete nonsense.

I hope that different views can be clarified for such a software situation
in more constructive ways.


>> * https://lore.kernel.org/cocci/c3464cad-e567-9ef5-b4e3-a01e3b11120b@we=
b.de/
>>   https://lkml.org/lkml/2020/6/8/637
>
> This on is indeed a problem.

I find this feedback interesting.

* How does it fit to your response =E2=80=9CApplied=E2=80=9D?

* Will it trigger any more consequences?


> Markus, if you would limit your comments to suggesting SmPL code
> that is actually correct, ie that you have tested,

Patch reviews contain usual risks that suggestions are presented
which can be still questionable.


> and 2) stop suggesting stupid things over and over

We come along different development views.


> like that putting all of the virtual declarations on
> the same line would save space (it does, but who cares),

It seems that you admit a possibly desirable effect.
Will any more developers care also for SmPL coding style aspects?


> then I would take your suggestions more seriously.

Your change acceptance is varying to your development mood
(and other factors), isn't it?

Regards,
Markus
