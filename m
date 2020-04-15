Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30729C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1167F206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898061AbgDOMLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:11:02 -0400
Received: from foss.arm.com ([217.140.110.172]:43860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441247AbgDOMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3931C1063;
        Wed, 15 Apr 2020 05:07:56 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C653F68F;
        Wed, 15 Apr 2020 05:07:54 -0700 (PDT)
Date:   Wed, 15 Apr 2020 13:07:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Fangrui Song <maskray@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>
Subject: Re: [PATCH v2] arm64: Delete the space separator in __emit_inst
Message-ID: <20200415120752.GD6526@gaia>
References: <20200414163255.66437-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414163255.66437-1-maskray@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:32:55AM -0700, Fangrui Song wrote:
> In assembly, many instances of __emit_inst(x) expand to a directive. In
> a few places __emit_inst(x) is used as an assembler macro argument. For
> example, in arch/arm64/kvm/hyp/entry.S
> 
>   ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
> 
> expands to the following by the C preprocessor:
> 
>   alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1
> 
> Both comma and space are separators, with an exception that content
> inside a pair of parentheses/quotes is not split, so the clang
> integrated assembler splits the arguments to:
> 
>    nop, .inst, (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1
> 
> GNU as preprocesses the input with do_scrub_chars(). Its arm64 backend
> (along with many other non-x86 backends) sees:
> 
>   alternative_insn nop,.inst(0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
>   # .inst(...) is parsed as one argument
> 
> while its x86 backend sees:
> 
>   alternative_insn nop,.inst (0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
>   # The extra space before '(' makes the whole .inst (...) parsed as two arguments
> 
> The non-x86 backend's behavior is considered unintentional
> (https://sourceware.org/bugzilla/show_bug.cgi?id=25750).
> So drop the space separator inside `.inst (...)` to make the clang
> integrated assembler work.
> 
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/939

Queued for 5.7. Thanks.

-- 
Catalin
