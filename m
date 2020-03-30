Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00EF2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bL+Ropn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgC3Kme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:42:34 -0400
Received: from mout.web.de ([212.227.15.14]:47363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgC3Kme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585564931;
        bh=2xKgX12kMUryR6LOPHtwg3l7/WzQYqc+nhXZWa9VTFs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bL+Ropn53oNrERMabgYb+2EBC622br+5GUHA8j+hTZaKU+f2crLivaDIIDHfHYdmH
         DKGgIKCDYusyApxdbXN78IPM8GY7ESxo0TVQS3/JuWTsidCupZYFwXLTTzgia8eg/f
         RirGryflAe0Ltnyt6n4+LYhXvePGHFHDAYuz+yug=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.71.255]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNmy-1iwmfr0see-00mYcl; Mon, 30
 Mar 2020 12:42:11 +0200
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Improving the Coccinelle
 software
To:     Julia Lawall <julia.lawall@inria.fr>,
        Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
 <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
 <alpine.DEB.2.21.2003301046530.2432@hadrien>
 <a840e22a-0152-6aa2-e626-33011ef4afe0@web.de>
 <alpine.DEB.2.21.2003301220140.2432@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9c2a8c1-ee50-db59-5b48-68f962492cc1@web.de>
Date:   Mon, 30 Mar 2020 12:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003301220140.2432@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7ObiVdVExXgPbUiBrVOx1FOxLsY3tnnlVWiWu/3aA7nzXGY3X3
 rHb8T2Fw+JAeJ+Ey1rkLg1VufM0IaKXAXPjpLB6eBPF+jUGOL3zVrOfVosfHaX05WgGLZAp
 hzYq2Ki2MSW1igtCCYh6N84JgVbtWiubBQ0w7XTyuiGASYGGhaF7sRPghFQQnotLuIBCWHz
 QeCCtdSemTY95Xu7e0Vkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKJLOwqh6G4=:XCHLu3V4q7bOQAfy0arnUS
 LYk8AwQv91vA+eH/bYIZWDbvZZrDqgSaLh52Ir+GZc6Avz2/yi2n50TMiWJtKx3kH1ilV0Ewy
 RjAxOi/GWockxJXA5FXRPNikGdD6GY7hrXUTz0gUh3IoN2UozP8rUjeVlLRyFGskjb/5G5doj
 5vhfCTXdthn3VsNrrIXxidMRHciWh9sLBVQHfn/uS3e4ekdhQXrIXLU1Ml1r03lvvb88OinIZ
 gUvqWVZ7HBeXEDSegXOlPPhJZSz7VFpYDXPThHgCwvcq2PwQAYnxtsvPzz9OJ0B1/KilZuHgb
 v8DS37twr4KjY3nbbHVLRY3pz/HQseg34uUuM1NybbzVNbCtbuaYLi+Qn5zz4+J7o6sy6gPvB
 w/CevI9EPhCBji3UuPg/2i4zIy8UnrXojh2THEWs7XEEli/fZclbjZekPbzJnywU382fdBcTX
 dz9BKWd/NAExGjNl5lk0fYXFBT4NEHuIIzQjLqw33PYvwL0Jd7Uqa6td88F485qUApcR8YHNq
 tuFwdkv41KxH5ssGpSwgzUFwiSOwmmOBhcwkQy8NS8WaWt6EEJJg6VUnBuGgADj12vyohfbpQ
 sh/m3VJ9Yy2+PCBmbsuWm7wy1L/zLeD8ZF97Spn9UaKIQYFjBaJNPWimy1lHm+Zk48ghBzET5
 YgZQVhhLMB3MJ3E9DWb6Oy0UpYBURodxCSW3tdQjILS8DChFSRMTPvjWq1N4PzlXSflJZE70k
 ntl1/zRpJWUcx2FIh5iz244U0O2y1PPeggJ+HLNhjVjDMHdj4Hia+iaQ6h4PKODr2njx+sz1x
 FOzMIgJG6HlP+NEiKYrSkkXY8yuVm+13xj++f/KrJC53XZRb6rxE63eG43+Exn8sLtj09ADQn
 yIZYyFxodKLAKo+TGzP6zcLPVwcXIFdycUX2NAgOVFWthkWkAxoieJONsego6r+GVScqnDX2w
 S/2CZD1gKa2Oa98KRetSJyJZSZqqSFa8nCOyU3/czSkHx7D+pqGFHgvenR9b9vObm93bLS9YX
 yU3rcLIeOW8UhhyphFOSZXeIIRWRvIKGRQJ0uKSoZ+GNxlbhLXS7tc/o+zl2c53lKgGpkTL4f
 wfNyLI/zm7hSNs29jlwTXkUkwERfWom9l06X8AC55X8rquphviO+uHoQMr19CmdVsG6yFV4Dm
 0fdzpBlXlBQ4g+1XmEgQb/ttqSIbnHo651DsPohPOyJ0MS76b0Co3JJQO0NCBaVui9eqVNmwT
 1Q+qQrEqiJQuP9iOs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How will the support evolve for data processing around the application
>> of similar macros?
>
> Not at all.

Will such feedback trigger any collateral evolution?

Regards,
Markus
