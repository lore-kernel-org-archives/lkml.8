Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD71C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB439206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AdGOuVd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgD3OGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:06:42 -0400
Received: from mout.web.de ([212.227.15.4]:44323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgD3OGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588255587;
        bh=a8CsPTsb0Rnh07ZEvOHAFMQL0ZBBV4dnc48d3lm8fCI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=AdGOuVd9lHS08wwlC1uq4KYwJ4SSYN/JNOr90LNnQrESvZKMYrPw+hSKtu+7WI0k+
         nnl1S1wuFvmvFR4Kc/cmPajft2NByz8OvlWQIYgBEWil5s5hZjwDvezqR08T6UfGph
         ZRpUOYxnHQiX8CMEem+S+uE8UDO+bRsNUrGY/NpM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.175.216]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFLQi-1jQsZb0RJk-00EQEe; Thu, 30
 Apr 2020 16:06:27 +0200
Subject: Re: checkpatch: Support for alternative quotation characters around
 commit title?
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200429163645.GA13810@udknight>
 <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
 <20200430125614.GA30691@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <dee7be7c-cbb9-688e-662a-34549d2df35a@web.de>
Date:   Thu, 30 Apr 2020 16:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430125614.GA30691@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QreoYv2Q90lndpAnA9rF6yVbhksQG/cW0RX7Eoabwv7SUpOph/D
 MkZweskGQ3QYZJmT636PceKB70uNcl6uQJpYpHbm6mmvpz75/oy6nyZO10/mpKLZ1BgkQEP
 68J2OaiL4vujyKeaKcmjw6SQiMltJt8BfU1ldEiDuuR0V9VFS+F0VPWVd0AVDwYWCU8+1MH
 GG/6/4Q1TP4cBYPTdIRDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCQabBRKl4M=:LV9DAdFMC3fojM0M6apAI4
 1piZa5/kOZa7tQlhtilqwYZHq+AbWszFb2CkQgdVqpoU6ZBki/3F9yTP+yayqvHkXfIC5Y3JP
 q0iz0B9IYN5Zq+mhrB1GZer2vVwXVJ+MHQLvDyryglzAKRUycijU28zXQwqqGpJldiUgMaAoM
 rj4JOIAig38+AUDAk4r3neHy0bjXU0c0MBbCbVoFa+2ji4MKtFrfUnv1atl79w60qotn74JfR
 KLOkOgWvFpSpFwxB07vJJ8HIKLilFmuxxJqmBBfYi3Z4sRtR45Ytv+SYMGM6P9q2S43i9Fkot
 7sTOelkEjOqnOTYNFfcuWYj/0E3m+92B6p6PRrDcXEIukbsb83cuBIUbCYitzJ85Y2zUZdYiY
 TgicCBCuWHZBpdM48luim+H+zl0pJ7GfXXwRJC4nXrz6goedy3NCMz8WA8YJBNTk50nGhKBC9
 DKnliP2EDJHuq75sAP7msSWNktSP4TRgBSR6l0Vkj2Kp/OkB/IB/nsZyVkVtGnlQoAZjZI+Tu
 Gw2czhURrM0HccSL6Fz9waO/IXk1oSSiH28C627NEANf5qXKiU8hnhWr832CuGozmRT3IVVXx
 z5f62u4O/nUudctZuuVoVViMyRNYr4syvMhJ8QgSFD0ILtz2KUI2XGUTMmevq2Ckvu5kzhmXP
 Y6aug9NBchFLZERb3/SXVJGYflj/QHR/i1DcL57tZWO2QrRtawEQTYihxhEsFxJrdDN7b8bAa
 XA5JoVanenEzA0C8hitFLO3Kjn+jT/BtBu50ixrwcbSY1nMG40weekdCVyOBLQ4zIWaFpsqEZ
 rM21gp1CjHzSIXuvj/m5tAMLU/ptwFdHWSJKLalQG+PdtlahmYW2mHr7Yo4uFC70co8GQD5oI
 +RNR0t7A74/KW1HTvQk8pK+A/zCmfw7PtBKXG5FDnA6VrK1rRcStqaWXHIJGmX+A4k+4X3teI
 /UunhOkRPHBIyMCTCM4bpv4i75EMLN3HmVtluxG2ckWHz+Grjmt0itFAeFrGPl3VHuFiJGh6Z
 95aX8x/a2ccKTcESoqE+Pj1xp67vCYpS2bVsHoRhOkbdeXv12lYUWjkL6XqqOIk6JAGUmvlnz
 DabNR9yetC0qy5nxt76pKfF9wZiDSnB/h9bycKXU2bU8pirSzm6QEw1mA/NXBbtA8O9lvtvLQ
 HksEY9GTLl4Ipz1e478bf7ZVKDn6PBRJ+N8PeCW3E2gW/MmEYOLio/Vk2NuJCRuHrvfEUt8d6
 c8k8dfcDaUlQ0FLps
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No, we don't need to support other quotation character for 'Fixes:' tag
> at least now. The submitting-patches.rst tells us the pretty format is:
> =E2=80=9C...
> Fixes: %h (\"%s\")
> ...=E2=80=9D

Can such a data structure still be correctly parsed if the commit title
would contain double quotes?

How do you think about to discuss delimiter variations?

Regards,
Markus
