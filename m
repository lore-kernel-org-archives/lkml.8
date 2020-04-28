Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFEC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F4206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EI9TCvRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgD1OyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:54:23 -0400
Received: from mout.web.de ([212.227.15.3]:42207 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgD1OyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588085655;
        bh=xea3ilwVKPgD/1HaT8RGfFIPvE+URvL19T7e+oJh+nw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=EI9TCvRzk6Xg6kRDBYrwZPTAIAFun6Wqqujm40OZ0sieWWIUm3DqJDKxMTqaHH90p
         F3QEEyH1f8GbcnZhJakVAjAb8DCt9kyZSNCNKOMd/FaGUOF2dyAR+UkcyKlxXWe4yi
         Er5TJw27c6SW14naPBMy3ik1SpVLASiXgWD1QSJE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.179.255]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOB3E-1jYxve37w4-005anS; Tue, 28
 Apr 2020 16:54:14 +0200
Subject: Re: [v3] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200428020223.GA28074@udknight>
 <35069ae9-cdb4-4728-5e94-6d863dd2721c@web.de>
 <20200428140649.GA30042@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <166ad4b2-5c27-9027-6eef-83d0faef4d1b@web.de>
Date:   Tue, 28 Apr 2020 16:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428140649.GA30042@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McuJTn3kvA0nE2MqpNsgp/hEW0qMKHNs9tHMs+jWYH5JI7/gY8D
 JtJk555aQkc8tLnPul2rwzjFTGGQGEPheFFz4m1mnCIV1XqFzdRjq7h9uqXNzMhunOBCK66
 wcG6aiEuBNB8Lq9yJBR0LsQul9An8YGp8sFGz/LP7DF/vM1b+3Cr6FIyg4XyHQc08q7FTtK
 4tjGqZqd4aIjj45v9vPxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ki41/bpa6zg=:mkwsmCDZ6f8SzBFdyMHJ5H
 2KCBZ1Y2uaQBvqoH1BaWxdYmHpWJs+YjSAM8RJbjoGNXeBMZw2tEjmbI+LegO9+Y9OZ2+NCOT
 Vqz18detvD5TetgtX1/MpeRN0NmTySqLWdZaBqxG1JVi1LFwnUY6XEk7wcPAa+CZsBQRaw+qa
 swq17W7S3K+wRiq/pUi67EbrR3fRxneQCyahyB7pDe1PlOu+Et6Pa9TZFM13gdIXj9jM30RFr
 GX4QlqoIljaYhm1BS0Yt9ndUkjaGrjUjlFW46h+nWztFA+WZKJxePHxO8ebd12C6DvfwJejs8
 wdmGe5NusCPn1qsy5wRirJ4h6b+HTUrncwOrFOPnm6dO/KElAhaXoLWy+teEAfN2rGXMLybWk
 TI2Ix92lkP8B6S4/R0E+oIOTaDK42mjQQpuYC67ByOhPG6o/irJ5z90Q8FDExj9BqfRWaTcyP
 pSfAn5hT8R4sHHATSK48nriq+pVxR8NShhANftN3+UxuWSbipvI8YB3Cz9IMIxD6e0foUBjPI
 JuhOSXGuy+Ktl+XV30wqpwNQ9Jm3udya58eWvfaTfJ5DOEwUJi8NMGGDYRbQDmErOkDEJ4Jfb
 /ubwWg6UHZdSva1iBrpPk+zsup3m0hFtC0H9I+PeJh8yi1O6dduZXvuZG9f79JOVuLvR0hSQw
 iJxRvjpsLYkjFn22SiT0w7tXmEKTTFcOGEIpaM2iM49+DHanGoXqBBn8F3v9wPzyQCvhnttq1
 jV8vzk/0TeELynx1RzBpEJa1yHvX76B09sgnzYkB6Zk64T8MOcqvTfTi8+Dod+OIOwRgkdwzh
 E8Q9450YUbMovOR6DdrjQ3B9DytuSwjKTDp3lpDionkaYXSme/Txj2V/Ew3D0XkDTYcmjEu8H
 O4s42QAiDlnkpwTNrxO1/C1lj+OaZI7iH4pGAGxHcCrRpHUX6+CCLhmDmqCa4oB0IdXjXExNL
 lf1udyc33m8ZlXQHPV+b2fsNKZo36nZxSP4pe2GRhHecRwxwRxvLdYs+9+BJI8gg4D0LYSATC
 xiFX8U94omuw7fLR9ZM64HzDCnixeLIoTmAyT7K1RshS5STnxtTMef8KNHC3Y6BcX88BxvPmP
 E1WclUnOUPEjq3oZqOFWetA8T8LsA2Lzf4r8IzRTHfRj6Xes+cbXnjl3vSfXjHc+4dWvddRbv
 vMO/M75abBOWKrYFcPNiUOTjfBB6TIMRUreoob+FpynHDolL2J8BeFaRxXoi4RwGp11DRzTpi
 PEcapzoZKmG+AMEf2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess it is a better perl programming practice that use non-capturing =
group always

I suggest to reconsider the information =E2=80=9Calways=E2=80=9D.


> when you don't need to use the '$' to access it,

Such an expectation can be fine if alternatives would be specified in
the notation =E2=80=9C(?:=E2=80=A6)=E2=80=9D.


> it will make code a little faster I guess.

I hope this also when such a specification is actually needed.


>> * Would we like to support any other quotation characters around
>>   the commit summary?
>
> I think we don't need now

I propose to reconsider also this view.
How should titles be safely handled if they contain the mentioned
quotation characters?

Can it be that you are used to the application of a specific language
where you should choose between two quotes for specification
of attributes (or text)?


> and people could patch it easily when we need others in future:)

I guess that there are further software development challenges to consider=
.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/s=
cripts/checkpatch.pl?id=3Db240f960afb900e59112ebcfa5a759bb0a85a14e#n2872

Regards,
Markus
