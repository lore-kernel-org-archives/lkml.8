Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A20320801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="E7+n06UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJK4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:56:42 -0400
Received: from mout.web.de ([212.227.17.11]:41369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgDJK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586516187;
        bh=fXhaD07NjfL91yOXDHRZNEEr5NaybQZwWj/cYtVKaAc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E7+n06URj96WDpmyDK3LfmVGzuxk09r0cv1Q1etwWrDl+mYMsOB/5ChW0XvUIuvEZ
         5vjvEpfaqqjSGMYWnkdhWG7NVYyKmsNs3lcuxnklcWFUUFFp4Cd/rw5mw9zlEuWxiZ
         nmTm+uEIgi9eCXBSP8bl/G4F4bmJgSwRuidFFZ2g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.107]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M41Bm-1j5se90ySA-00rXpN; Fri, 10
 Apr 2020 12:56:27 +0200
Subject: Re: drm/tve200: Checking for a failed platform_get_irq() call in
 tve200_probe()
To:     Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <0263f4fb-c349-7651-b590-8722cdd30c85@web.de>
 <20200410101831.GA27723@ravnborg.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <235b500a-0e5e-9ca3-4be5-9026c7d9f87f@web.de>
Date:   Fri, 10 Apr 2020 12:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410101831.GA27723@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C/jrja9K2QgghT7CCmZZh7za7qQGU/Lep6p/xvtDn+QNIDIBWI/
 bn2Hrp3KtYDnliCSyLnaOe56I1z8IMrzhQfikOM3tJinmMEFA8Rn8TFfElR111FYdKAgyrC
 ciWaYnARttCLa++GYym0LjCe1sGFJt/Amsj+RjhNSBG/p2iUPb/v6rJ5lHnSVF3A4ycacDJ
 ebn9jBSjcR4AvGBG8mdYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6e2dTCMQjmQ=:b1/6dD52FnISJ5L11D1ORW
 lHvxfXQckmXVXirdiuJTDpsvQh0ZkN5xHVFvG2sfjZf5rsVeGhQdZ/wkfNzLnX9v0a0HHLqO4
 9AUxr1c96dL4JagLdbSw+A1MQW0N5BRmrG6RZsg+/5H9aCpwffDzHsYwGdRbaoy2jM8GIwc8+
 3cbUSYTJB6LMXoQiJ0ocj2zjOg61AwxSTvRDGGrQYsulBEob8MriIl+j15mkAGUtwqiElqk53
 1OmIWI/ZhPI5sDB/V+Ck/CfoY2P/oGuZ6J88cR1A5clhDNs7FV9cPbMc3OAiL+oDM0VkofR7b
 1q9Xm65gFmHBVhlzmkECakXDsY3bCVMnJIROqkMgfDDi1AOJ65T5+jk+/NjJamFLrKIhMatGj
 2KnSGeJ3nDfWZGFl5WkkmvzhLYe9fW4TH2ZlVFMwYRdjs1ISrRVn0oEDl027aCkXtCckt0jA2
 0vrr1ZuG93BlnAtFJEu0MVTPJMDW9Td80wubZUYjEYtH65xS1HzcRMPggLJGRfKSzYVjVgO0S
 wOiBjaQatidcTvYjlaOblYw/bhzvNKfLcUoc6fCmhWhGIAIj2OVKU1ypKqif3xm9Xl/Jy/rVV
 aXmLHAdsL5Ag+8x2QJd8J/gAboh9H0HIq5wBmR64G05dyn6eJpX9KxFIBjXw9GoqCnPyBlKRI
 NU0qo607cqnE8cjiBLNbVpRnHJkai6Vs98t0NFCoO5bdZHZQlLSqbF0YrkF0Ezrr+6We1FXdC
 h/ByV+ykNVoCYqKeVcCA4cq6WbAW2f5kZjIiMrciWvt4z1xHmAtJWlq4VczzRyLgRiMzJhV9R
 QAOFit41IhR9pc5JF3uJ+Ofa1JnP4TKpnIlieiU950kipIM/wfancZj6o/Euksy3U34MJIsWM
 Jr5iDDWWB0moAsgnAdzcvS7WbZMOSYrllpthm6/rgnM5d2WjER6MRb0nHa9rBMJOUuvLEhK86
 5b/yWVu/U8oKlRIOA++xsmCrQzNLJo6vYrtChzmUuNXTO5xC9PJT0NE8u4lyGQZmJ5/mS+bhb
 nlbjmWlYIlHU4whb8Jd/g9CsBLhuth0C4LiUwOudnfmld4K1nzuiKxpaEfoW1PMyUqsOfORVg
 ErUnNvA0wjois3gJGT/KFzoV+jf8DdxevCWqyGbpcbeKVIXSDfEXIrlyArfK/SdK/GUGvpGhS
 9LbHiwzvkKtq7k21vrsYEP41FM5w5921QEa/yPq63W2BgM6qM76VpZpYXJ51MqZdcLjNYrW+D
 BCkS1SgfXcryWezl4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The right way to check for errors is to check if the return value is
> less than 0.

Thanks for your constructive feedback.

I was unsure if I noticed another programming mistake.


> Could you please audit all uses of platform_get_irq() in drivers/gpu/

I found 20 source files from the software =E2=80=9CLinux next-20200408=E2=
=80=9D
which seem to contain similar update candidates.
Would you like to clarify any extensions for improved applications
of scripts with the semantic patch language (Coccinelle software)
for corresponding analysis and transformation purposes?


> and send a series of patches, one for each driver.

Do other contributors know the affected software module better than me?

Regards,
Markus
