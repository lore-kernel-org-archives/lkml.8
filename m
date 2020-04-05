Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919C8C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A420672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy0QItI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDEOhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33693 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDEOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:02 -0400
Received: by mail-yb1-f194.google.com with SMTP id e17so7299367ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+0oq6gi0wf3iq8XzzSoBVpcUbwLNgP9dCzzwQG51v8=;
        b=Qy0QItI/Sxccq8Mx6NyTNju0X63Ern+3yjPAQzPZ3PZnd5zwCCU73bRsjl8J3KjMPK
         +ksBj+1poYsE1qaKzkXWwjGu/t6HMYFh78NpvlNWNoxQcBnHkJMMtzBrRcbLcKu+Uiue
         DFIM7Oi0kjRjIc9nP1OYGNP32mJYulYNkJY05GncZ17Bmxy/GBzEIVgEPjPiYhbEAm8z
         D+gE1Zuzolkuhsj6iwpHOoHFO2SHX79F4EzpkX6vM8Nt7KwFo0gavGCUij2B3rndq6Zo
         t6mo+wlQNzu8nUtYdIfuuUA80XkWGDTCLF1W7PQ7vHD71yFlEWemoU2c7n1LjAYUPLLr
         6fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+0oq6gi0wf3iq8XzzSoBVpcUbwLNgP9dCzzwQG51v8=;
        b=i69AKfpFK+jkY3QkOEJwbw2cMyeSV8AxEUH2ym/6tA+R1dd2NCvUR07ZVGBXferru/
         Wlojt3xhy+mvdvCM0/ebQBkBDTGEivTysvIZdYyRHzynh2kmY38YKt+H+gA31kQmAaQW
         BX3BKbfH6x07SIRf6simyGypwIM4ueV5AjqVJfSnE37B5bCCEhq//Nk4hQ2SIG74ZJL8
         XjxZy4lLIdlK9k2bsP8EnV7t7b02AGSF6WWkHj5P9+gxTS0SvrSkTY8wSki0LmDlZW3r
         4LI7pyL2oUQpfqb7v5zvtYGI3wThwFWPCdrg3J2NHapieigrvQrCXAHXAAzFX9jUSbhO
         NcHQ==
X-Gm-Message-State: AGi0PuZJU80NZeY4yc9r/vWDNokr6nkgIy04KvX5Xz3lzF6zr+xWUXbh
        R1+ALzYeMZCdLkDZSFnsZT5zu6bylxAQZyZJq44=
X-Google-Smtp-Source: APiQypIZ0P+jq5CeAviX1igg1e/s/YixfBJUfL7aJ2yu+ryeRm83nd3f9MCaMX4yJ/auCG4qVzendli5XOUEhd4fg0E=
X-Received: by 2002:a25:5e03:: with SMTP id s3mr30139069ybb.203.1586097421687;
 Sun, 05 Apr 2020 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-2-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-2-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:36:50 +0800
Message-ID: <CAEUhbmW3tkOxu99VHhMCOSFoonp7Z9TuNsN22JBhYT7a+2vk8A@mail.gmail.com>
Subject: Re: [PATCH v11 01/11] RISC-V: Mark existing SBI as 0.1 SBI.
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
> As per the new SBI specification, current SBI implementation version
> is defined as 0.1 and will be removed/replaced in future. Each of the
> function call in 0.1 is defined as a separate extension which makes
> easier to replace them one at a time.
>
> Rename existing implementation to reflect that. This patch is just
> a preparatory patch for SBI v0.2 and doesn't introduce any functional
> changes.
>

nits: remove the ending period in the commit title

> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/sbi.h | 41 +++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 19 deletions(-)

[snip]

Other than that,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
