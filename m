Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F90C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6677520829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="UM7q/hh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgG3VUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgG3VUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:20:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A071C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:20:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c10so2794851pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=T9TN+IiG05axbq9DvASXkbUWMclW/1L5ezZkeAERv5E=;
        b=UM7q/hh3+ycXamy6DmVDsqTeyGwToom5lGdDqRMu9nAmBIv9chtjGOtptQGetwvOLM
         dsbPN8u5TFZ4QxDmLlK2Qc8xKyIcI/Q4NYjbUuaSrkkEI6pidokfHVungFblJBmjzoz6
         m8k0/Kw7NxtrkfSYNWkXwhoqyaNZZ6d/gv+ZRsx9H+ofRvhogUmbxCvbEb9ELRr/ntEr
         seYQhSQhj4IkcOY/BiB6K++rUFLn5u5hKFGYT3+Q79YBWK/qBEMpIgkbhzctmN/Qmqqt
         CMP9i25xSEC9So5qlz7pEJooph+gaPlzD40QmetOhYuvq0Tc5Ft0hUd0GDEKws4bGMMs
         xBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=T9TN+IiG05axbq9DvASXkbUWMclW/1L5ezZkeAERv5E=;
        b=iCNHry0TtGsni4zBcFNx4CidYspg/Ko2JqgTsYlnz7eV9DTEFDjz5KPBXv0Qt0X1qx
         yxIx3wQ+WQc2a9R27khzq/Pe5++hL24GMy60lJgQpsIdLrXvsx5ZayAbUpHib/pmKzJH
         jwIjRXil5AfdrRcQ9rvg/NfIsJFRP0Vm5O0oSL8oIZN4YwzP0phBYviQyD0Y5QRNmyM3
         sKL0lsVUy5vrrU/3Ob9C1pPJuwPDlPfsyC1+Z8jr7NI0K7+q8RAw9YMQbjJQjXfJQvG0
         KPq/uGvk7HQBiZZroXuopBuiMPETTbA8wpojHHjrKl0TRU6SY07Ynghf58lIQ2zBFgz+
         yi1A==
X-Gm-Message-State: AOAM531eOLg0A+OmRaaBEdB8+L1MmHdfwNBCNwB47aTPxyu3aPUwBhkI
        Ud21Pt+DvE7DRJXQ49u9bmSIVA==
X-Google-Smtp-Source: ABdhPJzjBOdzPpZw2Zy8gz/U2wDGlNr+GQCGfyGI52RbMq/aPY97IjWGN5aeZxp17vggsWF8JUIiGw==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr813118pgm.348.1596144040321;
        Thu, 30 Jul 2020 14:20:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d9sm7277389pgv.45.2020.07.30.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 14:20:39 -0700 (PDT)
Date:   Thu, 30 Jul 2020 14:20:39 -0700 (PDT)
X-Google-Original-Date: Thu, 30 Jul 2020 14:20:34 PDT (-0700)
Subject:     Re: [PATCH 17/24] riscv: use asm-generic/mmu_context.h for no-op implementations
In-Reply-To: <20200728033405.78469-18-npiggin@gmail.com>
CC:     linux-arch@vger.kernel.org, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     npiggin@gmail.com
Message-ID: <mhng-5c1b7324-11f8-4334-bfc4-6fc1920aeaa3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 20:33:58 PDT (-0700), npiggin@gmail.com wrote:
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 67c463812e2d..250defa06f3a 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -13,34 +13,16 @@
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>
> -static inline void enter_lazy_tlb(struct mm_struct *mm,
> -	struct task_struct *task)
> -{
> -}
> -
> -/* Initialize context-related info for a new mm_struct */
> -static inline int init_new_context(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -	return 0;
> -}
> -
> -static inline void destroy_context(struct mm_struct *mm)
> -{
> -}
> -
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	struct task_struct *task);
>
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
>  			       struct mm_struct *next)
>  {
>  	switch_mm(prev, next, NULL);
>  }
>
> -static inline void deactivate_mm(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -}
> +#include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is going in along with the others.  Thanks!
