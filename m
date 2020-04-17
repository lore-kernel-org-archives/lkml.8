Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2355AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E609421D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jJaoNQrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgDQMks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727897AbgDQMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:40:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:40:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so2889161wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hw3zBq2iflGKeF6TIA06foptPhPCqmQ4gALSXVPDoYo=;
        b=jJaoNQrEIBPf8c+ShjvPCVr441gyQQerRqJv93mnrEQA3Xj+pLqdOzATk/Rn2d6mM5
         3QOcSW4fe/9UKaVuVYEHRDrU8RkNrG9QOrLRxAsWHkQQi2tSBQ13I+XF0EQBrqVA3bra
         sIKelGB72/XTdlKCQox25CECzSE17EDwMta1XSkH2DLt217o/7jDjJROmpFDxwtrWNRU
         vHF1nnsGUxzPphnUY7UhD+m7rnI2dyvzQLLjsrqI69ekVOfd3E2mdhSIIQIbXbKphLkq
         I9wQtMALwtQYIyiBTVn0d8qzFf20+E0n3CIBqQ4Ea2FXzt3wIoqvj5evJQ7B3R6Hcd/A
         QQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw3zBq2iflGKeF6TIA06foptPhPCqmQ4gALSXVPDoYo=;
        b=aoHJdxFfxzDq7VKnNJF3QpwHUBk9wp5yAX9rvyhA+vqHggN1RPJ1qo1bNDU1nBhfV0
         8IE9Whet1aUZ5X4vlX7OsoM4ASzovkaB1wsTGa3uI4beT7gu1rJ0tmdesCq2mXpRx8ZJ
         7T8Hhs6ZLodQK9Gmqdmb1vpDUbAiQkrUfc6VUw8AF0zfVg4Xxvm3ebtY9rys7JUc7/UO
         QAPdE491UlrM3ZEXugqMbmN6Rn9O1F8V+g4HIxih+oPNfbbdnhGP965MezGxHswsZGjo
         +D5ABDSs/hiBwv69MThmgKeFMX3aIwQ9h//jFzVHr6QD7mwIHp2185rXEaPRnYqoe5Sx
         wthg==
X-Gm-Message-State: AGi0PuZV9G2jSubd2zIQdu7QrAnrM3c48YbKXh7G4LKLA1RHfm3z6rS2
        wKy4husYwX5qLgT05wWZ51+oSLvYE5bbgRjDi9uS5w==
X-Google-Smtp-Source: APiQypJN6AKoUZezns2JYdhqA8iYyC3VPzV6Le8z1oI9oshNNiKtXSuZACI1oSLtIfdlgPsUtMjg1TAGYQBxVtgnw8M=
X-Received: by 2002:adf:b35c:: with SMTP id k28mr3718749wrd.61.1587127244899;
 Fri, 17 Apr 2020 05:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Apr 2020 18:10:32 +0530
Message-ID: <CAAhSdy2cFnYM4Q03nCUof33KwtfDhefvZVc044ukcjSa+CaYZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: sbi: Correct sbi_shutdown() and
 sbi_clear_ipi() export
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:40 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Fix incorrect EXPORT_SYMBOL().
>
> Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7c24da59bccf..62b10a16c8d7 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -102,7 +102,7 @@ void sbi_shutdown(void)
>  {
>         sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
>  }
> -EXPORT_SYMBOL(sbi_set_timer);
> +EXPORT_SYMBOL(sbi_shutdown);
>
>  /**
>   * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> @@ -113,7 +113,7 @@ void sbi_clear_ipi(void)
>  {
>         sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
>  }
> -EXPORT_SYMBOL(sbi_shutdown);
> +EXPORT_SYMBOL(sbi_clear_ipi);
>
>  /**
>   * sbi_set_timer_v01() - Program the timer for next timer event.
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
