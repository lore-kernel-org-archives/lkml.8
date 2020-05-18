Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A88C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F8F20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589802086;
	bh=7a20FWa41bfTcGNOMC+p9djim0aj+9TMfpuA4C90gYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fvIcQ4TF+f7kqC1Wa+7+MRZUxirs/XSWlEWkyMTz60dRM9/W0cIg2s8uYyo9LKKbp
	 Qzcm6SHSggJy//M5w42qNII8tivdlCVGZMD5taTGBoNTjftr0uMbnBN7Vy5o5wxlYY
	 5W0wy9rERzFLJ+0JDSdxQJEzVUaT3hxXXEPQmiTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgERLlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgERLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:41:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D20A20709;
        Mon, 18 May 2020 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589802084;
        bh=7a20FWa41bfTcGNOMC+p9djim0aj+9TMfpuA4C90gYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dvTkpWpMnj9k0xFpeTjw3FrbmSbeaUKZekRRh/LaYPqmZmvZcfr7EadxkhlKCgZZ
         R5gtlL89QEUfPhvYeaxCD7/NVHiotnzKr55YnG2FSSl813D+9od1Uudpo3LvyPQ4kK
         BpN1aBlNJekML7vqUmwy7B3Kxjepf8Px+hi9y6cs=
Date:   Mon, 18 May 2020 12:41:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        sudeep.holla@arm.com, catalin.marinas@arm.com, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix PTRACE_SYSEMU semantics
Message-ID: <20200518114119.GB32394@willie-the-truck>
References: <20200515222253.GA38408@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515222253.GA38408@juliacomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:22:53PM -0400, Keno Fischer wrote:
> Quoth the man page:
> ```
>        If the tracee was restarted by PTRACE_SYSCALL or PTRACE_SYSEMU, the
>        tracee enters syscall-enter-stop just prior to entering any system
>        call (which will not be executed if the restart was using
>        PTRACE_SYSEMU, regardless of any change made to registers at this
>        point or how the tracee is restarted after this stop).
> ```
> 
> The parenthetical comment is currently true on x86 and powerpc,
> but not currently true on arm64. arm64 re-checks the _TIF_SYSCALL_EMU
> flag after the syscall entry ptrace stop. However, at this point,
> it reflects which method was used to re-start the syscall
> at the entry stop, rather than the method that was used to reach it.
> Fix that by recording the original flag before performing the ptrace
> stop, bringing the behavior in line with documentation and x86/powerpc.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  arch/arm64/kernel/ptrace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index b3d3005d9515..b67b4d14aa17 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1829,10 +1829,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,
>  
>  int syscall_trace_enter(struct pt_regs *regs)
>  {
> -	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
> -		test_thread_flag(TIF_SYSCALL_EMU)) {
> +	u32 flags = READ_ONCE(current_thread_info()->flags) &
> +		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> +
> +	if (flags) {

nit: but I'd rather the '&' operation was in the conditional so that the
'flags' variable holds all of the flags.

With that:

Acked-by: Will Deacon <will@kernel.org>

Also needs:

Cc: <stable@vger.kernel.org>
Fixes: f086f67485c5 ("arm64: ptrace: add support for syscall emulation")

Catalin -- can you pick this up for 5.7 please, with my 'nit' addressed?

Will
