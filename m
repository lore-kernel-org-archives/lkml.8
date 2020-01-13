Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46B0C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=home.nl header.i=@home.nl header.b="XTtBie20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMIDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:03:21 -0500
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:50976 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgAMIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:03:21 -0500
X-Greylist: delayed 1196 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 03:03:20 EST
Received: from [212.54.42.132] (helo=smtp8.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1iquNf-0004wq-1W; Mon, 13 Jan 2020 08:43:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=home.nl;
        s=201809corplgsmtpnl; h=To:Subject:Date:From;
        bh=TGu8NoaxKCdJqQiP9JNgMSAX0ttQWysOYpO3o7vAVQ0=; b=XTtBie207viyxEBG8Oet1+WVEG
        kIANqLyqma7/8HhPvbUjgvfqv1FeLyRkSB8SBGK8ytVKy+XEseufN4Ev5gVZx5VZMsMsQ60oAGY2Z
        iFMqhHSXdCE6K1Y+bHTwMv6U/2FPHg1S0TfsL4mQXirO9m+2SLyCZ2QzWQrdIH4tB85TvcgV04yKE
        R0Xa5jVkxEfGdVWJhrNFVS08lUE859/TIFCpli9xH/CQRjme0N4ES2DRa+57lyZCYnihTDFnNgrCu
        GVTdGKnvFWSQX5vLe/7b3dF9e4nJW3ZhOCyv2/ER5NqEbEmDtg65xA2ksNEwpVND5xxMZgSXebqIT
        oT+rE2bA==;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
        by smtp8.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1iquNe-0001C6-Td; Mon, 13 Jan 2020 08:43:22 +0100
Received: by mail-wr1-f48.google.com with SMTP id y11so7427950wrt.6;
        Sun, 12 Jan 2020 23:43:22 -0800 (PST)
X-Gm-Message-State: APjAAAWN1I08BeokEzc8gVaRAT2F5RsutcK4nYh1W3H0Be+4OHqYm4Qb
        MgKOSZ+2tRBdbxwLUlJ081U4UfhDWjGMM/kNCLQ=
X-Google-Smtp-Source: APXvYqyaEuuvIhUNL9YnSALhEjJHnvg56g9AjV5DK4akoL154jJ8OYKXBejja+UT4joB9nzgXUFpzDnSU6w+ajvRnOk=
X-Received: by 2002:adf:b60f:: with SMTP id f15mr15921972wre.372.1578901402698;
 Sun, 12 Jan 2020 23:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20200112165613.20960-1-geert@linux-m68k.org>
In-Reply-To: <20200112165613.20960-1-geert@linux-m68k.org>
From:   Kars de Jong <karsdejong@home.nl>
Date:   Mon, 13 Jan 2020 08:43:11 +0100
X-Gmail-Original-Message-ID: <CACz-3rgg+SkZdkMFZH=vOwZFeD1dbOzoVHAGH55Mqkaif7YhJQ@mail.gmail.com>
Message-ID: <CACz-3rgg+SkZdkMFZH=vOwZFeD1dbOzoVHAGH55Mqkaif7YhJQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] dio: Miscellaneous cleanups
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Philip Blundell <philb@gnu.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.221.48
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=QpQgIm6d c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=tBb2bbeoAAAA:8 a=il4OBXxbQfJCqSgT4nEA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

Op zo 12 jan. 2020 om 17:56 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
>
>         Hi all,
>
> This patch series contains miscellaneous cleanups for the Zorro bus

Zorro -> DIO

> code.
>
> Geert Uytterhoeven (3):
>   dio: Make dio_match_device() static
>   dio: Fix dio_bus_match() kerneldoc
>   dio: Remove unused dio_dev_driver()
>
>  drivers/dio/dio-driver.c | 9 ++++-----
>  include/linux/dio.h      | 5 -----
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> --
> 2.17.1
