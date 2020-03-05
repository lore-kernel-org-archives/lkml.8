Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D634EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FB62072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DKbdj/N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCESol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:44:41 -0500
Received: from mout.web.de ([212.227.17.12]:51707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgCESol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583433841;
        bh=YGpSFOHQxvIOd+u31Rn8vxhKKRemBSS5VTUynvX0dBg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DKbdj/N7IaWMcKn91OvJNKBEARed8fUh5RhlhQbDD4TA7ReScxH0HDo4kPWv0O9+z
         Ad9NOBjV/tLLonJFqxZDCMbCgplwr8PR1ulrRquczkxkzfGCdVvhfXaDH4c6NDVASn
         FBYK9TEvyofbubvWSS4tYtEZRt0+51TniqMyTkl0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6H9-1jEcZG2yLT-005M9X; Thu, 05
 Mar 2020 19:44:01 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
Date:   Thu, 5 Mar 2020 19:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TDMiEjKmEQKMh7+g9EuzxHkMmX/S1KhkyOOX3ucbLlyHwKv16wy
 aoLOQUeZf2oNUUtPFiTAUPQZGm8YUDb5+9A1QrU65l2HWTXC3BD56YpBpOPJ2HpKq972mqB
 rVSiZJUw4U3YiWzHswazrEyceuX3hxP8xCm4YJjkTesY/H7dD/Cz8f/awV8LF8X2K81cFO3
 ShsW4M70CgnsAbw5lOG1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QMaAotwbH2s=:9pA/3PB8Dhr9fSVhsWJmQr
 Ase8HeDDlawlq4IB1ZGupbva+ddCyBwBFfWZM5l7h/6T0798940j0deyS0j/cGJC2T82etzmy
 hhHBhBKy0f8y9J+nlDb7aUQrkvULbGvsNq5w0G0awjKeMZ37yZy+AmDAtlhubF/t9PavGqaMz
 aYWt1WHm6WwwWQhkTBJZk1DNgm8brJQ4qHkQBTu3Giwy2Xtqm4ycyfDcaWDQ8pLiixn8OJ1YR
 nQstr5HH0qMgXoB1dBiMI2QLO41k/mWlRXwKAgKoIZ+Uy/+FIaLCsvpKYK0eE17hM7SPJECWL
 S+4aPr7Ky1PiRb097mbfu0a+4TdBKKKMXF9NRaaBHiS7Chz1FrA9OE9sm0aQuCMIOjCXmaan4
 LrQ8PguzfFTDOuoW91FmcrU6xJxAI4SdLBBnPlqwaSJn7gr1qU3IqLDz3GDTXIlcd1YnQdSKp
 tEpvojN73LTGKZsgHOHXfmCzwwIP6ANXzPs530CG7dGtcSO9Ghv8qFHEzL6OOs2/p+3Dz3z4N
 oFZ1IUrsLu0rd3Cn7fZUfCbtYca7SuGH0WuUbUzB3MbmvZY7h7aRcPxnyxcO4z6WTzRGXx4vi
 sQWJya+e7NMdZXa+mAI/ltzQAMUjZyr+2P00Qwnav3W0aNAT92aDgOyXpkZGtppVfBwAuaR7t
 eQ4Hb8y4sGZKZDSP3SLCZMhOugjNPf+KsPw60r8tsF9ighf6s1N0NOOJLma2EBBxD+3bZuiuW
 Khcjo0Y4jwNRkk3dte2WmlzaGps4I26OMndV5L8DITSOZI75+i64wlSGL6cWCdEsKB+y98may
 YTSyJL3AKlpjeslhFMm5HZJddvYIiifFJI6AMtXF+UpJyIBFlar0Chl9qojWByCGQ5/vaSdgl
 dFWEE66vC//W4rM48JDd3WLGMHU5WT12ZKoxshAckmCSYvobCN4uhU6zxBj9QJ9MIO8n71Cx4
 cTYNctHv8ZUOunHdO8FykmGFfbAu7c8n4EVvq98UwRNQhe0yVctOSZ5vKHJirmRJrFapMkeNB
 A4PYKy1sEUVDDtoIItt+8ZBYsilVLgb+fYgHa4nheL/7NU1c6Zl4/CwzBvFWjw5Q+2iLW8zn2
 ci1LbctKxR3M8Jrv3HDUtgiff5EaOtH7r94YAHYnC+mW1pQBhdFIjpmJy+txNa3yX9SpiFfPp
 ZNzN46/OarbXYe+wcjoHOB0tvZWjqDQOc/U1FgBHsZZsIi9Ggt3+DUVaaAE3tNa0oBPslP+vr
 r2PRMPTyof8XETTvI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> If you would (could) be more concrete (or discrete) in your suggestion=
s,
>>> I would be glad to comment on them.
>>
>> Does this view indicate any communication difficulties?
>
> Probably.
>
>> Which of the possibly unanswered issues do you find not concrete enough=
 so far?
>
> e.g.:
>>>>  Will the clarification become more constructive for remaining challe=
nges?

Do you expect that known open issues need to be repeated for each patch re=
vision?

How do you think about the desired tracking of bug reports
also for this software?

Regards,
Markus
