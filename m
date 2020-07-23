Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CCFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F2C20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GCiP8nPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGWHBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:01:15 -0400
Received: from mout.web.de ([212.227.17.12]:58207 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWHBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595487615;
        bh=SEZu+RKkvegh1bJ8JdN6Ljf8aasts3Z8zOczGqU9xnE=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=GCiP8nPnv2lYRvupnZ/VjXAcQKvQQLL40vc49US4zI4cZXSEnm3OU/YB57+jRqOu6
         Yl1jLPrvnbriXqhfDlKMUGNaFi6Pazk8ceRcOcy0vA9nr11KAn3gAMEkwJk2Y7S24/
         Q8c4QAxMziqdsOdfSQQxV1gVV3xm0kyVgd6zveXo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.132.31]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMEzJ-1jsiJO0lUT-0083el; Thu, 23
 Jul 2020 09:00:15 +0200
To:     Yi Wang <wang.yi59@zte.com.cn>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
Subject: Re: [PATCH] ARM: milbeaut: Add missing of_node_put()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d6df080c-f2cc-0e9a-7a7d-fb977323f92b@web.de>
Date:   Thu, 23 Jul 2020 09:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KAkjeZWsM/nBz7tSDNWmqvBO1BCt0Oi2Q2nXS4jhOCD5yuqffw3
 ktJnL3hxa3s/InvFvdThh+n/YMd807MTs418oLt6FykXlUrwuKRCxKio9gx5tI7VJvCbVB1
 EZJ94DPW7QQ7XPnB8Gm4eCeJA4wpPwL7qSiiwk2xOCXnf0D0H6c+ccdCW1YIabNzeoz7iM0
 cKyFkUmPjzfLCauM/MVsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:itgiWomf+8A=:A9BBd5Pf0k41z5VOo4KMWq
 1Odx85G7xELdkP0dMy9wsSXnSc4M+fVNN8C+/zAifDXYuzUTF/oEcbmpdNemX9d0lA/SKRFa7
 SfwIzP2YHdExqgQFd8Rhc2amlfLpodjkYKuScP/rkJ044x6U8MneNRuO0gYFf40jf0+XuveOc
 2heM//eFDoCJOMbcGPYLfVdOD+2mw7QyeeOQdPEmWKm7Ol1rKsIif7c/EcwWH2Zh5xpxV+y8l
 gliuqVj5qUaWQNJaQvL93k2MRTRN5fzSrBOigMyDK/yAmwRrGpk5JhjCrxssDcJw+iaysyWG4
 pQDF3oOv8cksHno4ZEsJ0wzmMRE/o5fCSSI4gJN73QFUyphs7eshaHpvyt/PbIbcYAsZ7OD1D
 2lB1ixjFcAybYxmd7wKSAMZutpUY3dCd/zcnEn4NV8+T9l4Bms9Gjm+xz2nbxk6+SdzMOGV1r
 Xma7ClI9osG/hze5plLTWq+PuQXHw8oOFq/GxssUO9d9Do5A215dVx9CK8CGSlSnlBOaDOSw2
 Fv7yz8AI4EhdXnYUtab4l/blNoO0FPB8kjUo/347MDOuUuFu7liTSvOU/ATHgboMCRk0cwJ6V
 9n+O1C4Gn6zIs4zaozvKhBnPJMa7aKC0lMJC9nvWGWvauns9FJG6BCvvM3Y4W3HRyQfwusY7X
 y3oauE8/SQNv+l6F//ufDJ1gBmbkXUP36YlCqbS1UHAcwWVt1ZYikrDGI8bajRGdbxDXy6Vx0
 5T9jqHJvqx/TRjZ4gmBATIoup6Zw9Nz/wnBBi76z9p+dEQxev+PpebPD/RbtT4o6Le2Rktgjy
 D6gtmG7dtARjsxBDuuGVRY3U5wtULZ+2IlKXyYhA8GnFqSNHi1WmgZpi2Q53rdMetq/fdp70c
 gxJFNammOpcPzAvjF312Z6/eFqEIbw1Wxw3+m1Ijy3zqiKWIFJSigyDLlbFBCCTHdYv9ON16t
 KkI9tk14yqRwkVLvVuTE5q7q9HXxGKwJcgEeEha7U4cLm22MB89HYBKCHWddEP/RTl/floOp3
 4iq8MOZR1mvePircoIF09ZNfnxf2DBNAI8oda0/hcUVXcRvOlw4cA7687ey1yAgEfBWo4PjXF
 dpOxdymZwBAAROfoGUAepOYPMHwhgpsrq2AnI5WPCBDRQeoE9ywTqWWvOXMT1nkB4khsf9MOe
 ppy5bZgPaEKIJquIb30+XbKh8gPLsXQG3ZrKeuozXtk+vgChd8utDR0NVa3x34hoYbD1eYboJ
 X8CUdOZ7Qia4Ir4hbHHe2L1qCnLCCzftymInr/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.

* An imperative wording can be preferred for the change description,
  can't it?

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit messa=
ge?

Regards,
Markus
