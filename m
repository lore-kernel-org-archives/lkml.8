Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F133AC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C720718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="IL8t3Uqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgBQFbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 00:31:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgBQFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:31:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so18066635wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 21:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK8OjVx+UrlFpp7xoUR1rRApkI96TZRdTAo+J2wgjp4=;
        b=IL8t3UqzajJ8X/Va2bVJn/7/EnDmBxTC5T3DlaybGhuCCl//pvqxTZNF0kopfHdzfo
         cjNjQSLU6K3XvbxKh2ZcpySu6e953c3lgMTIHrjTORqzIgjVOkq0nR6aF8JzDAoAaRv9
         o1PGO8RbOgWv3kE0UK6ZzZlMBqm+zCR8upj6HwuMbOu1M+EUztm7RPAG/YPe7gXQ9c/I
         wv/8giNlnCfHC//hrLvzxWBORlf8+ZFMyv/VWbvJp5p8nyNZg32OrBQfuO9FYuYv4Nnk
         EIR6VGo0hLxhF9fWi+ocm2EzMdmGi7hsJWlZGL5ziWzY7xrdu+tR8Ldxz9IMSBCgLAQe
         XyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK8OjVx+UrlFpp7xoUR1rRApkI96TZRdTAo+J2wgjp4=;
        b=LDeUXEaBx2M5kWPtWdWux2+e7YNjcrx7hYHlDSmfjV6qGpd0w3ZK8ThT6zs7hnHo69
         fuvC/c5eds9DcuPn06USQ/N1wZK2szooBj+Aoe4NHSB9LvGUCEVC6f8dtsrFSgBCL90r
         LLAL2WHek31MDVOLEL8Nc3XksLvJbei/IEjLlq/StI1mGItLUn/PDKbR77J+F6P8ViUX
         OwGvk+PBAIGor0iEF7jAP1/eDnf3GakKMpNu+tGqbtCtWDcodPNEHoyZi+NLGqTU4lwA
         CLXe5NyUvwzNZex5nQ+RThA6UQJWbwOUWa8FFY9AVLJe19VynKc6csJUA9o0W/PsbVA6
         Ru8A==
X-Gm-Message-State: APjAAAUe5SbpK3u9rLORIXV+bjR9j6vh9jyCsA+DpTWOdHo/C19AetSs
        qils+v/K/mLOMMNJWM1L+lr+X0vEF84ssusNSNNqHQ==
X-Google-Smtp-Source: APXvYqxqiMYGPOfmAIxWfpIMpYDldi/Ms8VKDS5YeyS1wS56OJ4kfXS7npV6dhzi2WYsmwLbCS3e32Ft+dyEaXMatgg=
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr18846622wrx.381.1581917501593;
 Sun, 16 Feb 2020 21:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20200217052847.3174-1-alex@ghiti.fr>
In-Reply-To: <20200217052847.3174-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Feb 2020 11:01:29 +0530
Message-ID: <CAAhSdy1aXUwCGYK61BeCXd+w-oEyf3=ZJmS+HM0mUxV-Paw-Rg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix range looking for kernel image memblock
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jan Kiszka <jan.kiszka@web.de>, stable@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:59 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> When looking for the memblock where the kernel lives, we should check
> that the memory range associated to the memblock entirely comprises the
> kernel image and not only intersects with it.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 965a8cf4829c..fab855963c73 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -131,7 +131,7 @@ void __init setup_bootmem(void)
>         for_each_memblock(memory, reg) {
>                 phys_addr_t end = reg->base + reg->size;
>
> -               if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> +               if (reg->base <= vmlinux_start && vmlinux_end <= end) {
>                         mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
>
>                         /*
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
