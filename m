Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF09C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC0207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="e6/8zHZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEULC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:11:02 -0500
Received: from mout.web.de ([217.72.192.78]:34277 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgCEULB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583439023;
        bh=wRoIHoXkn/jNzgnLhrfKT9vPI6I3Ac9mSmzVegyAJGs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=e6/8zHZqNHHWu8Uw6a+mraRJuHWe+ZS1yBQtALyGDC2yrzjdlp4QXCElp540j8LSj
         oz/OCkOFJTpz6aXWe9fsXTz4TIe8NvQun1t/NgGh/n/buSiPAVnjG2vBLiEJBQcTzm
         ENDiGqnWezLLrRyBgAnvy7IOM6kCukbNASni03LQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1jKld81PMv-012LAg; Thu, 05
 Mar 2020 21:10:23 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <20200305140004.535eeb1a@gandalf.local.home>
 <af5d4af0-9e06-cc6e-c29e-4c4eebdb9b0e@web.de>
 <20200305142505.714a5121@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2d5df2ac-443b-cc31-c2bf-78947f81dd00@web.de>
Date:   Thu, 5 Mar 2020 21:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305142505.714a5121@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zng0GwqeKwjz1toVlIWqxRR4CryrnheCVZYL95cKRU1oVC6R/bO
 P/9cz6j45OWN9zm0x2evwAJpE31GfmQa2AVs/oiKtiObeQTIOQ1degGjfGX5YzQKiRm9Cr2
 oi4cx2Di8t/UTrZMcLdZLgbTniQQmpjsiEJZRaFs3tsneqmZwYvtWxb6jfWor4OxPacHU4W
 rfnuggzdfLhNGEsL/bjQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZERt9Wm//3o=:lIe6zUYkgmky0LSJrJcCIR
 lol2/fB4E8W+v2AvCx38ShAREJ9YivNvy1YhHzac8AlJ8ntsjFSKPfkp/29T+ZTdwT2S+46bh
 /Z1Q3u8DRGzXkECiDEFWbpQHGz0KOLzQnDi5S6moTV0KgCjFGQ0UW41uUeaRYYzGjn7MOnVOz
 saK7jFCcD63YeNd+ThFWJdV1ZLPYnNI8dDnH7aL7tZJE9lYlyj7T8nBJjK3xSo3Np0U+GJuD5
 RMB/F/HsPfn7jkBMEU1DBMxfi1lR3giMJ4KYI32/jdIu5A8RsyDzVLIt3mIP69lmkjxTciCXP
 iABefLDF3ACYZce9B4jmi0iWiX4LQBk6SOTpjB+qhByMuj4slP9kbn5JUYMsWQUzed8bi6Npv
 VAWDJUf8NFd4h2Z1eDvH4/5uO74Bj9ejxl5sL4Nne4HzVEga57y2EcV9wzgM0whrYOe1hH5HD
 qDkwciXH7PYuYn8WGMdMg5cHXAQpNrbAwYpIU4YTU5zXjp8zNlIspKxNzmydld+jkXzTytMIq
 p8oVP1rWRrRV6Dp7eMbMdC10lhbcSIvKfwVZAp3koeXEmkLjlmHYaSfdghJ41+jjG/87iOgZ6
 J9+3kMZBrA1d7J9KDVrMRLKDWZlVJo+5eAaAzYkrHwxBd8UoLA49XnIPX1PMcAPkLSPiwmfUS
 u1br2Bd8gy6l2S0g+0/V2KN3vGEPV0aws+i19F3vxQIUK8sB+bf/sl055ONBybTKX+F0iwqtx
 xC1GsM0S3KVG9hHoaxT/Nob68rC2RNtSja0lf3oWp6b+KBkNTGL280FbYqHzIznRRWDQfBYzU
 0sxjo2XrevMuURU0Fip1sLyTccdA7X1cBzHhuK4wtN/0Y00UlNjGe3SFDq6nQ2cwsBToPq47A
 4KSsh0EGRPyCiFds+YxbQHDgI/3tzGoQ66gSv8nXTryckoVn2YP/Y6NAx+2vmm5KvnmEWF+x2
 XCMOULINfiJlSVNXtX4RnN2aiNNiBNhtRQKHGLlvQbWhYos0VAwqEQL5HOSCnTrZXd6YfDen5
 4q2FXX/bS+7dx+Uokp/+J1OZYcKe1DYIPtemtzI+qZ9uIgB7KbIcWISAbHbdICLfYD9j420Pd
 98CEiHP3ZZkvLZQVBxDc7Fep57IM6xXaLjYiNOL3AWaStXV+Y3YphnHvoz1EFRePUuxBd8KZp
 CjHvxg+Hpdxe0NyJ496paDHKGN3AbRJiiXpoezLH9fvGkv95RApl7MXaiqq7bCoY4n96a4Dd8
 EiZEg/A3YbXZIHF53
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suggest to take another look at review comments for previous patch ve=
rsions.
>
> I have, and I believe Masami has satisfactory addressed them,

I agree to parts of the shown software evolution.


> if they needed addressing.

Remaining issues will eventually be clarified under other circumstances.


>> Do you identify any feedback as a bug report (or clarification request)=
 here?
>
> I still don't have the foggiest clue what you are talking about.

It seems that a few reminders can help here.


> What bug are you reporting?

Examples:

* Another typo
  =E2=80=9C=E2=80=A6 contain only alphabets, =E2=80=A6=E2=80=9D
  https://lore.kernel.org/linux-doc/967d6fee-e0cd-c53f-c1f6-b367a979762c@w=
eb.de/
  https://lkml.org/lkml/2020/3/5/247

* Use case explanation
  https://lore.kernel.org/linux-doc/f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@w=
eb.de/
  https://lkml.org/lkml/2020/3/5/429

* Challenges for the safe application of key hierarchies
  =E2=80=9Ckernel.ftrace=E2=80=9D?
  https://lore.kernel.org/linux-doc/c4a0bc10-a38b-6ea9-e125-7a37f667e61a@w=
eb.de/
  https://lkml.org/lkml/2020/2/28/363

* Feature request for syntax description
  https://lore.kernel.org/linux-doc/2390b729-1b0b-26b5-66bc-92e40e3467b1@w=
eb.de/
  https://lkml.org/lkml/2020/2/27/1869


Regards,
Markus
