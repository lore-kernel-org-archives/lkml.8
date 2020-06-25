Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8C12076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="AaW0I7wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407166AbgFYV1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403774AbgFYV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:27:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E249C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:27:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so3940949pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YwxJgs2ekm2F5i2bbq3bvR99tjvhSs3RBO886udVeFE=;
        b=AaW0I7wf4VZi0tWYgsg0VXtU1/5OGKDM1/Sk65n9jmsn2IHKE0FgxNJRUXhp2LNS5O
         VxEWngolyhwIiqJPDqTRL+0wV2tp8Lk2ANlwhpXuC6ha7JwE2aCr7+7ojqIx++AnnoBL
         0lp82ylALuEFpFZLkRpDZsRyFetD4967ioBXlIWWukROBYsxAjquAShJp8VX+91+6uTD
         fL9zHCiRxJ5DJME5M77E3XFFnvdAPsV3FoyiFSkA0NDnONfIWKiB+tL2+MOQNanqjWQx
         FnKzlMURYcU9CGrPQy6PW9nZyRMvNZjdDF7uxzbDMqcSd4L94Vr2KH+717jxAE9Q4b+k
         mqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YwxJgs2ekm2F5i2bbq3bvR99tjvhSs3RBO886udVeFE=;
        b=U+F+9PJy9fNixJ6jCPaCALlsbj20H0UlpLOh0QzijgCmYOW1iKKq9t+dNItHcPX2ln
         sVME97c7GC1jrnLwFKNKmLUrKKyWnQpCj1c1QtpEy1bNn2NBG6fm9pmWo84cvEjstgb7
         UT1vvkxhLXxBLKeyXTOVq9GvsuWQYvuB3+XUqMEjGEkEyUBn7nAZCRDOWNK7cUq9hlRz
         YHbBnkwAPfcPkK8xqYENQNnqdfsGYkjamzYjL/73WRXx0eU1gFUkUVD9s+KSs58qVN5u
         3I5e93INdUss/0kp3LHL/oN+w4jfJplNJKW/fSgAEEjrqDoRZkU0TQUetZDIYvka1Tu2
         9+mQ==
X-Gm-Message-State: AOAM530Jy0efnx32fvibkCS47c7KzE6hJ6jUYrhbmZ2alCfYT/VeZGEI
        Jl+eFhEKdazycDCrbdB/+yIQVdUWFiDGPg==
X-Google-Smtp-Source: ABdhPJyogFv4o4zWEa+ucdAZImpfWIBrztId39Ahncn0ua4AkeSeZAubIKQiOim3F6/RucN0oZ3bQQ==
X-Received: by 2002:a62:8782:: with SMTP id i124mr35615630pfe.267.1593120471660;
        Thu, 25 Jun 2020 14:27:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h2sm24673386pfb.175.2020.06.25.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:27:50 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:27:50 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jun 2020 14:23:09 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Use a local variable instead of smp_processor_id()
In-Reply-To: <20200622234725.92511-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, greentime.hu@sifive.com,
        Atish Patra <Atish.Patra@wdc.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-99e5afcf-d8c7-4660-a9e7-eb515e9aa55b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 16:47:25 PDT (-0700), Atish Patra wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
>
> Store the smp_processor_id() in a local variable to save some
> pointer chasing.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smpboot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 4e9922790f6e..3e033e97dd08 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -146,6 +146,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  asmlinkage __visible void smp_callin(void)
>  {
>  	struct mm_struct *mm = &init_mm;
> +	unsigned int curr_cpuid = smp_processor_id();
>
>  	if (!IS_ENABLED(CONFIG_RISCV_SBI))
>  		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
> @@ -155,9 +156,9 @@ asmlinkage __visible void smp_callin(void)
>  	current->active_mm = mm;
>
>  	trap_init();
> -	notify_cpu_starting(smp_processor_id());
> -	update_siblings_masks(smp_processor_id());
> -	set_cpu_online(smp_processor_id(), 1);
> +	notify_cpu_starting(curr_cpuid);
> +	update_siblings_masks(curr_cpuid);
> +	set_cpu_online(curr_cpuid, 1);
>  	/*
>  	 * Remote TLB flushes are ignored while the CPU is offline, so emit
>  	 * a local TLB flush right now just in case.

Thanks.  This is on for-next.
