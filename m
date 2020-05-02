Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E55C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379F621775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nOFABXuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgEBQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 12:48:24 -0400
Received: from mout.web.de ([212.227.15.14]:43397 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgEBQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 12:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588438097;
        bh=ot8MtR3g0Z4VK5ZaLgJ9qEWbi/FOrBq+R39dL1Ss9j4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nOFABXuSEyJfQ+HzeMlkSDSfMFh4dxpNxJx3/66SkKUGGsT+1M95NbI3Mmh5oIBJp
         IWIlZyMr5pEQiy9NlofxuuN1LjkTVPhWqe1sCdAGBpcWw1r9K+lCL6s3S0xH6WVBOK
         Wbh9q2JUKhSr0EN9QsEg5wPbpj8iFeEQA7rU233o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.93.244]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1ilNQa27RF-00jcf8; Sat, 02
 May 2020 18:48:17 +0200
To:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: clk: keystone: Clarification for a return value check in
 _of_pll_clk_init()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f1a2a717-f89b-d4c4-02aa-dd106eaed0a9@web.de>
Date:   Sat, 2 May 2020 18:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1bLnWoWMwoNjavQBlX0SyTNle5P9ix8u7LcAPnhwclEW9W3V7Up
 Qm5sHKhl4rN/xCflW81nOpbargyg5lexzMWueSmd7ztk1kbL7tA+zcTt4q5GI1kE5CfOSU0
 M9xPqEIB9Yrtg0h5BATrF2FzyL7CsS25kycB3LUxth8TVyNrqnOYo9CUgozYLIi/QCeLXCQ
 IvUmp2xRRnn2hKsYBSGXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0x3Fw4bwP0=:MVSPYv4LeQmiBhmCBfapZh
 TwkLGXCvAwFqbndVQUs0Exqn6Uo903lAf2YkSYicEMw1LGBEbiLAD76geeiIpkx37sL735+MY
 5cBnqQeqLhHVOGAqCRN0dScn/9+Y54PVTbgHWNDh+ZkV33k7qZp8z/WrWCVJTYuHY6vPjOjw0
 XNhnOArg67vwL8L0YhyYrSIqT65TUvnj8k3vTEPIOhW5Q/TDUnbc3eAersGfRIFxTEqyEdre2
 eelHpp3zEigHG7j1ZxR78uHtTUOvKY9lLdq0nF9ATyQXJ+3g3bv0uavuE9NgRlOpIdX6WaWiE
 Z6mZukblhmXq/mRAI2eoIGKKYIbGW1icnGwy7Hf9m/grw0IALghS6ZyZBsaCb2PjF84PMjcrL
 mdIdTloB6iu66f0bxZhQYgqBGwJNt4/n8h5WAnYAxBJOWWcwmMS3x2f+MvsCrCbNDGv6ErQzH
 DDHDPjrXpswE9z60C6KwYYu5yb7339WuKrN8hR+BvzylgHov+WHXvaGJqt9Vq+WZ8TT0nOaXN
 IISyyP5aDF/r4PO33zkUStyoib/3JTzUCcT3tikx54OhgBl66bqMktPYsbWf4AYPKXbiX+hW3
 2hD7+mc83r4Or4CijehCYHuI3AgjwlsgSZqWo1BYavAd+3aFZp7HW+JtKCwNxh6iGOU1Shm3x
 68FgXcnb3u3FPpf5oM07hCxx+9L0PNPZIK/KHym/phJMqsTLjx6lL7Aeew54aqg28volz3kXf
 UALx/3cq0ngPtAC0a4ebpzAX3VB0BgxibTi1CQDC3CPIIW+fTkLpq4ZX6WesGGGsT7L0Cz1iN
 MwCeCBMXO6CH/OfkcGetIN1dZHslqmg03AHBFmbyjR8YRKQC4mDmOpT3qxPUpWalwsAjhQJoo
 U8FMjBReTh3qbmPJi8/KAinQPS0SNgzBKLtz2LbQcXPaa6D3ERquBgqsUR1xQMBKqquGQ9l/Z
 T/JYJXZ71QBGBnrRnpvCmIp/ztL6QXRn9D0n/tbCmvVAEcfY1cwpiW9MCRNe4C7KWu0eYpRbb
 ctBUD89c/TunyL9DLUU8Q9vC4ujBFQppbl/PZSZ/eaC27K67OakvAh/BxjhSV4RpQVSNxl20u
 zjjb9PGIdpHTvSeug6jyWdEiUFF+FpjnqvWjK4M488Zgtjv+ZIYM6oFAlqU+iMrlDjupN0lxk
 d7acrlcZ0ylKe2I8VFphiakkD8NheAp7tjrliYXspcXofm6rxMrNh9RGPEmvbYkenRgagUxme
 ZI900XuSEQ8flHEVn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have tried another small script out for the semantic patch language.
This source code analysis approach points out that the function =E2=80=9Cc=
lk_register_pll=E2=80=9D
is called by the function =E2=80=9C_of_pll_clk_init=E2=80=9D.
https://elixir.bootlin.com/linux/v5.7-rc3/source/drivers/clk/keystone/pll.=
c#L153
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/clk/keystone/pll.c?id=3D690e2aba7beb1ef06352803bea41a68a3c695015#n15=
3

A null pointer check is performed at this place.
The function =E2=80=9Cclk_register_pll=E2=80=9D (from the same source file=
) can eventually
return the pointer =E2=80=9CERR_PTR(-ENOMEM)=E2=80=9D.
Is there a need to take this special case also into account?

Regards,
Markus
