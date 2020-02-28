Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E74C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07890246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZDvbRvKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1Ibd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:31:33 -0500
Received: from mout.web.de ([212.227.15.14]:53395 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgB1Ibc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582878651;
        bh=nPnhFRvMYmTPH5FtdmNDtug3zupDprrOQTlVNSDpcWo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZDvbRvKDfFFLV7Lz5KKozb9PSrEbJ/rrrnW4u0eqkk+0YPJLgMNeNsIOe6Bz35tEn
         GWNK8b0VD3rESwIi9O64y6h5mCk8M740Hw4y83NuILVPua06+qAXf9hXAtL88svqdB
         93xdkbU+GhaJ1TBR82EYqXGCBAAiK7aqw7jjZ1+Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Md16Y-1iqTdI3J4M-00I9hp; Fri, 28
 Feb 2020 09:30:50 +0100
Subject: Re: [1/2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
 <158278835238.14966.16157216423901327777.stgit@devnote2>
 <8514c830-319b-33e9-025a-79d399674fb3@web.de>
 <20200228143528.209db45e5f0f78474ef83387@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <efe38d09-e73d-97b3-d4be-79194ab2685f@web.de>
Date:   Fri, 28 Feb 2020 09:30:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228143528.209db45e5f0f78474ef83387@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KgQ3vYV9ysegr9mt3KbORuXozfS41mY2NV0+S4K8PRmn24jCgm8
 WfFnbz2ikQncOtVTLJRwvEEm1nDmyevgo9aZ9UOIFlRrNdgDynTHwIn4U7uxsFN9B4/5MEI
 yOSiAXsKnSz3oG+lLZaH65jzvXvDsX/LsFCnM7HsF/B120cJ0cbJB2pRzq5xN0omhQUnonm
 /lZzjJPiO15lAUCjREOYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r9Lj2hY9OGI=:QWbBOLSB8tVj2xRXuj+3vx
 CKq9Rr1Tlt44EYS68bBhc4vKVkPhYGicIJ6qdHaq1oJK4Bq99iUNKWrq1f4glMX5RYOET97xo
 qBDIL5myQf6InBY7sXCvmL/fXED3NTnJdtJTGEdLsidCpvrIWblbN4gJLenr6dOzno1zpcsn5
 LCCmjdxS7H53MEjZ+6u6XPASwt0yb75d3UXgGay2PBtOg5m8jixS7RANHy2QAPHaCmDrhX0V/
 M9DZwvlEdhenWt+eyTjZ/tYkAb5CKWxcaFyEVtNLXLRBQD8beVY7DqYRVYGH2i2E0fEM2XRw/
 9qIoolfV3lpRRF7Ol34SS3t/4EJ6FP93THbKxiKRmIKoo2yyej0bLkSu7oK6/vVf2fbn+2lnP
 MH3uUFJdCEc5oXf0nFCXlhBAs4KDj1qztu4q3Ap3UllCNfaB5RIdQi4VX+OwCG5SzPN9m5UsD
 hpMmN5/mjeFAXeudWNxms3TKpS38VJ0RZwA9OpQkuB6cS0fAIPiinWQoBGLCc9LHeYrd9Gix1
 9WV6G2TSijc8cYnFTlAz1G78QDR/h7WDIgKS01osGZsetJKCJOYNIiuRXj5eO0sXC9I0DUs12
 StTYSp/5KefWZhf7Pjw4P6Kn7jTPJxSASodXqQSugKmINyWZu8CRfxqV5C+TlyBWUSoZNOWE3
 90Q4ecfTfV1MPM2QFyQ9TqrctXGUvwy/+0EGWUqpVfelqF1irKiugUQu1B7m0eiX0o8cGdaWE
 wViH0cRqIgH8FPPxxR51Xwqu1l1LqgO0nnQ5mABudvKUyoA8CLXWgPL3JgiFDjPan8EJEQE40
 6X9avLMl4+mrQqjwgjEvi9xeEElWMQsDk5zFPS0Bi0Nlnh9Q4lBLb8XdQZpNf0YcAzTEZdCqK
 NInfEekgjJawBI9WCzpjzF8q/BduYLYZUdU9zzPKlm7llx8miTbS4pr6KNaH6PSaG24Et2yoV
 SW5CZ9SfIu+iljzkX4l1gQyjQq3gO/AgQuc5eCz/ykd9Lb0Cu0FbgPq1GEF6LdUgLSqFI5geX
 bpK4nV58rk160UAhpm7mDLA87Ndg0dX238Q7MmcLSOmSL3DOsPK9/pwkKyZoQqbcoO9gnX02V
 lXqLdQtZWTKitgC+u7L/AO243+8Nj4b49/bvHy31Y4SGLSXpBdgMrsuNYZ4e/dDtH/JF0RZ8l
 JJcgA5xvKYSnTSbCVqhtYh8LgXuTnBFIJ05qdc2WWvUdflkzAiPMS15BuNALMr+jl0K2/+w8f
 bV7W6VwRH6gIs6dnw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +Also, some subsystem may depend on the boot configuration, and it has=
 own
>>> +root key.
>>
>> Would you like to explain the influence of a key hierarchy any further?
>
> Please read the example (boot time tracer) carefully :)

I find the descriptions still too terse for corresponding relationships.


>> * Can such system limits become more configurable?
>
> No.

The possibility remains to adjust the source code also for special needs.


>>> +(Note: Each key consists of words separated by dot, and value also co=
nsists
>>> +of values separated by comma. Here, each word and each value is gener=
ally
>>> +called a "node".)
>>
>> I would prefer the interpretation that nodes contain corresponding attr=
ibutes.
>
> No. Node is a node. It is merely generic.

I hope that the applied ontology will be clarified a bit more.


>> How do you think about to add a link to a formal file format descriptio=
n?
>
> Oh, nice idea. Please contribute it :)

Did you provide it (according to a RST include directive in the subsequent
update step)?

Can it be helpful to reorder any changes for the discussed patch series?

Regards,
Markus
