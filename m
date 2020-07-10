Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4021C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F4F20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="BumlcOmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGJRaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGJRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:30:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B061C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:30:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so2905787pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NNOpX7zDJV4e6MqnpK0c1GKw6S05vm1dDD8qM9H4QAo=;
        b=BumlcOmRyWmV34V0WnslhAdIOlWLgH0M6des+BNHIMbocDgDL/sGvEV2F232x8Kez/
         txkLpRixttssRpjMpHHHLKlVjaxH4ADaQcwyS13x6TEb/7SkalWdmqb9fyASZ+11Ljg/
         WYsUOaZvojTJDC53BbPr6b1L0FykO7UoEjNrLiY22Aj47LE5SUB8MUk8U1FjOiKiVR8X
         rP45YEcqF4I5hE+JAB1wUGmRMmyN4LHcw2ILoPDj6mbAcFope0T5ttPMVQTYYM5Uo0ge
         uBQgV6WWgIQYjQbl0zGG9YmWmnv7ApKh60Jw2QHUbwEz+kbqL185pz4/qYbIFi9bZ7OD
         EU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NNOpX7zDJV4e6MqnpK0c1GKw6S05vm1dDD8qM9H4QAo=;
        b=h8hBd1Ryo6sRvcNPCLq15LjGiHeNFyDHlCgftyRmx2DK5RxRsruKo4Y7oODJRIr/Vd
         SDJ59GC6pFJl9moxhZ/dSKrEophqsIGz2k0eFy85htCB+bpDMrNIeveLCPGqfVWJrh4G
         EUniLdDOJYM4sAr1FF1kDDkTvNYUcZqfMChvqgJMFnj7gGOSvprs9XInM7QQn+WP4SW2
         CVjR6dwF8WgSZ8zGmj02QopjNTLXmXjlV/3PLcVHgYIkRjkN8Rjs5mnmhDybuwq2zh+1
         w8ujDTShBJiHIJrOi3uP8j6lp5dkGyIq5ZHJC2aK8aSIA8Dx9RXjcFHK96/h7Ax5IObj
         jRvw==
X-Gm-Message-State: AOAM5338u5eAO36oRT6L09mUotH2lAIffamgPq0s5lRAfgfC98vK32dJ
        ZD9lB0wR5a3Xsjcf32U0k7El3w==
X-Google-Smtp-Source: ABdhPJxSBaTuTeaxjBm4A5kHzDSTVrnLGZh3eB75FK+XRaeA3wzVkI7EZNAzLMTp7OVPZTe4x0fSBA==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr36897652plp.65.1594402220938;
        Fri, 10 Jul 2020 10:30:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s6sm6192968pfd.20.2020.07.10.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:30:20 -0700 (PDT)
Date:   Fri, 10 Jul 2020 10:30:20 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Jul 2020 10:30:10 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] riscv: Add context tracker suppor
In-Reply-To: <cover.1592989082.git.greentime.hu@sifive.com>
CC:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-39d66393-b510-4b88-a0a7-93075d014531@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 02:03:14 PDT (-0700), greentime.hu@sifive.com wrote:
> This patchset adds support for irq_work via self IPI and context tracking.
> It is tested in qemu-system-riscv64 and SiFive HiFive Unleashed board based
> on v5.8-rc2.
>
> ---
> Changes in v2
>  - Fix the compiling warning
>
> Greentime Hu (2):
>   riscv: Support irq_work via self IPIs
>   riscv: Enable context tracking
>
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/include/asm/irq_work.h | 10 ++++++++++
>  arch/riscv/kernel/entry.S         | 23 +++++++++++++++++++++++
>  arch/riscv/kernel/smp.c           | 15 +++++++++++++++
>  4 files changed, 49 insertions(+)
>  create mode 100644 arch/riscv/include/asm/irq_work.h

These are on for-next, with some merge conflicts fixed up.  Thanks!
