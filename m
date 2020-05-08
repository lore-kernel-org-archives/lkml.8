Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33169C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F02070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NWZXNzF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEHNoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:44:21 -0400
Received: from mout.web.de ([217.72.192.78]:35613 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEHNoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588945366;
        bh=C15PgIF+OxV54kuqRqyq5JSrb0uSs+zSmVL7r4LIDTs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NWZXNzF++Lx/ecEIg1snHItoDkhlg9MnwwLAul3n+iLEpjmxd/SkblNNrMg+l2fWV
         MDrrPk/RSm5/R2IBFtBnXZpBln85C/ad5TtlCP5jdvdGHbo52NLKDRqdWegfAx60VY
         CUm/n1f8BiTfs+x5WXcu2x11zcg+xaWu68eEV4j0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1iyXjg1eWg-00ZwUv; Fri, 08
 May 2020 15:42:46 +0200
Subject: Re: [PATCH v4] tools/bootconfig: fix resource leak in apply_xbc()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <757dc0e5-3ab7-b00b-11dc-e94a903e3901@web.de>
Date:   Fri, 8 May 2020 15:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1b1WNI1dffWfQMoEdQKqVkDKp7Ltfkj0aF0vAGC1xNkKHNjP/Us
 rX7uG8418Wk/mfz4q+p4WOxJMlBJ+HK2Qzdj+kH4YiwlkQepgg/0k56T2iBaoVv4gM5qafd
 ozr17VRHn7bMXKtPwPSzu+inFuT8sFSBqYMrGR/2bU3bEnaqydcN8zonUGeg64VUgAzNzRs
 VsrO26kGFq+n432iCwoJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F4zd9lxVFG0=:wvgKq/f8G6GbjVDrH4PML6
 iPncoyU0HsjcwaGZNAr2ReQBZJlzXsUxezO1lUp9wAhb+n6PFDWmFOl1kN9+vAarY/F5X1cVk
 eA6lonQgE506htGNmY0ZnJV/VaenjMQnrqsnS2OUizkKHwxYCClj1LFrVwDdvIn45AxlHVi9b
 U5gB4K+0vxDs0036WTX5UHF9MKb515KjuKTGTpmAETfpGGsi/oPYb6/Fp3WrP9UxJwbJJ+bpv
 3IvjjZe7XG9DV05gWQid+E2sdpMo9hYbjFKEV1e9GgBTOjkkDQrUayX2ODG1cao3wktBJMxrR
 4FdDWIqNJfRNDltIigWgRhBB5TcSlItMMOhlrhzp5D85njhJD9+2xOaqpgRIXEDOWPXv61SW4
 Mpc9guuk/SX5yAkVfJWsQdpHqU1W/kD/eWEbpCzhOFRxZ44ewJAR9XJ3RXtXh7UUN0OlQCZYD
 L7ppo22HcVmRf09iPNE9TAE+dyRT8LrgnuvU0HXsN9Jv5S2sN6FNDwHwmltbR6vYsC9jSv3Oy
 HiE/zOqff9ywCiws9+4vxiBg2XVTo/QJQCYMI6KKm97dzVIoLyt2PB89jUeTkwnRv2dqQwHfQ
 Ku9N4cSOz1UT7xU2Lh4RC5Y3AS0VjSHn0+EMeHrn72FTg0j9SK70CIXKVPBGZPfkjqILSCfTi
 wSgV+LXRSy5/8b/zQ6DTUE2eE0QAHFBneizAN4JVtQRAxA+WW7EdPfuJ0bqO1N2sS6n4lMrFG
 oL3P2Ng3f3rNokQ+O774Wrny3qYghH03LxJSGVdo2EKOYgCxxsMoH4amlnZ01+RzkHZyou3GZ
 TH6up6HTfeX/JCfmAa0HdM9w8w7z9+wLT4Mc6xNrg8gpbssbM7FEunQtkzxB4slDaRSplDidK
 NFX7NC+GuoX0TYwrcoOMoALT2/4VaAFL3Xwvq3qqq7GMzKoTS3K7p73Xo4t/E4gI73P9G59eM
 GQy0kgPL3tPm+hILrqeMPRpy+XhPg7+/Rxq3u+j9ELsDOhb/jgzs52T2vQ/cPxo5MXXiAQqxd
 XakW09ymdK/QZ9WAOhjDTmpQkJ7UWeAwDa2OCUXEt2znYpl0xZmdxJawnZ4G/gW6gbmH9nQg1
 pLJI0EvuUzFt3C4ZBaprdJCZgExDakFu4MH7uwVpWhXTMGi75uiIre/zLLAYpq0rif3W20uLs
 5TpcqUUwF59aZYgUJx/y5mIVVsv+RMDIWUwB7pdKaniDLvfCNhLcWVT0Tv4tconYdfegTUxcr
 rtvTeQYE21bnkfhD4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> An error is found by a internel analysis tool:
>   "Memory leak: data" and "Resource leak: fd" in tools/bootconfig/main.c

If such an information will ever be integrated into a final commit message=
,
I would prefer a wording variant like the following.

   Two issues were pointed out by an internal source code analysis tool:
   * Line =E2=80=A6:
     Memory leak: data

   * Line =E2=80=A6:
     Resource leak: fd


Each of these issues has got a different importance for this function impl=
ementation.


> Fix the @data and @fd allocations that are leaked in the error path of
> apply_xbc().

How do you think about to replace the @ characters by other delimiters
for the relevant identifiers?

Regards,
Markus
