Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1CAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33134206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WL0skkhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDGRLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:11:13 -0400
Received: from mout.web.de ([217.72.192.78]:58005 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgDGRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586279449;
        bh=6Fwx67S7LSpJX9ZpZfC6U+5pKtQcych8l4xHzMwnVv0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WL0skkhXAuy5b7FlXXx2g/8pF3+mAtXaZ3Xmqki/eoAKDL3Pu1qHpxNrPz/ZLzCFj
         fBPG+3Zs8Oa22/ilENsg3BuFl4ATa1dtvjfyCXJ0cp4iY6x08FgvTZ1Ks6kjjeAtb7
         LTyrJEBEqwhrhz10/c+ia1Mp0Hoixi58cBZfsAR0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.5.104]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKa6N-1jLadL3VVX-0023fS; Tue, 07
 Apr 2020 19:10:49 +0200
Subject: Re: Coccinelle: zalloc-simple: Fix patch mode for
 dma_alloc_coherent()
To:     Alex Dewar <alex.dewar@gmx.co.uk>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Allison Randal <allison@lohutok.net>,
        Christoph Hellwig <hch@lst.de>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
 <20200407160330.5m75sfkhrrx3wgrl@lenovo-laptop>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <045a4a1a-c841-2979-c899-b632ca418b3b@web.de>
Date:   Tue, 7 Apr 2020 19:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407160330.5m75sfkhrrx3wgrl@lenovo-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:658ts8KvimtcwF8VX6q9/vLaAaDgPGhLfmlrhuR5p1DJ/49ESZ7
 t7zqagrqHtiNFol+3hQh9gTCZawokRswqnToErN6dizrlCcVY+oc4fO7Mfi2GcHdElEcQ7f
 xSv1NHoINQCLdl7+emL4aYt0rNWIM2tGak9+xrK29tPDtFtOTKavwEJ6b62IhSpkMtzEuL9
 aaKCf58WTzd9TK1CjbjiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RbwNodSnESU=:HxHcmDsIsBUwiJ5jInTsi2
 Hb19qGho3Di2u6lgZ+nhC/DpPk8hm3PRMwx6wucoQmJdUR786JjN6k4NYp8nGnWeEFuO8/8M9
 0/NtAIfRPOacRcaYPinNeapCFm2IM5aAspSY04rOdP1v1Z0spy58zINlNTKGN9ZCt7mAhGQr5
 n8npo+HLvbrKmOorWmAHCA/qjSw2lPd4Tk9UDj25GhdQsu/w/yu49ocMczPdquLJ42FoBGlfE
 ldVs9WE4HG7ZNHD3ZySwCr+uOIr+b+46yTdltP1mFwwOr9C1IhVjlXPm6QS5NxRAaWfLulYop
 6r0Yh5q5RPzr9SAEspsYx47Evlz8jhReEvrOQyCeX5ktAGpJqOPwajdpK4h/AHBisxAMEtTjY
 LG7pNL6ZhVt1r8PeyvGgqPxx+EqQiY6TEKMkKT6/kqBUVJiKCzA52X/AbfW4sjoVgWbDFkP7J
 LOz1gXwLxLdx8lwcuZ+EsTwh5N2nISR32hfnoByZam2RugQDGWJenvnCw6A5DivOiFEAj3mnG
 NkrpUq3JEgJjfy+iZr2b/uPv45u6SaEU2YIsJQDiJsJyQGVd0pvX0QXrWZ3qgQJZgz8qNjAtS
 5WY5wbfAgZ/QtoBmeYBz/3dFBKXXuhNt2NSPBuTCV8MJI8qAHdYxey0Umgcs5xPn/oLiR9szF
 oo9+J15J3a0zhLVlVPPmuV4vQ7V9L4hzpbF2Vf1foknpN2RrfnOjS6MQN9esXUTQo/Ux7ohz8
 X3j19ymhYaehbgPHZxnV46ZmV3Eq9d5oUtlqXAuHLcAUOsJ/JL/xUOR3+EFUKQGg1xotLsI8j
 3iAn23VVsYRQW6vu412a3s6tcfHfMYOYp/VTDcE8OC5IZP3YrsEx5NLmxF8+15mfJHn231E06
 zmaIJrooxZWeyf8W7NlTH2PB867nrkjimvDdPSK40WMPWa1uUi2tr3nvTEhDy/yvQbKHjmqua
 HMIFucJqkuhPV7lkMmpLrOpTHH4WeQuFKzk+so4vX5SSfLl/z5sl3rGhiZZG4mcCc/goTMTNm
 8Q0hkXKlU/p/V+kmzrn8yiQZ6cGVq+DFAjiw4mZ3r5Oz5m7ggQzDYTn4Zou8PAS/FghdIM9RE
 pb6ZDm/ilC987fZyCICXuJpsXPW0Dc+cPeGsdmb37BwnFi81S627BepvvFkU3Oi6wbuFE52SF
 qsED5ml6XaLiGBnYkHEFAY+Sqz6ohFUuOdshXr32BRmpJte/gIRa1InoquY5zRAI9zlcoRddG
 bcWzaEz+WZ6ueTiyk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Will the software development attention grow in a way so that further
>> implementation details can be adjusted also for the mentioned SmPL scri=
pt?
>
> I'm not sure I understand what you mean. Would you mind clarifying?

You would like to a change a file for which some software development
discussions happened a while ago.
Do you get any further ideas from available information in message archive=
s?

Julia Lawall (and me) pointed special development concerns out.

Example:
Code duplications in SmPL disjunctions
https://lore.kernel.org/cocci/alpine.DEB.2.21.2004062115000.10239@hadrien/
https://systeme.lip6.fr/pipermail/cocci/2020-April/007099.html

Regards,
Markus
