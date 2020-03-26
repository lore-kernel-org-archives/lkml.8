Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFECC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgCZLPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:15:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgCZLPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD1087FA;
        Thu, 26 Mar 2020 04:15:39 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 531823F71F;
        Thu, 26 Mar 2020 04:15:36 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:15:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <20200326111521.GA72909@C02TD0UTHF1T.local>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
 <20200325132127.GB12236@lakrids.cambridge.arm.com>
 <202003251319.AECA788D63@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003251319.AECA788D63@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 01:22:07PM -0700, Kees Cook wrote:
> On Wed, Mar 25, 2020 at 01:21:27PM +0000, Mark Rutland wrote:
> > On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> > > Allow for a randomized stack offset on a per-syscall basis, with roughly
> > > 5 bits of entropy.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Just to check, do you have an idea of the impact on arm64? Patch 3 had
> > figures for x86 where it reads the TSC, and it's unclear to me how
> > get_random_int() compares to that.
> 
> I didn't do a measurement on arm64 since I don't have a good bare-metal
> test environment. I know Andy Lutomirki has plans for making
> get_random_get() as fast as possible, so that's why I used it here.

Ok. I suspect I also won't get the chance to test that in the next few
days, but if I do I'll try to share the results.

My concern here was that, get_random_int() has to grab a spinlock and
mess with IRQ masking, so has the potential to block for much longer,
but that might not be an issue in practice, and I don't think that
should block these patches.

> I couldn't figure out if there was a comparable instruction like rdtsc
> in aarch64 (it seems there's a cycle counter, but I found nothing in
> the kernel that seemed to actually use it)?

AArch64 doesn't have a direct equivalent. The generic counter
(CNTxCT_EL0) is the closest thing, but its nominal frequency is
typically much lower than the nominal CPU clock frequency (unlike TSC
where they're the same). The cycle counter (PMCCNTR_EL0) is part of the
PMU, and can't be relied on in the same way (e.g. as perf reprograms it
to generate overflow events, and it can stop for things like WFI/WFE).

Thanks,
Mark.
