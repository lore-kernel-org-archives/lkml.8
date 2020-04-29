Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF29C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C1520757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bMDmpuLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgD2Rkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:40:31 -0400
Received: from mout.web.de ([212.227.17.12]:49025 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588182023;
        bh=8GJNRkN8kw1J3EYxnEcynY7rI245QeKgjvw+lUddvI8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=bMDmpuLGDHUFyej0Nx5ElJ+a3O+uZ8R7dOBw80g+9Kukr7dC7knq+td5I8ayfMeEC
         lab1OO6Gl155CV3lAEcczrqybinU4GCqlTtur7zbpTdNCcYk41YMRh1t/1QJ1yfkz8
         0jSajBZGX1MoV9TI++2I2FD1FBd6RGrxcHSB4BD4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHXxg-1jSjhT10P6-003MPI; Wed, 29
 Apr 2020 19:40:23 +0200
Subject: Re: [PATCH] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200429163645.GA13810@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
Date:   Wed, 29 Apr 2020 19:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429163645.GA13810@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0vthBJFAISaa5ToUbEHvTuV0EqpY1TbM+FuyPwMoMQFU7NIgCxa
 YyEhtmO9sdGsdyZyph92NlvqNCwAp/INQnKz4ax+0R7XV6iLOQEpkw9tr87LouVLEloH81O
 ScbAWX4Dg5EiLJVbI0xbKLrIRy4ph0YREDTCE6sE2iYND3zd9REILp6m2kn1Hu53BhaS20Z
 o5fsFnotvlBVxYuOij2LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YvA1moCBgxU=:jdEbba/RL+iiimv9e92OII
 yTEd8R0c8o53QLWk8UBig0F5IHnGRnafACKCBeqNH2izBxyfWzoemOmOyWeEaaz9O/Ro0Bipg
 9vu5jKuEouLoux8sZzLUnt2fLwtw77+egr3PGsI4SNWEv6VboonwFLqhWaZfOIL5CfSkkArLP
 l8W0r4CuWi+5G55pY+Xf1BJPNrsXIMSmysXY+npyinW90aLUMUkU1ecayr3VqTEHn/AJNgwaM
 927aCh4PZ5/a7pvrhA3OLhgf/0NFsqTmpXNHFYJ8DbRI+1kWemU3WOXcQUu6UQ/6b5/1gD2ax
 iQ25iNErCxyCutb9Rqk+PxpyAKuBNpOgMBDwSuY5WnqAurL2A90z/SxBV6Vpxag/gjtVySFoN
 ni5uBRwruvstzrs0aul8glpr3zrYPlgFbPe1+XSWAOan3J/YF9wUmYWZuOj8a0TXxBVheAFd7
 YAo5tmfBEaor5Lk5lqn0p4TTxOyMkfL7JpfWWUl5Y+hAQWVFBZDBmcSXQhX1dCS4mTtvaqloT
 Cc4pflm27X4QovI+epbqGOj3ZjBcL0kSeTLuELMJ0XmDFakoqbN+5dPyQbtkSFwuIqNkuluZB
 QUoZzIWxwvTseNPzZYGdRRznoU6UtGZ8nvUObgP+sIJH3/Njqa7l55kltl2N6bteW2dL8N3Ll
 RmZ3VjsJDX1q2K/OjkoAOCz4wKpWnSz8TprnJouC8Jpej9F/WBq+grNs7Y4GE7ONPXDIji4WF
 /0a/LZLKUmAfnWhlW/rb0Ssb1laEysOc65H/pn0v8gRq+V+vFQR/DpoPqAzCjUFEB8i4RZF8N
 uv6c/varr4XeHSxDL21KMIrnRoqGTrxBoxmC7nzZhxJDkhJugOcd9/g3mZDzrHrCkBZ+vuuuE
 0kxSQZmGvmPhH4lY1wGt25+OvyPSv803SFxYcITMSbrqoma8Yg0iLWdaimlLt66SKhd//cQe5
 HfCbcz60twSz+7qasQQeNztr5jEmd5aWVgb6YIxF2u7KVIO4h8iq8pRHKc4BRDFqMgSfYjGuD
 ejehcVMi0/c1UbAo+I+K52uTqqRRdCvv1j0fHUyo9/CbVOmPOnQf0voIYuyHTnWaakhVyKQ5G
 Hl4Yzb6l/CoNvnyn4ELg+iupU0lnGY0OsKLK9xGqtJsPupUyasRI5xHrRE7wl16i2SYcKU34T
 mHsC0IS14lPY2e9W1x/+Q33JiFelSU+6BjIQlVfabjMNlHumWKjvdyvdLuzT5ywdSjWqEmm4k
 ZuFmlTiHl95nYLuY6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=9C...
> Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to si=
mplify
> parsing scripts
> ...=E2=80=9D

Why do you not like the reformatting of the quotation so far
(if such change descriptions should cope also with specific
Unicode characters)?

=E2=80=9C=E2=80=A6
Do not split the tag across multiple lines, tags are exempt from
the "wrap at 75 columns" rule in order to simplify parsing scripts.
=E2=80=A6=E2=80=9D



> And there is no sanity check for 'Fixes:' tag format in checkpatch the s=
ame
> as GIT_COMMIT_ID for git commit description, so let's expand the GIT_COM=
MIT_ID
> to add 'Fixes:' tag format check support.

I have got the impression that this wording might need another bit
of fine-tuning.


> +				      "Please use git commit description style '$prefix <12+ chars =
of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) . " $id=
 (\"$description\")'\n" . $herecurr);

I imagine that the support for different quotation characters
can become helpful, can't it?

Regards,
Markus
