Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0651C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB72D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="FSwI7Ok+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgD3SXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3SXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:23:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:23:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so3138801wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzID6dyyEtHnb8W3jUC+1MMjyOI0QnfADZmAC1ounFo=;
        b=FSwI7Ok+WljTVqHuemSfgBv/l0IPhqe998/WQWww0qZd4jkx/oFKkGXTNi4jWZwtti
         MRho365ZHO1V33E5E1q6Y2VY+PO5wNd5GVfdPXWEK/V8/zY2Owg+oW/HR3pGcU30Mq/Z
         vo3ZN2VBw7fklcpV/jZgKkSyrG8KCx4b6K10I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzID6dyyEtHnb8W3jUC+1MMjyOI0QnfADZmAC1ounFo=;
        b=n1ip5uU4w+NUkMJdazY8NPzx4U0zh+xGrz31g/Q2jteT3UngT7b/XcxTsyO+otTt/c
         y43ORDZ5f191Xw2eb7wvXn9rvFSbhziN8dUT9F9Rw4fZMkUmvBCQjZpzOeLuQyu+/d13
         INBTn1C4HfnLBXBIO7ZtxxFXvwKB7nhBe9jaVp6V85YQOsOEJ52cClNxYz1STe9K57Z+
         iNf0BdiTsGflu2FbQ5QXD7zPaad/URUx/6GtzsPIfwgeff/mVgbovg0x3TwjwLPxo41h
         +Mlf+FeIiBGblfARPVaL6k/jkoRCCtEzX06bITAn0oxZQ+dzMIws3B3zn8uNnorx4R4k
         S59Q==
X-Gm-Message-State: AGi0PuaP8u2BUpwXFbl+fMxfhcnJVmyVOOSohAlcg+ikcXOqawFJfd5v
        CwoOo2U6ck2jhpO5Oh6+jkE9hU87o8mRFQLomHqJlX0=
X-Google-Smtp-Source: APiQypILI/sgZPbbAbvkcpFWeJGx8Ba1qT+Ddq2hduj1iLMhXXXt/vK891UT4CSsJL6MxfikcWFDtk05fG+dazKB6/c=
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr4348218wmj.55.1588270990928;
 Thu, 30 Apr 2020 11:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095325.111441-1-zong.li@sifive.com>
In-Reply-To: <20200430095325.111441-1-zong.li@sifive.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 30 Apr 2020 11:22:59 -0700
Message-ID: <CAOnJCUJBJ3wrY-KY3YgD-qJfr7dsWzdA83fxFYmOTmjsrYgOfA@mail.gmail.com>
Subject: Re: [PATCH] riscv: force __cpu_up_ variables to put in data section
To:     Zong Li <zong.li@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 2:53 AM Zong Li <zong.li@sifive.com> wrote:
>
> Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> Currently, these two variables are put in bss section, there is a
> potential risk that secondary harts get the uninitialized value before
> main hart finishing the bss clearing. In this case, all secondary
> harts would go through the waiting loop and enable the MMU before
> main hart set up the page table.
>

That would be only true if you are using random booting protocol with
SBI v0.1 implementation.
With HSM extension in place, all the secondary cores are waiting in
firmware. The booting core
will bring them up one by one from cpu_up method.

The HSM extension is already available in OpenSBI v0.7 and Linux
kernel 5.7-rc1 onwards.

> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/cpu_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index c4c33bf02369..0ec22354018c 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -15,8 +15,8 @@
>
>  const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
>
> -void *__cpu_up_stack_pointer[NR_CPUS];
> -void *__cpu_up_task_pointer[NR_CPUS];
> +void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
> +void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
>
>  extern const struct cpu_operations cpu_ops_sbi;
>  extern const struct cpu_operations cpu_ops_spinwait;
> --
> 2.26.1
>
>


-- 
Regards,
Atish
