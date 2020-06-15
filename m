Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0866FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iuH9H/eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgFOMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:25:33 -0400
Received: from mout.web.de ([217.72.192.78]:40593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592223922;
        bh=SLW0K5XcsPn+JHgObFUtlXKUjuYrOty55OQmV6+9D5Q=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=iuH9H/eha4NUEPipKimZYJffJnmsaxACAOX7waSYRXeF4IQkw0Otm2KeANW03HBJO
         O4xdDiAwaG+QB+FQWBIviMbCR3W5qKMm7GkgLN8Eyx3x+M3N1i/d4nsS4X9ZUdiSMR
         E7f4XMWFNcv0VpJfMaFj6c9zV/y2aK9FZvh19Dxw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1j73Z24AJF-00mpMI; Mon, 15
 Jun 2020 14:25:22 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <180ac25d-d4de-41c3-3159-835e10cfc809@web.de>
Date:   Mon, 15 Jun 2020 14:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/BotToIf8alCFZpo2hh7sAs8CshL3zewrYhKP1h9i3Odtnohtdx
 L9TFmGNueB0Aim3B2aAJObBT1Rvic6mCoZ4ItL4ixyi09x7nNGorf3fenUnlQMMyXQGrm+P
 TBYSDzaXQlIc67ao5L1j3oG1Oe21FF5x/UrwRqbvuUbKJM6YhvuKpoQ8+STFey64bpKxqZ/
 uc6ec6qMbg9aNsX9sNwUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1V8/DnCbQQ0=:6bkKfe3Y4d1bQvDnkIxZZ4
 6b1BHheK/6V6K2ZEn+YgdwztQIR01j94uuZBT54xIu0sK4tBI1XxMfKL5cBsAHs2FsYfqd/S5
 gR6GVjvFPvr0EEgodhZS/w36IvWmhBRdaJB2NGUEx72N1L5/fUYoX4+fEOUUWq78ezfj3pM23
 pM06ipHmu40EL3ezKnd3zc+F/kxInleF9fUa45098yBCq7LXf8N80N7Qftm54Us51laMWa1id
 cKE7biQEH12MdBQDLzQW8UW6ZWVI+m5oTsaPfye626gCDQEjM5x541u6CM7+oTA61B4spir6r
 ArwvzgFofRomJjY56MnKGCLWKggIs9iWh52byBqfuFb0RWdLAhuxL5kG0OWvN7PGxyGlMbcmP
 GYo0NsKlg4BNAfHy3SJknmq4lgQ53vgi9VB1wpEzz6guMUnQz1xHB4cqKhOwpg13DmS1oTieV
 /NPC1c1hmEc0TAWCJdX811nLuB8LJ8P32J+rf+RxeBhbimmZ6ubzcYkZ04Iznj/zEsvLWOZ0r
 +H1tpOCLOL45DrmmsifE30/pMPJYxuqMyQY/yLDJdu26At0Gy3h/ycoD3EZhUaDJxSaxT2KmS
 uI/Jy8uMYGQNtgv9XoQUXeh+9Ua4D2PzAmZXsW73Yq9iRESLx6nhN4MLCuvHvzzhC9kSHgjkP
 /129p5Lc4whkbFgmwyjKnEm9mGx6/Cwy58cLF65p3XB+uQAoWm272TGtsQeWS/EHQZu5cY+H4
 gm0VIVjhvsQdmQmUqyItqNFhTLEuXa6Odvo3ohPk03E3oJdYontRMY8DQHA1uRQeprxa1Qq2T
 BPWOuu1SnD0yWT2chQ5xPafl0/QfdbHkrjT45Mq0TPohrir1T1vYSPQyeZAvbs5UjjgBk+kbg
 pvHfC3M+akU/Q6/IGjeS+hDuabILlbwbUN3kTFz8BZLHXrNVLZ0+pIYl9gRo6mihTN/jD7MnP
 27W+vM9uzyj16yqAzMRKweh/E8rcZO2dmqSNwXFuT8P2AxFIR9pGTbmE3jJz44Q1OMLCEeL+M
 4V9A5QA8QOsn1nM/mlGooBkYvOSkZWRYSjyIrdebmUBf6oQRk0c9aq1KxnsCie2CRgDGaFJml
 +VsA4cHcOJZKph+gE4/MEPThxbl8uqP0qm/fnful5kKu0Hkk4/He2pYIBQvogrwaF5y4KfVPE
 JnRxIH3hH+UNSCeEgMR55DiSk6nF58ewZQvkBePgjAijnWCnbKWAOGaAz3wV8SVL09sZQ3HSr
 2NN1UHvK36SNYpNDZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest to avoid a typo in the previous patch subject.


=E2=80=A6
> +virtual context
> +virtual report
> +virtual org

+virtual context, report, org

Is such a SmPL code variant more succinct?


=E2=80=A6
> +@as_next@
> +expression subE1 <=3D as.E1;
> +expression as.E1;
=E2=80=A6

I propose to reduce the repetition of this SmPL key word.


=E2=80=A6
> +  ... when !=3D \(E1\|E2\|subE1\|subE2\)=3DE3
> +      when !=3D \(E1\|E2\|subE1\|subE2\)+=3DE3
=E2=80=A6

Can it make sense to express a constraint for a metavariable of
the type =E2=80=9Cassignment operator=E2=80=9D?


> +      when !=3D \(&E1\|&E2\|&subE1\|&subE2\)

How do you think about to use the following code exclusion specification?

+      when !=3D & \(E1 \| E2 \| subE1 \| subE2\)


=E2=80=A6
> +msg =3D "WARNING: same struct_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)

I suggest once more to pass the desired message object directly as a funct=
ion argument
(without using an extra Python variable).

Regards,
Markus
