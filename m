Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B562C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E31207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="prRp4Wf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFAJTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:19:10 -0400
Received: from mout.web.de ([212.227.15.4]:49081 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFAJTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591003129;
        bh=W+ZgEtIxGb6XZJ441yxdASxhL4NeqT35LP0D+pot0Ws=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=prRp4Wf1bRY+KDL/S4kuiB5RurEEcKvIXGJUCrYoTM7j/HcLROrCwOo19aIL4GbOB
         888XvLu/H8y3b5iiHzv7TJcLkD65C92lK4jUYOWbCbFa+FYQBtqnMiRF7n8UOHwdmi
         /QzP+1kTDX0UYDpNALl24Yae2M61ooaMlRS5y8KM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1jNjfa2Djz-00Ja9d; Mon, 01
 Jun 2020 11:18:49 +0200
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] misc: atmel-ssc: lock with mutex instead of spinlock
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <eb9b1cb3-5b3f-f387-da45-71427a4383ed@web.de>
Date:   Mon, 1 Jun 2020 11:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5DulBwr2jsMUSpEppPIKQx0o5MyiFakHWWiD7IiokDqY3QZuxT7
 Q5VbrdfeGgnRFETSTWDfoFV7iCwBwyoxM2LxDt6DXZvTtsQQTUP90bgb9sg6nTDEnFW+Ut4
 FPBtGyRUuQFTrIA7F/GBhzct8hkTd2fEeq3gilncfO5LtFrGbFnYS5bIalfbefTjDLJOer/
 a9AoZyH1s8def9QGeqAkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uTzdNDcQuZY=:oo1RjsekvhzHSQP1rGdl9v
 ftzOBbPbTZb3npwTF7x/lLDAU7PBch5gKLs4tyi/1qP3HtyRTBkiWH1DoHEEHuEcdKOXvZL8C
 rEMko7MvWyA44wrQtFzHnDPPVcwBc+1xgxkNwgvLt5pUdsWxG6nRutsXpZuBxo/W0APNj6rG+
 d7K4W71vQ/Q8z+jIpPrkQpWiKhgACbcNaJ4eeet09yQns6vqBs0hLBNWYUSe38IG5YnzLL9eS
 65vZibMe6Ieg76H31ps3xnujwOJCjMgmxeJzLUS8DDXAZJaf7ADI8hL7Cw2c731EDf2z+5Hum
 n9PZqH54lXhMeNM70UuVOdI25lf/A/7AU+SsE7qWtkRLnc37rjN8E+XH8eap/PDNlkCZ8GI+E
 Dhzqb/z0G7RJcvPnw4hujIwXpgInhGkM+oskFesuc+DXRoO53Au7F4uvAyE19u92tjel8QkLa
 +xqkY1KIUchxWyaa0nbLu/2FSZ5b1YIXTmjriEelr7AQpFkuR6NUve/tMsaPKml0vMDgPvt+7
 f+x0//HJ2y8GPwPFSsBFUXNlKfv03nqZR3Ox6ReTJXbjtGKqA9Rr0l90360qVwC4jTnr6QDA/
 P7DmMYcZGfkPWzxP8UU3Wvvc4gWoMXDCAdVqoewnaiJDc8sGMo9UySdhkbjtjlh3MLedFhEAq
 hRpkoE2xi7qbYXG2mp8gmF1DqCgK5tZxkMEIy0pJUYQSBELybygdMoYEog5C3esWHkMxXErm2
 ho4RKDmCIiCUntRJ/61ZupZMOCsQCwgNvddD49J1V7Xd2uHlhfL/03/dNjQJENe9f0MRr4pNr
 7AVdur7pg2dqFFu+Jyshu2k8LvaxtOEceY63dVuWq/ljCKOwyyOTiY5D0LiaFu7P3yUdktO3m
 jLdU996cKsejDbrcNSLM7UdEDHNnTTr4ZnyD7eR9Q/tw4tjgds8QGpPGSYoXx1iayjoBFqGg/
 75ztmkgZnuziQ7KX0XXoVplxEJBQMXQVte4vTpUZdi1NN2vTfZdAThJXzNkBG3eZVoJbe0nPh
 AXUNWPbkdRLYz0dz6SP6IEBJyiDgkysNSKRlSP7HD/a6V7EnV3PQHX73gUTyUtEHgpzG7XVBg
 Clbn+QG84oz674fCkaH2H3IfuXB8yJsjEzIJNPCY/pNC35pAhteoQmrdWEdCKRj6k6IFqf62t
 MimGVS6PodqlbmX0eD5E53YrseSk/8R9oEEElW3Q7amvgei2kuV/7CRrqh2mK91UdvGtqsIjT
 +VIW1Oiiy/Gdjo05+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Uninterruptible context is not needed in the driver and causes lockdep
> warning because of mutex taken in of_alias_get_id().

Was a spin lock taken?


> Convert the lock to mutex to avoid the issue.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
