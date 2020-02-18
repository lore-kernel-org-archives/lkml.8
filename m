Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC33CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57320722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582016237;
	bh=Oosr7exZhuT7/iQ7DfImqXy4BK7Y5vT4H5twup1j31o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ps81mR2cgcQ8BwQqdTYTVM5YsBAnfAGMpKGJKGFEDjCa9Kcaqi8y3hL0Ab+Tt0TQX
	 6XCPo9f7UMBQYsXjs9h9N5i0M0UUCKAS8iCrmmgHueQz0Uk1/D7M1spjkk7/TI+XEU
	 cjPSdy9wwhrgMy8yYT64BJ8JH48LH8kScTHHaLHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRI5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:57:15 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2219206E2;
        Tue, 18 Feb 2020 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582016235;
        bh=Oosr7exZhuT7/iQ7DfImqXy4BK7Y5vT4H5twup1j31o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFUyiWhi5hiCBPWpiitKj41HumVA0IEmhesanSXeA6225Y0xYwJQk+8bUNO+pIoIx
         907KubtLQrIt2KH+AvfqsosGgJkAIT56+kVCPmMPsfaTB8m42Lyo0hwXHDUtCVMzY2
         x8BMWuXeMK4r0No5M/APDoD3S7L/P3DRoMRKUQRA=
Date:   Tue, 18 Feb 2020 08:57:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 5/5] arm64: Remove TIF_NOHZ
Message-ID: <20200218085709.GB16828@willie-the-truck>
References: <20200214152615.25447-1-frederic@kernel.org>
 <20200214152615.25447-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214152615.25447-6-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:26:15PM +0100, Frederic Weisbecker wrote:
> The syscall slow path is spuriously invoked when context tracking is
> activated while the entry code calls context tracking from fast path.
> 
> Remove that overhead and the unused flag itself while at it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/Kconfig                   | 1 -
>  arch/arm64/include/asm/thread_info.h | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Do you want this to go via the arm64 tree? It looks like it makes sense
on its own to me, so I could pick it as a fix.

Will
