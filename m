Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE3C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988892078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DHYujF+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbgDNOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:18:02 -0400
Received: from mout.web.de ([217.72.192.78]:40805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389351AbgDNORx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586873866;
        bh=4WQE4NvHZfPUXbCw2ByJM584SzfmIjQKDB3/3syx6sg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DHYujF+DNZUE26nTYaM28tAuxQkFlhFP35tvb7SirWYLeoOndesMD5Sct4wtNr41Z
         NknKuqRNknUk3s8BOc9ZeP5uPWobk5m/damut0al2lm1JLZjgXpjnZHla10YaEG4kv
         TRO6QhfZ4smz4hk6N6L2AQwfUs4OT87L9H4KDqRU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNnw-1itTcg1wBc-00mZ2v; Tue, 14
 Apr 2020 16:17:46 +0200
Subject: Re: [v2] mm/ksm: Fix NULL pointer dereference when KSM zero page is
 enabled
To:     Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200414075622.69822-1-songmuchun@bytedance.com>
 <ff540216-7f3e-9841-4896-81907540404d@web.de>
 <CAMZfGtVpMK38odpd3Ady_xW0hyMpN89Vwo_WNXBZz0yGaZzFQg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <36a7d091-440b-a3db-c93f-713fc7cfbb5c@web.de>
Date:   Tue, 14 Apr 2020 16:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVpMK38odpd3Ady_xW0hyMpN89Vwo_WNXBZz0yGaZzFQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SGknuvvPbw0cwfLy5Q0drBCgQoEK2J36fOKPhh+909KOCwtnp1Q
 32cQVjEJ2kmF1VxaSxTIwL2I8hV0uecuVU17zC/JbohqVhCx546NIOcLeeH1gO9ClS8vWcU
 ZWIbYYlj9Z4l7IPcT9dIbk5oDKo8kSeSg9kzltmq6xmJN2etG5EmD5Hj54b+8rhulekUJkK
 jovxlkSXYQkLdmra3L5Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3enSZaqb9YE=:ZT0eR9XURv7Y4asZBIk8FL
 fT9nj9Y6YxWFa4XZgijlNea1tp40C3OP1xdf5kF2PfZuK8N6RN9zNEH+GT3NduberChRwkfq9
 nXDNuWNEMHNJCEnYLaHquWWopCCQgTULlNkRkcir7nM4qopjaQ56Zfw3k7D4xjf7BYhaCGg6v
 OGLJzxv34eH8bkAnMYzwPZvlBWGPR8PdVDBJwSMrIViSo8axoPu8TR0LP1eKKp6AznCK8PwYV
 CYIfsgqtjZYwZ/VTTUwFHs5wQtGKMpGq2qEtdOJ56wT0ooDQ6SK4Y0Rfjuhy36n1KCj7Bjs+H
 +3oYD67sUSMqi9lo/s6Vd2XxRA4w/s7pTt3A0y+xCMfStUomVPHjrdV6IGEP8CtDbxXDamm5v
 hWJyjBY76fjwSoC5FtrVpcXb/EpLadPkU4i6f6RV0euGBsrEurJv7tRzchHWrtpm0qT5z3WDZ
 okqeXrVdQoqMD4Cmuqdv+gmw57tryO8oFvqOB/0Xsc9giooJvHGkjbFhOikKR/iXR+0w45KSs
 Va2ljAJPwjB+bOXpDtRzI9LWSW0BwFjMivNPOWMouR4ytpIF85JZAL3ButYjGQ/xthaEebZbD
 pq69g54o69xYK0zqdUiDZqcQcR2eNnVOP9WdUFhSE+GU6/Np137/bA3mnqp+BWqqsgcrJSukc
 evjZZAosDOvCNRXDx/nAteBL6ERBgng6KMb4mp4gqjzCJcbWigAKUetm2NXoj/ZYcOL1AOrtL
 ei7ltJi9hi7kWNAGGT6W892hcybBeF/xLDwSaf/2xRJ+kFGR2gKhhGJqJKO2jDqiI4b3wTafF
 ZL/ALcK75tWO0wMlDDmW5qpejOAPDisn4YKoD/rEeqXnkrwxNaV3tTnRxYJOgMWdsvJQze8D6
 2AoDnTNtsarcFpocv0zP1TSAJk0CVOkfom3hJ8HHpQZ0OSVcpqWO7oYPo26uAHF62HSaOh5cR
 Q3LaSW0TYvpKA4JhYdbpcXiZp0gFp3rby0mvCNKRzSsjhcVIufjkOT5bSjHevk+wB3GnPv9KT
 vGvibj947XOxbiX9n4oFiE9Ev6tEKOCbtY00il1v/CkEABU+qSuDP/Hac96MrL5WPzyBlimg7
 ZO922LmSthNbzuImxO66EJ2WgVyyPiHHI7hYDFBQ45QVh96LVE8DEPyw+lbcpC1bl9vkgohFl
 r13rIsazV7T7ezYtIYkuSTFJoxKhF4biP2G/LJlpmrlfmi+MQjAZ23BjMDbzPIulavUUJpSuT
 vkNfFXb6Gl8d7ZSO4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> to crash when we access vma->vm_mm(its offset is 0x40) later in
>>
>> Will another fine-tuning become relevant also for this wording?
>
> Sorry, I don't understand what this means because of my poor English.

Our language knowledge can evolve over time.


> Could you explain it again.

You integrated a few of my suggestions into your message selection. - Than=
ks.
I wonder why you did not like the following small adjustment possibilities
so far.

  to a crash =E2=80=A6 vm_mm (its =E2=80=A6


>> Will any other tags become helpful in such a case?
>
> How about changing
>     "following calltrace is captured in kernel 4.19 with KSM zero page"
> to
>    "The following calltrace is captured with the following patch applied=
:
>        e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with
> colouring")
>     "
> ?

I find it unlikely that such a wording alternative would be more appropria=
te
while I became just curious for related development consequences around
the usage of a longterm kernel version.

Would you like to reuse the term =E2=80=9Ccall trace=E2=80=9D?

Regards,
Markus
