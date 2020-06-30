Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD756C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8691620722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="K0xR/Nvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgF3W5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:57:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:55743 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgF3W5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:57:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593557853; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=VpubEwscYy9Um/86J1tXHFPq+iEVca+qWyYHhgHXdzY=; b=K0xR/NvipBz9bWASkykf7+vBfdvgjUXqMa6IQ5lJjc3i1+0BZWlYC1hh21khN1iVaE2NVA3h
 8SdoXjfQXcWTnWYm0V0yOKsLZSLsaaYmetuefVQdskpoo9sIF/W9JY78H/QFC5Fmco1GUEks
 MZrrabcKyCsGxSxWo/NrBF+bK84=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5efbc35dad153efa348e61c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 22:57:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8C15C433A1; Tue, 30 Jun 2020 22:57:32 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43377C433C8;
        Tue, 30 Jun 2020 22:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43377C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Peter Xu'" <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'John Hubbard'" <jhubbard@nvidia.com>,
        "'Michael Ellerman'" <mpe@ellerman.id.au>,
        "'Gerald Schaefer'" <gerald.schaefer@de.ibm.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Will Deacon'" <will@kernel.org>, <linux-hexagon@vger.kernel.org>
References: <20200630204519.38809-1-peterx@redhat.com>
In-Reply-To: <20200630204519.38809-1-peterx@redhat.com>
Subject: RE: [PATCH v4 07/26] mm/hexagon: Use general page fault accounting
Date:   Tue, 30 Jun 2020 17:57:29 -0500
Message-ID: <283701d64f31$d63a11d0$82ae3570$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLNld+hj8aHZMBe5LJcSEztg0/Qa6cDN8Ig
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
...

Acked-by: Brian Cain <bcain@codeaurora.org>

> CC: Brian Cain <bcain@codeaurora.org>
> CC: linux-hexagon@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/hexagon/mm/vm_fault.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
> index f12f330e7946..ef32c5a84ff3 100644
> --- a/arch/hexagon/mm/vm_fault.c
> +++ b/arch/hexagon/mm/vm_fault.c
> @@ -18,6 +18,7 @@
>  #include <linux/signal.h>
>  #include <linux/extable.h>
>  #include <linux/hardirq.h>
> +#include <linux/perf_event.h>
> 
>  /*
>   * Decode of hardware exception sends us to one of several @@ -53,6 +54,8
> @@ void do_page_fault(unsigned long address, long cause, struct pt_regs
> *regs)
> 
>  	if (user_mode(regs))
>  		flags |= FAULT_FLAG_USER;
> +
> +	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  retry:
>  	mmap_read_lock(mm);
>  	vma = find_vma(mm, address);
> @@ -88,7 +91,7 @@ void do_page_fault(unsigned long address, long cause,
> struct pt_regs *regs)
>  		break;
>  	}
> 
> -	fault = handle_mm_fault(vma, address, flags, NULL);
> +	fault = handle_mm_fault(vma, address, flags, regs);
> 
>  	if (fault_signal_pending(fault, regs))
>  		return;
> @@ -96,10 +99,6 @@ void do_page_fault(unsigned long address, long cause,
> struct pt_regs *regs)
>  	/* The most common case -- we are done. */
>  	if (likely(!(fault & VM_FAULT_ERROR))) {
>  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -			if (fault & VM_FAULT_MAJOR)
> -				current->maj_flt++;
> -			else
> -				current->min_flt++;
>  			if (fault & VM_FAULT_RETRY) {
>  				flags |= FAULT_FLAG_TRIED;
>  				goto retry;
> --
> 2.26.2


