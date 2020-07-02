Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D771E2089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Hhjnybzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGBIXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:23:25 -0400
Received: from mout.web.de ([212.227.15.4]:46825 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgGBIXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593678148;
        bh=r50khE4f8sNvlXWIvRv2gpF4lDQ2DJgm5qYt9RNo5BA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=HhjnybzjP2ZwI6CK8BVSRo8XS/Zrz5h9d8dgROS1MZP9mUkCuhM4JroZpQz28b/6w
         PY9IdEnm3Efz0zJvcR0ciHWXvR310+cz0KqJSDJ8TrKxL9be3rsrkObAZ8ZrOxAw2V
         nSY1Txa6xrd5jyQslm1u/AOJQjrmg7BakL6Ut+iI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M24vT-1iy72t2hD9-00u21X; Thu, 02
 Jul 2020 10:22:28 +0200
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Julia Lawall <julia.lawall@inria.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
 <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
 <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
 <5e83b473-8764-fbfc-394c-1acffa74943c@web.de>
 <alpine.DEB.2.22.394.2007012232510.2540@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>
Message-ID: <0b4bdb33-2b67-bc08-cfc1-0cd82c8551d0@web.de>
Date:   Thu, 2 Jul 2020 10:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007012232510.2540@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9yvsi1GEbaoTzPF2KcVG7QWBwCdu+yQyAfxOuTUMqMROIVS7DPl
 oSXq6Waw8yw8sbwdbv3ohNMCh3W+nv7qhvHo2ug4C/lmem4HZT1/Vf27MxOPKykTMBiprUl
 Z1XFhFEEsKWg+T4XH2Z/rjzJc3od+TeVYiXMLXCu8L08kZBR4vitM+NbYdpMhIhs2yCKgZL
 WOgiQNUtUswZ+83/msunQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VBNkLLNT1Fw=:i/f1Oa5UZovOwvZ/B0crOg
 zSvTxVOn1XQUqWSaLBcthT7JUyrAqldZ9TU/ruO7srPBrhogN+9rbHNolfZOxOq5oZu57CIwU
 JPFFSO/6HSQKqsjq3Vb+KbTLr9cTqjm1+hCvINH4dx8GaGjYNE9vVODhqS9bYSV4tJYdEWEbL
 XW2FUaFS54lFzSjI02nnUnQHPHsAvVLNDKlPa6lNY37C/TO2hxZZ2jwW+FvZS/i95HxmZ7bWJ
 waNLNkvx2Ke4Rx/RTrAs4ipO+x2uVyACeziRMfr2sSH8tLPvAzWq0AGZwQY4F3xuEh/k21O1C
 fes/URR2HBLzC1ynaCYDqVvaxUXcS2Obsms6+hubaGERCuaIKtz7iDINDQ+EuoepbuFaw/9zn
 3d4ltOnFa+YcohK+vuhTfvkxkR3WHawo5KocDcr6KSBXs59UdKqsMiG7fSFpQQ7EY3Is8GRCc
 BDKEgR2g9OfxmVcfmBeKtQlD3D6edleSlhUxXjYgoVnrvuY6dsreLMPlOnDI2DPYVOu0tD2xT
 wk4uzeKLfiCk8sOoPdOth7EiprHZnuVJyHfRzWOQCVy2Ys9BFj9tU8NucBYbjwrh/c+fZVJA4
 lMf8tVpcB54ywZJUejKZr+XHbLg1lf5j8oFhxMzWB3QPdmdb37uQzfn6SB55ep1uWvMbRTcUh
 eY1Bvs4nl64SrY3zXYLq9bQ3z+t6RulwK6Mafn4Liglx5lzPXoBAeZdv2czZEMUSmSRJdiHk+
 4siYmdM5pAJjChU5s2FYwjNQmJoErEejicrrejPtAxa7r6JrYj1W35A7vteddTaRHzq5l+KL8
 R6HIaOwhwAl6+XIvod+LRv5Yik7FbKCFcSaVWbuELcWFYO7XTQfRxF5d1Pxgrw8n9k6WkBiDv
 paCyETvl6P2T+4DHdifxwBw8XD9TeYY+yZoov5upfBR2fWIFJuyvztRI9K/pnQJ2QjitQQasl
 /B3FK+EtYv+Pvpb8VGUA6D+w6aYb2K+JdJ+QJk889SUSbyn2JwhpEEI1D/WX81Byapd6MEG+X
 Z/GGWYDppyBuH0nCEKkYpxV90OioYbxtx6U9P6bYHg1d76F6d3amU2V8o/qQcRT/pLiMUh93H
 ps/oi2GGyO4mSaB9c6X4c8EDbYD2EiHORO0TAHjf3aHZOMoMdLaa+s5i0mYhjtwUqKyTbESNy
 Xz2wqxbO99sa3Foz4n5Lm2ELn5+xvYWad51oFnj/5fVZHlTTaOCAgRzqSTPjjNyQ3+OEFUcuq
 DtpTKpncQlZYJyImPWik80tTUQCu3xR4tjZxD3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   elfring@Sonne:~/Projekte/Linux/next-patched> make J=3D1 C=3D1 CHECK=
=3D'scripts/coccicheck' MODE=3Dcontext COCCI=3D~/Projekte/Linux/next-patch=
ed/scripts/coccinelle/null/show_pointer_usage_before_null_check-20200701.c=
occi drivers/usb/mtu3/mtu3_gadget.o
>
> This is not what is intended.  What is intended has never worked.  The
> coccicheck script expects that the file name is received on its command
> line, and that is not the case.

I suggest to take another look at information from the verbose execution v=
ariant
for such a command example.

* Do the generated program calls look more appropriate then?

* Are you still missing any relevant data (or corresponding descriptions)?

Regards,
Markus
