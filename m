Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC2C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FB20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5AZ/Rsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgDEOhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:13 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37732 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDEOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id n2so7275309ybg.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SK0gM5FiI9XuUvcTFvtmQjbWZBJJQIOo8chrmozcPoE=;
        b=j5AZ/RsuWdKjZog+IPmSJ8xEKc+kCYPKGASqxpoZiRUSDzIipgtVU4HSjrOEjHCSQF
         bgM7QXS1VIZEd9ZtmvdezVLiobKFngS8stMwtzgr2LLTuxX9W5N8rgFRJpfwM4zHwYHp
         1qMgpUyYttbidGObst6ryCYUavhxDltWQElPE4M9R9CdtA7C4Q+iOeDsmZGomjz87fTm
         BQz4meXv5ahOAwDFftNU3JwUqSEMbdvm4Rwl4tzCTZ9KIVHb8Pfw1ACkZToIuzfdJBGm
         cQh4RCx9EyXmmk6n+30X1I08dQPxvdSZNiqFd4CoUVfTi5+9JKLx7ygRhRBpWsGZ4yVI
         /KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SK0gM5FiI9XuUvcTFvtmQjbWZBJJQIOo8chrmozcPoE=;
        b=dHO7TX3Hbx6rH5liMzYH02BSnXTp+4Tz7CQiBWbjlnuQrsEcEYsKCeWb2X6saPiCMm
         dG96+KRSLbnCdjIoRCR4ODSU92iqLX85W4NFXDWm9RnTyB8e7cDxOZ15YC0ZCbbwER11
         TpgL3yrBkRDHD3/QKGie1XyVysWQ8QHCWtreVkN4Y9KRI1vyR3ZC1BnyCpFkmcdjpX3b
         bq2z3D6/pQjLN8vuLv5PYAhXl5dxg2kqWrhHlnVh1VkXIgE0ResJbwwpSnhY/7J/yC9t
         q6SKTU34T9VVVx8vjhmIqFvz4MEr01bbBsudnnwiFyBVHYFE0SX/qg4l+b1I8iAjpgzZ
         hKJw==
X-Gm-Message-State: AGi0PuY11bHyKrPR3xFrauNOhcmyoxAcz89jBNpqGftjP14zLbBxlsSS
        3thvuererjQ7JkgQNrEGa476n3pghjxRnSKqpIg=
X-Google-Smtp-Source: APiQypIXLNvikhWh1JwSWqmiAj/CdMw3jmv/ihkLr5mX0EIzMKlQDZeFeXPoudR2shtZzU/LpUwGxwkMhW1FBSIMzR0=
X-Received: by 2002:a25:e694:: with SMTP id d142mr29195012ybh.490.1586097431973;
 Sun, 05 Apr 2020 07:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-4-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-4-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:00 +0800
Message-ID: <CAEUhbmWxFR3VX7BkJt6Nc1t-QF2Q+GnXH0_B8QEbgTADcy7+RA@mail.gmail.com>
Subject: Re: [PATCH v11 03/11] RISC-V: Add SBI v0.2 extension definitions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:11 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Few v0.1 SBI calls are being replaced by new SBI calls that follows
> v0.2 calling convention.
>
> This patch just defines these new extensions.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
