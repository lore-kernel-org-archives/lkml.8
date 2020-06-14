Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5260E2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MFGTTGLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFNPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:10:25 -0400
Received: from mout.web.de ([212.227.17.11]:53899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNPKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 11:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592147420;
        bh=8/bdhGS5m40MezAEDzIroGBeOdzcIP7PPWNCyst6OuQ=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=MFGTTGLhO+v6UYHXvqr5jyv6IrcfbOHXXTIl5V5wZ7IlJylW8TEvGvG+SpSK37HRP
         PLOB+XZds+EbgjZQ4OFZLWLsm1N60P52AKapU5FtM6W1PfTIgzkI50LfsiwK+kmqb8
         NYINN6uFTt8dk16yzyYfF9/uQDlwWoWF2koixwTc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1io4CZ1n9D-0160PI; Sun, 14
 Jun 2020 17:10:20 +0200
Cc:     linux-kernel@vger.kernel.org
Subject: Re: coccinelle: api: add kvfree script
To:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c1735c1d-62d1-6c87-17f6-81baa2169604@web.de>
Date:   Sun, 14 Jun 2020 17:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:viyfeNnSA4J+Zv3VXongIjyEK0xhwSciPNn58YJEz3+a6Q5u2Tb
 cdz8B2hA9LBHJ3FBKZUtGsle5hdkmAWo0Q7zcPnhCKXPsmlRQSR7VWxse57g8Xe+djyV6c/
 6SvAyIrgKz/6QtEKc7ug73DC4DzYMCCibc7gvKFwJLnyAqfBKqbKYr97VvC8KoVczd2MgHi
 sau73KUBKnR1My8xrD/sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKtrgjm+SVM=:hf02F61qu2q/zojZvK3PVg
 pHz8yOSm2QABz1UzenfCACxzV7b2CZxWjBEvODGjzFXmy+g6SmU7BbRMdODPN+cKNAVv+H7Cu
 lMqf7fXMldFG9R7qu0NMJxg4P8aXz7P2S/z6bcTVcovpj5TCm/YY1AsiOVvUXpFw3BP2zcaH0
 hsWTxrI3rLzUv2PHFqqHBN3QC/ulmD+5KvWwZeCs75HK3hGDBAjFCVbJgCGiD5vIBAMVluG/1
 w0di0QfcXDwoA1jehwn4x3vNUQVj/KD+HiaBcpp80S/Ugn4EqdN0bEhnE0D84NFyEpHnDPwXw
 7C0tmuaHYWNs4KG9l5+lQP6qWqSkfS7m7blHhbkqHKMKULh9UswKJrizRhyy+x+Mnvc1ks2gk
 iF2jPCu0dA5yT0TwxdWcCO6Ql8EN5gVofBwO4dMGFAEz/COdS4CADiMEWeRwUvzyDg5osj/vX
 Bl5y/J+ooTg8H0SFNWNJhmB8PX84RC+Jtp5sP59Iv4YkjVeq0+DCm9BWyqN8hbYlW00v4DZ7K
 tSdOvJ/95WJbuHYDpaaErJs5Vbed3DTPdJM8eqnhToXejqWM7lZv3TDzpuCRugxWg7g7ap3dO
 2uDQvHLVVlV21/HHtcGUSVBErrHxSOizlm+UJ5Ql1XiR695xd0Xw350viqXji9Jb3n+Ocxptm
 FK6ToNfZhOjUcYkRE0EJjYjU1Q/dk0sjev49tbjuywtrHW15kmbGOTLOtd99V8a1VOuoy/vAq
 cpOrYDDsr5+6BMZ3vFlmnWnpeoOChHaHMfeGMsK93zVJ+Q0AZzzz6CVtSNGK1J+AhKc7Y7O6T
 /t2aefLmhbvqQ5zbDwdccHY7WaIuvO46+15oiBVZ9JID0hx4dkxp4Kn6OTj+QQpDOAk5cew2u
 HwNyv94hIeabAMTRbkpvDbfBXdr6oqM3PjiuyG+/ac3iCndbVgWi6BurSM5Q+e8ntD5wz0vEI
 MKftIN/HXlpbvcvsL1LyaEXbHW+6wLWPZr069MXdO4KWfpznOJluIrLxvN2Xq2ff5z6Zkfdev
 r4ZmGw6/fPCOddXVXR0YC2oDXMw7BLq0IE87QQ/VveeFaprJkRSn7t7FABfaoXPLNj3yetTNF
 panla5/1cseWYMj8EUzAdBIQUj9qaXrNmKiNoL8sWOCkwzIuyiI1JgQH2/OsWe3fTqzizntDL
 a1nV+KIQIPEjSrqLs8wp3cKbfbd4JVt+q+HtQ4KgKIHiGbaFwGsFaAVUXbN7ldxrT11TGrTmx
 FNn+AuQfxNG5JgBdY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 Looks like it's impossible to break "when" lines.

Thus I became also curious on clarification for further software
development possibilities around the safer application of code exclusion
specifications by the means of the semantic patch language.

Regards,
Markus
