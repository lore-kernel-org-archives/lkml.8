Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2699C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACB20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oOYBrlLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgAJKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:01:04 -0500
Received: from mout.web.de ([212.227.15.3]:57235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbgAJKBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578650442;
        bh=i7u0dEdG+1HRoiQBreS19z9Ai2z+JNRMC/5uuUcDg/k=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=oOYBrlLh9LMMfmh8rAlevK4TwSELeJVUORccIP2sFmAUa5RxBfV6INVem4t4fmkCN
         47uCP7r6ILmC/4jJaPcYlUFJNvmMhGuBOmdphWb378q0cEnOv0ZykuqA3kXTy3l4jb
         PDcwMSzTSKa3n8x42sPiGJHIcfGomAZaJTq9/vHk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7blv-1jeGSc3nTb-00xM8x; Fri, 10
 Jan 2020 11:00:42 +0100
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
Date:   Fri, 10 Jan 2020 11:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fSGc6wyCT3FrYyBtnOzeymSNpMPTNYU48InLxdnbDmwKwrglERK
 s4rDmV76Q6ZTiiQhFkXNJ12SY+/NHnFzBGazv4D3DYFDpUuKrY0RoRC5ViBBVtmWfFprAbF
 7VfX22MspQr8I8+JtTlUfE47+oDJHyZQ8SfqzzjTraa1QDoS+pCVibgLGUVHzao9AiFP9C8
 kZ80yY22FEuhp1s9D1baQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HZr2eRRuu0=:RnoWqOfAdgsShgcvEdRNvM
 Ds41z/5wD+zAGJMS5lBDDIq2DnwzIz0KCtoKgmP/68is01ahDZrkPPOkckhwXM1/c1zpEhMmD
 7Z2PuhkASaAqnJ9JTxmG+xJvBaGrNzMD2F0dT0HaMYF7I33hEDLEyYmpVTo89MUDgqrtHYIDH
 kPWej82t0u7hdMuVZ5jKt0eaqPhopmoSxTcnTu0Jpomyiyemr89raEyptLcDSwvLCi6blSUXi
 lr8KryIwFEaIrYYrhYIX3PXkNzdQuKL7cgCqEcyd6PUW3CpAok60V2UQKh5vA3Wq1vMEj3oIQ
 MQvufef22uJOjcf5QfuTDIZhBZv2kb+1SQ07xR01o4vcXvUhDc8uJsoVxGtUdTBXBS6bEPY2e
 ehCnKjOi3NtdeU1rhkCaUROauFooK8fxP9tETAjieLEQdESphZuvLBKeUfKzEmMDCEm9Yq+Gt
 h4Jc1J+U57LI+K//ul56vBOF8I9qUp+2tMOD63KI4w/8xttJgvG3/3IR2NTLm83jyauvt9fcW
 KgGShM4qOEackGtnLV9J4+GfnSqHmb8WP5CF0Oq7792kHm7EdEzD6/tBuZunlmaTWODLnddqu
 ooyg5ZkTwYqoGOhlK8etKP6uxZ5Wuz4tSKdrABeeBgydII0QE6LeqgWEHUn2itRd1NLc02Vb4
 3iX6mfU0SEyBkTWPoUVEWa5t/mI9UZ5nv9oMlZYAOcZpCny70bYiJ/lnqZ5jjlROdse1DSlmk
 oOoNxmqRJbdnopYtlgiLMXjMZPEBRrTWLDJCBNLhkDKbig6EugFvoC+uk7tkp/tYIFs6HX+u2
 vswZQDs35zevUF9YtgsGkFtU6iqTBC9BAh2OMkf10nEwgrlb9ujsWrR7fFrRxvS1ai5UnJM6c
 OyQcx5NeavezPZXieTdlOTiHJYcqr0Y2io/NOgC7XnPp4k4hE7TZIq3ycjtpkLAiVRUXdXLxu
 PvoGgeX876bjt4lH6bIv0eZw9YTvoBUUMuz3eMxTudEvd8Tv16rE++FnkqJDtwm/y953sHsMv
 g3EyL4AwM262P2ei4lsVOiPHrB/FATyyXdjs1fjuQf4JAZwN2LDTkpJ0oGDjzJVx+YlD0wBR6
 grglnKrsJS7HrtX0OSr5MNwiRwYDIuYBQW9l0FWwGpDksdPyP+5KTsfLNkxCYsHoU1ffFYZnf
 PkV8c8ohz4U4MXiQrAn4oo8cicGV6ZvOCF5x8dCx+vPvOqylGWEt/nz6cmAMAqLJX/dox4QwI
 GO+P+4i18gFbCx3i36l4KNh4T3jrbGQtzcBz/kccWonQZCfckYDxu9nHlb/A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@initialize:python@
=E2=80=A6
> +def construct_warnings(str, suggested_fun):

This function will be used only for the operation modes =E2=80=9Corg=E2=80=
=9D and =E2=80=9Creport=E2=80=9D.
Thus I suggest to replace the specification =E2=80=9Cinitialize=E2=80=9D b=
y a corresponding dependency
which is already applied for the SmPL rule =E2=80=9Cr=E2=80=9D.


Can subsequent SmPL disjunctions become more succinct?


The passing of function name variants contains a bit of duplicate Python c=
ode.
Will a feature request like =E2=80=9CSupport for SmPL rule groups=E2=80=9D=
 become more interesting
for the shown use case?
https://github.com/coccinelle/coccinelle/issues/164

Regards,
Markus
