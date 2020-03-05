Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F168220848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="oDU5Pv5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCEPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:55:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCEPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:55:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so2824215plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zlV2/HhklUPk+6HazhFg2c3NcHDRCugdQYzaRPS6yNU=;
        b=oDU5Pv5Tq7eaDkdXZgiOnF2OrFlP5yNMtB7KGbTTN/Bon+6j0m3jnH5bSZGnDWBPGZ
         DPHh0SnpRCxrWkKm+jyrDnIeiK/wGA3oiSLBoX86vLkwwGlV9ytRFKSyIETYjl610/iA
         Gwdmez+Pq2qYts0kAvqLHLRctmWiVhyRfO5Oele2kYtm5nuFkTkBa2/MCTG91LXFaZuk
         A7JJQixojSCqudwflVfKOOJUgDZXKkZSwNavS/lAVo/Ga1Ty7Bblk5hk4aEKJ4+MDjy5
         eMhQLETOJiJ2Psrg4sei318QCkfAXFvX9/XQfVocIjeK3xREXHi92BnFrHCBKrvZKJ5+
         E8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zlV2/HhklUPk+6HazhFg2c3NcHDRCugdQYzaRPS6yNU=;
        b=ZSi3kld1GgkkGjt9ihIqn8vLbo3hiYbzAN45Z6K5xdPrYTKD/G61t9Q1w1MlqiveZJ
         MZqaJHa4T5l38bpgWriinrCupsC9k3Q8nf+PqaTVoWR+AXv04CxOjrpZrrjRYFy8idgB
         B8EdaWN5oFXTG2N1GZOkz7kHveJUY8gE7p04p5vU0O1o+0DY/98AhSCinu53KieAKQXU
         EJRJFQE1Uh5BSZ28bOCfsR4dqSW+ZCzxyntQ5PfMA3V35OWg+ZUN10i5VvWQ1fik6DDx
         tNhnSDIoNYP/XrwGomB5q6lIyJmtZH4w0RrztmAQRlirlCLL7ZnbYzUk6O0YYMdy5NeZ
         xByQ==
X-Gm-Message-State: ANhLgQ1EKHADRCdSDSn1f8QhPtqn3ZNs4196/R1W6KaO269ZL7NrkGT9
        2EP6CfT8gObfmaFQaC6Dlxd6ng==
X-Google-Smtp-Source: ADFU+vujL3wjPEssfVg2CK4Lcyyb6fMr4/WV3FRA1e4Tf9tofUg/l7ANxmbO8T6vy8+++Xmp2K6UxQ==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr8440330plb.293.1583423724799;
        Thu, 05 Mar 2020 07:55:24 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id v123sm7307086pfv.146.2020.03.05.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:55:24 -0800 (PST)
Date:   Thu, 05 Mar 2020 07:55:24 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 07:55:22 PST (-0800)
Subject:     Re: [PATCH 0/8] Support strict kernel memory permissions for security
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-f31549a4-4c1b-4f9d-a034-2d0217bc1ecd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:15 PST (-0800), zong.li@sifive.com wrote:
> The main purpose of this patch series is changing the kernel mapping permission
> , make sure that code is not writeable, data is not executable, and read-only
> data is neither writable nor executable.
>
> This patch series also supports the relevant implementations such as
> ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
>
> Zong Li (8):
>   riscv: add ARCH_HAS_SET_MEMORY support
>   riscv: add ARCH_HAS_SET_DIRECT_MAP support
>   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
>   riscv: move exception table immediately after RO_DATA
>   riscv: add alignment for text, rodata and data sections
>   riscv: add STRICT_KERNEL_RWX support
>   riscv: add DEBUG_WX support
>   riscv: add two hook functions of ftrace
>
>  arch/riscv/Kconfig                  |   6 +
>  arch/riscv/Kconfig.debug            |  30 +++++
>  arch/riscv/include/asm/ptdump.h     |   6 +
>  arch/riscv/include/asm/set_memory.h |  41 ++++++
>  arch/riscv/kernel/ftrace.c          |  18 +++
>  arch/riscv/kernel/vmlinux.lds.S     |  12 +-
>  arch/riscv/mm/Makefile              |   1 +
>  arch/riscv/mm/init.c                |  47 +++++++
>  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
>  9 files changed, 344 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/include/asm/set_memory.h
>  create mode 100644 arch/riscv/mm/pageattr.c

Sorry, I had to run last night without quite finishing the patch set.  Just so
we're on the same page: there's some issues with the patch set, I'm assuming
you're submitting a v2 so I'm dropping this from my inbox.

Thanks!
