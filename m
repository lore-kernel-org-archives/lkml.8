Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461B2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ryiw2eq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0IAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:00:41 -0400
Received: from mout.web.de ([212.227.15.4]:35393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgC0IAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585296012;
        bh=qsrIXvyI5XAqFT/bXzhp7BN576w9yn0qWhtkPLd/MFw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ryiw2eq6p32Xptvn5yWb7YreK0Za1tgDc3HYdL2Ihe9vKkdmymexPsG7HtpCiThzi
         eV/oKZqPXMHP5Rqouy8bQmuaVGLd2mK8YV6S6wsPYat9dKK4WnYMYmyMB9m0xWN+wD
         NMwYLMRvkT2w8umMu5PCe+zkwhM+DYMvr05hdyh8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.253]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwHmQ-1jJHP819OI-0184q1; Fri, 27
 Mar 2020 09:00:12 +0100
Subject: Re: [v2 04/10] mmap locking API: use coccinelle to convert mmap_sem
 rwsem call sites
To:     Michel Lespinasse <walken@google.com>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Ying Han <yinghan@google.com>
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-5-walken@google.com>
 <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
 <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bc15b633-68ab-a121-53c6-32972ef1ad9b@web.de>
Date:   Fri, 27 Mar 2020 09:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dcMcueHUQVFFNviLz6d709esPHEAERQJVckeYupwVRHYfZecXUp
 1EGDL62O3La6nHt6FcNxgS/FDwRFKOT9DEQ73MYKBjSUn2AD+3Pv2EWlyYsuf055nCyuwd7
 +gmH1gakD06lj/3D/WBSXx16LdBICFUI4/7Gqzfn3k24szzMWYsP4iqsZ/xmgALYUyJ58VN
 CPp/VVGJ2WvyJwKNR/NSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ejVoErBuYBY=:9acXfw6axRJDdBeYIHcMi+
 ZNXDEGEAEIBMzfuuMt56ox6NlmngAdN5MlFRDXNwb42acqxyKdZ80uKwf3+v/vrJ1bLn5qEE0
 fgrNZ9oYYu0qDK/8te0mBLXhdZE7vlP1NWgSWvMT+MztY+vsoqXdvYdw0sZeopppOLgeIBsTO
 IgH9CFNJ621sB+Gm29AODQcIJSsp6OSftLzihMRpFDDjeENFQsEKDQMAZAzvMj6NsuKS8zitl
 dAe3oUXMR1yFhy5f6xtcJDgtL6wgU1mgcrCW0JkDx/PjV8NSpt9j7AMKS+8hbj0QHxYLqrihA
 sJgna/GwQIYgiCyOTnreVbco5SU3oknhal00MZs7xqQmjjjal8xeI5M9WrSt59Kd3t47OFQPD
 28mzXuRkk5OWzITpQWh3xfCoeWjwU36wrpslTp8h8Hs+aahXEd36pHPG4dSLGD5gT2LSKeUaT
 FVftCQ7Bxe/ua3h3cZCSxCBfXQJHFDLTpMk+yGRrhHjvhowHy8XuLIbeLOueb8G6NuyrQmo63
 MPlC+hkXhWqVLfnpJSeMRTezHCxQE77yTO2vEEvHsxWShJquk2sj77XSsiG+I659sCw/11GZx
 LVkdmNoVuzp4uAksulCzwCxIt3EufGh4i730KoFwubfhZXbhih4WT/N1TmmU1EGqOn4xaKEFD
 FWNtaq4Y0I28hxsLigd0lgUFC9IUkbSMzTVx51K6ZlHq+3sEZ+tmIbZA2YZzscJWzBizrMEK6
 JJEoXc4DAYa7pfoBINh+8VqP57e4xKd7A6PnLp2oeyy1xkIbZsmDkJDsLKmMMSJcfQODtVLtL
 UDEcfP9A30lBPklh3yXiYJd+hlmH/XmIHyTbY460auIcFrb9e8OaFNQ3Lh7o68HoAjpC8Yq65
 6s/yb9fvctu7u4Qk/OE3T0/IYiIT0RPwmA94FXOAj6JsivJPn3cNY/QOD/6mRheZF04d5WOEG
 IN95Ttw2YVd5Z7Qobi+tr06G8Qf5MgXhGsZUNLiEyYplvtC9Jt2eOkXTH0wqozqGIdf+xKctP
 pT49WwoEHDMMIuXO1cBBRD51L7tHWVREdqh0/bt2c0G6CIsXOn+ZexV2qaQKyAbvWO/ALHaaZ
 zFMucRRtncbLfeQuCpU72jWvZUHU3J/COJsMU5zPbOCxjjIC15fvJbUFwV3WOfkU0fgC1NYU7
 NeEUYbPbHkDdnBP3NjHyPl7R0BJEgMekqQk6ubJjsJcPQOAQ4pqFM6zW3Zg1e1YYG4rL6FZ85
 WgHhDZNf2HySCs6I7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The change is generated using coccinelle with the following rules:
>>
>> Would you like to apply only a single SmPL rule here?
>
> I think this version of the patch is already a single rule,
> similar to what you suggested ?

Yes. - But you repeated the wording =E2=80=9Crules=E2=80=9D in the change =
description.
Are there any other software extensions still in the waiting queue?


> I'm not sure it matters that much, as long as it produces the correct
> end result. The run takes about 25 seconds before any optimizations,
> which I find very acceptable.

I am used to look also at the run time characteristics of
SmPL script execution.
The discussed SmPL code can be good enough for your current needs.

Regards,
Markus
