Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34331C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0250F20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zmlVrOV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbgDCPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:53:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39459 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbgDCPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:53:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id k18so2835457pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfG/HEpqhA3MzgbPqFWg+BXYNFgu6A6b9QFElDn5ySA=;
        b=zmlVrOV4U6GylZVEDZ/ygdUdYk/Mge0hHPKwyECljiOx96v/ROmb1SHJBB9GtwAZBj
         l5Xfiy592UC8ZDWXqj+Yj0gcjKTZQydzV6W5PfmDobTD9gITspP4ttvdk/zC+YGfB7Vp
         h45ETzIoQLGJLJKF6PerEV9TNu++gUBsznslsO1RpZo418bVcE+3nYJ7q35fIEAIPm94
         x1SU6HEY43c42A3UATWv3mn271ShGdYzu8boGCsTSJiwZT3Kooj+PgvLKbCQn+nJT1PN
         MZlFKoszWaqz2pkrs36cKgUibijldDKQpTEm4Ong82kCK1fEeYODGi948KB4AY4UNar1
         mxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZfG/HEpqhA3MzgbPqFWg+BXYNFgu6A6b9QFElDn5ySA=;
        b=uLeiY7EvvvPtSZvUeK/5Tx+9VU8ER4x4UUK2pmO1q3tWbXmr8NXsABzbCFDnx3mS29
         hRWJ4G+Jlidng1kmdrXhImpqlrF7fayKw4OYnNn2mgMUebFQiVDltzNxXGXSKVPlxFev
         zHoSzh+F0ylQ8XBDuBvEdWLe7qEEHrT8owLe5ECbo4izkPpLgaj10HYtOyhZe66RHfN/
         hIf+f3Wlyh/yuvOetI0rHVHc2aVZH57oE/e9OS4Cz7nU+nqLHbsj2SaICX9WrQyiYKxw
         SG6x7d67eN/YmvXp1xJDsoXsZ6YRvApUNSFc+A+waUgMiUxkVlXcRNes9VnSRMKOJ0fa
         BvdA==
X-Gm-Message-State: AGi0PuZc209TBkZt/ZvWVhJ7ej46FaCxIpgFchKFEJuTgJjGxNkznEel
        nA9VgcIDQE3fW85qWOuISa931A==
X-Google-Smtp-Source: APiQypLIdx8+bzx7igbQi4YQ7pK0wEv8aLth3Xj8y5QXe5i6NJjZArjRddIE7SsYOpnndrd6uQmz/A==
X-Received: by 2002:a17:90b:254:: with SMTP id fz20mr10705848pjb.27.1585929201970;
        Fri, 03 Apr 2020 08:53:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm5954001pfd.123.2020.04.03.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:53:21 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:53:21 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:53:04 PDT (-0700)
Subject:     Re: [RFC PATCH 7/7] riscv: Explicit comment about user virtual address space size
In-Reply-To: <20200322110028.18279-8-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-85bee1c4-d1ea-4370-8940-2e35c5eb6d4b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:28 PDT (-0700), alex@ghiti.fr wrote:
> Define precisely the size of the user accessible virtual space size
> for sv32/39/48 mmu types and explain why the whole virtual address
> space is split into 2 equal chunks between kernel and user space.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/pgtable.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 06361db3f486..be117a0b4ea1 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -456,8 +456,15 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>
>  /*
> - * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
> - * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> + * Task size is:
> + * -     0x9fc00000 (~2.5GB) for RV32.
> + * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
> + * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
> + *
> + * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
> + * Instruction Set Manual Volume II: Privileged Architecture" states that
> + * "load and store effective addresses, which are 64bits, must have bits
> + * 63–48 all equal to bit 47, or else a page-fault exception will occur."
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
