Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679B206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mMWkdWus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgFWGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:13:11 -0400
Received: from mout.web.de ([212.227.15.3]:41289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgFWGNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592892767;
        bh=b44EkyIoTZPd45HBfzvnjB9aJzYRaSdhV6Up5m5zkNc=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=mMWkdWusgdRKCKOhp42gu1ndqBk9dBLqdCCsm8wuGeHLUeP8Ku5qYMnlN0oor8wZ+
         h+Uvp9JsmDuuDQPZ4WfDtdp9rQJZESD84wZLWJHZRPFpsA5a7Kj2T7DcDXfrf6ssLt
         0lXLU9RVqDvcDalLar7eoA0iHCO5QagumavSXMGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbQfs-1jXBDX1mlg-00Ildq; Tue, 23
 Jun 2020 08:12:47 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <4014118b-90a6-68c5-048f-32485fa3e852@web.de>
Date:   Tue, 23 Jun 2020 08:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ceunm32lueHsoWlr3jtOMa9J4QC9xCFXmKW7X0lHDTkeXHItUCx
 OLHKOHIJvmsdpAANUBOKGcdhAyZKM11MyGwL3UiDU23/R3ILBIS8ba3OivDHuyJbmNS9rnY
 ojbpSgc4fYePhFkbSlkpDbJC+LkBSisRGr7ygMr3u2q/UW7dbMPitKcykOWnGnhc6z9BWVD
 xM9Xlx4our3k9HuDR/UcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLSk/ve9w24=:2XT8fF//C7NB13pR9vRAVQ
 TGCyabeUqvEWXXDqUcTCUK93PBl2WbqPZwVczVjwBY9sfChLCEjzX0jLA/eTr+niO//6uT9HE
 jr3/ur/XUAv652bxp3bjbisFp2p7RT6ALlPTazYEemwN7B0vIIBbACrqBhY6ChTWt7EQGfoN5
 ZEr1M4Xw4tEwqYUTutlOVM7fxrqEkA2+hcJIah/NIBprBOmVepdcz90jkYXg5kPfHvCSFSDCU
 nN82vzLOn5AuAIlEob3JJAfTi0KBx+6cLNErVw5EIMV9vE9/PJlXTMoLUTMOHSJUIMMj83s0C
 aIlOlBn2EN1nITnBb/LHzL47bw7GpLx3zreulttwM1O4UZBW65V3ScDILIn1OeVYQ0PvabRQF
 gBinDcmPyIEnTwofPWPOWKDTGuI0/9Aba6KSveWuEmYKdlFu7apYOs8YATagc6qcW583CotaL
 NFNnF+xMufdJZAsiiQQMjCrRa9ac2BTrQe0VL6yhxcg5BbXLXavp3YvkLjQERMn/kozNEN8ap
 /EnVnzaGOmqaNTmUVNht9nmngA5yACKkvVSUdjQUqjpLtL6jD+5QYAHGxEjNKUTbeY9A58ftO
 HVnQTXGQ2RyKVcOBl9VQTLiTxtFYm6k+dzYfFxgqCnEzDefXAkIuS2I0ueliFJWw8J/e0Rb9N
 Yc+wN7pMqCb9SUvmh3G2M0TeMvhr7SHUyL13fIECI9jjYAuQm/EBik4K8o3XhgYSne8PRMRe7
 GSU3yfJXXjrMSjwoaTg6fX0pYapK2yYjdZg2u1SCxabK2Ic95nMOh7I8XywN18fV+n7Qa7A4c
 yZDdaaxsQwUGrsWJotdChLfUDYoXXovv9zEXgg5Pcosy9J2W/z7DzE3YuPpqFxPioocAkao0m
 FrdF/ZTWVqqWAOZtBx7o2LB/2Sbwq1CNyuVeSImkYAVCkNyAos36Br3SIb7jMBKnewGoJX/Xa
 tPZsU90kUJd1lXaBvd7Lds6PdgXtHxCN5nWhmaLqUn5FLSBjB7WzAoWhMJAp3mRoN6JhUNxml
 6st5G6BYVoBCMm08dCI/u78VgTOm5lxh8sRkwwG2Xl3de4AhPf7tkmr+hFRZew4pqQa7F0R+H
 yLnikoQjLgEDLE1Prjxc6yjDf+KVAlZ9+e0K97yW5u7iomjwUsII/WOz+J5mll/0gA71wfzgx
 SsImejBgmN3wnVczm3sMpNmtMWptZGle9uVkYpgdqHz+PbsOSYg6fPP1DahovDsAWU909uHxp
 PdBuCTRDZlsNB9Yqs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v2:
=E2=80=A6
> - assignment operator used

I prefer the distinction for the application of corresponding metavariable=
s.


> Changes in v3:
=E2=80=A6
>  - \(&E1\|&E2\) changed to &\(E1\|E2\)

Would it be more helpful to mention the movement of the ampersand
before SmPL disjunctions?


=E2=80=A6
>+/// Three types of patterns for these functions:

Will another adjustment be needed according to your information =E2=80=9Cd=
uplicates warning removed=E2=80=9D?


=E2=80=A6
> +virtual context
> +virtual report
> +virtual org

Can the following SmPL code variant ever become more attractive?

+virtual context, report, org


=E2=80=A6
> +expression subE1 <=3D as.E1;
> +expression subE2 <=3D as.E2;
> +expression as.E1, as.E2, E3;

How do you think about the following SmPL code variant?

+expression subE1 <=3D as.E1,
+           subE2 <=3D as.E2,
+           as.E1, as.E2, E3;


=E2=80=A6
> +msg =3D "WARNING: array_size is used later (line %s) to compute the sam=
e size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)

Please omit the extra Python variable =E2=80=9Cmsg=E2=80=9D for the passin=
g of such simple message objects.

What does hinder you to take the proposed script variants better into acco=
unt?

Regards,
Markus
