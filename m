Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE175C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7465A20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592293397;
	bh=1pSplotTuJJE4CyD+G9q++EnmPd7meShTvU8xyLK98A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qhe3OcBb4NNGi/O//r8MOZuE4kD4/Fo/Fhad8Q+9E8oZqTN9Qb4yLylGDxuVY/bI0
	 Swi/CVxXeQZ2mKeMbLC0gzztaQNwKP6wEpYI9bW3n80Yy7GpZCETjyQapLD1E8Qp/3
	 ZXaU3qFXyaKbcmRFDAE6W1QWxJ623qcwP+Ids6zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFPHnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFPHnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:43:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7225C20663;
        Tue, 16 Jun 2020 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592293392;
        bh=1pSplotTuJJE4CyD+G9q++EnmPd7meShTvU8xyLK98A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuPgEAc02r/JqeDH31iJkiWWj5azW5vcasRKc2UKkNnkKYt7rUlLB3t8e6YLzm/mp
         tTiI8JNt5w7p08n+zxG+gkvLQxSdAaOfHuJSWmpvUFzU4x1Sm4AGxf9E9b87vpKlvQ
         FybJSAg3ok7ivN2DQjLnxxlJV+K+Q3KvRVj5aS50=
Date:   Tue, 16 Jun 2020 08:43:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/25] mm/arm64: Use mm_fault_accounting()
Message-ID: <20200616074307.GA1637@willie-the-truck>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615221607.7764-7-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:15:48PM -0400, Peter Xu wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/mm/fault.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c9cedc0432d2..09af7d7a60ec 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -484,8 +484,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  					 addr, esr, regs);
>  	}
>  
> -	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> -
>  	/*
>  	 * As per x86, we may deadlock here. However, since the kernel only
>  	 * validly references user space from well defined areas of the code,
> @@ -535,20 +533,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  			      VM_FAULT_BADACCESS)))) {
>  		/*
>  		 * Major/minor page fault accounting is only done
> -		 * once. If we go through a retry, it is extremely
> -		 * likely that the page will be found in page cache at
> -		 * that point.
> +		 * once.
>  		 */
> -		if (major) {
> -			current->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
> -				      addr);
> -		} else {
> -			current->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
> -				      addr);
> -		}
> -
> +		mm_fault_accounting(current, regs, address, major);

Please can you explain why it's ok to move the PERF_COUNT_SW_PAGE_FAULTS
update like this? Seems like a user-visible change to me, so some
justification would really help.

Will
