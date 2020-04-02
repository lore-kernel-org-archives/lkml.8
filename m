Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E020784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Cb9vLyvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgDBOB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:01:29 -0400
Received: from mout.web.de ([212.227.17.12]:48963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgDBOB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585836046;
        bh=RnDZqNfFSBFOf+KJb/Ls04WWYH/zkvws0gtnPykEYFQ=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Cb9vLyvlRV1/BRnDKN0QR/kcZJU/6fL3JBhycKZWyTHUM78Mbd+kTloBXQJ+LnuDc
         x9XVe5cn8OkTxSyGmbuDLEL71L1koKr8RKljkr8wVhrl/Fxc5P5BxbS2h4qFOrFneF
         8e/GPfVU/SD6Iuqy79IpgMwJcCXqT2HtkgydqkCI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.187.28]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUC0-1ilmde1Cl2-00chVO; Thu, 02
 Apr 2020 16:00:46 +0200
To:     tangbin@cmss.chinamobile.com, Jun Nie <jun.nie@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ARM=3a_zx=ef=bc=9a_Remove_duplicate_err?=
 =?UTF-8?Q?or_message?=
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2b9c1939-ffa6-1ad1-5927-5cc4468ef846@web.de>
Date:   Thu, 2 Apr 2020 16:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pa4kwPKglTVXYeRd3uFuvLpkI8HRuyzACTJVjEVyvz/p+6l3axI
 od64DbaOsOCj7J9WhQdcXNDrDmZF17mEmdNTlFXVTuos8/8ACxNUMTODReJf6pww4YI2blW
 prRNt82S+xw6dLQ7sCTEFp1/NOXHOmOa9DRUvkCmDUsNbrHWXPjubrEHxIyRwT1ZPbgSrWI
 0fGONbECqbJPmN7oLUrOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AKK5ULPWAmk=:tdjZM4v7VpmisprRV8kQLm
 vJ5HVmHsDlkP9aPvMLVey62gQ6I5fny9+HUh8yfiC6O0XfdDfUTbT/HlyPH1rhF+k45mbJu8J
 wuf7RGrhR9z3zbyFFr95pDO/2b/lpJl/ezhmO6agWHXBuww9Tmoqvjbn6xz+Jrhf5V8Q0BkvA
 0oKf86CzGqHZphHbNm52eI9VoleW5v8xFeGh84YslNPsTMeoXBqvwUEBlhnFU2pb+i+WkBOxs
 9zA6dNeLtU++bdanaVbpFYArsGq8pFs/uvJwrwitYeJluP5Wvm4Yt9He2b0utVPPIwMHseWlw
 OTnXuHePS4VMEW6jIJepX4c7+67bBSwy/xDgUYcrM9nXygDWK8YjyYyOO4Za3EO73cGjsrnjS
 YFpmIYmQFybsKVbZaiz0d0hvMl+OLmXepBkYwyXKMIlVSEYJhtNPQvwdNBOVUnUo1UJoms/1P
 N2WZ1yiFX/rttTPDlXqhrQqSg1yGBTmGpJ8n2cZ7SOofsZ68wFXgQIAFNZ7KnKgKX/mGKOCAS
 IMhs3AgkD+5BzEvKt841Am3Kv3qgbkCo2ruhqMX2ejxtJPIRGLJnRuXxZX7vc9Q/gpPuyH9nC
 1u9VqqUU/MN/5tXUQ1yG9aqbdr+ByZiW3WMkJ1iMm32GQwpHHEV9l3yYaNJv7dwZw2lx8xpyh
 qf92FRRsx9f75S0r4eLq25ihF9OUDHy6Jf8CmCetCYEtgH1MDyDW1CmJ5bfKn/CuLO9JOqnki
 oRaVOoQ88BhN0vAJfvXUIi7uhTToFzN9/M5Nti4MtE3pEGyst3du6Z4nRpHf4b/lDBBqWZQZy
 3MhEH6B+Lcchh6K4awyi6Sgx3ZtJz3UlX1/ak0VH9KSERzChBvB/6TRQwjMXO0SUoPXK941d+
 HiiranTLxC4AVrS2aw8LNC7J9liZYgVhfY3q4wMeD70k3E7vYbAieLmOLLkys0bTcWuP140zB
 Gr0dUizne2JnfgEeQR2ofFD47/wTFg8Vx1T3vPnUHEf/iNaRvXiqsqwdHnNu++4ItHI6notQF
 PVWctctwNgfFAvJnHhnwxM4UPhrLVXCgSHNF19z1kB+ZJETpLnaQraEJ72hLLnw2aymFIROyI
 WwEKt0aM9tRzMP4EDQgZC+9dMxYdVIJZO2BP8rh2QidNqM9eygdYqfDvQw+6kDP0xWolxjlUt
 CvoigRI7+o+vbCrOg9klTtDdroigQ9Wq1fNmjQ7Dlm+3bdUI/q825P/K9bPrnqZnuay9kNgOv
 YBNdRcm0ztlNcpHES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> remove duplicate dev_err message, because of
> devm_ioremap_resource, which has already contains.

I suggest to reconsider the wording for the final commit message.


Will the previous update suggestion =E2=80=9CARM: zx: Use devm_platform_io=
remap_resource()
in zx296702_pd_probe()=E2=80=9D get also a bit more software development a=
ttention?
https://lore.kernel.org/linux-arm-kernel/30b6c588-6c4b-c8ff-6414-a3fc53867=
bfe@web.de/
https://lore.kernel.org/patchwork/patch/1128530/
https://lkml.org/lkml/2019/9/18/50

Regards,
Markus
