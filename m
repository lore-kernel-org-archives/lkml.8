Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86083C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30420842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581357144;
	bh=w4QaI4rwl8xDK0pPvWLaHd5U0Rdh0Tn4UR8oOFoh5Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fJHj1UMxg0smQsl+CWFr+p3323Wx0dL+M9ABDcv5/+iqa22NzOcX4uBsKr03jF5Pw
	 465MdWZdeF5a6T174QUibwBVjdxlDE+T+8zVlzWNsiLojDLycfoGY/J3ttX/x3DHlT
	 0SCdWsDdE95thb8oNCi+L0WAVFhxLHX7QRFIRaU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgBJRwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJRwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:52:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5BB20715;
        Mon, 10 Feb 2020 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581357142;
        bh=w4QaI4rwl8xDK0pPvWLaHd5U0Rdh0Tn4UR8oOFoh5Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwvUPgIlRB37NIGfkknNFZdWlQ7zdhhxoI9oOpxIjAVtbw5kEW46Z3Xua3ED9FVVz
         Qe5ek2fpczwxrW3E2Q2bxRjmv2GVXM5HzJ/+ZCQ75nikohMXSsDTxFneXJ9W328+oF
         NUm3yhGlentzJM3zl1Cd+UZ7gCE75VqB9vrOyToY=
Date:   Mon, 10 Feb 2020 17:52:15 +0000
From:   Will Deacon <will@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
Message-ID: <20200210175214.GA23318@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:18:58PM +0000, James Morse wrote:
> On 28/01/2020 18:49, Sami Tolvanen wrote:
> > Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
> > different exception level.
> 
> Hmmm, there are two things being disabled here.
> 
> Stashing the lr in memory pointed to by VA won't work transparently at EL2 ... but
> shouldn't KVM's C code still treat x18 as a fixed register?

My review of v6 suggested dropping the -ffixed-x18 as well, since it's only
introduced by SCS (in patch 5) and so isn't required by anything else. Why
do you think it's needed?

> As you have an __attribute__((no_sanitize("shadow-call-stack"))), could we add that to
> __hyp_text instead? (its a smaller hammer!) All of KVM's EL2 code is marked __hyp_text,
> but that isn't everything in these files. Doing it like this would leave KVM's VHE-only
> paths covered.
> 
> As an example, with VHE the kernel and KVM both run at EL2, and KVM behaves differently:
> kvm_vcpu_put_sysregs() in kvm/hyp/sysreg-sr.c is called from a preempt notifier as
> the EL2 registers are always accessible.

That's a good point, and I agree that it would be nice to have SCS covering
the VHE paths. If you do that as a function attribute (which feels pretty
fragile to me), then I guess we'll have to keep the -ffixed-x18 for the
non-VHE code after all because GCC at least doesn't like having the register
saving ABI specified on a per-function basis.

Will
