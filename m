Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBCC2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E4206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI+/uhwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgDEOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:21 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37738 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDEOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id n2so7275388ybg.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfgUAunoLM+HahCbkyo4i/ldtjZiqNOiQU1VXreBYiw=;
        b=KI+/uhwxvtydGdjySRjob/lIdKlJiII/vA6C7rFNTo6dRVUCMw1eHiLDWbMRduMKTi
         JDYBCFYX9jDDi3eV5x6NzGZpgOA1g8AWDT/kyR8L1jIi5fhGuhhLrnlpUyig25SvqjsA
         vzrWjKaoGQi7v9sDdvvQmcnY6RdwFu4JR1A9hYNKKIIcuD2ta4KS7a9CvLBM6koAoyXQ
         cMs+FPo1fRbgHSiYoLyVtUVoIws9u74miY2liE1WtnTc3zuQIrYbcuFTIfA1CbgVCGx1
         kUq/2ZQlVIEhIKDt1aPfollhYqOHyxdydBrN6o6nw/fXoBeuc/UgjR32x9zWcw1gjikB
         2mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfgUAunoLM+HahCbkyo4i/ldtjZiqNOiQU1VXreBYiw=;
        b=bLrGQAwCpTLXfVYF1Z5NfM1wVsdWBEmORlTObgHxQ4LvVtxrfLpZ4/AXVDv1MAFGUn
         gROy5t6MCMvjjwjzWR4sMWZPHHKE+cQHCiFE6A73Us7wu4USR+6KV9XrKjx8j+aL3J38
         6GZK/wc/Fd9vU1GeZImwhTliQj/LKMpU+wDFqzhxm08fX89dmCqEYoC6sBbaYd1NUJs8
         5bMvPsJUDow8frGD0Pmp9nRbRWW0pjNuTbAxd+90RaYhMkpPyTTHgkvh7s6of0oBVGUu
         b1oJkSYI8ZDpMfVElPGYWmhMKWStByrYyBpwTGORSwUWA2WQ97xq7eUP5ZBhYn6MrhDu
         jXPg==
X-Gm-Message-State: AGi0PubIwb/qNc9DEquSu6XXHozhJKqHWmHiI/lnwrbWfYn60xpYrYSg
        yr/W9u8nEZhbc1j4hKQog3n5fOdfOPqeupYAvhw=
X-Google-Smtp-Source: APiQypKSRfIBkRfIXFXlJVSLEmw46Q8lLHjNcMsvlZBhlrzpGd282f9HGb54tLnKBbr6tojfFpZXducTqTC2t6NQg84=
X-Received: by 2002:a25:3b15:: with SMTP id i21mr30614690yba.11.1586097437766;
 Sun, 05 Apr 2020 07:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-6-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-6-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:06 +0800
Message-ID: <CAEUhbmXa9xuszy-h0xSwn9SYOdCNwGSh15pAQDYkvs6+7H9=NQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/11] RISC-V: Implement new SBI v0.2 extensions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
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
> Few v0.1 SBI calls are being replaced by new SBI calls that follows v0.2
> calling convention.
>
> Implement the replacement extensions and few additional new SBI function calls
> that makes way for a better SBI interface in future.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/sbi.h |  14 ++
>  arch/riscv/include/asm/smp.h |   7 +
>  arch/riscv/kernel/sbi.c      | 253 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 270 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
