Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75EC206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icZ8PQrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441169AbgDOHUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441149AbgDOHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:20:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C856FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:20:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so17651733wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JNTtrAlb/mmW6eYfSwP0Ro8M7IaMvjXCniYxJ2CnwM8=;
        b=icZ8PQrXhCZI6D32MNsceXbhSUdE3ss+k0PgEpqDHKKpUuNLoudWdHM44NERTbVm8o
         LgPj3+qoxx5rF5qJjQv0Y1ykLL37R/dqLSLiZ3J9hvBMgGZ8SBYTXgL4W61sPsaPkkmg
         tj8QWK8y/A2zfxups2uwgfp/r8d19M2NCwdg4cf5sElp5s0no2yDwcTjLX6DRaaNwZK6
         sU/M+nt9Hk9F9avYx4KpUOdeSVd6vX9NBHEAEQ1Uh9M3Esv8cpfZnoAyxp2ig3UX2B4y
         DMziWRGoduMn20Oc0ArYn16VU+Y8rXMG+QmlShsO9H/q0VXyNs0/rf79/7Pg/bvbRN2/
         3Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JNTtrAlb/mmW6eYfSwP0Ro8M7IaMvjXCniYxJ2CnwM8=;
        b=SSnpyDAI68IdOznrCka2Fb5Y7ZL/jlSNMZn/JLBh0EmSXMJoofInftJv2qy/8IfW7P
         E5iULi2qoM6PxEPNjFnKEMR8kHpiBUnlnd3+mW339vo4eVKWUNrS8uck4EGtpmhJ5dr2
         +6Qxy1svrmglEsD5X8Om+acQShPERfDULkl6GyhghkZLrZshnMZY6H1H1Z4MqrLmhnT8
         eLeLZ7zE8qG1HSJg1jPBNRY84YsgYZ1hGBif9XKZGO5Te+f9KeN1LRtpYAccOOj+jqE8
         FPJ8WQ/ilZNdtKePeJR0VigYXNpkSDkRAhKCVbSuKTDfvMcsxt+e1THYqz6zu8ap5ryA
         qrWw==
X-Gm-Message-State: AGi0PuaTw2BliPFFg2cbQ0gkRBqMHuakI7iqhCc3InUGoydPio+qnLt4
        dQGz5vpPvJQxytQvzcZ8vDrJ8Q==
X-Google-Smtp-Source: APiQypIt8y3v1RcXGhlIV5rcKng20PQp5/POLLPotSkVPDavNgF+b9tnwft19fx0HP2uPFDJdrAkQQ==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3649301wmd.67.1586935208412;
        Wed, 15 Apr 2020 00:20:08 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id a9sm16577131wmm.38.2020.04.15.00.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:20:07 -0700 (PDT)
Date:   Wed, 15 Apr 2020 08:21:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?Z2VuZV9jaGVuKOmZs+S/iuWuhyk=?= <gene_chen@richtek.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        =?utf-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
        =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Subject: Re: [PATCH resend v8] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200415072108.GE2167633@dell>
References: <1586273804-7722-1-git-send-email-gene.chen.richtek@gmail.com>
 <0f60497f62d24a37a0530941d6eec258@ex1.rt.l>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f60497f62d24a37a0530941d6eec258@ex1.rt.l>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, gene_chen(陳俊宇) wrote:

> Hi Lee/Matthias,
> 
> I try to fix subject and update again, please help to review it, thanks

Few things wrong with this.

 - Please don't top post
 - Please snip the parts of the message you're not directly replying to 
 - Please do not send contentless pings

With regards to the latter point; you sent this patch during the
merge-window (please pay attention to the release cycle).  Not a great
deal of reviewing happens during this period.  If ~2 weeks have passed
(they haven't), you may assume that your patch has been missed and
submit a [RESEND], but whatever happens, do not ping.

FYI, your patch is on the list - you do not need to send a [RESEND].

> -----Original Message-----
> From: Gene Chen [mailto:gene.chen.richtek@gmail.com]
> Sent: Tuesday, April 07, 2020 11:37 PM
> To: lee.jones@linaro.org; matthias.bgg@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org; linux-kernel@vger.kernel.org; gene_chen(陳俊宇) <gene_chen@richtek.com>; Wilma.Wu@mediatek.com; shufan_lee(李書帆) <shufan_lee@richtek.com>; cy_huang(黃啟原) <cy_huang@richtek.com>
> Subject: [PATCH resend v8] mfd: mt6360: add pmic mt6360 driver
> 
> Add mfd driver for mt6360 pmic chip include Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig        |  12 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/mt6360-core.c  | 425 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++++++
>  4 files changed, 678 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c  create mode 100644 include/linux/mfd/mt6360.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
