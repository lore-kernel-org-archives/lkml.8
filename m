Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E80C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591E9206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bpj8+NOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgFIOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:16:24 -0400
Received: from mout.web.de ([212.227.17.12]:58859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgFIOQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591712171;
        bh=4e28CHChxT7wxLcfH98/m8r7z/2Hp4xhy6bqpTw5+6E=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=bpj8+NOODMCoywXkYrrRJkM769aY0w1Og6daKIEZHUZ4mxDdIBE8fFME7CBDWphOz
         4iG41FyqTkYkuHQMHm79PtOsaYgLOVz0Q9EpRQdJpC1wGoRvwiy1yLkPA8+int+1A5
         HjjnHnw+WBoPBlJ8IwRLtwtxrvqUm3p5QW7S1GyA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([77.6.55.3]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1GAG-1ipaS32O64-00tFO3; Tue, 09
 Jun 2020 16:16:11 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] coccinelle: api: extend memdup_user transformation
 with GFP_USER
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@web.de>
Date:   Tue, 9 Jun 2020 16:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5qOHi/QGPt6HDDy++mQcTjcvl6ZVbhg+a6OWbIowPMUPExg1FLM
 ytrFenQx99weYIyI3UcwQjBApTIflOTTc9lCa77JbbOQgvgC3lnvbzcrudAkWkmJTuxtYbX
 FSgvPIjMRqkTCKs+KqOUSAbnp4lREfw2QXeqHqS+9tYCNUPdjqb2TsFVg52WWlTUiX/vwuX
 P/Mr0zvv58D1tJf9uSROA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mpYUnu5JEC0=:JaviUAuDGsXJK5Nwln/HGc
 ChxKS+GRPJrh3j0aI5i4AMTKuzEBxHauWmKvaWA6nCKJdPmvAyNy1DYmL1HUAo7FBK2YvMaYh
 eX/iFRAqHV39Tg8W++EMUAKweE+x3tsbm2h4/Z8fRmxKbxZv+HKAz1phIgOBUWTZSz4Tq2kD5
 BYkSv0wdaSoxrDfuJ4LeH270+PKuU0cHfo7vxSBxy8p28wqxenp9ytL4bCVp1El6OcJ0KwKkQ
 BiTTO+ZGN3nEDCYCWlf+bKzPJ2Qfci9zz3xTwUP9t6yE3TN2D8pQ78DJNVKp2+c6FEzuxfmFc
 FBE8jFmRY+4WulWaH33YZMlw02G/h1gCYmMVXW2atuy0vZR5UzilYvSEFKgYaZm/DqdnkLvvn
 U8qR97oORrlpzbo4cpw9ijIYaGqafn//qL8FeGAv9ssN9Dj1z4qT1YlWdRNIYtpLJkvuszWXD
 JrMuQKofELqBIov3vl6Erzj/S/OJxewuTn6rwweHdmJpoPX1U/i3qj4sYSr4GALiquLsOw61k
 EeJOHLkOwqCi55t3Fq4JLS2KGmTVSmqt4s6YbQ2FPjOjGB6Zx2w33kDSsPvwwCx1KRVU3DNtE
 OCXGQcnJyevO3X7kDMpUnjogFizmalpGWQ2L0VsOmAdh8VEKMQJa1gMwDUl9699z6iFJb73r1
 rXF8Eh12k59viryAQhIxPYCjZSBxmNFBY0ZGognW2nXvzh8TdmuGlMGCwL2WaHcq2bFtWTsnv
 cyiuNzBQQUxRq6LpS37xlQvWcMH7eptOThG+jnB1GU5eeozVHUshVWSCGA2h+Hpd19vu1ITjt
 BgMIv5RMPg8bH+xJZx39yZ0LxqJoGomcBjsbgCjkUfezHSD2tYXNr5MHHsU8FKi5ykQ/1yhhK
 CoFay7d/4/AdDyNA+DPSe2rPkxSed3kG2etq6IDcYkFSuzOXdUAtXula/fy+0xVeI3zSLcvIq
 K96ISQALVXUebWLzsFekPTrevE7urHjk/Wf4oAKLkFjDkmq0alESrrF0x+2yyFY4tHVGA7lng
 HRrUL+QfD1ZiQpodCONSVLwyH2upzjOvweHxUB2lk5vKcUgV2tJpscY+tveXVnnzbM2vxG/gS
 q/yBNLM3k6me25XLsZSb7gexYeZwsxzqo+2h1Fu/rcHd19g0lkPFB1geUl2NcNgUlOsA39j6o
 KO5TqxRRKRbhridmpvUhvWDk7SovV/ubbrhIoc0OGiNO4JbJ5kC5V7OwmoXFSSPDUU85nQtXe
 Mym/Ya5QwHw78I125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -20,7 +20,9 @@ expression from,to,size;
=E2=80=A6
> +-  to =3D \(kmalloc\|kzalloc\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));

I got the impression that this SmPL code needs another correction also
according to the proposed SmPL disjunction.

+-to =3D \( kmalloc \| kzalloc \) (size, \( GFP_KERNEL \| GFP_USER \) \( |=
 __GFP_NOWARN \| \) );


Would you like to express by any other approach that a specific flag
is an optional source code transformation parameter?

Regards,
Markus
