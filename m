Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A7C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC40206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WTwkUEi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDSRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:09:20 -0400
Received: from mout.web.de ([212.227.15.4]:34069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgDSRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587316155;
        bh=x1gHgVLBr9MTx7hPtqahG8DOkzRn3pwA6OhyJkKQ8dE=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=WTwkUEi0qwJW4kZQ2SEEadv6DaF/ZQPB6z6er4pggMZen330JHih/J82eY9/JeCLL
         hcWKIHwrvgVfWJNvBr2PZwM7Z5OCnndGXx0IgmqA+iDcP2U8mnD68qpe1T34lXV+j2
         3U8B/hZBj/Nn0/pe7M7QFS1hR4hrk9O5gI/WVIVs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjAt-1ik1nI0r3H-00hrP4; Sun, 19
 Apr 2020 19:09:15 +0200
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v1 1/2] regmap: redefined regmap_read_poll_timeout to
 simplify code
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3376dcba-4285-c894-915e-2f41cbf23caa@web.de>
Date:   Sun, 19 Apr 2020 19:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUiDQShDsKKuJVPMv4swtE3GElrKhTotPfuV7m6ASt0C6jMC32O
 lIAOR/Ps7E5XLZBegFSFqZDBoRFTdOpYws4uaD9WlAy249KE6D2vF5lJvOW+UyXVpGXeYej
 KdpZ5Zu14eK2QB5yCQe41MYBI1Uk4f2Jxfaij+g64KI41wkDfzvjel5/9tB2SbiqJO48Fz0
 h3dvJR3yHegijqxAo6csw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vORQKCk9158=:opqh37s3z9T1A67bJFRFoO
 uWbK3HgLQv35+n1MAxyquTjFfG0ftg5lNJEjS5oZN1JGbVEXyKt2ijSlsJfh3JrViXdOqtTJs
 t2SSkq3HtWt7CyZm18g0Z+KYksBnzjgAnNaBFJl0GvcgNLctclo1tMmYZMIx9lTcdKlS1AGc+
 YaBjF4IZ+9JvXlMPVCjmGFsemeGFMOBAioHFm0sLYACmtPAtZK1GZoW3CN9e4ucrJaTHCWfvZ
 Brk0vi5O2zSMDpdaf62v9pCqTGJaWnexkzD02FjCxvFtUM4HRFOq82RmVT19Q9WORf50f3qhS
 gNzBV0qfYLh1Cd4RJH80m4MHcxJOkr9Z40knJQE/qaBI9jJkI6ygOgQWBVl72lmQFHboRIIWj
 jbd5TCpuIV7pYYlZQRnp6p3QFoHCeZT6wlPRryQAkV1Me8B09W5MTb/J8dKC5ksETNpXPBjGG
 72dEmqlPGef3Dwwm1cHxtrTybtx+W1wtX8jkg5tRBTOQBZIDj4nqGFkHcrA6ukHk8UGEQ4Czx
 KbSqE7XgV465oxErj75tZMYMhQiHPCIA3SOOcINwMNXRDedeEWNLmOFO6ItLl+JhNdMcEd826
 4C7q/H45pJr/NJZBhENvFKTmv2PX8H8lGAFeKBbRgGCyhN5YC195Q6heIELquKxsv3PeNhzH6
 B9qaixXo4kYbRpJtnSnDOuOTAmZMirkjhhxDAYCeY8cDrs+uhyOuFVXOf4ObpLpORv/gbp+eD
 AJnZa3ZdTv6enSb6cJWTXXz2iDMQLKas6WRbC+opJXUZcKSt4cV8AxryGjvUIdE1MGERjpAXo
 IHMMw2WZUHWfaGukCmhrSiZlQKj1E5EEFnF+PW2VoPCDdv5aqIM+nDMYkb+eZtP1/vlWEb/UF
 Oj6gzb0FlPosGdNcHu6b7izMRD6kyiSpiCKPex8XB8vDIEOhcIdv4m0wcmxlW4Lb0KUtP0sl/
 lB7zmbWuI/jK3xwMAzOTEkw0kygsQ4fY7va96VYwUAx8oBTEaKBko13bW1TTF3jfbQcEoYm2g
 4GwqcVJ+PH/3vLU6yaWDkUQavediv6OPNzA0g6TjWSPEDd4LHT6gJo4tvTu1ysn+kHCg56jpb
 IUVsUQvXqr2J9rr2ZsqW/yZ6GZ3JUw4HpWwKdkEEKNWivXet7rKO2qMRei1F6gJ+tFO2qOikS
 KTTVlZYnYzFJkqi8SAJUbqjXmI/kf4J298im2Se4QQIZvonviLCiwH4XP4x9qxOl8ugxM5m5g
 GoZcxU6Q/QyUzfn7+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> use read_poll_timeout macro to redefined regmap_read_poll_timeout
> and also remove the duplicate code.

How do you think about a wording variant like the following?

   Subject:
   [PATCH 1/2] regmap: Simplify implementation of the regmap_read_poll_tim=
eout() macro

   Change description:
   Simplify the implementation of the macro =E2=80=9Cregmap_read_poll_time=
out=E2=80=9D
   by using the macro =E2=80=9Cread_poll_timeout=E2=80=9D.


=E2=80=A6
> +++ b/include/linux/regmap.h
=E2=80=A6
> @@ -122,26 +123,10 @@ struct reg_sequence {
>   */
>  #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeou=
t_us) \
>  ({ \
=E2=80=A6
> +	int __ret, __tmp; \
> +	__tmp =3D read_poll_timeout(regmap_read, __ret, __ret || (cond), \
> +			sleep_us, timeout_us, false, (map), (addr), &(val)); \
> +	__ret ?: __tmp; \
>  })

* Can this macro work also with variable names which do not contain
  double underscores?

* Can the tag =E2=80=9CFixes=E2=80=9D be relevant for such an adjustment?

Regards,
Markus
