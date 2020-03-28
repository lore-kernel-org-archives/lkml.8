Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE5C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE7D2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ljF6dsXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgC1Ijj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:39:39 -0400
Received: from mout.web.de ([212.227.17.11]:34149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgC1Ijj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585384756;
        bh=qcoJ1WC3ZRioG5XHLONOakP3pYmZoLjAeNjlsz6LHyc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ljF6dsXxHlcw8aqy8Wnjwd4S3i/hWCRWv7g5HSn8gjQnatyELvlAPkxNiAQGf9MK6
         D63jXc3M6tOxNxrTJb8Om3PFD4eoE11gU1k4uAsP0AmBeT+9AnCGXFjMMKQxTfeTlg
         dlkna+DrVZVTeSmw02Yh/7vr6ulIIZ+d1sGVuS/Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudGm-1jR9WO0X1U-00zqde; Sat, 28
 Mar 2020 09:39:16 +0100
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
Date:   Sat, 28 Mar 2020 09:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OFU1ymAFyPEQuZp1d0fVlBTHINhdaFGpXIUvb4FUB/hlAQd4Rl0
 KFrNqVI7S7OJnv3pQHArNv6qWtJkd4wInZy8ZqqPxvymfqss30dOS8y4enSAcg7AcY/Ctk6
 8xctk54xkmotiSG4YHhva5C5lR9cuaz7iV8VlQ0uus+7eL4K2tTH+f9kMac5+dQHfsJIVvH
 Ey0ccyLpmfunF9sgXaeQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UhNTkBVtU8I=:jUmai95FMwYGZQlOViY+ic
 jdXYL+XcIDBmq6vR7DqUK9GBNUnHJS5mjhoomsEcmj+BsQCYwfxVeGPGU3Y2xAJvOKqju4HeH
 kTkgWgoGM6uZ3xkNxG3KcY+jbj+ecqDsxuznO1gcONtHIwXud+BJAADi92G5OZBLigpPQ8vs5
 mS0IrAVfd936NwgKdiZJ4lGqMadu6fDTjUEaKK2MRKYOth8XJMOSKoaaMC2H7hU1CJuR1PRw6
 BMMulFDFoPaCbO9/S9EZ1OJWJ4xXuvSIhfN5tQWBCSOFKWjeCLyoDfLn7VTiqlM0RAp5YQ4lV
 HN2JMbCJwxGPn7CbXRcXeGS+9dBQp2cJ62VpYASE28/VqoTDqQz5dZoDWsUCnMYqWeEO2BTb/
 QCtdutW0RkOhob//Ma0ljYqO80+V6r4kbIIeDp/IEtHpFYHM5xs0Af4YFld3xKgS8y/BIC2ou
 n+7cJdCCOPyxmhuZ3G/Iy+V7l1x4sYyVjg462RgTSbvzybqCzEz2AbS4e+U9LMYYk/y9xFQLv
 tw8Jvv6X7jTxvs0F+jxIxa+miWmmhpJPJLNXYpnnN3sAbcEZSfF0RQZtG0NDKfn55gVRgW2xj
 dwdCL95iVy3Eku02yCHTPBP8lcQifh2NlUB0/Pmj2aRtrEum3+zZrY54dsJK97LbxT6Qxd2Uh
 7ML3yXd1Qn9dxIUbTOccE5MguA8uQFILpykWAwv+hz7Yf3nFjm/JHDjEyDHJwmB4TgClGgmbW
 y9tXOFhe7r+XV5PilkGwUW+g9XI7mx0feC4E0qhUDtel/D7pWxwJ+eSVlRfJLHKaA/cmpiYqm
 EizEziKMjd8iwiua9UrhupHdtBh5GJhdCs8ETXwvZZ0PDQd6oJQkXkRCiu3JM6QeKZ+bxY/iK
 ZAa/ANvEJTQsoAyTWeXKFvwrs+j0EgtP4Ux4ZnG0xGV2owkqQK5Kvb9MJ46Eabb8W2wyZg0XM
 lzYyyqamQdWdnzdKKk7hnKN8adBDTcscFXuJKNuJjO5d6Q8BBYDClmHgD0j+eLCcktXEOaeC6
 07ZR1ziaS39Q+Pg9bWaMiLjtckYDENElujIYwL80MroUyxn19jXYjh+YPsvKafaSM2ojdvFX6
 GYJdASj4DUcqmaHGHhmwMRHH3+GbAOaTmw4DowTob/8yQd+vIu0Bei8u4MrtfMDGgaPUay677
 0jgCtPXp29l2XhodTtzUC3lmoSu+W2perg2YDAZiA7Zu3sYY3jxaroW41xwFWZU7n+4F8oJlm
 Si9zEGYd3EgZZlDuf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I would be interested to find out why coccinelle wasn't able to do the
> last 1%, but only as part of a long-term learning process on getting
> better with coccinelle - =E2=80=A6

How will corresponding software development resources evolve?

Regards,
Markus
