Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E898C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317AD20678
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="HfLgM9ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404203AbgDCPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:17:08 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36614 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgDCPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:17:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so3066307pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Fx4AohXcpCWWeloAMp1+tr3EHYpkAySrgcIIxr7kcOY=;
        b=HfLgM9cilYyLla4cdYfW2AvcCIEbJysfo/iCt8RVApG6bgtOq43c2VYE04UoFPb2n6
         CXkOo7muD8btnl4gKcGYJBV9EIRwOyKcsDiYZy42T96eb+YaLVciY0c+nbPHAO9S/2Yy
         9EcbWGLe0PB7/LAPQg4AxqiAUjSOYAONdeOKggAy/hHrsZhAMC3bdD4IIzSYID+LmytA
         yCaC9GQZ8iawK2uO7YQQ1ufg7BLMI7jWkpxQS9RP66GM7jaZiMVqyCNZbwz2d+ruissJ
         gMgY01yJ1aPjzk0wfGs2RVyzGJOWx3rS0rJhEqG1EX2DXrfl14xHj2SKc3Kj75Q11TSr
         zrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Fx4AohXcpCWWeloAMp1+tr3EHYpkAySrgcIIxr7kcOY=;
        b=KVd5gVP6cqmSzIYtx2MEYj9PpRxY2+rNpkgyObIiYC52TJuiJCO90EEBfhDcMo7+ma
         gXCtGf6qaJ39lsvZf3CXaNwSDYheIp7psBn7vtOBEQgWil9JRxuGYxCxJRSoGOZWSS0+
         2cPhJdo4GM7bVP/QbbROt4ZLJWYF607jQIs+BgDzZJrYwGPjgXRxn2SpICyMxp6CEwpF
         kVJ65yYZTYdjjuHtDSv0+2KLj/w/24K/+1JehjHZAXFF4+XCy/GZxxG9YSAobEkqELQJ
         JxcJchd6XZV4VSK69Kq2NBtB9yiEg4ABSnTcWEa74BUD0sRq+msvwRpqd/xiB64pLuQg
         38Og==
X-Gm-Message-State: AGi0PubHqaEmcq6C4/QNKViUrM2nC+ZGiwqPxMg8l1h2lOvHgNoGn0Pa
        wuA1sdvXfJSids4PKJEPD8ynew==
X-Google-Smtp-Source: APiQypKmng9gZ+Pi+NIKxo4VVzepa02lDucm/bsTEinOB0lbG6J9uaAqmzf3pxPsEoJl7m2wAkEAew==
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr8423259pls.128.1585927023636;
        Fri, 03 Apr 2020 08:17:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p70sm5969601pjp.47.2020.04.03.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:17:02 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:17:02 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:12:08 PDT (-0700)
Subject:     Re: [RFC PATCH 1/7] riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
In-Reply-To: <20200322110028.18279-2-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-ee39eb13-2567-479e-b0f4-5d23dff8496c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:22 PDT (-0700), alex@ghiti.fr wrote:
> There is no need to compare at compile time MAX_EARLY_MAPPING_SIZE value
> with PGDIR_SIZE since MAX_EARLY_MAPPING_SIZE is set to 128MB which is less
> than PGDIR_SIZE that is equal to 1GB: that allows to simplify early_pmd
> definition.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 238bd0033c3f..18bbb426848e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -247,13 +247,7 @@ static void __init create_pte_mapping(pte_t *ptep,
>
>  pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -
> -#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
> -#define NUM_EARLY_PMDS		1UL
> -#else
> -#define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
> -#endif
> -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>  {
> @@ -267,14 +261,12 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>
>  static phys_addr_t __init alloc_pmd(uintptr_t va)
>  {
> -	uintptr_t pmd_num;
> -
>  	if (mmu_enabled)
>  		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>
> -	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> -	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
> -	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
> +	BUG_ON((va - PAGE_OFFSET) >> PGDIR_SHIFT);
> +
> +	return (uintptr_t)early_pmd;
>  }
>
>  static void __init create_pmd_mapping(pmd_t *pmdp,

My specific worry here was that allyesconfig kernels are quite large, and that
dropping the code to handle large kernels would make it even harder to boot
them.  That said, I can't actually get one to boot so I'm happy to just push
that off until later and drop the code we can't practically use.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
