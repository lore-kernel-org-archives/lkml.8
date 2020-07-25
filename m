Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99651C43469
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ED3206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TBk4PtVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGYMDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:03:32 -0400
Received: from mout.web.de ([212.227.15.4]:58313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgGYMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595678590;
        bh=wQxlQ/SmWc9RFw9VETtG31ULmFDa4lN0pVNKkYynVio=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=TBk4PtVNQdVi0YZCzb9HczeZv7DaB6e0IZlB7mrXiZZ27rowK8J78Q0BVgb9eZLJm
         Fo1zYvGI696zcI3y7zJiO3z8rzY1CQbym/7ouF6/yWp17A+NDBZZaedMQ1GkKCXEEb
         CALAfTIHn674hDxhR+HLzJAde1LQatSjfok6dQu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.94.55]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8zRF-1k56Aq3Bnx-00CTsG; Sat, 25
 Jul 2020 14:03:09 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
Subject: Re: [PATCH v2] ARM: milbeaut: Add missing of_node_put() call in
 m10v_smp_init()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Yi Wang <wang.yi59@zte.com.cn>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <e0092582-6fb6-e374-e130-232002c908e7@web.de>
Date:   Sat, 25 Jul 2020 14:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mZISB2jQ0F97zteapPrujC6qzBqE+bj/c5RiJHOJntYQ3Dqx0C1
 /0L/aLzfTueRVAF3zTff+0BVtrC8W9tvtdL+R2p5y0gdfrDDjjK6MhAJGVP7C2zTt9aZ00v
 l9MUC45P2rgF13mJcRnc1VpLpi5GoFeZqWWPWmCfAlZDGshUfHJ/QOOYxG8vxUbk92gCIij
 7zcpANuqiHm9dK2kzyd+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dksXAoVsbKA=:4e925Q/IQIE62cSaBgkGOs
 omtsQ/p3TFgyViId+wmpTQ7l5p3Phnzjxj3oCzlwbuJQ4pYPwYfgJ7wpf8axdm2fiKqwatxR8
 CQePo0XoTw9fWDFwS0t6vQypDzZeBg1f0J3lefDlFWXpDagzYq0V8iXKkSl3HnXuxDnnxGNWt
 7Gd1irKpZzX6TTnkzNp4NEcTYNs8CH/M21ojFodqOGMdUgEiTvgyfkTFIFMUCbS65gGZp8m/Q
 MCBUbAvQN7dmRRYcCsIW5af+K99jCSXZhIJveIn298Y+WDyqr8EWLNKXI/Si0VNQ6hRhYCbrS
 Vk+WlDwU/IlKEQuwqqg1pziihg9BYWfLwvK08Kq7n4jSu4bKJDqxZb+WC+15qxzPTLN0nSN8f
 /ye1y4rMMhNSZBupTk8xJG17f3Dgr99MCoGwPXTWI+xA/2e3zvQyZ03Z7F/G6LXnPytJH1CWh
 VgRg68m4liMQg9H2oSOzS1hDLxeekhc4/GqOOcjX7V1gAqPAHZEOj6sGGYYedyWk76a7uEppI
 ZfXLPHNwxud0eillXCswy9XxT+XmIyJtN/KRH5BBDZio8ZDUjhZW43psbRIE/D8PSoB5FpPKs
 IBEdt6cKq8NWE03Uo0jCZ+HjFzQtwwCHhthItfCbgj+Rrur+Omo25Kwgp+vlslpCldT39/Aua
 Eq078JheN9jGrv4mKvns9tjAxpZ96BaWTCktCn/4GVNxKzGKo+4lVdwStfgQSwjnr+2r/QAXx
 Y5Xm4bbdZlFvG1AU+14FSGJzipg4y0YsO4m1OHdCuREw3LcPNKoscadFGeHThNsYA30TSpt+U
 /HIEVfMF14WpVCbKs8yjBeyXOHEXLwCgCpwbTQ0icxHqUNILAdpPaWjgXzKSb97EeafBg+si6
 qOQ3TQOg/a2RNtwWpM8489vxt1RI53IXKCIoY13RYIq8Lvcxz1TEK/NiKacgqiG6nJ4oekIUe
 n7iERrFSr6redBmVzPIQu2hsFL87KIDUhwGsekSOW0/w6h014LIZnloHLHR969+YOwviES7D2
 GAWCy4loK4eiy7m8exzB2JzVXilBkW9NXpWNxSHOlf0OIbxAFh0YT23Bvj77DiKBwBXD9q9+g
 vufnBnp0mh31K+eu4bz4e3cq/74ijdiuxA08aB/6fE1y0JnHSVrNc/5smSmR86XMKNtwyS3Rj
 CVbPvjDYh+ZgdEcAHwzffSjpzDk5ZD0ylavj0x9re31kxjjlCb+DzRUqhfzAS93HnmDRmrKNj
 5skFgNxiRMRD/04GYEkeugy+AaACgHljQiSe5gw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The variable np in function m10v_smp_init takes the return value
> of of_find_compatible_node, which gets a node but does not put it.

Such information is useful.


> If this node is not put it may cause a memory leak.

Is the reference management generally improvable for this function impleme=
ntation?


Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?

Regards,
Markus
