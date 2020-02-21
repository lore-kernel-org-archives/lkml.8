Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF9C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2437720637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uDyg6dtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgBUGB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:01:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBUGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:01:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so404671wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmMw69yF1xjsB+33COeMx7MgH3XoFsnMEnp3FC6eBks=;
        b=uDyg6dtZ9smsx+eqycwjMVDhcPmlDEP1FZK5nl/O2qvCxKvW1P94PT8OnzZbHwCJpu
         aN6M1H98LeutAxEAsUOtYbTjq+rVGdUqgZRvdwDbgzyvTAQRoDVZisFPZDjF/CE0YUnC
         79gvRuR4oO27/YGdnNKEEseriACNpkx0xVTJ3QFQUlhSI33+LJafkcVNQCnHiQtZrB0o
         ghUUHwvrlhn8PiFdgTV+ffKNK5dVIvOyIn0fsO75TJWs4w+Jl4Qm+FVtDLtgn7ZKEDhd
         if4toeJjJuDjr0I+ECLbTjnulqYAvq4asTBj7oHOkCq1kJTnxlpUnWOgwYBZsz7QCfqX
         1OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmMw69yF1xjsB+33COeMx7MgH3XoFsnMEnp3FC6eBks=;
        b=RnpH1YrhLQZpzUxlIKNpUXQe9L1xs8iPVKR3SFC6QzfdKyMRQDR5Z0bh8iOOcHJ71o
         BbGhnbmA4PeAt/Tb0AAVUOsZuXdw0XSUczZS08na2DoNZSrc1F07mYuSe0z4lKt+ItaF
         oLntjrNAJom/Yw0Et8l5SK2UvYI+nprp1/UVagxBln7OBBmm9v51szhaxNr598rwju35
         CaoICSLhAJ4TBLV1iMBFA07GkdCYn3ak68Hr9O5M6t3kXjlA9LaPfhuweo/kPA1mOJ0K
         aYgO6urldFnh/hjeVxrmiiO2jxi9sxXSAZOLrhbrOVlCfGjYqOmSnS3U+XiUF4T3cg7a
         NLOw==
X-Gm-Message-State: APjAAAW5INPNl0LYkzg5Tak+YYq6uS2uB3ZtPgVZJM12XB2uOTuqC5E5
        05JmQpGv5p8rfkulZ/hQoROICZ23pWJGPNf/8pFHIw==
X-Google-Smtp-Source: APXvYqwSbWQx9lHm7xKEsIjxehHLlqsyvfT819rPiihd+ZTdxgf94VO6sABql9l/fp2RHuPgOyZ9ySzu33XnkEYOvEE=
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr1460069wmk.120.1582264882627;
 Thu, 20 Feb 2020 22:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20200221004413.12869-1-atish.patra@wdc.com> <20200221004413.12869-9-atish.patra@wdc.com>
In-Reply-To: <20200221004413.12869-9-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Feb 2020 11:31:11 +0530
Message-ID: <CAAhSdy0QE+5dXZnnzWaL-6GZCEN8FhLQY1f=kW6ZdEmaCwOxYg@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] RISC-V: Export SBI error to linux error mapping function
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 6:14 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> All SBI related extensions will not be implemented in sbi.c to avoid
> bloating. Thus, sbi_err_map_linux_errno() will be used in other files
> implementing that specific extension.
>
> Export the function so that it can be used later.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 1 +
>  arch/riscv/kernel/sbi.c      | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index d55d8090ab5c..abbf0a7d3b6e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -130,6 +130,7 @@ static inline unsigned long sbi_minor_version(void)
>  {
>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>  }
> +int sbi_err_map_linux_errno(int err);
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
>  void sbi_set_timer(uint64_t stime_value);
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 38ec99415060..d0c9516b6c0a 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -46,7 +46,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  }
>  EXPORT_SYMBOL(sbi_ecall);
>
> -static int sbi_err_map_linux_errno(int err)
> +int sbi_err_map_linux_errno(int err)
>  {
>         switch (err) {
>         case SBI_SUCCESS:
> @@ -63,6 +63,7 @@ static int sbi_err_map_linux_errno(int err)
>                 return -ENOTSUPP;
>         };
>  }
> +EXPORT_SYMBOL(sbi_err_map_linux_errno);
>
>  #ifdef CONFIG_RISCV_SBI_V01
>  /**
> --
> 2.25.0
>

LGTM.

Reviewed-by: Anup Patel <anup.patel@wdc.com>

Regards,
Anup
