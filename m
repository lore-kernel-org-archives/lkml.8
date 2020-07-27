Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157ABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94FC20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="solVB7kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgG0UTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgG0UTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:19:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F511C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:19:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so8750653plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GEaUy1Fu1lp3m+GXiMScnx03WYprA9BtWxGSWIlMkLY=;
        b=solVB7klx3WtOFjPCehD4ovahfSWXpY6iMsiq40Rb4dqAUniRy9npg8YQ4JqKQNOuk
         J2hF6ajxMWTaBkunpx7+uJfzUPLXy2nlPcv+qGRfxFRT5cPoG6/Zx4KUQ3xe4eOpvbTX
         bfqTbFkgtlp4VVsjV6mQVU0hT6svzW0P8/FLzUwCXzzERMTaw+P5mSpMcYTmCm7i/nG3
         oRQ61qrLW4XTYX56489z7Cits0SmPHnmJYR7G2Kjcaar9gM2v1nrLwefqTUdPxxYREvp
         PEfAhiVEsGKsWEV7UfKanP6gEFCbwP5dV6yaqWRRNbpmrkLdPHEJDF7j8P+o8euxW6L3
         QcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GEaUy1Fu1lp3m+GXiMScnx03WYprA9BtWxGSWIlMkLY=;
        b=Edr5OQd22RSbzQJLexw3ZYieXWytZnqIJwooajItYMeaPo+L8VtO8GtkclQkgm1g0H
         caafUFzqbT2EbPih4vli6Gpgr0YkiOr5BTqB9HvI312GtZ+9j+pa296kZ4nkEO3qXnUQ
         j+U/32YRpiTPneqCdeQaLt4DR3QCvzDfGWjq6KqgAuYkVNHQp1L5YFYl4DdUEzAKR76/
         zXULSccpV+eGJF4qKAWTRwwNIljHtTJJDU2oObyWkduXShHdegZHIHn0HnaDJWK7gIeT
         5x8AJPMNKqwAGRSnbMvsvH7FcMSBsE0Dj/45dLgUrFsmMMQ8Kx0PDE5wR9vHd8YcZPuI
         wUHw==
X-Gm-Message-State: AOAM531Jq9xRkpJerA4vh66V0ffCWnPYu7CcmsqL8Ro+JYz9z4nid5kD
        Eh13cfg6l0RM1SdfkW8JSjNXhw==
X-Google-Smtp-Source: ABdhPJxCc30R6xAjTUNEOkp0/wPdS5BuAQ64CALm1PJzGSrmZW30yt2uBc//rr4MEU1Xx2IdP6j8yQ==
X-Received: by 2002:a17:90a:2d83:: with SMTP id p3mr972544pjd.124.1595881180864;
        Mon, 27 Jul 2020 13:19:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o10sm426540pjo.55.2020.07.27.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:19:40 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:19:40 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Jul 2020 13:19:31 PDT (-0700)
Subject:     Re: [PATCH] riscv: Grab text_mutex before patching jump-labels
In-Reply-To: <20200723163628.82794-1-kernel@esmil.dk>
CC:     linux-riscv@lists.infradead.org, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kernel@esmil.dk
Message-ID: <mhng-f51a8614-665a-4961-b6d6-a37c0af73a8d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 09:36:28 PDT (-0700), kernel@esmil.dk wrote:
> Like other arch's we use patch_text_nosync or equivalent
> to patch the jump-labels, but also like other arch's we
> need to hold the text_mutex before calling that.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>
> Fixes: b6e0878a4ec8 ("riscv: Add jump-label implementation")
> ..that is already in riscv/for-next.
>
> Palmer: Sorry, I didn't notice this before. Feel free to
> squash this into the commit above if you like.
> ---
>  arch/riscv/kernel/jump_label.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index 1bab1abc1aa5..20e09056d141 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -4,8 +4,10 @@
>   *
>   * Based on arch/arm64/kernel/jump_label.c
>   */
> -#include <linux/kernel.h>
>  #include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mutex.h>
>  #include <asm/bug.h>
>  #include <asm/patch.h>
>
> @@ -33,7 +35,9 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  		insn = RISCV_INSN_NOP;
>  	}
>
> +	mutex_lock(&text_mutex);
>  	patch_text_nosync(addr, &insn, sizeof(insn));
> +	mutex_unlock(&text_mutex);
>  }
>
>  void arch_jump_label_transform_static(struct jump_entry *entry,

I've just put this on for-next as is.  I generally try to avoid rebasing stuff,
but I think I saw a message today about a patch I put there prematurely so I
might have to rewrite history anyway.  If I do I'll squash it and a few other
small fixes.

Thanks!
