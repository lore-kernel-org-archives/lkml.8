Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D32207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IQ8wHHGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgGBMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:24:27 -0400
Received: from mout.web.de ([212.227.15.4]:55193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593692653;
        bh=qaoKcCMLELX7RdYPh/C463a0dU9Lt9fxjwVYmt0rLAw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IQ8wHHGCuxxk3CYMSkMRh3svE4sabTLhZDu/rY/qUq9IIfxyHuJY6B9ZX+uOjnNtJ
         2fImqqlLjUmHmsF5praAngJ7/qrJ0TW53/ymCHZ9pAhnnsQR4yEUi2ipwPmssq5FYM
         AjzZHSYLMAB3xh9209zAhCGucnxHziiaciwQnA/M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1jdFH83td0-00Ez3X; Thu, 02
 Jul 2020 14:24:13 +0200
Subject: Re: [v4 02/14] irqchip/csky-apb-intc: Fix potential resource leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
 <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
 <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
 <971c649e-fe07-3771-6fea-f5aaeaf090ad@web.de>
 <c7cc848a-1ce0-e877-aa44-ebafe4b5985c@loongson.cn>
 <41b48aa5-e5b2-0257-8b3d-07e1b86634b4@web.de>
 <0726ddc2-6b01-2ac8-d5bf-74c3df36b6ef@loongson.cn>
 <c0093731-fa42-9d43-ebfc-208ba51a96c5@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <14cacb4e-d687-dfc4-8ad8-26f9f1050a0e@web.de>
Date:   Thu, 2 Jul 2020 14:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c0093731-fa42-9d43-ebfc-208ba51a96c5@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jrY9kyU2X/qvGp46yZqguV79ZRx+hDW7SAX3Ilvruyz+ZKcYv7J
 6cgd0lzz14TgcURQekhirE/wopbMTwDmFb55/wHUNt9KeHAVSUOY0mgBdL/8DIGzV+SMlKj
 27IY8ddro0WK1MhKnysSpfcIbwoqknJGbqqS54ANrBo++l6S2NjeXOjysBNZoqGTQxa8QgN
 n+aROD5kN93K15Nx2wgPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FrEf3TZVQ9c=:C5WR9A2yiKfLgiApTsjRb+
 peIst7gfH8dpNopJFPIQy4lj1gwZNdfMtDcJ2c7kGiY//M8sfjs6J9FMpuZYWixwpXt0d8IKz
 nv80yZLhTVy37BJEw4jTMfV5F2Jm3ElkOf2ZzR5Nb/RjEuHz3PddpskMUkPq5Y7isJrooFN8i
 +ZHILyqSsx+IwN2w8ob6HBc2h8YTXZU7QJmx/JUXl+gn1ZfHEYYGtSbMv6QiyEJWlkDB4b+ok
 /EXGN77ofyAmZSQeFAZI2mBcenfyHhKQFbVyWIV0iB4JlHU7tRvTboSk1Xuz2l+hpyaaSUjPk
 LrQ9rh93S4TP+hBnRRkA/fpGcEgoeTtQ6/9KVUcmYK86wUoYGmP9Xy52xjpPXhiv/V5CNNgu5
 3Yd4/YQFnvFra+Ye6DmrVmSiYBjNLhgS1UNw2YU2oiPI9ERiqB4QEPMkTBdkOaEbR3atgPH4r
 9LBfzAOewHTb27XyYcWVq1Iid4/lLI+zijKXJo+VzWWnq/ooNBjwgS3aGEUHrcAnjvNcLXk0v
 /V8GqSNF0qEbKiLarQpXEID+VOTgFESoGYOm7Ekssg+Llrlh7I52qWOBuRQA769Gt+UWxiIHr
 YDpiwDH2mYLZF8Rx4YfFkwDT9rBBnaE2Fa2NKqaJpnQ1PJ56cdVOsNiYUPGSJ7qMnr0i6Lkje
 X9opuz7PdAg+Kr/JoStG1EIVW1OUJHxaECZFxtGhVtNOZp+E2fwa1sojFv8nhGq8j6cqxOHjL
 7xXzcmWZaQfFuHW/Vm5zYqvs1/SVSrt85qgtze/6u6r/h58Fs80a92b7rLmH5G7/1O7EkV5dE
 bjSHChAVgpBebyPCBBn3Xi2vvFDjaic3G9wiA8PXekHgE3BC8JHmyLFO0IMyWtOKZWWQl/sOD
 IaHR62gyQ6jWZREJuObMDDHD45ahm6LoEVpYEQj6nbcLvr3ZuxrhbTH2QlPaHHpsonfhRQjkC
 D9wSbFzors++6DeT/KLSI+TTqAYqHoXFWWk2K4Tw/SCvyV5Wh0dZvnaRwXt24MmOA3vAoc/lQ
 yJB/1VdxfWPLpARpM8eJ24oKRGnYYHF9qxSEhYdFv+vNL86flaaHCoSl5usvlTyujrK7gde8Y
 TKsELF6tBTJxpPc4PZ1MaFXZvsKyBjjmDEJASajfNRKcPLJwT5qeYSgddHvOmClQuBhJgBIUI
 jtJ5AL792WVi2Lc9MuZNUe6q2p31BmgIN5DfDIFUt9o89b7y8YC05VzSFmZZLHgabYqJeTJjo
 AMw6xuz7Ya0g1+tkZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> +++ b/drivers/irqchip/irq-csky-apb-intc.c
=E2=80=A6
> Let us keep it as it is

I propose to reconsider also this view.


> to make the code clear and to avoid the alignment issue:
>
> ret =3D foo();
> if (ret) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;

How do you think about to delete this assignment if you would like to
reuse the return value from a call of the function =E2=80=9Cirq_alloc_doma=
in_generic_chips=E2=80=9D?


> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ...
> }


Please apply a known script also for the purpose to achieve consistent ind=
entation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/checkpatch.pl?id=3Dcd77006e01b3198c75fb7819b3d0ff89709539bb#n3301

Regards,
Markus
