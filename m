Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746BB205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fdFjp91y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgFCPbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:31:11 -0400
Received: from mout.web.de ([212.227.15.14]:37103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgFCPbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591198217;
        bh=Rn7fKHsFwwLiEDgA/knExuHS54ZAZVO02QRZ6k3ZyQw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=fdFjp91yBSfmCCQuEF3025+1+9nOx16qTgwCi3Ifl7dPsxhZs1koYRPU1X9s+9nL3
         bgu4zy6rJll3L8404giD2f8ybctXT5vpn6Q/4AamdnCun8KcT71St6E1/wEd5Sitz+
         JwL0gJt9eoe5mGoxzFQmSxMJFn6/83DHGH6bAqCU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLA1-1jGqJA08VB-00lmFU; Wed, 03
 Jun 2020 17:30:17 +0200
To:     Cheng Jian <cj.chengjian@huawei.com>,
        kernel-janitors@vger.kernel.org
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] panic: Fix deadlock in panic()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fabff510-bd19-1712-2aa2-b1d742349c39@web.de>
Date:   Wed, 3 Jun 2020 17:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+A5wHvMSSwj/4ZulG6se8q7GUNYt9SN+bV59H678/2LVxIt4GR
 Z9PVul/DlWe7u4Rl7ar5yIwP7IERy5eLj0hdBq2q5J2Su6QmkhEeQW3qlxdx1ST/gOmPXHD
 B14zHbvPHoR639eMkRy1xylG7W8T0uQCuymLLuV8EG7iy9PvbOZ/YRSz2SlbutEGTu+LFi0
 xamNM/eF0p47MPGoIstfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojT0uTotzlA=:eCQgDS8fiZu4U+MWxD/6fX
 Ye8uXMfpXsR2jh4HjmeCd9vBnRaTjaT2iH3gsjJhnUhbC+LSg5smfliCY18vN2ksA8Ag9lAQE
 v1xeKAutfZoRUgqfxdTbhZVvnx66nsBRqTZX2eLDxit5AqYP9x9plxcCkn42uHFJ6s3NEJWGw
 JNWDQtK7kl+cD83Gb2DTvtMMvCctfdW17Yc32o+8579BuMGo2QCkB9AagCzjjTF/3qDA1t9lq
 1/5n9rwX/IvrtHDhsonQc/2KFoFbQTdGIZ5WGdIKa199zQioQcav6HyNSQI1RphSGeLmqVayk
 uaKyt594JuDT4kzMI19mmEyumsk5g6vmnStB577yjSBFyjDypbv+1xGFeGValHlFqWNyArt8k
 +hQ8tHTMC84MG8t/D2XRCtaF6wcFw1t48DGhtUyrDXGX7VWQcodM8dcQbVL+iOsIkCehJmibt
 W42IG2cVZ71l3nrMWK25iWYuGQDVKHgNWV/nuQnsZG4C9xprZeS4jHLSt/tCAtWnxUDh1ikb1
 f5cFS//Zo1HHhH8uRBoL+SaQBcIoo7QvtbMaXHbwmuDAtI/lA0f3Dpxvifq3lSXF+4trEt8sc
 oHExGVNvUBlCYz/wvxUrrkECbzmOg4+fn1WI2SShrjfo76irp4zQUoLUcZQX+XCdjD7VKJ3lj
 Ysz+IouPmGYECyg5blnSJZ2LiFZixNMqWjbNYcdI6F9t7RIkmVJAg+UweiXmqbF39aOswKq7C
 m68efz0hfz8WAwMGiYSOwx9W9NlKOo2NLmYnM0YzGgYESzDog2I/nnK7tkUu1/OrqyORpDJ3+
 9ZpVnw+cbdfLaCFUaYo+u6379a7miKbHnyanPcN0FLpjEWcfBNF0cpUae27gzDKOaQWg65YnS
 A1EPX2kSJ2KsySyCcJKE7tEjU71Ryoaphu0JpdjBb5RiG2oJE3dILGCYwY0Qy3+Y4FEYVLcIC
 9WgMLL+2znVvD/rYPih0/ni54vwhQDtD9tMwnZ9coPrnKGFjxDAK4kPolkJLdl2A5mZXbB6k3
 F+uvki+bJAN+lwGwk1AdJKC7IWeAXe9EtjIQ4I/fDfgJdUs1x8A9M3oTl05w2iNn8igxyJwyL
 O3KGOJHaekmJvVfe0ykVJc9W9HQuTmqLLW8Bjb8A9ey9SajpkvFxCvEdVTqDaa5uUW6DcKTxz
 NNDEpWxB4OHE4WciXOVaKS1zX4i2X1kNRsfhpHWIy5cr4zRO5mXOGvUyQB6syl9j4rJCYF+zu
 zu5oo78EpDGVYwfxX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  A deadlock caused by logbuf_lock occurs when panic:

I suggest a few wording adjustments for this change description.

Would you like to omit an extra space character at the beginning of this s=
entence?


> we try to re-init =E2=80=A6

We =E2=80=A6


> =E2=80=A6 deadlock, but it =E2=80=A6 here, because :

=E2=80=A6 deadlock. But it =E2=80=A6 here because:


> Firstly, =E2=80=A6

1. =E2=80=A6


> When the CPU bring down =E2=80=A6, =E2=80=A6 CPU willn't

=E2=80=A6 CPU was brought down =E2=80=A6, =E2=80=A6 CPU will not


> Secondly, =E2=80=A6

2. =E2=80=A6


> =E2=80=A6 callback, so if printk() =E2=80=A6

=E2=80=A6 callback. If printk() =E2=80=A6


> =E2=80=A6, deadlock will still occurs. Eg, =E2=80=A6

=E2=80=A6, deadlock will still occur. E. g. =E2=80=A6


Regards,
Markus
