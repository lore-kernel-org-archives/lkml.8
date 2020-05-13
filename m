Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913CF20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="WVkzwlpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgEMVOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgEMVOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:14:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so6640440pjs.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Uz9nKjyzBvX3Z4DCax30kQ0R3wJYCQylCQFmxXOLegM=;
        b=WVkzwlpBwQjpu4x+KKlzKUJUU6cft6mHPVuspHWs4HG0R1rBhtrqOb5O5vlt8PYln6
         2iCnL3187fBHhPkag8APA6XfAAuU5MAJRN3xy1zWcbODx6G83mzzeWRLpXTCWjfso0tH
         Frw5Hfk2et37CFBlypU36+0RLd16EwZacEalMK2H6iygVeuw0QMVOUnOFrT3l4hI5bGr
         4aYTYUtvhYexvOW3jU96O1r/Y0Sfvqe8MbkU9KtW7kkyzePjxIX48fWg+HTzDn99cJI3
         BeTCz5rtJbpAlkwdMT5qnpPJUvj9H6NrYUewbUtYHU8DpxM9omIT7gjW8UUUj7FhbY6c
         K0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Uz9nKjyzBvX3Z4DCax30kQ0R3wJYCQylCQFmxXOLegM=;
        b=jM+CamgLM3zi2dhg55SEKuwwLbCiQi3v1VXTxpgFpRIqZrrGqIaR7QqYC9E0Gc+t1x
         0wOgrnRp+nABDtXaAtSBTLOvHO7R0XwY+YN02Fa/9IajL57PGqdET1IZ1CM6wx0Pv5zH
         xzWZOs6Eq7T9iTkWJHTVypTgUtWb5gpz7gIKq5rtHXuT2Pfw405yh8k7Cz45yHAD2/8h
         dOB/jZiG45+pBv1u2t9z1wZrxyjh+Udlvr/Yd1+eCPLljKi7aTSvqB8yoR+zRq0MD06J
         e090JvrEUWAQDdsVnT17+aFjalVyPnLbhq2b48Tx4qRPFJC4YpvBrHK8P1m96kkW4Ekw
         uMkA==
X-Gm-Message-State: AOAM530C1h0h7W4gxwYJPXNCHZ2fgmy9bYt8BiElephbTd0QQHLIf8Yi
        +4GDKSrqUJN6Zc/M3CQpcf0eeA==
X-Google-Smtp-Source: ABdhPJygjqB1SOHxlgUauEI8fTi3bHJPUt7nznvEgumBWYg3l+f++5tMOzqwHfbKe66LE1ZWKfaxbw==
X-Received: by 2002:a17:90a:21cf:: with SMTP id q73mr10395521pjc.230.1589404486290;
        Wed, 13 May 2020 14:14:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ft14sm16123887pjb.46.2020.05.13.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:14:45 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:45 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 17:30:43 PDT (-0700)
Subject:     Re: [PATCH 07/10] riscv: Make SYS_SUPPORTS_HUGETLBFS depends on MMU
In-Reply-To: <20200511022001.179767-8-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, hulkci@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-0f72368a-209f-4659-a092-82e479b21a06@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:19:58 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> HUGETLBFS only used when MMU enabled, add the dependence.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 494e670520ae..d0010ed8e0f4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -138,6 +138,7 @@ config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	def_bool y
>
>  config SYS_SUPPORTS_HUGETLBFS
> +	depends on MMU
>  	def_bool y

I don't think this is the right way to do this: there's nothing specific to the
RISC-V implementation that makes HUGETLBFS depend on MMU.  That said, SH
appears to do it this way so I'm OK taking this for now.

>
>  config STACKTRACE_SUPPORT
