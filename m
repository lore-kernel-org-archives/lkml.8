Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9760D207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dTpyKn3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgGVGJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:09:57 -0400
Received: from mout.web.de ([212.227.17.11]:43233 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVGJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595398179;
        bh=se+nqzDtn8pUiCYMScXYBHNGJoeSJRKWNOzOXalTpQY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dTpyKn3AX9+9fehtrRn3/qQCTNkk52gW6YxSVENxq29c7Kl5yarXuYkRhK9CHkvmK
         etcHADHdyvcrGaO4I+EplzaqK0VjoJQot7so5Qh3yTCTnsHn9fMnFkxeX1mj43feex
         tha1r6RY9+h8zpq54uS135z1EyDAg3872nCI9wXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.161]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoHTx-1kUgkU20Zl-00gHTg; Wed, 22
 Jul 2020 08:09:39 +0200
Subject: Re: [v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
 <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
 <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de>
 <alpine.DEB.2.22.394.2007220801590.2918@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <07a06754-94dd-60b1-1ad1-9e602c86b1f8@web.de>
Date:   Wed, 22 Jul 2020 08:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007220801590.2918@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:AkJyGSSy8f7k0ACFmZZ+laOPQMpPH7SCUzpPj4NN7LYdpGthsrn
 xd2bl9v/yWBaPb2tsyDxsIYOMh+7RdAoHAYdhfy5so2PCWjeicbsAs10oFn3yJFhIeuDk+J
 glW5JVwvMH9cAp0lPAgssrYumCX+poDrHrR27RunBdw1bR4V2hfxnXXEQRscLd9G2sfxvFl
 rVKzbCmdZZTDgAUZmKz2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X97opvYO4rU=:LWyXmsRmrj+wXY217gg31n
 +8Ct07xIHOHIdcuyh2mNEQX3sf88jvJGZicCfqqn65RzyLEWS3+/toaYtPmdWnnTsgJ2TRJnz
 2eTWgcRH62TtGnA3BeLOaym9mA5WhDwQDtZKJlpHsCOvjlQFgpG94Di2RDeQfjwNwrX2LSPgL
 Q8lt2pO4tenyZX+3DNTKE8GUuw2csp66e43jDFDYkjpuGw1rfF6ax3PnNq39eivqBO3rpksPH
 A9OWpw+zNbQB6UnLwJK5oyst6Dp8ci+sk/2DGaWVNRVmhWN6jcQOI8yOl1oe3MhpiOapQbmJ0
 ZW6mS/RQaWqPTk01Rg20ntS8LrGulbiYjGPqxBN0Zl/vqqmVP1cyNu1qGEv6tP0zT0T2Uy/JM
 1YxomnPSvAjQE39xqFJPoAoTMh4bOIxiMX3w59rm4XkYAN54lYaEO0j9pthIXhbWs/YLAkYu1
 MnwIvJaUPvNSePjW12P5b5BIJp8lsMS3COjZX7Mv5lLmx/7k5Q4XDyMhpUBEuZJ1j7GlpPuUz
 Kw29WMGszLRhp2j+RhP9Tb8uNG1DKa1rLaUrSTaCWghCJBwJ5MVoC5z3kVAZr2vCprBhUMENe
 PeIqAKXkUjn2GpLaP9XlWUA4nm9RTLhb82mA2qI8ysUpd+BKEiqFtpGhPrt8x64YO7DOCL9o/
 Nab01Fjqs5TXgCAYcEJZJZ+COGEqwiQD/Z0tXHSzRMjbLTYGyOFUguAZNacud1N5H1HEDNTJY
 F7pzzAsQl4XachB/E8pB1pbvgLlfrdaJkZWYKJuqbwPuXcS2/LYnXRU8fFEiJrGvMzm1oFyvE
 J1rfxUZkrqWmX0aLwj/mQQy+6rsvUTpUbGyyum0kZ8C2UdokpfriqwD2bQY+VSGvf+XB7RHJE
 c+wqi4ps8NNbzaOJXv4rStMfIANMK/qw2mjty20peRbXQF+o+j0+v15ApaqTg38qvieShmlRB
 vbodszYMXoBNqjZhkmKDXwKbRYt4zopmkbh7GmTUCZKnztvJs6QL9sbHXE/kvmXHpYtfoqhAi
 1aCPlKgEtt9jtibVyRRqntdC+udpifIVAdmzjyUNLvWck3lSVrx3RLm7ia5kRKfEW/SrtZvVs
 ezJhUo1PgPxKn/FTDTzJu42qvngiLe/0Aeus16tZxg9FUL67ervkYAGZdHgoBuGjsqyCDiDeC
 NRf4OOOtxEdAOfaw7Uu119cuojT0pCR+E+8HwhIue8/Oa5ztR9SfQ/vgbXaJDRP5p94+xMUyk
 zZ5rwMcH/ERC9xw+HiYBXeVgzg9e+Zwq4mPSP0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Markus, you are welcome to try this since you are concerned about it.

I dare to point software design variations for some reasons.


> But it doesn't matter.

Under which circumstances would you begin to care more for involved differences
in corresponding run time characteristics?

Regards,
Markus
