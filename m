Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BAFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459FA2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="j2Nj1ZjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFHTY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:24:59 -0400
Received: from mout.web.de ([217.72.192.78]:42911 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgFHTY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591644286;
        bh=ntpGprcWPLFY+hQr6JDXGQi/wzfc1NSUFNqsD75E4Ps=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j2Nj1ZjUR3U+j0AKe0Tebd0ta3GSnO8KkEto6QLaua7JveyBYPs67LWe1zruIfiyK
         RiYJAEMiHRrycXaPJ4hCd0HXovbDzyJpXT/nnDG6o+N1e/WFhfliKecBFS97uOfv5V
         iY8DpXDq8R+DeMmYNg9idNklCvkvWPJNF7C2X48U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ldn6l-1jHbTR0FIB-00iyWa; Mon, 08
 Jun 2020 21:24:46 +0200
Subject: Re: [PATCH v2 2/4] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6c9c6a4c-c305-ddab-8a1b-e4dc448d643f@web.de>
 <alpine.DEB.2.21.2006082035580.3136@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd5b2ec1-2307-7508-6423-a3a1a371d33d@web.de>
Date:   Mon, 8 Jun 2020 21:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006082035580.3136@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4RLo0gH8yxE/3JuG0hn1uf1xKtPScsjntHcA766Gqf5xjwt7rbc
 qxUrvkTHGK7iE/nykUpFRIBUJtWQ/04b0VeYmmoDvyI7Ay1UkY6qebfzWoX0X0r304plX+f
 vEKu0uRwIMmnCEAEp3py9Tl6tcCabDk9Iy5AaJRKuJ9L8EFs0k0NUF6+N+bzH9FCZdYTvAr
 j9EpKljhXR9hRdILz5oAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rQabCmWyncw=:mIJgOO/t7DIcBRJtV8Ugpa
 +uAdrOebI6bEnt8CEQsAHyeCsTbv87OS2Bg4+jk0u6ejTiZmi2xgASy+cBSt05NC82HURXDSh
 PNuV++mC2XyHF1aYiTGhYNbCA0Wdsy6cq8ImTJCTY4AYoHjim6HdxSD9ywNbrrZDrRGYcWUwB
 SPdVKlFPLIupC+xieru7hN5oCDIXsfJwtYNSm+bFnQeTyJ1moDCliuCq5nwPKirOVaBZ1DHGR
 V9nGHll6o3C+B1ZvosvtYpm9TvlHYjeESOvOoXhFDpIq24A537mRGyjNn/1tYmjuJbxZoHQN3
 dbHZlfR6dkahyNz0YmAXX+UNIt7aMzfsC647MO4utN40ee+SewDD/yd8Mt2gufQjiOVt5vq/q
 cC3wTgrwToEJbbfSgM7X52shF11f2nVYGj9t4VjjrUr/cVPP7NnvyUoNzRDrTqYPuFG9j+EKr
 nsiNyQEv4JeBiPwoVn5YofhvHC3knnWngMuSaVPQqVquJYbzE+vcHI6iE0y9zGm09NTp188Us
 KFFa1SKKXFD0cn0MkDSGSyxQ20cmam/ZLPcW6s8GPOoEoxvKfIoJRiDn6fX+6F5AiR5ScnZt/
 lAlJPX7LvxAekNP9vUn7yS0wvLldkqzrTnjWoXFZPqs9TUoq9RZ/42JON8+1QlymVDW+ugUbX
 hgoh5fTRZfMOgUvMKvGOaSYFYWcYzrKgw4Hdf6o9qvU3Kb8m7sisAH0ZuY61LEFoxjuw9QXs1
 FXYFQreRCoRiToS9QXdHYj2fPX9ISx7xdA8XjauaP7KQb1dhPqr9LGRfT6jinRlYscXYW0BQ7
 5JrPvWy0yCzlHp6dooF4JYwkCI3gW/KHVCnBGpviIM3Y2OpAVMcoxyuRjxu01yxuf4fJU/aVV
 VS1kjoV6117q3RbAaUfAz0mtUx0sz7XMXJkEGwbYkBPpz1uahEF3y/WNWonnyu9xoxscy9nHc
 cOpN6NXnwl/ePQ7FoKG7HWCHIK8ixNbpptzBcU3rlGl7OHK0rRe9BkTLm3cKQvEv5uwLZtkGa
 VM+QVx3ORZpsMP+ZpsVEe4uiG3GXz2wPXBZhjwIuqeuEtH6WZvW48IQw1a+4M+WzJ6kuhHTWt
 DkzlHzFC7jitW6/+lVtuarhLG1/E0kEZuIywmiZnvMc2mx5RT7B5/yCFP/Rf6eNXvqQHh4Tmp
 X8LpbDVdh2yT6Z/tdH9suJVnSA+PRlkjPdJFpOowHMDmFC6f+zef7ExgwQTYx4JFhxmQ6XToV
 v+jvoS7c5dASq++38
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +*  to =3D \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
>>> +   if (to=3D=3DNULL || ...) S1
>>> +   if (copy_from_user(to, from, size) !=3D 0)
>>> +   S2
>>
>> How does the SmPL asterisk functionality fit to the operation
>> modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D?
>
> Make coccicheck uses --no-show-diff for org and report modes, so the * h=
as
> no effect in those cases.

* Can it be nicer to generate only required data for each operation mode?

* Would you like to compare the usage of this command parameter with other
  design approaches?

Regards,
Markus
