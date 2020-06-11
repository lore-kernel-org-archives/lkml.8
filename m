Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B8A2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjWJ5w4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgFKQO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:14:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA21C08C5C1;
        Thu, 11 Jun 2020 09:14:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so6795039wru.0;
        Thu, 11 Jun 2020 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SolIPmozBB2ZLWoQdcEzsstEXBuvXqWYFKuIfcs8t6s=;
        b=SjWJ5w4xHDdm+cik7nA1m2oHO2nRqFHg/o4sEHRA627CqlAkPmCZSrsAa9bR7dEUyQ
         PlebGiUAiZfUkiwghhyzljsYSEsePw2XhhINXw2wnpQhMAft8DuvHRWYE4Daj49PrD9U
         W9PpPCyZGVd27JmXmYDRSoJU4p6GdIUsG894vtwwEemFAJxW1bWa322gcOQNsyw3JFR8
         0oquQXmmj5XkO61zEH7Aba+Hc4ap1c6VRX0djSAWXbwOKsqh1P+yGgtT+94A34u+BwZz
         EahR6cRPoTfu6ta84w3MMbCa/G9HktksOMKoHfZOujylMEDxfMw2cMZCk3hqxMa5AeWN
         eeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SolIPmozBB2ZLWoQdcEzsstEXBuvXqWYFKuIfcs8t6s=;
        b=lRxYuhsQvWH+IJOYO4Ne9DcyQ3AyH9B7R4+hELPy10QYu73kDjN6GQEzqjWPbThJjb
         /5vilQKv2SdZYG3isX22xURfLst69x9odxbv3W26RZRPT7IZDO4+x3sZfz2v4N1htMzK
         qXWWInkagDQDqp3DxTV7APEribdLyOyNRM27ddnCq3V+RUbAHza1Lj+JxXWaRiNj6WDj
         1P/DwvhfBqM4jjOC2+U752aL/2uSGxjHDwzZfi2NRwvzuNTFGK313ijlAclxRgyBBQ4P
         xYOTO2g1mp9zWBUgwg6MqPlQLG4X/+dUfiM5GTn08BEdFKFEKRrTv7s1Yf6bVz5W0rhx
         Nhcg==
X-Gm-Message-State: AOAM530RBUSEZmRJqjrdS15iX9GZPHyhES8A1LZMccAOd1+5rnZqwWCX
        +NmbvBSgCwuQRVD/CoAje9M=
X-Google-Smtp-Source: ABdhPJw0jC4Gb+rgPGGdw2rNC7+qmgLdf4kWd8TVSDXhKRIXvPuE1fcGDR2NrUsqVqPi7VldhKTohA==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr10808207wrx.326.1591892062584;
        Thu, 11 Jun 2020 09:14:22 -0700 (PDT)
Received: from macbook-pro-alvaro.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id b8sm5878699wrs.36.2020.06.11.09.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 09:14:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] mtd: parsers: bcm63xx: simplify CFE detection
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <715b0947-f4dd-0c04-5c52-5da06c04d665@gmail.com>
Date:   Thu, 11 Jun 2020 18:14:20 +0200
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        tsbogend@alpha.franken.de, bcm-kernel-feedback-list@broadcom.com,
        richard@nod.at, vigneshr@ti.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DC0E349-1319-47FE-8565-9B30C190EACB@gmail.com>
References: <20200608094053.3381512-1-noltari@gmail.com>
 <20200608160649.3717152-1-noltari@gmail.com> <20200611095540.250184d2@xps13>
 <779D37C7-58CB-49AF-8739-C34295B86FC4@gmail.com>
 <715b0947-f4dd-0c04-5c52-5da06c04d665@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> El 11 jun 2020, a las 17:42, Florian Fainelli <f.fainelli@gmail.com> =
escribi=C3=B3:
>=20
>=20
>=20
> On 6/11/2020 8:16 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Hi Miquel,
>>=20
>>> El 11 jun 2020, a las 9:55, Miquel Raynal =
<miquel.raynal@bootlin.com> escribi=C3=B3:
>>>=20
>>> Hi =C3=81lvaro,
>>>=20
>>> =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com> wrote on Mon,  =
8 Jun 2020
>>> 18:06:49 +0200:
>>>=20
>>>> Instead of trying to parse CFE version string, which is customized =
by some
>>>> vendors, let's just check that "CFE1" was passed on argument 3.
>>>>=20
>>>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>>>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>>>> ---
>>>> v2: use CFE_EPTSEAL definition and avoid using an additional =
funtion.
>>>>=20
>>>> drivers/mtd/parsers/bcm63xxpart.c | 29 =
++++-------------------------
>>>> 1 file changed, 4 insertions(+), 25 deletions(-)
>>>>=20
>>>> diff --git a/drivers/mtd/parsers/bcm63xxpart.c =
b/drivers/mtd/parsers/bcm63xxpart.c
>>>> index 78f90c6c18fd..493a75b2f266 100644
>>>> --- a/drivers/mtd/parsers/bcm63xxpart.c
>>>> +++ b/drivers/mtd/parsers/bcm63xxpart.c
>>>> @@ -22,6 +22,9 @@
>>>> #include <linux/mtd/partitions.h>
>>>> #include <linux/of.h>
>>>>=20
>>>> +#include <asm/bootinfo.h>
>>>> +#include <asm/fw/cfe/cfe_api.h>
>>>=20
>>> Are you sure both includes are needed?
>>=20
>> asm/bootinfo.h is needed for fw_arg3 and asm/fw/cfe/cfe_api.h is =
needed for CFE_EPTSEAL.
>>=20
>>>=20
>>> I don't think it is a good habit to include asm/ headers, are you =
sure
>>> there is not another header doing it just fine?
>>=20
>> Both are needed unless you want to add another definition of =
CFE_EPTSEAL value.
>> There are currently two CFE magic definitions, the one in =
asm/fw/cfe/cfe_api.h and another one in bcm47xxpart.c:
>> =
https://github.com/torvalds/linux/blob/master/arch/mips/include/asm/fw/cfe=
/cfe_api.h#L28
>> =
https://github.com/torvalds/linux/blob/master/drivers/mtd/parsers/bcm47xxp=
art.c#L33
>=20
> The caveat with that approach is that this reduces the compilation
> surface to MIPS and BMIPS_GENERIC and BCM63XX only, which is a bit
> small. If we could move the CFE definitions to a shared header, and
> consolidate the value used by bcm47xxpart.c as well, that would allow =
us
> to build the bcm63xxpart.c file with COMPILE_TEST on other
> architectures. This does not really have functional value, but for
> maintainers like Miquel, it allows them to quickly test their entire
> drivers/mtd/ directory.

I don=E2=80=99t think fw_arg3 available on non mips archs, is it?
I=E2=80=99m happy to move it to a shared header (which would be a good =
location for this?), but if I=E2=80=99m right it would still be =
restricted to MIPS.

> --=20
> Florian

