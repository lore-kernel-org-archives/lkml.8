Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE5C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEA2206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFT4Hm/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgBUOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:52:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42487 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgBUOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:52:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so2450540ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUcPV2GCgbBShPmu+5wSCUq/MqsCE/eLeOt+CIDiVPc=;
        b=vFT4Hm/pk+T31nHv2shjLkufUz5Cr/t0N65CkFaj/Sizr5KyWlSV/Y8NA29qzs6vOh
         MeVM4rhiT7mGF/U9J0cFGfXC4E+d2qDAqZPdYyf3uUynt73NzlS/NfnoX5pYZ10Z9ITQ
         ErD0g67fAiDOSPP9VMlWTsyy0a9280MN8Tm8hUR1x6d71hPtomD5X6gDhYgRAXbkOIHu
         Rg4Z4vTZiQ3yXiMJVD5hNBWS1qYz5mpz2jE7BGQ/Xx8jI98IwwOvwvuNjp1N9YZS3oXu
         XOiP1934f3BQwQA6RTyPXSzx/zD74LqVWX10WsS1osnxtwklXTAqiMZivGo9dEFEuTrr
         fg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUcPV2GCgbBShPmu+5wSCUq/MqsCE/eLeOt+CIDiVPc=;
        b=RFvZ/vVywTrFl3+gRn2/HtfeOgckMDCOs/kyeYzLdnFMgeYpJrC4+1BV1XldAGuogJ
         oR9w32T4AQpuBV4bt96R4cfjLyH/61Q5miH4PQWfXVcq8ENGkjJFS15JIhRUI46b8pcq
         PvY5AEueodZ65BKSFQSM6bNgO6ITd+MEVaZ72dx+c2/AYf0HKVo8N4seHNL3jGPZQGTC
         L3uhYDr+ipBbKGYA/KMQYrIhvVkDU++AOiPi+JLqWSwjHcTNXwqVeP6MVEOVOM7CmGJi
         Tx2v52Yw35sFbotZuWPKLQtkqe9Z6ZO9hjDewiDjbkm/xdSiHiI6FuUZsS7L7KRbtsqR
         a+FA==
X-Gm-Message-State: APjAAAVZnwncja4rdE2FcZMrAq8hxnJzD/VB62WiuzSwFxsyxFU0NWXi
        Ce/C+R3bN91NLOq5B/dpm2u2wwVCyLShzHgTBGeEJA==
X-Google-Smtp-Source: APXvYqx7QzoUceGSUDS+UZI/PhAOHRPUfSUKows5za0erhmg+mfzJVs2uibGsDolvZSJht6gDa/ARZoYGCtEGtkDG/0=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr21788556ljg.168.1582296723350;
 Fri, 21 Feb 2020 06:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20200219094702.6463-1-brgl@bgdev.pl>
In-Reply-To: <20200219094702.6463-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:51:52 +0100
Message-ID: <CACRpkdZxBcrXFMWDXddUGdQQku_FpdoojSq8-VBGjHHShWn0mA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use gpiochip_get_desc() where applicable
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:47 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Whenever retrieving a descriptor from a gpiochip: use the provided
> helper which checks for errors.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied!

Yours,
Linus Walleij
