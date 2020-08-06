Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67148C4346D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE1F22D03
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgHFHSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:18:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbgHFHSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:18:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 07FD0DE76A8B34F94D7E;
        Thu,  6 Aug 2020 15:18:03 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.173) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 15:17:59 +0800
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated
 assembler
To:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20200805181920.4013059-1-samitolvanen@google.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <95156879-d76e-65cc-1469-ae3096aa95e4@huawei.com>
Date:   Thu, 6 Aug 2020 15:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200805181920.4013059-1-samitolvanen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/8/6 2:19, Sami Tolvanen wrote:
> Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> LLVM's integrated assembler, because -Wa,-march is only passed to
> external assemblers and therefore, the new instructions are not enabled
> when IAS is used.
> 

I have looked through the discussion on Github issues. The best way to
solve this problem is try to pass the "-Wa,-march" parameter to clang
even when IAS is enabled, which may need the cooperation of compilation
tool chains :(

Currently, I think we can solve the problem by passing
the '-march=armv8.4-a' when using the integrated assembler, just like:

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 55bc8546d9c7..e5ce184e98c2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -91,8 +91,12 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)

 ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
 # make sure to pass the newest target architecture to -march.
+ifneq ($(LLVM),)
+KBUILD_CFLAGS  += -march=armv8.4-a
+else
 KBUILD_CFLAGS  += -Wa,-march=armv8.4-a
 endif
+endif

 ifeq ($(CONFIG_SHADOW_CALL_STACK), y)


No need to worry about that this might generate instructions that are not
supported on older hardware, because the 'TLB range' feature is only
enabled when the hardware support ARMv8.4.

> As binutils doesn't support .arch_extension tlb-rmi, this change adds
> .arch armv8.4-a to __TLBI_0 and __TLBI_1 to fix the issue with both LLVM
> IAS and binutils.
> 
> Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1106
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks,
Zhenyu

