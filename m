Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661ABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451342073E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="wAnSJ549"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHECDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:03:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 19:03:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so11300138plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Qyes9aGHAxVaJwtNU8SQug5LmGFe5FwkrmnytKAZUyE=;
        b=wAnSJ549eHrDYnIB99YVIamtvLCQlqW/lKN2yWQjIsz3q8+o11d9p+F06S7NiQUYHe
         RziUTWxW8ZXS4OG+YN4QsdUgZMefvdMVa/vaZd3WO8UKdaY8EV+JxIBNeRIzGeB5d9FH
         nYRGyUfCm/FQHxwPkYiUr5uJOLBfwcXlJ7hEav94oNnp1CYW3mQgJDTh8EDB8yVssrv7
         /oGfF4lvo+3NKr/S8LTQu4T3kEfONp5H+Ahh5YZord44cL95izeVZER+xOLIpaKni6Fp
         vO1FtiVHPJRMZuu6w7FngRLukPrm+/CpM2lLbd4OJo1o/9U+T0yWVTO39bQSvZIYICSt
         mJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Qyes9aGHAxVaJwtNU8SQug5LmGFe5FwkrmnytKAZUyE=;
        b=fcbIxCdvTlfRCa9iRz/pmAzP4otiLjE26eYnulwfLtN/bnlOL7hOH7rApc5cprxD4h
         YEc14fGBrTqssArhS6R33w3xAtmaNM2xy5/iFKdJFxl5F2QOkMEvyj1g4+/ve8N1P2z6
         zmjKtTvKN4b4d2fbsxA6kaF59MXGYGJnWjiCYMK5a9ImMrL5wyNjsvLVWGPsRRSUEIlv
         tlvb43Q1d6Nc8C51YzJUPsKqsbSp90U8ZRkHIbG9zX5PuRNPS22HtA6CvceT0+m3VAcC
         7esoxVpvWGO+KDltO8iui9uUGRnt8KB82NcHTD1zhCPypKp/xJ1RSbxU/n8nDVljmgDJ
         MsCw==
X-Gm-Message-State: AOAM533ZfyEAVYtXK4DyID0fCxHZEtd3jQ3SOIPmXwogVkb4V+j4L2Ax
        YX61hAVaeJ3zACyI1KA1h3la3A==
X-Google-Smtp-Source: ABdhPJy88+dyttrj2FSVGQ5NdiNibaUE/8BLo2tiAki3SiUKIg9qWa2lVwhEC1uP/cKuYf2VDGXQDg==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr945003pju.177.1596592987410;
        Tue, 04 Aug 2020 19:03:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w16sm652942pfq.13.2020.08.04.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 19:03:06 -0700 (PDT)
Date:   Tue, 04 Aug 2020 19:03:06 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 19:03:04 PDT (-0700)
Subject:     Re: [PATCH] riscv: Add sfence.vma after page table changed
In-Reply-To: <CAAhSdy1QbMjZxxu+wSBYr3+3oaM2Qg=_Uwj8dfQidi=ck6PV_Q@mail.gmail.com>
CC:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, syven.wang@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     catalin.marinas@arm.com, Will Deacon <willdeacon@google.com>,
        Marc Zyngier <maz@kernel.org>, mark.rutland@arm.com,
        anup@brainfault.org
Message-ID: <mhng-1f7adcd7-551c-4b8a-80f5-e1230b335c6a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020 20:29:32 PDT (-0700), anup@brainfault.org wrote:
> On Tue, Aug 4, 2020 at 8:32 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>>
>> This patch addes local_flush_tlb_page(addr) to use sfence.vma after the
>
> s/addes/adds
>
>> page table changed. That address will be used immediately in
>> memset(nextp, 0, PAGE_SIZE) to cause this issue so we should add the
>> sfence.vma before we use it.
>
> Alternate version of this commit description can be:
>
> Invalidate local TLB after both set_pet() and clear_pte() because the
> address can be used immediately after page table change.
>
>> Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")
>>
>> Reported-by: Syven Wang <syven.wang@sifive.com>
>> Signed-off-by: Syven Wang <syven.wang@sifive.com>
>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>> ---
>>  arch/riscv/mm/init.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index f4adb3684f3d..29b0f7108054 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>>
>>         ptep = &fixmap_pte[pte_index(addr)];
>>
>> -       if (pgprot_val(prot)) {
>> +       if (pgprot_val(prot))
>>                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
>> -       } else {
>> +       else
>>                 pte_clear(&init_mm, addr, ptep);
>> -               local_flush_tlb_page(addr);
>> -       }
>> +       local_flush_tlb_page(addr);
>>  }

arm64 appears to be upgrading all set_pte()s on valid kernel mappings to
include the fence.  It looks like the message from 7f0b1bf04511 ("arm64: Fix
barriers used for page table modifications") is out of date, as I can't find
create_mapping() any more.  If that was some generic kernel thing then we
should probably upgrade ours as well, but if it was arch/arm64/ code then this
approach seems fine as __set_fixmap() isn't on the hot path -- I guess this is
fine either way, but there may be other issues that the arm64 approach fixes.

Do you guys happen to remember what was going on here?

>>
>>  static pte_t *__init get_pte_virt(phys_addr_t pa)
>> --
>> 2.28.0
>>
>
> Otherwise looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
