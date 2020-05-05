Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25933C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30F2206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iQZywJur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEEOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:32:44 -0400
Received: from mout.web.de ([217.72.192.78]:53823 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEEOcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588689134;
        bh=eiN/8jcvXd/3eR7H/z4x5tDGR9+h/Kfp5pAzuCFyIT4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iQZywJur2D0eX9NAzFFowq9XvdvBnadZW/aqJFRhTegUyC5CpQjkq/N1PzmafOJIC
         cjBhxQ1hulRv3dO5ER6jOW+be036z2nywTDlkisLvgGX4ct3kqjXzEEk9AcNj4C3xB
         Ny99Y2WusSLuw/HgSwy3LZOAIE7PtiredI+PmPY0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.132.123]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6y1-1ixC611B9n-00aHWn; Tue, 05
 May 2020 16:32:14 +0200
Subject: Re: [v2] fs: jfs: fix a possible data race in metapage_writepage()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     Dave Kleikamp <shaggy@kernel.org>, linux-kernel@vger.kernel.org
References: <20200505135313.28793-1-baijiaju1990@gmail.com>
 <d3e126df-e7f6-00bd-aa3c-ea39fcd1582e@web.de>
 <05f9211d-6f57-b613-b584-a6d84b163645@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <074b3682-054a-d2ec-8142-1d87e1e97ed6@web.de>
Date:   Tue, 5 May 2020 16:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05f9211d-6f57-b613-b584-a6d84b163645@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HEzblqaHxK5qRM/SOxgAaO9AMJbHBSzUS3DoNDekGx9qS3LmNhU
 kk0Qu31jJ/IbWxic13Oo/LrRwLNgeWT7CUQIofVe7D/5qXysOPvMFXfRAZecKMr3X1d9yzG
 0WxPb9i09J11M93K6YDXbJDGDsIkHpGJJx+2qP7OAL9ZrLHeEyy4Ux5e5e6vIQSnb1AH34V
 ThYBmZco1ZTUFt0sriDOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/EJrkYG0Q8=:wEsFMfzOSmcvcgizF5Pcz4
 8cBwCsQshgnBgyvDZWvSdLoYLwH0gLrlH3Q6P8bLggas2X90DGlbePpsgJpvKJeYW6b8cVMrb
 j0FiWLDysHBHkRDHH+JGhvwvdnHpinY6EzzeqMx49SI0YRZW8GgUiM1LM9SLikR1ZBgOU/J1D
 IK2QhYWr6XjwxFgh4qO35YFxuqG7zy7FSpNEeLZ9Np8oOnsejaOAMeJveLS+akOS6bk1EnCxe
 ryjFJSLCrZ3cg+14mNwQVb8EFjruCDIi8LgP44d4V6bZF1fjMCBVALPfr24kPBfhOZb6aUFOf
 JYky/zoY1+lmcZwR4ZuflY1iQFPuovdesqVVtcdh22o68r8ZPSV+/yynaUFLSZd1RJRgNNhl6
 HeL8cpsygDvviNuoJPvdCYvKh2g7Lq+IlUhAh+vfhJlPRTF1dFuinzctZCh+Dg7M/Cm/aeWqO
 9r54WBWnGdtXPZZxy7CszIaRp3tQ3qOWlKNT/Wilv7ufc5sMrkKNW5qrg5DEIIhS13yBO9H+L
 0L1iholXvdyvUAvbfzTd3VaQNVFKUuarjR9KSaUITuMlk0XpssqZe5Afdee+8FUPH1MRv+lSd
 3kp3nrBYFLs+0q44X0trzK8Ml4+zEPFGUxZnYWhe/aKyB3zo7xFB5Ih8fpG0GJ6dos+wMunft
 q+fs3cKyzhTEeb6N2TEMC66IGSxTeoT1us4qMGdXOVDjp9h908SDcO73hk6FiHIjax4nvcy9n
 SOA6hWVXRjr0s3BAri+saqWtNPrYT5778IGFQqafjmTcTU3WlMibkHKYJPax7SL6bLI+tBFP1
 nJ/i8vDLeOmIBiLFoKesB/Y3+doiRAWEarAmZPpcHygRl8wCgTBbsdMfp7mA6Q/IzAZmExg20
 sMg2CTlDbZa0hqK1NPoMB8Kt80ZeOn4F53UNGD3ZSojnNOxNTH6jCMlTOlCvoimFV2n6V3qno
 nSTFw/HCeT8+VKtqiSeLMjyzXq0KiK6HCEgi3AzicQTCzk0ICz50FJTCzJL4H0lhMAJO5ZfLu
 hyRBclOnjpnJI3jUPNpBScibPDmHNKxYizWyw87yMEdQTdcbAnXyN0QtWA5Q3Vq8rW0XCtwy2
 vyMRRB5mVNnPxhtCgnSofHnCf2voQFzm5IZeCm3RxP6n7eMpBbvzj3ph1WOCV+3JCD05a7z1l
 yBYne5FREvHQwCv0mF4JpldUCwBwLDbTL1sCOpQxeOOLzMUTlc8J80TMuLKo49m2UpiVZOBzc
 +vqgjSgyZt9xLN1Yp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This data race is found by our concurrency fuzzer.
>> * How do you think about to replace the word =E2=80=9Cis=E2=80=9D by =
=E2=80=9Cwas=E2=80=9D?
>
> Okay.

Can such a positive feedback influence the change descriptions
for any of your other patches?

Regards,
Markus
