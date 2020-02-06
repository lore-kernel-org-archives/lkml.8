Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E70C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9A321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580985545;
	bh=gtIwWtw5fbPPavML5kQUyoCRGV2WDAlOHO8LMQiUGG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FYn97xwU6LWO6DTTSj00M9ObmCxMezu/MLh31JKKDwtD4u5PKupgteyQitdEmqnxc
	 g97vIm3zw74uiaxlf4kgepc/YgFhahFPFHbbxJewoCS8fB+7B9mvwjWjUa49c+JHYZ
	 zSTvr41qBmz1S46C/eDqi2nCQX8iulAIoF1k8pGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgBFKjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgBFKjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:39:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B697D20730;
        Thu,  6 Feb 2020 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580985544;
        bh=gtIwWtw5fbPPavML5kQUyoCRGV2WDAlOHO8LMQiUGG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJF3o1zTd/N4TtE8/XCkOytSP31/QOn96mQWqN1WNfwe0csOLIhqBtuHWzXs3gubA
         tiTMnmqwF9IGwzVNao1obmoHdhpoq86vlHgfv88G1kExMw68NW3PCJjwIauMr/X08D
         xxc8XMjoncKl1o+K47yseG5Qp2Mwf9iF3BAJU/C0=
Date:   Thu, 6 Feb 2020 10:38:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2] perf/arm64: Allow per-task kernel breakpoints
Message-ID: <20200206103858.GB17074@willie-the-truck>
References: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
 <1580768784-25868-3-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580768784-25868-3-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:56:24AM +0530, Bhupesh Sharma wrote:
> commit 478fcb2cdb23 ("arm64: Debugging support") disallowed per-task
> kernel breakpoints on arm64 since these would have potentially
> complicated the stepping code.
> 
> However, we now have several use-cases (for e.g. perf) which require
> per-task address execution h/w breakpoint to be exercised/set on arm64:

To be honest, the perf interface to hw_breakpoint is an abomination and
I think we should remove it entirely for arm64. It's flakey, complicated,
adds code to context-switch and reduces the capabilities available to
ptrace.

> For e.g. we can set address execution h/w breakpoints, using the
> format prescribed by 'perf-list' command:
> mem:<addr>[/len][:access]                          [Hardware breakpoint]
> 
> Without this patch, currently 'perf stat -e' reports that per-task
> address execution h/w breakpoints are 'not supported' on arm64. See
> below:
> 
> $ TEST_FUNC="vfs_read"
> $ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
> $ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null
> 
> <not supported>;;mem:0xffff00001031dd68:x;0;100.00;;
> 
> After this patch, this use-case can be supported:
> 
> $ TEST_FUNC="vfs_read"
> $ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
> $ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null
> 
> 5;;mem:0xfffffe0010361d20:x;912200;100.00;;
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 0b727edf4104..c28f04e02845 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -562,13 +562,6 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  	hw->address &= ~alignment_mask;
>  	hw->ctrl.len <<= offset;
>  
> -	/*
> -	 * Disallow per-task kernel breakpoints since these would
> -	 * complicate the stepping code.
> -	 */
> -	if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
> -		return -EINVAL;
> -

Sorry, but this is broken; the check is there for a reason, not just for
fun!

Look at how the step handler toggles the bp registers.

Will
