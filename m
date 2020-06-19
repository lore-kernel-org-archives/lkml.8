Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6388C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80E206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="TZYvnKIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgFSAbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgFSAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:31:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA48C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:31:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so3612253pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uw4q+6RxBb1gZ8hafCJgFSIShMDUHG3YIGhQQPpjq/8=;
        b=TZYvnKImLRzWawkHleEhvx7rGT8Wk9QkPtu0cMwu1LUjYtRJ+G5DhEXf7YUIGvStgE
         vq3LpzuaolOsAVpzP7w1eHmxOL/BC+nd/zH0RswrD6baAehVmmOCCuAtO2fd+/UAlISS
         iRPvzSjUhcsjA23fdhaGXUQ56oX6w4LilW61s+qQmKChHTeGTlF56x4qaCjJgU+5YCID
         aGEXy43ZoJm6rh1j7UBWQmMCOmdGt6E7hsv9oO54c2LOzAfjOqtt4qt8a1+TT5GKzm0K
         tpXrGOwtjRKs8L0Xu+qUYWji0XrPrU218HIw2xmZRsPnpJy/ujsiln86I2Q6UD1mo7lm
         PEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uw4q+6RxBb1gZ8hafCJgFSIShMDUHG3YIGhQQPpjq/8=;
        b=QPZVquQ7q6e7A4ovwaTaJAWuvVK0oTE3PtsDtclWqawIPKylf/bj6d4r3dcfQDmGsq
         /+b8kwDMmezuV9nUVR/Y1oPXvV2WwtkuaE1W9XZK6oKO9SxYP/hRL9cw3AVIGCi4yJTJ
         3Tv33V9oJJNgw9v9cemYyALgAEsjNoCRBD3tD/p1LLzkuvWGf0TOBJy3FQ0jTJnM16Q3
         poAtKsUJzfShkcGqynNuiopeWwccdRh2cUpRSNZkEwPY02aeh+ix50tuBh78IOYNRI2Y
         t8bcdaB2OXSXx7xbv2OefxrrURfuQQuFfGFQXB/ryoz/AZ0I0oS05i0hrBL4h+Yu1Men
         Uo0g==
X-Gm-Message-State: AOAM530MhrQ3g27p96PAOS47uQC1Ip/vrgnUL/Oc3pslktWV5I7z9enM
        fc/oEV5bd7I5gkoGTV1NUzZISQ==
X-Google-Smtp-Source: ABdhPJwau8uI/KVK0RFr+Mma2bumEKOSrKCg7KtTVps5gdvTpxpwqjvlK9D1HrbNbA9hH6yf7NDHMw==
X-Received: by 2002:a65:594b:: with SMTP id g11mr987979pgu.168.1592526675190;
        Thu, 18 Jun 2020 17:31:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h17sm3338722pgv.41.2020.06.18.17.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 17:31:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:31:14 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 17:31:04 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Don't allow write+exec only page mapping request in mmap
In-Reply-To: <1592316186-1420-1-git-send-email-yash.shah@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        colin.king@canonical.com, aou@eecs.berkeley.edu,
        david.abdurachmanov@gmail.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-f46325d7-1e58-4c03-b345-b39e53cabb12@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 07:03:06 PDT (-0700), yash.shah@sifive.com wrote:
> As per the table 4.2 of the RISC-V instruction set manual[0], the PTE
> permission bit combination of "write+exec only" is invalid and reserved
> for future use. Hence, don't allow such mapping request in mmap call.
>
> An issue is been reported by David Abdurachmanov, that while running
> stress-ng with "sysbadaddr" argument, RCU stalls are observed on RISC-V
> specific kernel.
>
> This issue arises when the stress-sysbadaddr request for pages with
> "write+exec only" permission bits and then passes the address obtain
> from this mmap call to various system call. For the riscv kernel, the
> mmap call should fail for this particular combination of permission bits
> since it's not valid.
>
> [0]: https://www2.eecs.berkeley.edu/Pubs/TechRpts/2016/EECS-2016-161.pdf

That's super old.  I can't figure out how to get a stable link to a new
privilege spec (the riscv.org website has some crazy wordpress paths that I
don't trust, and github doesn't appear to have the PDF for the ratified 1.11
tag).  I'm just going to put the ratified PDF on dabbelt.com, as at least I
have control over that.  LMK if anyone knows where to find the ratified user
PDF of the manual, as that'd be nice to have as well...

It's now table 4.4 in the PDF I get from riscv.org, see

https://github.com/palmer-dabbelt/website/commit/4c2676320c9b580f592bd0a1074bb3c6507d97a5

or

http://dabbelt.com/~palmer/keep/riscv-isa-manual/riscv-privileged-20190608-1.pdf

> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/kernel/sys_riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index f3619f5..12f8a7f 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -8,6 +8,7 @@
>  #include <linux/syscalls.h>
>  #include <asm/unistd.h>
>  #include <asm/cacheflush.h>
> +#include <asm-generic/mman-common.h>
>
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  			   unsigned long prot, unsigned long flags,
> @@ -16,6 +17,11 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  {
>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>  		return -EINVAL;
> +
> +	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
> +		if (unlikely(!(prot & PROT_READ)))
> +			return -EINVAL;
> +
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>  }

This is on fixes, with my cleanups.  I'd really prefer to avoid linking to
dabbelt.com, so LMK if you have a better way to handle it.  I'm planning on
sumbitting an rc2 PR tomorrow, though...

Thanks!
