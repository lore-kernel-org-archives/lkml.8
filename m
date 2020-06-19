Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFECDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA321707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dnvK6hy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405549AbgFSQPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:15:10 -0400
Received: from mout.web.de ([212.227.15.14]:56741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391043AbgFSPDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592579002;
        bh=GxYh1qdG0mY8NBgFhfOclaGuSJllPFVrAzWx8/7J4Os=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=dnvK6hy2/lDP5qxtum5D/NUKgieXMtg84RL1gjMcc3KhM8XXcg6vioONzhpJn0kU+
         WVM+kDtsg8f7e9ETrZ3b1COhHwG4Ftzw7Ou3eB96vAIFsc8X+MwTDkxO4Xo8C8YI4R
         PHEKFyY4p9AbETpahXMIosqf67WegJ09PwosLGvM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.139.231]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1jIAOH0MHT-00eetB; Fri, 19
 Jun 2020 17:03:22 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cf6ab028-4297-dfab-35a7-cb6589fe61ac@web.de>
Date:   Fri, 19 Jun 2020 17:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dDirl9a1cXle/tNkqr42+2WaoqiVXrFC5lI+chji2DVPI7fmJX
 B+FHitTBLLj7znFEwh45Sc1LCXF9QziVsXM8GJXu4q29LHgXELN1w4KC/13krJ0QxmMaVw7
 yaQGaVb+R91z53LDiUE9igNYXrkfEBRa3WmuiuPD5EE95Zq3Rgi/VPQT0HKVva6J2HZaAKj
 KaMc1LUoPBZ0DsbHU7uCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:joucBZ9eE5E=:RIurRgSuJTokqpZGz+2J0+
 bzt2le0VsugVrWTRNfAclI6TswkmQMTisFuD7m4bfql08FVvEVAK3IkzGCLw4rEoRxiNLV5C3
 27sQ8k8C1YjbJGA+F4oQDFze8uBYna+DaifXRmHZI40KmW/Sf2+zfK+3oMd/otG3LW4blgPFw
 y+QtNd6OfHNclWKRy8YwawTX+L/9DI7YhgxmcUPAJs+l6JyI/gc/J86fP2GfUvwgUEeU2UY0/
 JHWpNDieZu0lJZCN2h03TRvGD1NupB54Sh/MRRJbVeHhopPy6D0RzteNzfyzsA1kkdtd9FqER
 XFUvUhIYZsKpO3Pys7qBNw9GBgRACNidMgkb1FLiGxStctedIsD8s/z4MDfM8493oODh7fYeW
 ca9rqK4/tz/VzLnSCSKxgQEQGHNSMqS9o4K83vgl0dlT7YUFhGKO8RaS9kcu1Azu1k7EkRJFr
 yT7nCzogr1wE27RktKqppzOAmLZHNjcJmBkx/n5n4u2qXDp7eyCZyXy0XSwMiiB/o0+FWlM9W
 GSCPtp8fjsmLfPh4r9UeYY5qoGh2VOQ/Go7t5AZLSRLv9ohyeYUEulo+ag6JugMJPTlVMqWmH
 X/tpwhbATdJD35oRRLR5IzqhZ2ebXMOZTyfxM/FvWjjTojNKy0i18naG72gYUvn3F1g7RxK+e
 oIgWgMKnGxUz3OMzIwjFiiCgPXtIMr7PF2IgMXUqQ+KR3mUIzTWPt/4GIicridnDYz2RAUmU0
 LAfyaHNCpwA4bbUz/YdDOgWkmui8s7l3bhxVsUbVYCymMqlkxadpudYNbX3ofpu7tKEiSfy74
 T0qiZAMhgM4DOskVTOwmdoUW7l1Cu6EZRAFfvicro78szVX7pW67gXfJ2+M356EUle9IgASf0
 9yEzzyUQNkcqZY+kJkwSY+ZKJnXlz6WRoZard745n861vN2ZE32S1V74vCBn5WXDape0tu5Kr
 TuRxinw2M64b3ABfzQHH/uGflLBUnhdKJeNA6HFbAukTfzZtGVwBev/hvdSmVX5SpvvH6Vifg
 aJQ6dPJkJImQs7StvSXyR7S933tPFJTb0xdRQCFoXAwa4ETPq9a9LLQgn8VKE3gt09DYbHJzJ
 v8geyl17eODgecgJ5wJUCvEx70k+R3PAinonliCaiQUuNup53NaqDXO8D+63/WYEd5WeMSWuM
 PNVU0JX7tmrbw+4GQBJC4mjRPgulKt8rdb2zz63RrI6YSORmfw0KI1AICp1FZw923gY0TUg/1
 sYwn1O6MfVqqCW4BS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v2:
=E2=80=A6
> - assignment operator used

I would prefer the distinction for the application of corresponding metava=
riables.


> Changes in v3:
=E2=80=A6
>  - \(&E1\|&E2\) changed to &\(E1\|E2\)

Would it be more helpful to mention the movement of the ampersand
before SmPL disjunctions?


=E2=80=A6
> +virtual context
> +virtual report
> +virtual org

Can the following SmPL code variant become more attractive?

+virtual context, report, org


=E2=80=A6
> +expression subE1 <=3D as.E1;
> +expression subE2 <=3D as.E2;
> +expression as.E1, as.E2, E3;

How do you think about the following SmPL code variant?

+expression subE1 <=3D as.E1,
+           subE2 <=3D as.E2,
+           as.E1,
+           as.E2,
+           E3;


=E2=80=A6
> +coccilib.report.print_report(p2[0],
> +f"WARNING: same struct_size (line {p1[0].line})")

Please align such function parameters.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D5e857ce6eae7ca21b2055cca4885545e=
29228fe2#n93

+coccilib.report.print_report(p2[0],
+                             f"WARNING: same struct_size (line {p1[0].lin=
e})")


Regards,
Markus
