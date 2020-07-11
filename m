Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2117C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9778E20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="mylwVBf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGKTnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgGKTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 15:43:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C739C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 12:43:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so4056074pfn.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yw7ehmxORJy4sIbNya0u48Qorh9d3UtEM0gh14sgRLI=;
        b=mylwVBf8ZP2cYI+vTV2Iy0TSPoCBuUKKyI4kqGysYHwgxggSoRwfygWDMUMzv9ujyu
         pD4eMK9Luu4/KaXspRyW+FNGSxtLFk1h74sHUHFGQrL0DxfCBP02tgnqQ0cGQ/fe1dTG
         fIN5rFmGpXbSZCcN5ocYClQVRgVWqeZk+wGZE+lEm8LMJ1nD1NhY82a/ABi408RXk/Fo
         PA/1uOKMgMSaFnb+JUSYB1cL9LTMH014FiNk5/9GbQ2dZy5cgf0pp7EerFmUmiCViucE
         RdEQCmSOtMtXS/u/Cv3TZFEYae1JTMfmufBxxx/T1mXwll7GT/SNtQ3592IV34LhHBRT
         iRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yw7ehmxORJy4sIbNya0u48Qorh9d3UtEM0gh14sgRLI=;
        b=HOQ86IMzkK1mtxXOyeeOaStQDvN8vxyFdhQHn9jGvRa0cdGfqs60cC2MyIPnxI4MJi
         ZuK3oT6YLuVx4THo0OJUyiAj2lpEpP57Oeg+ZHZ+2Pes/r29Nes5pVSmWdPCtks+zNyU
         jRpctCXe4IrFzfS4M12vuQJwsbvEUh6AD6HwcBTJtENAsLqrC3pH4aQmFmZDVzdBJXuj
         v4IRccTR/lXKMwgymEBfBFJydr3w+5wLvb3bnP7bcww6sQaYb2eOT/lYx8DayI2Bii7+
         PNPeH1337oxjHaAUPSGi7sfCgxB52G4N4HnE6IDabF6xwdHBd2RE0yBPX0afr9t/o1dc
         O4Uw==
X-Gm-Message-State: AOAM530HS9MRWZCILd4oZnZzqVdAjXT7RWifEoH/q7KzYtKAWSl4zppM
        bHrCSZHw2MHMu6GoBB4pHvgdvw==
X-Google-Smtp-Source: ABdhPJzK9+khKr+Z9s7skyyuV7g90/sDvKB6R7Wtu2va4YLg1bmw3EyhtKykgJkirCYxta5YMCs4gQ==
X-Received: by 2002:a63:cb03:: with SMTP id p3mr62374583pgg.444.1594496627665;
        Sat, 11 Jul 2020 12:43:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t137sm9573449pgc.32.2020.07.11.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 12:43:47 -0700 (PDT)
Date:   Sat, 11 Jul 2020 12:43:47 -0700 (PDT)
X-Google-Original-Date: Sat, 11 Jul 2020 12:35:18 PDT (-0700)
Subject:     Re: [PATCH 17/26] mm/riscv: Use general page fault accounting
In-Reply-To: <20200626223625.199813-1-peterx@redhat.com>
CC:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gerald.schaefer@de.ibm.com, aarcange@redhat.com, will@kernel.org,
        mpe@ellerman.id.au, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     peterx@redhat.com
Message-ID: <mhng-9a62674e-ca04-4e59-a03a-5e4924ef83ca@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 15:36:25 PDT (-0700), peterx@redhat.com wrote:
> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/riscv/mm/fault.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 677ee1bb11ac..e796ba02b572 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -110,7 +110,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * make sure we exit gracefully rather than endlessly redo
>  	 * the fault.
>  	 */
> -	fault = handle_mm_fault(vma, addr, flags, NULL);
> +	fault = handle_mm_fault(vma, addr, flags, regs);
>
>  	/*
>  	 * If we need to retry but a fatal signal is pending, handle the
> @@ -128,21 +128,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		BUG();
>  	}
>
> -	/*
> -	 * Major/minor page fault accounting is only done on the
> -	 * initial attempt. If we go through a retry, it is extremely
> -	 * likely that the page will be found in page cache at that point.
> -	 */
>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -		if (fault & VM_FAULT_MAJOR) {
> -			tsk->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
> -				      1, regs, addr);
> -		} else {
> -			tsk->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
> -				      1, regs, addr);
> -		}
>  		if (fault & VM_FAULT_RETRY) {
>  			flags |= FAULT_FLAG_TRIED;

This still slightly changes the accounting numbers, but I don't think it does
so in a way that's meaningful enough to care about.  SIGBUS is the only one
that might happen frequently enough to notice, I doubt anyone cares about
whether faults are accounted for during OOM.

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
