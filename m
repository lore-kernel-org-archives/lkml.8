Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C139C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CE420675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ELWbTBQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEMVOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgEMVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:14:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CBAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so6640452pjs.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EwdTVTg8mmRP5YtYCIIiQPIfSg8ie3bF4e/q64Mg9dM=;
        b=ELWbTBQYMw1XvDvuC2Kn+oknCOCk7pbhM1B7YzVDAwNi0aBs1VuOsZ+Lj2NrjCP/aq
         UfBUveSRhhzDGbCeDorUGAHsKfupE5Auv/hlDq20Xxi/Hw3K6Cp87zJMfwJPjk7exZog
         XtBvEIqd5heS6wyuxnHMr3YL4f2RGstprKzDmZZurxc6J4C9j4nKx/KPBn9Rg1bk8TOH
         v/d/6N1NOlmgRbHNiOvUAXDVtyFKH9CnQCm1U3fLMNk4hDVVh8vYHOHaQqyM9NNVszCZ
         l1u4Ov4Uz7XlrZH3vd5S8OAM35vwJk9cpeZumO4lGNtIXxalUQ9IXZmSGwpdxmY/3YLP
         TJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EwdTVTg8mmRP5YtYCIIiQPIfSg8ie3bF4e/q64Mg9dM=;
        b=RYjIMLFQ/42O73WMy5/B9JTwCXzlAhjy9zcRpY0wZ3JilEGupWaSYFU+wCRkoykMHU
         qhd4pI7Uv2C4lwOGJP4KYMQ8H4rJPcASBQwErWLwJvxOS3XBvP/4tlRJoeQ9J9HZOvQu
         eRsRCnj4lAoiQCTcbgCCyrNMIXAnWguY20gnCPkh4SLntsiIhpEVeo+vbnSyTZKqAMnI
         Rtjm2L4lIf1bqc5QtmaG0sSotEfSxwCLf69sWx77N/NgQ0NQYNq3aMXN5+iosBKrvkNH
         TMtkSqmEuKIn+r+7mD8lCGHskOM6heACENMyKpfo6Q64U/qiBJLjffeNV3bUJ4xl2wuW
         WKxg==
X-Gm-Message-State: AOAM533gjKq0QQTbpg1nnnEAkhXn2UrVV1oCB6AHHS6EF+M4zcdojHg5
        Vkh2RIoavb5ucvMX7MvKLa2sGQ==
X-Google-Smtp-Source: ABdhPJwGk3yPQp40vsZT1dr+JMO18Awpnqmih5WSpB0ypDAKJcm2uCvFuwfG6YgL1KBBHK/B3F+czQ==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr970708pls.341.1589404487623;
        Wed, 13 May 2020 14:14:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n4sm410257pfq.127.2020.05.13.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:14:47 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:47 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 17:44:25 PDT (-0700)
Subject:     Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
In-Reply-To: <20200511022001.179767-10-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, hulkci@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Message-ID: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/clocksource/timer-riscv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index c4f15c4068c0..071b8c144027 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -19,6 +19,7 @@
>
>  u64 __iomem *riscv_time_cmp;
>  u64 __iomem *riscv_time_val;
> +EXPORT_SYMBOL(riscv_time_val);
>
>  static inline void mmio_set_timer(u64 val)
>  {

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Adding the clocksource maintainers.  Let me know if you want this through my
tree, I'm assuming you want it through your tree.

Thanks!
