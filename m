Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D246DC8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32DC2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ETks3zot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD2Gp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:45:27 -0400
Received: from mout.web.de ([212.227.17.12]:42131 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2Gp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588142718;
        bh=VCBLXyHbN+UmSYNi6DMunUk1mydYP9IL+PGabg3Jlms=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ETks3zot1Wq0vEZztoyBUywuI818/mHyOwCvVeR3EGFZJ8dw3MI62AN1MTXz9XT1/
         5j27EIlsHVo83MDMZRIA5MFed1wFvoKD/NJ4Gk+wbGwbObCS5Rz60Gpu/RHeijlLAA
         IEumPB5vWBHvedvwVikkKyKZd/yrp3FECmx1z6o8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qOX-1jFLbX1YtB-00z1Mk; Wed, 29
 Apr 2020 08:45:18 +0200
Subject: Re: [v3] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Matteo Croce <mcroce@redhat.com>,
        Wang YanQing <udknight@gmail.com>
References: <20200428020223.GA28074@udknight>
 <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
 <a2d7dbae193800ce430321d3fcc71ab5d1a5ed03.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dec3d317-8381-a4d9-efb9-0418f9b42a55@web.de>
Date:   Wed, 29 Apr 2020 08:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a2d7dbae193800ce430321d3fcc71ab5d1a5ed03.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xtZvzK73ObmyIbNvr+L9ycW8oL/E1kaBiWNSPbAw+rfoNJgf+mV
 Dt0os9512PpE+ehi/jKW0IPKPVZJokwZLv4NuSft+ALW5bzQEEvGDmFl3Ha/JEuPr5q13Oj
 qHmLsBBZRzuKDlNAgBjH45ZEA8KLTufHirA8W6NGgNQyD5hwFYSq5xENreKtIw5/r/ElsXz
 F12YE/67rTd/pguips3cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmEfWquDztA=:S0lw5Mc9o7PmKvmmi9hSnZ
 McOyAlJUTVkC5f/U6YlogujwnBhJ/lXTrSWHmsqlaSpAwR4//+mSNiBhJKKlZsDpBfT+byx0u
 fi72oTXadfMNNkCnBC8rFJZQviDxi5FznH+vK9U3TSW6Kn7m7NGKa97yTOCh2OZNyy+aE6KBi
 3tgsnPznKDsHgTFyTqJqN0D9mukQPes1Yho9OSgXlbuPIGK1ekkvp0evPcTApGu4+RvFxfB+E
 u2c7qI1gvmqN8kvZTuEtlU6JrNoHD7ifisnXMZ6FVQr6eedapsKqxVcU4PGIR4lQQ/4GYWCKs
 g/BiC4+lIaVNdVa4LG20yRwltU1mDjwLifIGVTumEtLl2E0H5PC2BQ7YTU+9YtolNSF2x498V
 InmtmPnNKaQuvNJsSBJlV/z6ldCQFL3ZHokxGPU9FDCWB+aXEoZS8aY7NQBdrlQSm+leCOPDO
 unUj5iIDOfcTmvmQ/Hnd2ksiJ9UdpASOJ9vqigo7+h1A7uqpJv+uUX2P7pQC3MG9ZQhVrYUBR
 Jw054JlKpHSjI0/OMDK6OySUUo3cTIhFMb0DS1bkfSvlV/kRogaVmdNXMyaFx67AaXmewyub6
 o4z3oku7b5MiXf4GKA4B4sJBEQt3NQgd3JHZLdnqxGTXiBnQvjluu6sgmLxDuQ1k1OMcUrW33
 StJ5OI3CQb4ct6RSkKNUGZod9Y1M1Uqr2oVnVNoGzU8S7RPB62+O/JS+YvihOIHhPqIrNappZ
 M4W11X3Go+tjfeIeaQV7wG+fgNixbMXcHeJXsUqEn2CDvN7IYetZkUO/lzMOfZtZEVahcbLUg
 I0XnuEeXWJx0wRS2uhZ3KQ3qNlbXjuJT9sF5SPLCJO/obnBdQYhic3woaWrf1mjIReuNtgm+s
 nGEVXIzgpT6SiP6orkknsZUI1hcEgxCD9mIcBSu1WUKBalkDwGergtk50GjfB7fWsVESPLLmi
 p2s4ht0kRZHNwZXRt4HzKkZGLriXAyiPZuIW0kSieWU0oTGZRSXS4XoV1CN9pDjWawD2wkUAx
 gHEHzAEa5H2c2hIjop08hVsp3RhmtWB/wimsO9rYQQU/05Pop7E4YlGatHii7zNuIJqku4RK3
 VNxoCGWbdk5EuSPJ9r0wx4GwIQRemqFkvJ3/7yE3GJJYW3tDLCcU7wqlVOz1uJXluRivbBEvB
 ZaHjbhFz8T93jGdQtwua2I2/ugFk1YrivabA8rGKilaGcVMoR5f/YC/i1WqgbVo2bt2DB6pzI
 M2GUd8iAG7B7hdc4p
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> btw:  I suggested this patch last year.
>
> https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.ca=
mel@perches.com/

Thanks for this link to the previous discussion topic =E2=80=9Clinux-next:
Fixes tag needs some work in the tip tree=E2=80=9D.
https://lkml.org/lkml/2019/1/17/966

With which script did you determine the presented statistic for variations
in the usage of details for such tags?

Will another update become interesting how often shorter commit identifier=
s
are still published for Linux patches?

Regards,
Markus
