Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B566DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195E92311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgHFQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:22 -0400
Received: from foss.arm.com ([217.140.110.172]:45202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgHFQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 515231045;
        Thu,  6 Aug 2020 04:30:57 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC7C3F99C;
        Thu,  6 Aug 2020 04:30:55 -0700 (PDT)
Date:   Thu, 6 Aug 2020 12:30:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated
 assembler
Message-ID: <20200806113053.GB23785@gaia>
References: <20200805181920.4013059-1-samitolvanen@google.com>
 <CAKwvOdncvJbxphoDFdWTeiMnuu4pDie9xCxA-dC=__CK9p1KBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdncvJbxphoDFdWTeiMnuu4pDie9xCxA-dC=__CK9p1KBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 12:15:54PM -0700, Nick Desaulniers wrote:
> On Wed, Aug 5, 2020 at 11:19 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> > LLVM's integrated assembler, because -Wa,-march is only passed to
> > external assemblers and therefore, the new instructions are not enabled
> > when IAS is used.
> >
> > As binutils doesn't support .arch_extension tlb-rmi, this change adds
> > .arch armv8.4-a to __TLBI_0 and __TLBI_1 to fix the issue with both LLVM
> > IAS and binutils.
> >
> > Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1106
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> I've filed https://sourceware.org/bugzilla/show_bug.cgi?id=26339 to
> discuss more with ARM binutils devs about some of the compat issues
> around these assembler directives.

Until we get some alignment between binutils and the LLVM's integrated
assembler, the latter will be officially unsupported by the kernel. It's
just insane to maintain different options for architecture extensions,
e.g. memtag vs mte, armv8.4-a vs tlb-rmi. Even worse, I think you can't
add some .arch_extension in binutils without bumping the .arch version.
So maybe ".arch_extension tlb-rmi" works for the integrated assembler
but, if such option is added to binutils, it would require ".arch
armv8.4-a" as well.

So, please sort it out guys, collaborate between yourselves when
inventing architecture mnemonics so that you are aligned.

We make take the occasional patch to fix the integrated assembler if
it's not intrusive but at some point we may say it's just not supported
and reject the fix. We have a hard line on the compiler not generating
newer than ARMv8.0 instructions (unless they are in the NOP/HINT space),
so we limit newer instructions to (inline) asm. That's why -march
doesn't work, it needs to be -Wa,-march.

-- 
Catalin
