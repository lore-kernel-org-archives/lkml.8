Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2345FC7C840
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13832064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eWvXyq8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgD0OBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:01:06 -0400
Received: from mout.web.de ([212.227.17.11]:33511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgD0OAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587996045;
        bh=G7f/i/fdoo/LeHSYerPH1Vrvch+OGtSaLOsj7Qc8534=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eWvXyq8kjge77Qe35CpH4yI5sfJ2R9SRvm6lES/JOhA864heS75+Efw6zCbhzoojM
         UmgQO/QsPUDALWX66+wMQANmL8tiRo5aIULHoKNATfd+wUgJwQxp7Rt+0PPJgOIi6U
         i3oWzNuMCemvKSPAT0nyITEdLuJ/IPSxGWNfgcYY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MN4Gi-1jZh5R218q-006e2V; Mon, 27
 Apr 2020 16:00:45 +0200
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: add dedicated checker for 'Fixes:' tag
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c8960fa6-c69c-3779-aaf2-b6ef14671a63@web.de>
Date:   Mon, 27 Apr 2020 16:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n98IuW6qhLjPHkPe/kcGewJzP9mxcnvhLvGBWp8Pv/cxZOedmVc
 /x0l1yhSnEl75hBN8OIun7AH0OvjUDGwsH/o0CFz26xuUMdeRcgjdICd2Qud8hbrDza2yDa
 VPWDtb20/gr9TtKJF0Fz2z19u/iDJ9QUEQqsuljy4XoqK+ExJqv4j8f+wAzZaVswUihK7hx
 EC+8w+ULO2I+00wPgalyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uS7Q5NpihPE=:gT80idVeVLLNkSTUWwjOIw
 7IXsouJUrpbCCd25Y+JRhRkcRpT9uthtdepli9vF5Iu7xBDSm1/DEgB3IIQWYEx/HIj0DmKyo
 UojwR5/LI2NR97pf9IiWewJrI+bkFXPNoyXNFhwPuElc6LOJM9EXBKH6BxnSC97ahc3SU4uZt
 xiyJFqn3jqQDXgSJERocTGkfQvNnYh+G945nmfMv6s3q2VpaQxiXoJH6+OOHKV97NJuGSTqno
 kRvw93Y7r/50JwVT3/TaUMP3OnzSAHFCUHifmJr8VESVVZyK53jOMHN6n4+XtfvQdavg+KfYN
 xWv4UlimpLDarSKEwDdalS71CNqJXUtR35QP+pXDWjevI/Vt8EqTes59g7f1bIR+h0miXrtAL
 2b7Shj65NKZzi9pjZwnqt55m4I7w6dIQSkZK+vDRLaYSYV2/JGuK+G2tOBdVhsGmj+S8LbeQl
 KStJsfxi9WzKyZ78pZLFRjTmu2mJYxD0BfOL92FUSRegUHs1DLYXYK5rWm2bK0RaiGAe0D/uK
 vU9RXlBlXezeXCZn66pfITbXoVGfRPQsxaEpZZMsAQwAilsWJsCvebUUMeyf2/TC+d+9TlOkk
 1CF8ALlFS0iNvUmOFr5MgogOZP4ijCh+YPBj3tz++z+yga0qFlo+2Z9aCo9jOhn51+KSHXlaT
 A3HGZyC8A7W0UtMjxS+NDvkCuFjZ/KNnwm84Cjrmb6eAb4PohSnxxJfGkcFRg8TGo8YUqk5D/
 9Q078GC3NJmOJRJlibNmxPQfl1mJwNPLaZJA5iwtCbqn/xIu6mSu8mfRqE3DJqjRDwIw3g5nI
 LneJrD+hiQyR3WvQvJg6pDagf9d3nyyz5q11qES0iY+xQo2EsVmfIWM2oWhz/ajORlta3aaOj
 MOvtuUgJwKGqTnPMmS2idg/QT5woDbG5qHLLhOA1QWFTxNIn0uFoCI+QZI60JeMPraXVJvp6r
 omX5rSghxDJ8zOhvlLoh7QlSn9dmUntj8rwza+xKuO6ICU3xM63/ruAbCxbCo8LoJ5RQ5ZRNH
 IoW1Tb7H3ir9LtCNSCKwGk1RgcsT1HonqRC/J+63iEsCaL6Wlj68lDpZWVDt/bSOWBluKcDfo
 SDkvz0qMBd4DKjz8cfj8yuLfzgegFNFQ9V1wPIjDtHxJxXs7TNi8pqINFB2ZfMR1dXHUbZNOW
 oSptsPbKoes+tsVFZNFlev2TWcNyOQeoYih/7c29gN5SpB0/hMKaj4J4Fd3I50t1pdK5CECP/
 MAT7lYgmrxP95+wbE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> length, so I think it is better to add dedicated checker for 'Fixes:' TA=
G.

I suggest to reconsider also this wording once more.


=E2=80=A6
> +++ b/scripts/checkpatch.pl
> @@ -2820,7 +2820,7 @@ sub process {
=E2=80=A6
> +				ERROR("FIXES_TAG",
> +					"please use the 'Fixes:' tag with the first 12 characters of the S=
HA-1 ID, and the one line summary(no across multiple lines)\n" . $herecurr=
);

* Would you like to take another information better into account?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D6a8b55ed4056ea5559ebe4f6=
a4b247f627870d4c#n177

  =E2=80=9C=E2=80=A6
  You should also be sure to use at least the first twelve characters =E2=
=80=A6
  =E2=80=A6=E2=80=9D

* Is the information questionable also from the parenthesised text
  in the error message from the Perl code?

Regards,
Markus
