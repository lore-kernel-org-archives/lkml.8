Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A87C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E504420702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="PoaKW+Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgGFNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgGFNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:32:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C9AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:32:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so32874105wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ko2w1+ycEur/pfHrKptDPRv/FO4AoLBCTaMsUEWlZHA=;
        b=PoaKW+Yz+CyO9ACCDiOplerrz2RgUUNWJ232tMWiok4Z7kOpmuuTIx/NfRflNAQmUv
         mNzSDmrvEmiUnrD9dz78LDRo+SxPWFUA+n+hQTHsaqbpYgZNtBiS6IP6Mvm+kuS8RNaq
         Cl3rs3xK94dUtlu9FPjnZru4TyqusrmB+5oxKEsIvlEl5WX4YzHuZQYj19Yv2vXVF5mm
         KapHZS61RNuaZUz/LlDMVLOo+nY9UV/erIZygQ3fcKZfgSeIijFZedXYPqcdIyP/WVva
         jT1Pngr0Yz0u+oWv/dg6k1qEXqwCKKdjwY5/0A3uXHwD1kaRCg2CBsBU4h+ZiSLdC4Th
         1PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ko2w1+ycEur/pfHrKptDPRv/FO4AoLBCTaMsUEWlZHA=;
        b=jRG3h0WbU7WNc5bVZQrFvS28Kxs550JM/8sm8Rl0oJTMOCGC7Gpdjwp46O+gdIYJaO
         cWKPtBaRbFhncyE3C5BB4ST9pvlIe51fK0tlagALRvAQ3F27uDNdkmlqhorZf6NGdywd
         F3JBFgZeSoslGWIhUfdNaTk/oJBXcuMeRjZFf4w1gPs3pSmeocJUMXf1zyK7EakXiJ9K
         Yu3T4ufu1H+eOWLpCVl9DDkQS0QEpASOxn53rjR1syeXu3pBrj8WmLzPvXtxsGxPsvj5
         d6CzfEc2olBeX4jLW7DKZKq8x9wVHpdSaGfwbsg0B2j8A7f4PrWAxvzBoxArPbzM7yae
         4YuA==
X-Gm-Message-State: AOAM532ajn+tR6wEBCc3k0o2lr8RZvDu0IR/pkZUsk7Gfn7ClPbfiZ5J
        pTGzq97MMsQCwz1UFABsJFfhxiYpD8KV6+1c8bJv2tDz
X-Google-Smtp-Source: ABdhPJy+b4oK+stysikQj1MtAzUoVr5iiIUynI8OhGa5g7IJ/LIa2IUN1+VKuIkcaMKbKNOMSzo5MZNW5ArSDO0FpAQ=
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr47894756wrr.325.1594042342000;
 Mon, 06 Jul 2020 06:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <mvmeepoddt1.fsf@suse.de>
In-Reply-To: <mvmeepoddt1.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 6 Jul 2020 19:02:10 +0530
Message-ID: <CAAhSdy2c6t6TkwCCU+J9iV0jynNOyzm5fRcXz2CwqB=hhvJC6Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: use 16KB kernel stack on 64-bit
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 6:02 PM Andreas Schwab <schwab@suse.de> wrote:
>
> With the current 8KB stack size there are frequent overflows in a 64-bit
> configuration.
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 1dd12a0cbb2b..464a2bbc97ea 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -12,7 +12,11 @@
>  #include <linux/const.h>
>
>  /* thread information allocation */
> +#ifdef CONFIG_64BIT
> +#define THREAD_SIZE_ORDER      (2)
> +#else
>  #define THREAD_SIZE_ORDER      (1)
> +#endif
>  #define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
>
>  #ifndef __ASSEMBLY__
> --
> 2.26.2
>
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
