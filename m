Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBFC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFF12054F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DrB1Mcgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgDQPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:48:57 -0400
Received: from mout.web.de ([212.227.17.12]:34901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgDQPs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587138530;
        bh=uR9Ez3u/7GnvtnBI9nN/OKjFu21RjRLKSDicsZqRY3U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DrB1Mcgne/caxQXbrbYB2UKkQoeXq3ezMyPzrmS6QZ1ZKgaUnS/3D/3uHPoOBhAY+
         dqMRyWMJg7hYLaN8A+r6CiHztjqWgHWfz8pZzHNxnbSpoilIk6uYI8AoJDwMqm5Bl5
         jJF9MaPF01Fetizw0pL3tBWRwqpeoDM9vk6lPu3Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.97.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLKb-1itCHf1nOn-00qBUu; Fri, 17
 Apr 2020 17:48:50 +0200
Subject: Re: [v2 5/7] remoteproc: Restructure firmware name allocation
To:     Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-6-mathieu.poirier@linaro.org>
 <aa565fea-b1c4-9b5c-73ed-591244afee19@web.de>
 <e887c990-8cba-62b0-0f47-3ea0c166d603@ti.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7a978c24-945d-8d39-3a0a-30e0678d569a@web.de>
Date:   Fri, 17 Apr 2020 17:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e887c990-8cba-62b0-0f47-3ea0c166d603@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/6dhADAQ7uzeRvMgrEKzEC9uCndlCMfp54nMDIGD8OtskzlNmQ
 jMqOaW2aYturyVDB04AnhqR7NBQyT9owiovvUKzhdC0XPlTBdu6oFuoz8xPmckedOci7gcc
 1obJAijCmgBqgLK+8zcTtsMlo+beiCzXGrPw8VfR2F9WHJbQjeS/IRIi1UrbL3g5rZLYWfV
 BcHZsxFvC+crF49TXKUIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hLJf7nT6nXA=:f0sodW8Cn/RldVBY+9kWaN
 fumjX39YA43Ph6mFqlidFMcHwXEqe++S0d7a7JBuHco/g2VsHbQKAfE2Cc7zjRLdNlTGBkaZg
 oZAIWrWy/LrRwZBqn2LYyf6gmYt3lSRbw/8OEzTu8LRWfMSoK17rOALw7Z7rbnrBz+09IqQPE
 6TjlWo+c5d7AhgBbVg9dkECjBWF6N+YtsuZmxNuVsOu/KrCDbfdrmzgOZwpC6M6QB2pY42mbz
 UtRBO5aCvBZfxm5s6i9nnj77LybwywISb1EVYOh+LW//xCVE5KzGG4mEfd4BGMYafYukgESjO
 i4NBcNHM29fqyOI9+B2g1ymEl/Fiw8cTVJC03cySjdzI+nPMtcqUXaVosnxBtK9iPNky9NHik
 E3sG3uYtruzeg6vnCqIdtKnawojfNIxvRgcL5hWOPSZcGQNnxG9339zAtywfBwJRBDb5JqP2Q
 KmRUdckZf/depuLOOiJtgSiGp402Rz5H1IAmIJcNHysTOJAwtu7AaMTdXCCHe1FGTFakji9k/
 0TIwhb/ldlPg2oQrSxb+sKZnO0SBkqsMCmtbrBAIIBthO0CXayKKLfl++L8Ad0GJu87ILr0GN
 l1mOTNK2yw0UX2AOpZeSDE4HeJawEhgDeOCQayVPU6lGeWwZ2rYqKtIK0UQzCMSbmS1cFMFZs
 higZ5jXWZZzLERS28V2b8RCb365AugLkRlDk6/hscqjWw7Bz0t/9jvShemTQuNmajTjYnakGu
 h0VVfAx8WPEBAwhG492sOlVJ5PfYzxX2VDBX5xRyql2BGArDrfFLmUJe4bPd6mdouuKWT/MBd
 qCq4P/x8iKZdBvJAAl4wNZoypsoYsW0DUdiwLeFkHFL6gPonsfKtXEkIGh/Hi+3crGjcJ2j/P
 fxvbm2qTLjFI3jfetIjFw4H2TixlaksmINQyAim1QAqAYjrtoz6oQNExDtAuYheLZUMUuBsLE
 CrXZL4/0QnuxAB5q9AXKSy+pKjKqXUM/E9uD48sjBLrU5mfz/ypD3hwc1JWRJxa7QoxCdlO0L
 yZI4TR9jyLU596RITkgY/kH9t8Y81GLhOfedf31hcyScRbqlMnOg+KUw9+HQu8eJXoDZ1ErYw
 JA0kDflDhxAmSeNgN4P/DCspZtRLYN+6HTuWnilep8GxbEnc+2tcRAY0jZ607UsvJr5X01tqv
 8+j03ZUQa1jOIxRhcBGUYngheCwTZBzBO67WDWtiZKdl4JEB3Je/YSzhXszfjtx1s40ZtFa8N
 t07n0Qk/mSWwDIOci
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> =C2=A0=C2=A0=C2=A0=C2=A0p =3D firmware ? kstrdup_const(=E2=80=A6) : kas=
printf(=E2=80=A6);
>
> For simple assignments, I too prefer the ternary operator,

Thanks for your feedback.


> but in this case, I think it is better to leave the current code as is.

Would you like to consider the use of the function =E2=80=9Ckvasprintf_con=
st=E2=80=9D
according to your review comment for the update step =E2=80=9C[PATCH v2 4/=
7] remoteproc:
Use kstrdup_const() rather than kstrup()=E2=80=9D?

Regards,
Markus
