Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3544206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dyrZOWNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgFDPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:21:22 -0400
Received: from mout.web.de ([212.227.17.12]:34851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgFDPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591284072;
        bh=caLG19BmdI2/AnMcBvEukST94msU8DtaCn+EwD7K1C0=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=dyrZOWNUombdPmNyvpkL3QYQlIRpqZQZ0+oGqCWI6EaJziJo6Res9i1ivnuPKp9RW
         J1u8vLJ6AASKvy0cQspoRAOKqFqBpIYBgvh9Hq+0TB557t+r1uhJFHDdDlEtKwaPSi
         nLYj7ocYEYDwGnoQQRKpsQBUWM1A9dqkP7XqCeAQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1jmwDJ38PW-00EsCG; Thu, 04
 Jun 2020 17:21:11 +0200
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] coccinelle: api: add kzfree script
To:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
Date:   Thu, 4 Jun 2020 17:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZMf8O4Xn5rAtQq3P9sIxoHJO1CdlQUWpYmMtF2VojZeExe/gcSR
 WXf6FseHTRO7D4dJ8Ox3yun/OhGjd5WqaBRiKHFARIDxTdYxnSMxkoz1ocB2bXPoaSS6TB0
 HSHKpyYQ5olhNADcQ06q6MWpYFIXJ1B4CqEvLfg0AwakyfG6njmKMyq63V59i6lu6UnVzvI
 2040+SX9/Fw/0ekxJZ3Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1xbuqnI6g4=:h9RSSV0n/H8v9/uG40pu9M
 jem+883AQumTBd27fpL68Wue7KPKEQiu3tyMjBikoUbWza1jlZrxPcbjZnV85LsuLxJ27zh7t
 EjmsWNR/ezbNFDnhLtORkja41VGvqW9f/cVrVh5u1lPbxt1Vzw3HeuA9M9BIKlm0GKfSFteqG
 HSycIoZ1t+GpB5bgDzAq+L+8Nq2clVomj0E7gQrOu50JvLoBTCuzzIazbcYhbINH4rTzFOx5l
 LO6x0zVkZ629nvVNAVRNBFZUlKHUfnYRPzcPSCctkB1KecK+QQnoqCFLjbD5ngMW+t0psmadg
 PRdqIxFgu1IhTL8qUutiWYvbjprzZAqHKRk8Cbq3xZMPxt5fTi5HUpyoCwTTShp62xov2vzPv
 j7J8axc6gZTgwX2WXX21NqZagcSDL9pE154QmPdSC743UQ2lgaI3p5JE/Mhl8AhxAISPy4hp6
 00aL1Va+3GIM5qxF/0OHlZVqyTyU/omRIrMzrAdOI3IBaEa2cxryxFvbGbxQMhyJCP12y8TMY
 Abr9RWjn1qVw74/S6QvQD/pNjOqYTtw+xNtBW+PSqdJXG5CoXXlmmlmfWcAaysT09BXhhmKcb
 sOmizOAlCB/raTwDPKrdsm8vEvYs9ChYCxPthUpggJIcaXRW7kDjE1rueppzcJOWXGgatbJZq
 Jxf4ndX3JYBOpsWIHO/kgI9sPYWUVavLsQocyXqPjC00KugjbJ2NqCztkP+bXM7RW+Ghq/NSI
 im0Ys1VaWug6kEUSmQ3fHJdBwlPzKiMuvSCHWwBgWknWltDdInXjj9YmNKj4zNYt8vxXFBMU3
 HVy/NP9HdaAP3mlw0WbmqxVZpuMjrIVjKi9J1QoNYY4MXyDpZ35vSDTOyfVXyRIIkv5eCFmXv
 OZLNDvXxNMkKhG0qnLrQ6cPcIAe+iFFH0aKi9BqMkFThRm/QUbK9NxR4GZ7rYYGKrSuvsjz1j
 sMrZqM2v06fntSze+xMxepPbvDgFh4DZltikJHsScuzYpRj8yABbR6HvXI7S5z6KNnGPEO4MD
 tDuaaIXJyFBg3xDVw0qY/RznmrHSraSrHiBA/+kevX7lbWt/GjJgVazuhJhP1QTPpC+ucCFnM
 hm7JCj5gCo6y14IOeiGAIHJpxSJGCH1F328Jp6gSRz2q490qeZxZ5UZE9o/woBHp5ysxeAGrt
 1TEzVy6zKzP+sfYmfbSm+1QkETIH+KgcsFE2bDF7PHKrnbFGCsBYuz4b763WNM9a8AsQm5Sa5
 5A0UDBqCclTlYDYmZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Check for memset() with 0 followed by kfree().

I suggest to simplify the SmPL code a bit like the following.


> +virtual context
> +virtual org
> +virtual report
> +virtual patch

+virtual context, org, report, patch


=E2=80=A6
> +@@
> +
> +(
> +* memset(E, 0, ...);
> +|
> +* memset(E, '\0', ...);
> +)
> +* kfree(E)@p;

+@@
+*memset(E, 0, ...);
+*kfree(E)@p;


How does the SmPL asterisk functionality fit to the operation
modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D?


> +@@
> +
> +(
> +- memset(E, 0, ...);
> +|
> +- memset(E, '\0', ...);
> +)
> +- kfree(E);
> ++ kzfree(E);

+@@
+-memset(E, 0, ...);
+-kfree
++kzfree
+       (E);

I got the impression that the specification of a SmPL disjunction
could be omitted because of the technical detail that the isomorphism
=E2=80=9Czero_multiple_format=E2=80=9D should handle such an use case alre=
ady.

Would you like to tolerate any extra source code between these function ca=
lls?

Regards,
Markus
