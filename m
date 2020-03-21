Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B5C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B620754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584789788;
	bh=IrN8hft8egtKt9q2QCIAHGIVjoG+tI0cY9ujDNwCIRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0IiviVAKfK8viXsq+5HzYXhtYEJOuH7QjTpQQjnmvP5P6FUmcvXSRagRwyekA58FQ
	 TItUltYRiuxB1RE8WUv7a1ePcYcHCgKVEW4iLiMMefvCP3v89OQc/Tb+MJXlUvBNI2
	 ZSGNATLEQ5vgbvD4sfyrPwBr1P3Qb0/HXy9Wi20E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCULXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCULXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:23:06 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B757820786;
        Sat, 21 Mar 2020 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584789786;
        bh=IrN8hft8egtKt9q2QCIAHGIVjoG+tI0cY9ujDNwCIRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mj+1sA3qyTxHp4YDj2Lx/59ZyUJ6tpiQZUSLPF2MWhNCRYMQZnERYuq6ABUR5x6BE
         /fVXmUcRPtXRAKSKXitqslhPV6JtoMIkZniWk8DTOB76ldBL5JAuRNM678vK3NAUWR
         NPP+qXQ9mlI1PByJeUo1B36mZPwxwrXc24YsziYY=
Received: by mail-lf1-f44.google.com with SMTP id a28so6506847lfr.13;
        Sat, 21 Mar 2020 04:23:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0B145zTVE/GqZrLfVhDEQPtYbfr0QKebp+UiwPgZX4f4HxlKcS
        0CZwQxij7YABmKaIvkI+xGD25QpoJHRXzj0nZko=
X-Google-Smtp-Source: ADFU+vtBuGthZOiE/exncdFcOQotmhkxovU5FM+ioKG7kIdq/Q77KU7HLxMgNJ9KnymclfA9axDhFQpw7K0/sN7K6dk=
X-Received: by 2002:a19:4f10:: with SMTP id d16mr6800457lfb.52.1584789783795;
 Sat, 21 Mar 2020 04:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200318044702.104793-1-wenhu.wang@vivo.com>
In-Reply-To: <20200318044702.104793-1-wenhu.wang@vivo.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 21 Mar 2020 19:22:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTp8fwy7hRCKKzmxXv9WZfh=Lhzu4_7nK52E3T6XfW8iQ@mail.gmail.com>
Message-ID: <CAJF2gTTp8fwy7hRCKKzmxXv9WZfh=Lhzu4_7nK52E3T6XfW8iQ@mail.gmail.com>
Subject: Re: [PATCH] csky: delete redundant micro io_remap_pfn_range
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@vivo.com, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx

Acked and queued.

On Wed, Mar 18, 2020 at 12:47 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> Same definition exists in "include/asm-generic/pgtable.h",
> which is included just below the lines to be deleted.
>
> #ifndef io_remap_pfn_range
> #define io_remap_pfn_range remap_pfn_range
> #endif
>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  arch/csky/include/asm/pgtable.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index 9b7764cb7645..bde812a785c8 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -306,9 +306,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
>  #define kern_addr_valid(addr)  (1)
>
> -#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
> -       remap_pfn_range(vma, vaddr, pfn, size, prot)
> -
>  #include <asm-generic/pgtable.h>
>
>  #endif /* __ASM_CSKY_PGTABLE_H */
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
