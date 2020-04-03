Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002D5207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qopBEYsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391006AbgDCT1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:27:19 -0400
Received: from mout.web.de ([212.227.15.3]:43009 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgDCT1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585942009;
        bh=pIHtPJrF/XoMH4Nuh6ZtQJtzP7zytPQVhd8IeMMXuIE=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=qopBEYsrBYsUyrYV5FgshuPAltrV9n+92CQ4nvHZxYFyrjuXkGqdziM6H9e/YPSrw
         j5kD6LgC7QEsD8aW2XQ0peXSKI+l41V2O7ww2n/Cvkh1xut6F3zOpas2YfuDY9AfMv
         g75LqZf4DKIvAyYf3unME/bvGmBKNqWXH0fW018g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcgkx-1is1IE1tBf-00k7YH; Fri, 03
 Apr 2020 21:26:49 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: bt-bmc: Avoid unnecessary judgement
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a0e9e0c-e6f3-139e-ae21-83a2e293ef35@web.de>
Date:   Fri, 3 Apr 2020 21:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:sY0gvbFN/b7SjFxKRUbUZtLg5n1XNF5rCLkYNcpPDI8uJV5oQVZ
 E0Cz19VVXqufaNYG0oG+bcxp61EFItZkqXUaA7XTTCdgRFQ6QWOaFkG4jAbJUZn3NjvqmZq
 MOFNCQGsU7ia8X+fDN+sf1dvRi2h/e53F3/HOHMmML2mLDPJJs7PZIJO+0LhsZqA2gTuRWn
 G8s9nPFoKrbVOSRRxCYsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14RRBmQo+vI=:JzvCXOmOB//wzxO2xP53l+
 7oLmF3TS+DMfVpxotByVs8uyJwMY4/3pFTYGRoy/Ezvjbc9xEIG7l0YK7tzrgpVXC8rjWJVDK
 rRLpRVXcXuVRZM6zly5ZIiqSqQIGiXwWKetmCeTC/iW0xlrdIIL+uwHVFvhc4vOM+fTkTRwSO
 hiqwBFEe98FJbARMna12Tec4+aY8nITP5v1jIMvgzHGx4MCwfeZTBHrpeAos2NCYjJN9XMZ6L
 AJZ3zhxczspgvsdb12fQOjb/nUQT/yD5yVBU/MNDXjtcPJCUDOO2pYmmA/K5PFoIuDDlOHxBH
 0FUE+RgTvVqFux/gLbtr+N3lRE+AtysBURMuwGHaCbm3+LsmSgsTxWj/m+oYh8nViBOEE1cWR
 Nm0MlWNh9sQ/0as0UrT9B58bM3Je8+1cQi3mkT2vE51um2RUaEbXzH9eT68jqMfz3gH6NONK6
 GNtCqYyD4jyqz9sTAf9Pclm1YRRjr9A69SaIobqZvrKcxtUNXO4V5/JPwhPgzF3Gt2iMgySzK
 xJgSxlqfsY5JqxNN3T2rUBgIBi+IIt5lrFsH2WVbkIMsmOPMRYSRbP7uQ3r9HsTZUhJJl7C3T
 aQlWEDe4LKn7MYHzKK3pDRqm5k4cLE6Lc8p1FhfqtOds4JObUB/5QzffntDgb6tb8iBnqiIQh
 9Gj9/AW5QoFD7t5WBCI9gvbC/B7yHUDR6dbRVuM9OuEME3tzKDwd7gWNrUuQ70D+tFPBLZOn4
 EBq7ZAJGHJTlKbXU10nlPDAIFnUYH8W3Brbp0nXv29Ip0L5b8CZ+FYgHCLJsAsP2GQnRW6vwP
 raeT/7mMCB/TEaM8IofWdMEmunNS4HW1/d8qz0XLW5k8cZvbZYB36yyxbOd/VaS7nGIuqEum9
 pH3el4Yc4InIIIssdVOWbED49mfNKHHHEFG0fcbQSMF5tsl2XKCquQFRve63d8DAoDxqH8pz4
 63SiSREhskTcnChydjMRjCKUgufbY9SZy4Aj7Q+GTXPw9posza1VWQTXwrhROQxNhbohyHpgx
 8DeLlmoaIs3kbMMIUHq4o6THBJUcErxDxqgf1XxjtWbDafsufRzuSTyHSbgGsl/lkvJIYIfB5
 y6pKH0vi904YxR2w7ZpJCSmDxg96c9eKzOErymz7PVyfbGQ17p4+XZQ4wAIXLk/A62d8yUHN3
 nysDuq1d3ZU4UFRyH9pRzIUq8tqcMxJoJ1rMoZvPkV5M/Up6P/Esh5oD/W76KAr1JW4DpEypU
 rVI5NbnJMoivh/rb2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this function,it will only trigger ifdevice and driver match,and
> the driver has already used the device tree, so the judgement here is
> unnecessary.

Please improve also this commit message (besides a typo).

Regards,
Markus
