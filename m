Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C8C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ACE2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="IZAut0DG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCSBpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:45:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40167 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:45:14 -0400
Received: by mail-pj1-f67.google.com with SMTP id bo3so249507pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=15Ag1guabbez6fmeIZ+SLDWHfu2CDemRcsM6ytC1rkg=;
        b=IZAut0DG7zAsxQUQFAa7FaASbpC1hSxvgO2kLrxR65bUGBYZIGDfHZyg6SguRu7+Hc
         +NgxVZLHu+g0eHSWuzXh3uqTLfeeaCh9r0pKEL+lkknRUbX6h4TH+dWqScCEHthul4HL
         4xQTL5qxE5UVCapvn5U+nqKUunQhUC2wJmud9ZkN3k5IH8+gktuUvtKryvkwLBzh1Urn
         jNqq5wEp6JHUzmrDsDIKEXoeOtgFkzDmG+TxBS7OBX539OpI/82U5nh94MQxyIrRw+C8
         6saDRxVPA/QuByx8WGl1tdedfH8v9KeAdKyKZfF7X5VZigWiep0KY2K/d6lAr1qrFtRc
         bY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=15Ag1guabbez6fmeIZ+SLDWHfu2CDemRcsM6ytC1rkg=;
        b=LGsI4Cdb52Hu0l2ZxW71U2av1GwAGPvDLuBuJgqMKgsZ7RDIfvLRk7UHHjtqC4zuCi
         XIPGX8tyk5M0k5+TWwNEXNOVxXpLLSH3FK1KdnuuQlwX3cYkr0a0SGMfFK8Vaa2EKSjk
         WQW8KmKC5/5e8zCBTIwH1NhGFSyQDi+2dfhcorjSWFL8Agiy9ACSb+ofQl5i62i5KIXo
         VNqaEwTIkncJfIPVbTc8Jte1nC8oODa1Cveizv8GaP7ANsUgOTjRJUUzeXc+3Sra7CYZ
         y7UwuZNGv/+s+pH29uy49Cw49K2XmF2Cx3XROI8X6M+zdTeZ1FRD/ro1A4g8NG6rA4lp
         Go3A==
X-Gm-Message-State: ANhLgQ0eZ7b81hO6T21ipXHc6/FV1NjX/nfigAdnOEZjsm6uD2MWw4l8
        ULdHC/BMgfodtqYP/UmmC5UijSHFQbU=
X-Google-Smtp-Source: ADFU+vss47yxMO1HlAXyYytkS9jQAYFIDvxwUZoentpt7OiEJ52BZiAtyH8usHDwp2g9MxV+M1HgAQ==
X-Received: by 2002:a17:902:34f:: with SMTP id 73mr1100441pld.50.1584582312362;
        Wed, 18 Mar 2020 18:45:12 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id d3sm262618pfq.126.2020.03.18.18.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:45:11 -0700 (PDT)
Date:   Wed, 18 Mar 2020 18:45:11 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Mar 2020 18:45:05 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: fix the IPI missing issue in nommu mode
In-Reply-To: <20200303093418.9180-2-greentime.hu@sifive.com>
CC:     green.hu@gmail.com, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime.hu@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-aaf75a1f-f765-46de-9102-08e455c4688d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Mar 2020 01:34:18 PST (-0800), greentime.hu@sifive.com wrote:
> This patch fixes the IPI(inner processor interrupt) missing issue. It
> failed because it used hartid_mask to iterate for_each_cpu(), however the
> cpu_mask and hartid_mask may not be always the same. It will never send the
> IPI to hartid 4 because it will be skipped in for_each_cpu loop in my case.
>
> We can reproduce this case in Qemu sifive_u machine by this command.
> qemu-system-riscv64 -nographic -smp 5 -m 1G -M sifive_u -kernel \
> arch/riscv/boot/loader
>
> It will hang in csd_lock_wait(csd) because the csd_unlock(csd) is not
> called. It is not called because hartid 4 doesn't receive the IPI to
> release this lock. The caller hart doesn't send the IPI to hartid 4 is
> because of hartid 4 is skipped in for_each_cpu(). It will be skipped is
> because "(cpu) < nr_cpu_ids" is not true. The hartid is 4 and nr_cpu_ids
> is 4. Therefore it should use cpumask in for_each_cpu() instead of
> hartid_mask.
>
>         /* Send a message to all CPUs in the map */
>         arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
>
>         if (wait) {
>                 for_each_cpu(cpu, cfd->cpumask) {
>                         call_single_data_t *csd;
> 			csd = per_cpu_ptr(cfd->csd, cpu);
>                         csd_lock_wait(csd);
>                 }
>         }
>
>         for ((cpu) = -1;                                \
>                 (cpu) = cpumask_next((cpu), (mask)),    \
>                 (cpu) < nr_cpu_ids;)
>
> It could boot to login console after this patch applied.
>
> Fixes: b2d36b5668f6 ("riscv: provide native clint access for M-mode")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/clint.h | 8 ++++----
>  arch/riscv/kernel/smp.c        | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> index 6eaa2eedd694..a279b17a6aad 100644
> --- a/arch/riscv/include/asm/clint.h
> +++ b/arch/riscv/include/asm/clint.h
> @@ -15,12 +15,12 @@ static inline void clint_send_ipi_single(unsigned long hartid)
>  	writel(1, clint_ipi_base + hartid);
>  }
>
> -static inline void clint_send_ipi_mask(const struct cpumask *hartid_mask)
> +static inline void clint_send_ipi_mask(const struct cpumask *mask)
>  {
> -	int hartid;
> +	int cpu;
>
> -	for_each_cpu(hartid, hartid_mask)
> -		clint_send_ipi_single(hartid);
> +	for_each_cpu(cpu, mask)
> +		clint_send_ipi_single(cpuid_to_hartid_map(cpu));
>  }
>
>  static inline void clint_clear_ipi(unsigned long hartid)
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index eb878abcaaf8..e0a6293093f1 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -96,7 +96,7 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
>  	if (IS_ENABLED(CONFIG_RISCV_SBI))
>  		sbi_send_ipi(cpumask_bits(&hartid_mask));
>  	else
> -		clint_send_ipi_mask(&hartid_mask);
> +		clint_send_ipi_mask(mask);
>  }
>
>  static void send_ipi_single(int cpu, enum ipi_message_type op)

Thanks.  We should really stop putting hart IDs in cpumasks, as that's just
nonsense.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm taking these both onto fixes.
