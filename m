Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7DA20674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KirK2Giu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGYL2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:28:48 -0400
Received: from mout.web.de ([212.227.15.14]:36503 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgGYL2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595676482;
        bh=tL632JoesBjA1nIjOOtilNQQx0JJmdlSdql+Vgh01R0=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=KirK2Giuq/oI0i9/TOwFC7RXcEVUDLETNSS3bDPmLGguFu4QpmFB0EjuKG7YQfUTx
         n77JiO1TlmZo0+HhUZ4eX2jVCRvM8NSU4hdo9vYBMBNU4BayknUHNvcgHob8NGp27H
         SmOsXcr7SZGursUrDGx5OH6y0WmnC5AJf/W0wfQU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.94.55]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8hxz-1kmhdp2cDb-00wBcX; Sat, 25
 Jul 2020 13:28:02 +0200
To:     Yi Wang <wang.yi59@zte.com.cn>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-sh@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: sh4: Fix reference count leak in sq_dev_add
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <12d84b44-96c8-ee11-fff8-b1a7ea6b0d7c@web.de>
Date:   Sat, 25 Jul 2020 13:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bFIRIPpz0mwd/cEGOsK55a8GXJvnM2pc8bURK7XeKErXRWl7aJn
 +GvcuU4gLrwyL7LKdv5kRg/eIAGScGG5uMzJHwmVJen3ACg+cXpLA8r8PNreZ77AYoIF70g
 CSe40jrf0WRB6tmoNJpW2WcTbYexM4OgSz5p0nVSzpiPuDs+0FBn0xs+3GW6YCG+5PtzMb+
 fOH1wb1VzuKcH4EjsBzFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IhFmOiaMMh0=:/xAZbNULFM+YFruV7Bhasf
 CjrEQuyG8fc8TEQoFPuoYZlYIzBMSwECYS5Fg1FSJt6EfN2qRKpRqW/saAQr2cSuDsQ1WRz4O
 zLltHWydBtRzJtXitdcnqFoMANVUF2zusw0bItySYlWfjv77najf2OibKI71oKKq2n3uS4krA
 eWY729dko+qS2n8tnP5Wn+ZK0NA5BCPBtz2T7QqfWzzI58YFEJU0pXTs6q1XSIpYm+1/zpzbI
 XiYswl/8lpMVAJfwm2e7BnBSroOmgZaOXqRI8WccAXlZSftRPG1SqxiE1MSUDdThWHqFPczUw
 ZbH5+gZPCq2CV8hQGWDH8ZlMhfHasLRg9KRxum2zGqBze4ySjHGCPUHT+IQoo9HCTOByOECHk
 xPJbq2s6hWfy28jN18t3KxxFTBxIt8fvxrtYupiLe5+eEI7SY3tnm997cNB366J+V99GV68FT
 +vkc1FG/vdiQv/MDyNr7Az5SYXct1dVBWmGRtr3j10gC0ZB6UKrE4W/AXPoNY6fb6grRdfJ8v
 Lpy0wkMrQvZr+4rDQX1fvFlcFgGGyKtMps9/WEdx3b+wOJNaGjJNaoA1jU75QORbzpZqq5P5h
 yM4Ta5BBEtm2DKKh0o8FQCOrAIMpkOJrK6My+bMSvG8ax7/ijIEAtI2Q8qii6NuAPjg3JBSQs
 3cH0Re5eFTqcWSN0IsXDZYLVIK9PtI52K25jDJTtIRdtEgkTuhyJU/tc/fhhei2j9VSjaAe9h
 i0MvOwpsQ3KJU3r0uAMfJDFG6y+y42kCNzjOU9NE8Z9FYNGsEWl2v01v1wGuo9S5Z/XPBKSlj
 Z7vXB4WpUPhTiTm7WvW9nntS/pJGNWMLADX9kBtxc78dlGGMpz5vCWbLTs7/e2KqcYHJiBjHM
 t9PZc8UU2cXOSTd6S8Hbe7sM/PoFQe/tNv4Hr+OL7F7XXn4cNuoAz1Jl/YDzqD/eDYnpeAHhp
 nknrn+bZ8oPP7rYp3ImWEOM5Ztd/OkBffVJqmeWnLf26K5dGIdIKYHNi3HTLkTnjIN/4KGjKX
 KAI7XKNzRW7JT02c1cyzin/bXCz2Jz0JZ+n0ZJQZ4fFCFoyuHyz2GaXJYLA85+IZFXh0UbyD3
 YApPYfmtPt3AXTJo1ITiV+c2inD+k4IBmz9gx4mZtX1HQ402LvBBqUX+SGiiUB6ozlav+4BYW
 SZEI2Ug49YFbZo5RjJwCyf6H47DMLS3Iyby7XBDS6yh6xdlapOPdwV8fVdyzcKYwsu/ysMT6s
 964HF7j5aY0b4nuqmdHF0vo0nn2tgTtmo4RGzmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kobject_init_and_add() takes reference even when it fails. If this
> function returns an error, kobject_put() must be called to properly
> clean up the memory associated with the object.

* An imperative wording can be preferred for the change description,
  can't it?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

Regards,
Markus
