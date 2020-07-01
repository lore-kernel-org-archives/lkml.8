Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978FE2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rSNJa/BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgGARcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:32:46 -0400
Received: from mout.web.de ([212.227.15.14]:41177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbgGARcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593624741;
        bh=/ni8x2imDqtybVtQomFINHVBaeo02hQP2oYx/JjzxEM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rSNJa/BZtVA2E1tVURBKmEl5haFYpK502knWaq2FL36dM6/FJQHdR+Dh7HHNVHGYg
         jvvrwn7eqIONecPBCuOw8H0xLlkziBwqkIJeBQOStkR8UGbmC8wY257dG3P/H2cL+4
         4bM9Bq+7wyXJfLNpmt7e/1sP7rRSNo4NmLZu5+MI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1o4o-1iy1i32hLO-00tlIU; Wed, 01
 Jul 2020 19:32:21 +0200
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
Date:   Wed, 1 Jul 2020 19:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:xnADDqxyY81VJQv3NSenfaw5BHzRZk0UidDY4jesZcQapjOv+aA
 0dQLFeo9UUaYEAgPrif9AGfDBeFS3DZ5vunkOy50n3Iyi235lmLmAfucefEWmDbC0VARDo2
 MUwy6/G8dH3DFsnY9iMXMwNA2P9GNieG7rk7Q4Md6EOG3uOzF0oeaIijhvJBX0zL1cjW0Mg
 PD6WKbbwcfpT6cvQR56Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2UNibV3HUCA=:BvXRMJuz9MK7Vs581u6msd
 wvEsDpCHalkdHUbcImLR7gDRVHovb2bLEgHkcx098eajcP06xT7EcKIGLFIxJKCT1XnMClILK
 gkRl3PFSlKZycVDl58SrDW4u0s0/J2Xg/GkzguLbmYtsmW1sriOsR9agWoe/erRV0imaCA2xl
 PyshRfcEDQ0AqP8wMSIDwALNCtjtv7r6Mpt3tm86cbvGuw8SFnA3V7NlPWeXLclrlXuC32zOO
 4PDls59r9v9J53EMVLYJv1e1AKhojViixrdLkrcMTCP5Atu7Q4RXCEDxZJOgwWAuVr6rTkp+X
 ECtXxqXufCg7cOv3DFImdR+OycaEqmMcG3ZSqWR8lyJjhm6w3ssRPb2jlpD94X17ytL9bi+Gq
 dRjuQVBTg7rawUuZ60INXjBe7DwjMhlmK1mApTSjsbRVvejGmL35jSD9Zj2a54SXsd95nf6iJ
 QZjpkAeU551IvUJRwiMUCjj4D8UcpqEexfvxFjV+9O4akVenke8FZO8yJiSKYGG9q6nc0KO8d
 0f1kweP3k7pmeHI4lR1lCzTawXJP1ugZOij75UTxp43Iy3sEAWBPTUkz9fTTOBGVTlVP8dfJ7
 /Xxf7j+7tOT+CnzKYDTdrshSoT9EKAmqnPxj+uorAJRS/+OdLSsKv4TSEFflhGhB/Lv1yHhbQ
 EtdYLUHCQo1Oy53URIMaE3/jyQO1YDZ8zJA039jAIfO98q1/9zf10+D8acEsCk1dgtv0gI88U
 W1AsY0p685EIMjLZSWAB24WxaycPkwd2A/rtMEm6NJSlT0/oCNMI1hbZ7OSRcoAwxjFak7nUH
 sIG1STiJr4LRDJ3+NZNVFEA3Bk4I+Og4/qTYaVev7Wed4NA5ubg2SIrRig7Udm03n4HyoMYtf
 lxDJWXpQw0WZSDRRjfHd0+0L997VvMsWdAPJ2gwHLg8sPrBHPzgqnmjsUm35M1kYRJ+EjNLGq
 9ziCpfHU7fj8MfBDfJ4adCtwIpLcDR3ctsZL/0xve3th2qMBh1ODDJNuTH4+iLJN6UClOXROG
 RT7jTxlITWrVm0GjiY5eDyVx33IqzrmFxLaOCzGlaoKMlgEaB2/rpurV59DUNDr6D4CSykbxC
 8yONBUtJQBxyIG1HSm3w13AB8ZHiMhOrAm6+roZmvxk7xOKUvBfCCJHLbuxXOSMBBhUeOlKd9
 RvK8tAtEt8aKURnmV/3CtIarAH/U1esgNNh28hsQ1gBYdZTIKZ8p1XkHI7v8Y3XmJ6L7mgIfi
 ecTf2TXFlE1mgWre0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> None of that has anything to do with the current patch.

Did you test the specified make command for the display
of expected data processing results?

How much do you distinguish desired effects according to
the specification of file extensions for such build commands?

Regards,
Markus
