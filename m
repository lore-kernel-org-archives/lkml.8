Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2020207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="klf6PYxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFRXtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFRXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:49:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48114C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:49:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so3491956pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yYUcfax4E2dlsz0hVRBnudhd98bc0SpSGm5R4FipwaQ=;
        b=klf6PYxyM9AmxSgk8zCOKLbtBcPW9VhTg0ulvIVXLz/AQn8z6IwTCbD59rmvPhi93e
         y+DkH7ecRkHn7zLAR2VVtt01GFPgG63EEVZv4/GreOx/9rbvhZsgMJs45i/pgYOsj3ny
         6ezT4eI6QXUlGoesRGqlin/ErRc02ZdEXzM9Lwv2OBPXgymW7S+O2+uWS7/D1kKHflEL
         OT1UsJzh7peBJbJSUEk5WrCSc8VhuSMWv/y3tiJqFhRBEPF9V3BGHzXJSpn8eTl7IDCh
         Ukz3KSPCPw3lwJnElbwl8nmANvhUB9g/RKgjXSWYs2PDzhBct5zE5ugGtNa/ODGWZxrx
         lwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yYUcfax4E2dlsz0hVRBnudhd98bc0SpSGm5R4FipwaQ=;
        b=YnSYLqswfoO2XCwip4H7ODiZ6YXRybYp9/5wNtyZofylByJxRNTRjjSR+TFDpTgwHG
         7s4RfJBVf6JYkUSqlhoifJiVJHupj0jGgWPWlVHGWI7Xoo4CmJcrMCYylwJ8deS81+mc
         CxFiDSFzEO1Vgo8kZQMWMBW8HkC/ec991jJYsID3QV8uqJuYpfZxkelGFeO7ocVndHSe
         EcwjeDVlbHbCoh/vkjpPzDwTC/89VtRM6qDSAhx1nSSu8bS7TsBaub7Yn1pt9bdqCbjr
         hMABTnlqGr9CgMTnPEjkRu2nGvvJ+gXGeu1iIlfRWGKoY0YYRDBUtvYEyYTr4CPLclyy
         Aozw==
X-Gm-Message-State: AOAM531fGJ6z/RYOTUuO86157bej+RuViZMuPV1nNiiIy4EL3I0EKcVX
        vmWlkNO02ZNzopPVAUrP5T0kAKFxM0ZNTA==
X-Google-Smtp-Source: ABdhPJx/FYurnEYAtKAZPHIo+SrvRxkIg9o39R8+0LYg79YjNV81gAy08r0kIzj7nF+RFqdHW7P8tw==
X-Received: by 2002:a17:90a:5218:: with SMTP id v24mr665196pjh.223.1592524164257;
        Thu, 18 Jun 2020 16:49:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f14sm3456421pjq.36.2020.06.18.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:49:23 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:49:23 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 16:45:09 PDT (-0700)
Subject:     Re: [PATCH 18/25] mm/riscv: Use mm_fault_accounting()
In-Reply-To: <20200615221607.7764-19-peterx@redhat.com>
CC:     linux-kernel@vger.kernel.org, gerald.schaefer@de.ibm.com,
        akpm@linux-foundation.org, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aarcange@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     peterx@redhat.com
Message-ID: <mhng-261b69ba-d08f-4560-9c69-f4ece64a7729@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 15:16:00 PDT (-0700), peterx@redhat.com wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
>
> Avoid doing page fault accounting multiple times if the page fault is retried.
>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/riscv/mm/fault.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index be84e32adc4c..9262338614d1 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -30,7 +30,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	unsigned long addr, cause;
> -	unsigned int flags = FAULT_FLAG_DEFAULT;
> +	unsigned int flags = FAULT_FLAG_DEFAULT, major = 0;
>  	int code = SEGV_MAPERR;
>  	vm_fault_t fault;
>
> @@ -65,9 +65,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>
>  	if (user_mode(regs))
>  		flags |= FAULT_FLAG_USER;
> -
> -	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> -
>  retry:
>  	down_read(&mm->mmap_sem);
>  	vma = find_vma(mm, addr);
> @@ -111,6 +108,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, addr, flags);
> +	major |= fault & VM_FAULT_MAJOR;
>
>  	/*
>  	 * If we need to retry but a fatal signal is pending, handle the
> @@ -128,21 +126,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
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
>
> @@ -156,6 +140,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	}
>
>  	up_read(&mm->mmap_sem);
> +	mm_fault_accounting(tsk, regs, addr, major);
>  	return;
>
>  	/*

AFAICT this changes the behavior of the perf event: it used to count any fault,
whereas now it only counts those that succeed successfully.  If everyone else
is doing it that way then I'm happy to change us over, but this definately
isn't just avoiding retries.
