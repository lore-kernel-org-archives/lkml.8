Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B546C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C720578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZLBKQd/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1JB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:01:56 -0400
Received: from mout.web.de ([212.227.17.12]:46615 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgC1JB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585386093;
        bh=/GV3JcR/L+u3DtJEBVsxdeS63G13/kY6HFnQJbM5qi0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZLBKQd/BFptEepxt3/rDZi2K0JU/Qeb3NMEWwYZsvNzPbMoMIitRVqYeNWjnqt+p8
         8R80be5XP01b15BB+lWE1Nee2RHx/m+MGyYZsTwUdnDpfl4/O8KCkoImHNAICo0n0K
         YerhwHYckNMN/xMa2SWoXZwbLmsVBAxbLNjJw7bc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGAG3-1j30uo1eEx-00FBwG; Sat, 28
 Mar 2020 10:01:33 +0100
Subject: Re: [v3 05/10] mmap locking API: convert mmap_sem call sites missed
 by coccinelle
To:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3973478a-8f41-e09a-dc20-fe82bc46577a@web.de>
Date:   Sat, 28 Mar 2020 10:01:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qndeFfyR5yHLNnHOgxN1XaCawIatqyv324DnoBw/EhSmaw4G/iQ
 PWfUL5pT9Q90MEq4vBvVcVFP2Rf2EZ5Fb6+70GYUq0J1D4QqD8gEsK440EGFuX/DN5yZdq5
 NAm5cr8XjN1PEztka9s2GdKJ4lWU3SwGhHQonVFIDAVl2pZnuqAcd0r0CL2DC8tW+rKxi/e
 8e/PCBvnv4Eye1d+XQwag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmVEls5Aocc=:kAJkD7UGWfC9Y8xNNRY1ue
 R1fYkX4uh+5sxwQGERU2yCCQdoTyJhx3IbcVBpnJFO3+RfcXbdieLj49pxFxXnhXil7X9CEBH
 0jXW5owHfGAjGW+puTeWvnHau5feisvvZDSp5llZieFwqfiEDj2j5RL4bHnMQiVdO2k8VO+O3
 DVrQZ8ntW66bSdfqwqPpDR78kSofLpPkeAzP8hbN35KRjIDhQgWfPTq6CuhbbZYqy79n2c8W8
 0U9GCfz5zwZnCS54qv0MDp9ou8tmk2PhNtHuN0v6i9QpeoqpUsSndx5I2Hug5V8chn/2m/3A2
 suzjXAYjMwqbpIGMJuJyBd+QTOlazLUYCOl2X/aeMvmx+JJkIroNKVuj/0oN/IaXAsxnllsR1
 TWFIpzetaja0D/4/mokDgIXM/XWRrH1k1sQt8YcgzRZEO913yBkrTJwPeFz4eBrVYoU3I5vx9
 zt+XwVXRBuuyk+qyROmRxcaJKAA/IDjzXIky8bRpfCnjkShOBAgLEiRM1tzPKbGH2quhJd1tL
 ebMVKkax0spTDkiBqo47FZEfBNzDl8ongg62wU0JaxN+Qo2XGn26AO1YTAiUNrm4CZwTOEvxU
 K+vKfFHe0wRceBh1sESk2+xrqEb2GFavulBn/6v2kFf0JJG1RAkCJjo8lTxqed5kwBWiG+Dty
 Jq7NwMeK+tmADNpyG1Npu6ZzUH7Bj1oI8OtRXCwdPiNDcAAxGahRgcST9GPdnp/5SOUjIEneo
 2HkU7ewlxru7iQ+6W5aGGWWP23u2CxmNvGQ0CEi3o/1SfSMtoYph7NbPtHiSMTN+qayWT/i00
 r6iezaW48cabhs2XF62NAL7QPdJ9F36EUXRFPG5vFeRs3HEl25zvGQ+vtAi9bYHc/luCFxbIB
 jqJ/IF2N6s9mJhEEmS2h/85vzNySQCUOne2/6m42DbajvLn+5e/Uyx+Q4k+6s+Td2cl22XqqV
 97YnxtFBD2RHg31xZyoyCZ9Egkz7Om6KxLuuc4k6635EKl/e5IGVnBECpuGeIa0QaptDwddJg
 OgbuVcvz6NXO6I+q6nffUlkBWv9BP+2x7+Rw0LeqLpj3mtCCehTjXmjUmdZxoyOYgYTxnBFFB
 vTPjWK8zy3JprMGgb2CcM+AtT+/87bOk6asQfT/Z5d5hR2kh1EX+cRdDxmxgw7XEdkDMfCFdr
 lsUu8RTnuXTEElxkZpx387gtQtAdSv6WcHXefLa2tvp8k1vcObFCuGECrV9LcgaKWxjdo6s11
 Wb3/nYWBfoFe8trXW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I would be interested to find out why coccinelle wasn't able to do the
>>> last 1%, but only as part of a long-term learning process on getting
>>> better with coccinelle - =E2=80=A6
>>
>> How will corresponding software development resources evolve?
>
> I don't think I understand the question,

Various aspects can be reconsidered.


> or, actually, are you asking me or the coccinelle developers ?

I am curious how much the change interests will grow by involved
contributors and organisations.
Would you like to discuss affected implementation details any further?

Regards,
Markus
