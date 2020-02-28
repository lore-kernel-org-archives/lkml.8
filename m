Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F8BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E379B24680
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ibs1HTe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgB1Nfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:35:48 -0500
Received: from mout.web.de ([212.227.15.4]:53391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgB1Nfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582896907;
        bh=faoq4Jj6DfiLVYuKBB4k7ujCuN9UWBOr721NLdYkMWQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ibs1HTe3Xfefvu/8z8C4rvtf7x3BIRZ0tkr4LXkfLPzecYfQOEvlNJrHQdPq1ZR7Y
         jj7x/sH4Fy3AkI4098gD+MKN4wrGndmatul2zWg3U+Y+2A8zzfjULs0/TRA6X/Qmze
         O0v+9yvjRk7ZdtqFhfQyNUW1rT4Dt82/ilRm9xzw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjJK3-1jgBWu2vVv-00dSZ4; Fri, 28
 Feb 2020 14:35:07 +0100
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
 <efe38d09-e73d-97b3-d4be-79194ab2685f@web.de>
 <20200228221108.ff392be76fee6925f27103e6@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44efe433-c1f5-9131-4b0e-50cc5897a4f3@web.de>
Date:   Fri, 28 Feb 2020 14:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228221108.ff392be76fee6925f27103e6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dqpsRqqCKnVUub1yb/AoghSQVq8RMw5zD7fXvfLA8TnxkoYlhxM
 /JIP1TzlacgNjMavnyxO3+azetNIkE7br+YkYCCcxHV9In9hKbUYc5PRVvvH8uAZnbwWbTN
 aLNA4Thyn3HEou6tygF68H54kXuxss8isiTgdbLH50V1Hz6JPKjbW/zOKxz6QG8EuCppfe1
 HNfkE12ZIhTYG/io6Ri6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LrsoVTPbFYU=:bIBKSAQ8IrrjHdEAdWR0jJ
 pjlIbFfUJ6Cbgk2imaXxPB26JpMYZftwwvFqXp9YA5tCzZrRkrnd9esu4bT/E09K/aYo9niHH
 a/Lt4Msj8iQm3+cxTbjZmpEJYDPYMg23iWnNPyIQxd8DIm/AZV/NyMBIVt9maygFT2OZ7mP/B
 ua+WYTMA8hhTf6q6e9ApeQqoT2aEvhZQUl1vv3CTWlYaj+wgfT/m3VvgIE39RuKCYK9RcGAIy
 2454fch9X8cB3HupDC4E2bcxkCaIWMbyEH1TeRfbJKi4KzePbCinRyLEOfi37W56BfA8XccEx
 I9yNSJvA+gABbNFz95stTmZjCLkSb8JfE9cczGx6PQiIUtU84swQeuP7fBORncCJe0UVrcZfl
 Fajiue+1RqctNJCrLBqZHD9+ofE0pcLPUMTFSddzUCIFQq3WnoTlU4y2bZcXEfUm/KQp4kJ9U
 WWKgW5pTMhTtfioBa3Evqsad0LzPLRMLOvApKfF35CAltnhTlh4wZR2qA+pBlxkYiwH2LbdTj
 1IU17roRSbn8jmp26dWrjxu0eIycIkyWUTY8AFL7+LWjnDZB8Htr4E+7pZXmHveGZTt/HFqFf
 iARYdadXVMlgNHCTjdBaL5LwHARUqNjLWzXQUszBhxF5UuG1WzSXF2og3gTuq0g6AXdMDh+1E
 FDhLjzEdBJ08UqBf1QFfTnBHum6q7MnLlgl+nwR+n1OYOs0BYA7x873EMTufeKWR96w5B+DGm
 0Y4459y7u8L2AARPmi9IosUev5MCiwyznH83TFLbMJj/693w8kc1iFcy8OhH1fj/gFogUMTHF
 VhmiQmRniGDhNlCc/4q11P3CK9HOARyj5Sq3USzjAyvFEegGolM7zkIrVWwZnLLmIY3/R90Kj
 PmdK/2ZpO2+SnkmEgFCVZLewsI7GUoXVowCf2I1oEzXwhTMnciW4wwX8yat75zBM06Br6EcJV
 twkAgSQ03xClU59hbiLXdg6Ik9uSq9sTeag3asSd9I3PcDrpJWA45x2QuqFYtErz74TatrHpD
 dmjsx4QD5cSPoaEfyh0Xr/cvTJ0Dqp3rFpMwAH97gAJkTIf9iOm5lg82/ASP5fAtBMjt+88NN
 PDvteSNc9W9CTlDFI/DoHTKJfWCHzNIEjPb/8wA1qfLPDGDd05Eh0K3pkQtSAmYXr86gbFXwq
 hZ/eP2BwD65EVx2KtTM85Cf4bN0NFDqAa6w+DwFKWAD8tdQBwkP2IQ2/ZvhV4n7fyKvAQLwPC
 0k8NPVI47izS9sdUJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> How do you think about to add a link to a formal file format descript=
ion?
>>>
>>> Oh, nice idea. Please contribute it :)
>>
>> Did you provide it (according to a RST include directive in the subsequ=
ent
>> update step)?
>
> No I didn't.

I hope that more progress can be achieved around the published suggestion
=E2=80=9Cbootconfig: Add EBNF syntax file=E2=80=9D.
https://lore.kernel.org/linux-doc/158278836196.14966.3881489301852781521.s=
tgit@devnote2/
https://lore.kernel.org/patchwork/patch/1200987/
https://lkml.org/lkml/2020/2/27/72


> I you think that is important, feel free to write up.

I am curious how the software development attention will evolve further.


> You have a parser code in the kernel already.

This software component is useful there.


> It might be not hard for you. :)

Some challenges are waiting on corresponding solutions.

Regards,
Markus
