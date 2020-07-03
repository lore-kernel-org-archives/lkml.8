Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C106C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4607207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kMdvSJOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGCTW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:22:28 -0400
Received: from mout.web.de ([212.227.15.3]:41951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCTW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593804120;
        bh=+D2r4Vv9pbcWq84dydtviIZT7FzPS4qfIsx8SVDmKNI=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=kMdvSJOR1VtWTnY/+Uwu0i2wlHtnuVN9qGIJpBQz66jG/N3jKkd1sx91cSaNjFbG2
         97/tTi0nhGKnSrOpVvhOHeMP6SglIWA/F6J1h73uo5Hw80SFnLzPhWMpBLQ95WFTyF
         7osnl34BKQRcsu/fBLSAwBmw+5PpxGUyBzEQ1Ry4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.162.39]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvjoa-1ik89c23GW-017ZBc; Fri, 03
 Jul 2020 21:22:00 +0200
To:     linux-doc@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?Documentation=3a_Coccinelle=3a_Checking_information_aroun?=
 =?UTF-8?B?ZCB0aGUgbWFrZSBwYXJhbWV0ZXIg4oCcQz0y4oCd?=
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e546930c-0022-c0ea-059f-0c5ec782b5ab@web.de>
Date:   Fri, 3 Jul 2020 21:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdMXaG3dSxRkcHLbr8/VciD5jYfB5INxtU93pV842MenMazksfT
 XS35KDvspOOcymAEzyStq1lTs0obNO2Adwb54tiUker/CubAhsDUxG1xXylqcLXw78cBA+X
 gMi7T1mv8wfJRw+vYJAdmsGznL9c3sKLGrPAkr2mI2p2n/gG5EgYtNQ/5ourRUPBk8JSIWo
 M5gSL+SkTh+w5hDpKuYQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmubloIqieY=:6ioFmBVUhzddmlLARoFG+3
 14Lq4crWHI2U9MoDP/JcNb8bAfpz02cDekQtgpe+LdsRMqWe+pYyX0JTWP8zD5bpxGjjmCDp7
 J/n4K4zsW9yHoubm1MdS3QvsmlPAY7mEYC/pR5z4OOWG2J1qE2Br3MtTKkXs+DOHxlN14wnKV
 3+0wxdbcQZrxBeDCMay9nmaqW+glcjKq/AXDICCRDYKjwFeLCIXwUJAHjef/evLngD5omxjK8
 hAzztyaDULIC2TjBICBofYobFdEG2jfn/RXLHe/75zYtsVizy9AWyA4n46x4KJKRxQXIBJSzs
 XujvzC0yInuC4BqlbbYljupwQ09bBGPlhQszLasMOOkzjhahtW5e7i3grtMdP6YQrZSxU2u5l
 PlwOUKdIlpDhs+iSb6pZ6Tm+za1UK3aylsf3KQt4omkxU5iUpgdXCooywuF2k4qDmhS9gzU2j
 m1mx7Q5Bnxz3GH/dQnzvlhf3G+LozF8LWXQL4b5c6k2U3crlJw5CFbSsPbzop1c7ob0IrJh2K
 Yjiv+zLVWzMKOWPO7F/3EwIvBvPxHArBNqlr694YUZD0O90P3LxvU8CkyIv8o3EWDY79Hs5iN
 5GqKNujcDHRikgsyZVf+m8eWISNQSvkFywL6zgi0mUvVFEdkJ3iLeQbKGrQYy2+mkAsivI+ho
 /V5r+dWE6vxUezOpx84AEHaHq3kz77Cq1Oj8u6Qh49CJJnB00LB3JEvzWqnr3pPQYbvZjVv33
 Uo0VunqsLy/U/Dh4QLsjQoPUAX4gBpGk1HBb1qjj/VNmk2nmS6P+5dMVvb03HJOkKbiKFlYOf
 TYsrEo6czE0N1dLHOaN76e05EO8jvgRFA78aiTY8zDuND44wUO2esAfC71BGlccdV8KDCHgD3
 BHQUg/HL5m56IobeBMzJP6RzKbHHqs+55dGxYWivUtv4v4zWhggQOhVQzHti5ycclgkWl+Nu0
 ErnsPcwnBdPVupRUK/zA6Y0Df5+VTU7SnsPDJdLYm7gehQge9B8vI4dIV6oo5MvzzB2drUOIL
 pwL3XS2Z3pKW6Z99e60ZFSvjkLSMe/MmK+2ZNyLGJmiMYCW/4Si8wBQdKUY7j/16S6JOJz/mh
 TI7z+s20v8jL6tur8/hF7ogzff/Y+asoU1PbAm4BHBcxgkYm/+NXK2XXfCIivWn1BYMuGw/Xi
 PCN69TMx1NKfTMV7TiRa9qZ+Wqwmj86A9qnaCPtQXEb1Ax5yGmUJBFRj5HY7C9wr406GgewnW
 uLjit0Qf/ejR1GxEJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have taken another look also at places from two information sources.

A)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Ma=
kefile?id=3Dcdd3bb54332f82295ed90cd0c09c78cd0c0ee822#n201

=E2=80=9C=E2=80=A6
# Use 'make C=3D1' to enable checking of only re-compiled files.
# Use 'make C=3D2' to enable checking of *all* source files, regardless
# of whether they are re-compiled or not.
=E2=80=A6=E2=80=9D

B)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?id=3Dcdd3bb54332f82295ed90cd0c09c78cd=
0c0ee822#n182

=E2=80=9C=E2=80=A6
To check only newly edited code, use the value 2 for the C flag, i.e.::
=E2=80=A6=E2=80=9D


How good do these description variants fit together?

Regards,
Markus
