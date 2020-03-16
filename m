Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3AC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C85206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgCPNe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:34:56 -0400
Received: from foss.arm.com ([217.140.110.172]:48402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgCPNe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31D61FEC;
        Mon, 16 Mar 2020 06:34:55 -0700 (PDT)
Received: from [10.37.9.38] (unknown [10.37.9.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9C093F52E;
        Mon, 16 Mar 2020 06:34:49 -0700 (PDT)
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp> <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
 <20200316112205.GE3005@mbp>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9a0a9285-8a45-4f65-3a83-813cabd0f0d3@arm.com>
Date:   Mon, 16 Mar 2020 13:35:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316112205.GE3005@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 3/16/20 11:22 AM, Catalin Marinas wrote:
> On Mon, Mar 16, 2020 at 10:55:00AM +0000, Vincenzo Frascino wrote:
>> On 3/16/20 10:34 AM, Catalin Marinas wrote:
[...]


> 
> As I said above, I don't see how removing 'if ((u32)ts >= (1UL << 32))'
> makes any difference. This check was likely removed by the compiler
> already.
> 
> Also, userspace doesn't have a trivial way to figure out TASK_SIZE and I
> can't see anything that tests this in the vdsotest (though I haven't
> spent that much time looking). If it's hard-coded, note that arm32
> TASK_SIZE is different from TASK_SIZE_32 on arm64.
> 
> Can you tell what actually is failing in vdsotest if you remove the
> TASK_SIZE_32 checks in the arm64 compat vdso?
> 

To me does not seem optimized out. Which version of the compiler are you using?

Please find below the list of errors for clock_gettime (similar for the other):

passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
clock-gettime-monotonic/abi: 1 failures/inconsistencies encountered

passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
clock-gettime-monotonic-coarse/abi: 1 failures/inconsistencies encountered

passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
clock-gettime-realtime/abi: 1 failures/inconsistencies encountered

passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
clock-gettime-realtime-coarse/abi: 1 failures/inconsistencies encountered

Please refer to [1] for more details on the test.

[1]
https://github.com/nlynch-mentor/vdsotest/blob/master/src/clock_gettime_template.c

-- 
Regards,
Vincenzo
