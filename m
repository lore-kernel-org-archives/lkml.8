Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63439C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3401420771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FYSS/gEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgFWJnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:43:18 -0400
Received: from mout.web.de ([212.227.15.4]:55107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbgFWJnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592905359;
        bh=xHb59Ik5mAbrqdY1zcG1yB/bqUHWlNrxdtT4MivxF94=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FYSS/gEYpgENWyDltRdkuIpfv5bECdYKDpWA1AGzry2NJqDphTFpdw61u7dQoC03L
         ceJvFy1ypF42JgvnlKyCbgyQl6KpNz1ufTyf+ARKkhE6zDVcy8ePDAxLghtVtuTWYw
         5qiViykkdoC+RPqkyc51o+LtynPlcCbtZiK35kwI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1ixlBT0uG4-00s8d3; Tue, 23
 Jun 2020 11:42:39 +0200
Subject: Re: [v4] coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
References: <4014118b-90a6-68c5-048f-32485fa3e852@web.de>
 <alpine.DEB.2.22.394.2006230902210.2367@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6b9a8459-3b32-8d8d-596e-203a33d2982a@web.de>
Date:   Tue, 23 Jun 2020 11:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006230902210.2367@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:R1rTZTwCVRzznbsMQsIQbsQdJhxnVNlX5lqnP0G5vzbwXyYYM7k
 gDXdYBz8tTwavjHaaO0lx88s9A8DMolaIyo2Wli6yXP2Y5/eZBdCRSh/p9c15BUf64Co+Ju
 NLtaHp9kC9ld7Cu2AV9tmeBiq46k2PqwIIzWQL7Rew44Gd2vTHALc56MNnLnY/RoObRLtU1
 o4WKC+X1Txh7mDwER0xxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aHp7Q9qGsxM=:ZLSOw3ASD5UGnVYR3L85l0
 a/IcjvzbH+35VxIb1giDWq5e+uxMNlh9lT+auuKYRJ5Fx9Ev9OgTDOhIjfgfgCproyOPZlunE
 ItqinalIOUP0FMVg/dik1n/OuXb6ZF5oGC8Ws1uMCpfAGzzwWxKId/9ZCcsEFC1HYbMNqeH90
 GSGDyk7nEiVitrdT6w5pe470H3XRZRGaFJ5rnCFqCPK619RR0A819oitkcEAQEqgZ5pVuJccM
 dKPAF9QEdnW+Lpti/PTSzh4xrqRJOXbtCOkR2vghVoWRKFY2YP6kt+mS3dS+thPG27Afdcc49
 7+uctYH7njcZ95GXB0oFIbnyUY/p7M7IqmBXgOYtyFxg5PjKv1NpF5w4+UoCawQZXwSlhb4Y8
 rvUQ5WVX9ky/MMsiv+KW+ODrFbap1yKCnXEy1/jZaLVGdtdwKcqfSDK7GzM2ljfxRInWYmT3w
 Vp0WVrYkjAAUIrJ2IZoX28CEJbX8ud0us2A1QdguNJWqczgjPQxTjBRjvr4p+w4Yry80pSMiD
 PCAkDcZHCbdVIFmS6AJYooFqjk6zPk9Ej9LokQXvS6mkxvBGHSIFO9YOzqM1AHfzo1OLFagg2
 b+q3TYjjvqh3X91PNnsnz4pWBbCzI/d1K9ZG2KIjsPYzG90TTNjNdzbAefv/kUxQQWWmuWUzQ
 dbVLz2SfIc0J29R43hRWHLEB5IDwFpG0aLgTaWdJJrLDYV//dZAXg2rbJCsrqEq7mGsesOncw
 i7rBLsajncPjk/IQt0d/hcpAkCWBS8/PfRO/CluAyjxH/sN07bHtg67R4ItIBWKzuR00AV2Aa
 d10f9svYrRK9rvGs/vFSTCU9VfIATLmILVzqZPCBCkUk04lOMGoUq4FRzTAfSi3szwnMNqhM1
 LxoUrZZpNa9lNXwzEXbouLHQInJ6N46xrTQ4P1Pl4uGtqtFDv6HSpYEuij32jco4m6Irs4Oiu
 WDjGRHZ2x6cp3s350YrYiSmKfP8JHm8xmTUR+GeKAVglsS7M2Oty7K9GyM/O2/yJdhwCaCIqR
 CgBDWqm3J5Q5Ti//V48It6AYiyFxbiIw+TLmGo/3kdNi4H6cb7GjuoQajFEIVsxMAwU1sIkvM
 q5OsJ8m/aWz4EmlcxQaUvwKFQkjsXEaTY5s1AWbBn2GrYHoKALHJ+xlOuoWoC6ZoU92MrIWJQ
 Qy7kzpAWRdQLl1KS78eNn79NgUb9ssRjWI5A4X9qfRpnysPk+wD5U2IIjF3Yax3Jq6MjzA6uQ
 XyJ6V7aRAnvdqL33e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't agree with any of these comments.

Would we like to clarify each of the disagreements in more detail
for a more constructive patch review?

Regards,
Markus
