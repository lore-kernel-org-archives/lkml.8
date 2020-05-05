Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA58C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31C020659
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="LCUE+epO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEEXzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEEXza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:55:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D35C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:55:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s18so1768432pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ATXIubCTTXOBHXzWhZxzF+Sp5JyKqEJFksQsf+OAlCg=;
        b=LCUE+epOqJoR+Js3sGpG0U90X1zeIkkRcKpuwrTZTpRFnEKXfY5giOa0TSthpXBEVN
         3p2yoVisoWm3Ql4CELeMvCLVV3zFKJO5Zb9KkLTcb9IlPfE0SpCg6hnmaBGuUwxNDzwc
         85PgVaVDmb+KyOApTbH3RaSVKUhOF1ck8rMvupcZ8dQZqrseOXOd25uPak5H8kNy2zj3
         RQgFpOiMOcRgjwhPkTdVUD3qYni7JIFID0WxVWai7Lln1CV+bLzop2GC4P2wYxixDO6X
         FOou9ZBfpbxk8eXB0dj2oGB7ME+R8/4aiGr2NpmYjKbNEIhRM7O7tB6vm7MIt32nvEOD
         1hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ATXIubCTTXOBHXzWhZxzF+Sp5JyKqEJFksQsf+OAlCg=;
        b=hKKR6XVtqzVDvhzl9CQAQjaII0Yq+fNrFWlDqShTba6NKMm0bxjC3iU2EpWnnyNiAk
         9Gjbuo2sIFcgafcwY72ozYzbTYhRBO15vVff4BbNeI4GJSG2f+0Q7mDTXdAcZAHm/8PY
         pFSwazNGWm1J4sMUXZMZh85RQpaVnbpUkrLtZzGbOO0Wb/9CPFzTi7BQKiMUsTtDyx2e
         1LQLxn+FzvV3+jD7ySJa6vtcUPRr1yPkQ6NIk6Bh/2ZkIvmRtSa/fYUrEXaI/Kf3xYIE
         fLNxywJdvuKzyv3V8ZZw8m9yOBIt3lmR7yGGc/Sn1B6dHckMMrfGNGzNFw8K+4cPt83D
         oKPQ==
X-Gm-Message-State: AGi0PuZToikSs4QSmzfE2svD/JQ5uI0mrkbaal4fI/0+MQtC2lfs9Vv9
        QhuFOaIVw6YHf/pWANtcV0C+847I050=
X-Google-Smtp-Source: APiQypJQ7iVowzFYXtx5BFr6e1gDDwQs19amgIfj5WG5z8x8u0u5C7Ec+ncx0Sl9ZJzKU6sM6IdFMQ==
X-Received: by 2002:a65:4107:: with SMTP id w7mr4619921pgp.438.1588722929163;
        Tue, 05 May 2020 16:55:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 188sm122789pfg.218.2020.05.05.16.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 16:55:28 -0700 (PDT)
Date:   Tue, 05 May 2020 16:55:28 -0700 (PDT)
X-Google-Original-Date: Tue, 05 May 2020 16:42:29 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
In-Reply-To: <20200504040319.31423-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-a3f16502-c8cd-46db-afa1-86df18b3778d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 May 2020 21:03:19 PDT (-0700), Atish Patra wrote:
> This patch removes the unused functions set_kernel_text_rw/ro.
> Currently, it is not being invoked from anywhere and no other architecture
> (except arm) uses this code. Even in ARM, these functions are not invoked
> from anywhere currently.
>
> Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b55be44ff9bd..ba60a581e9b6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
>  #endif /* CONFIG_MMU */
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void set_kernel_text_rw(void)
> -{
> -	unsigned long text_start = (unsigned long)_text;
> -	unsigned long text_end = (unsigned long)_etext;
> -
> -	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> -}
> -
> -void set_kernel_text_ro(void)
> -{
> -	unsigned long text_start = (unsigned long)_text;
> -	unsigned long text_end = (unsigned long)_etext;
> -
> -	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> -}
> -
>  void mark_rodata_ro(void)
>  {
>  	unsigned long text_start = (unsigned long)_text;

Thanks, this is on fixes.  Are you going to remove the ARM code as well?
