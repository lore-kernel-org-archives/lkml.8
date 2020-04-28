Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A46C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RgHbtbSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD1KxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:53:17 -0400
Received: from mout.web.de ([212.227.15.3]:42609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgD1KxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588071188;
        bh=MuVgc++mK1LoWNYOk+q2KcESKGNFPp/aLL8KlvUH+Gs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=RgHbtbSsazkbszQhoU375M3MGYNDvQLKmMHoYFKItv3VmMrnfc4DeGEXpFfKNsk4/
         PYsQn7j9Sw3ZPnkDrvQtEMUXA0EOA46pkSFt3tcTQ1SX4aWW8Jd7aKtePyyIVHrn4N
         g7bleMpGVjttU8dBxvkHjC8luWeYr77dowMS5k9I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.179.255]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRzYo-1jacsz3aCA-00TDQr; Tue, 28
 Apr 2020 12:53:08 +0200
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200428020223.GA28074@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <38e1a926-53a6-bda6-cb07-2614f4c682ba@web.de>
Date:   Tue, 28 Apr 2020 12:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428020223.GA28074@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKYuo3VtcPy/WpQxFfAYFZ+4mmQ7Yk4hS39wdYgPgrW+R29Y4Iy
 K+yaGL8E7gOgSXLpIIEUIBm31JqdoQWr2CawQjohzk3DFkYeGVCdt+wWKZVwfo5kC4aCTQu
 2J6NV0QK88qEnsZGFifnMCptx22GC1POT4wIMQfFa4Sl2ELWfNOWGPIBxXD4saySsQ74IGA
 bRKyjK0GUt/spzB8DZuBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SKe5jNOUlDI=:nacpSeCOguexjVHhQWvj5w
 nvIlpcInm1WOZOtm0oyxJ5ujgwhqjo86w9iOoO7PkAEqNkuqOi6k+RxmHiM0TZYOCNpzs8mp6
 NBdkMhXxRRTYLzZJO2EQuS2PQVuv7dnJdHpyVy37WPTLMTA3YeRsKunlQqmookoExWUHshYX2
 j3W4fnAh9S3Cwn11Lr4kPmGjDjK0i0EErgxr+T8Rdh6VaufppS2rqX89Vwn1ftrL58mj3F2Ah
 naidg2warb+82F6f5gLA4Pnss1nRzaWLLXnHwrCs6xuL6Dv6GVFUNmIS9JIb76MHOccKhG1+m
 kzImckkIOeu98lzQ78Cz9H1fR4sUY8pudwWMUKlUdHkbDtv8kRgDQ7LR7HsI5FXTb2rjinDld
 Jr2NE5HwGXOU4Rbej54cRsaDAmpFGjLmbGop1R8EUe2tlpsSHz///XhWUMz+jRif2MZlcgQKO
 o6MaMcztXsH865cJC3JiAu9ygYgWO/YpmEZmOjmfeXTcS6ELUG3ND0TX7gdKdmriwHrrcB7VV
 eGsZL2CtdbCaDzyPfJNwPT/4LntDL6f2DZSv7ZRbjyog6oI2bBNlZk1H0qzVVLLKKfUzaEO1Y
 Jw9cxeC+1JqAW+wREQ4RoN9S/PbA9ao9v55PCFkVkg8AJUfXb/kHTJUaq0C+odbcGGn2u6z4V
 +CzikrJveJpkSDF3hModLIn1fqBAi71w35V6684cbSb3GIsL4Vwe51/grL0/Ym/3+Cp6xHgeY
 YuI1grLWmHvS6IgMh3uEojDNJfUjNw/XgZhCQPmqVK2Yj4xL/sOx2bPAMBmKp5d/F7LSjR7ox
 nHmXc/mFZbB1nuZU7WSwWx4NjE/3GUWYIxG9SGp5U+b9QwgdEZU1nhh4Q3R9iAJ3QA0wyMpmw
 TYPWk54sr0O8bqL6ucHi71phHOmG2m4EWiLETbTotO0lqP235ZuoeMgvYjN3nhRAx2fIf17Bq
 jQHG9Dki+KJI3ikhedzuFBIRN9PI3jYmiK4opwU3fqI8AhCva/ov/mfepNeJcvOWXRMCpmRdX
 eqSwMbFFlXJOrdApPBE/JtQZPDhxzpfOPBMlDgX880WkaQ+YNnwHpDh5DPD8hz0TA/5GUX2eP
 FAm4WXOwaGdols5U3cOcgJM+TUmJvWCMBVLkrnud+I40XSP2S5qoE5jJeGEoE7xP/twwHY6DE
 wWLXtc8WHiJqjsx47hzU5Dn+pTCiDwvVBZusqYpdehClByth555ZsqDmL5KjfJWUQ2eSArPLV
 Z/xTYwQ2csk9lkL5b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And there is no 'Fixes:' tag format checker in checkpatch

I have taken another look at corresponding implementation details.
Will programming challenges get any more attention?


> to check the commit id length too,

The mentioned script contains the following information.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/s=
cripts/checkpatch.pl?id=3Db240f960afb900e59112ebcfa5a759bb0a85a14e#n2818

# Check for git id commit length and improperly formed commit descriptions


> so let's add dedicated checker to check these conditions for 'Fixes:' ta=
g.

How do you think about to reconsider the usage of the word =E2=80=9Cchecke=
r=E2=80=9D
at specific places?


> +		    my $id =3D '0123456789ab';
> +		    my $orig_desc =3D "commit description";

* Do you try to extend the existing software analysis approach =E2=80=9CGI=
T_COMMIT_ID=E2=80=9D?

* Would you like to avoid the development of duplicate Perl code?

Regards,
Markus
