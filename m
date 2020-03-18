Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9F20719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCRSGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:06:34 -0400
Received: from foss.arm.com ([217.140.110.172]:52926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85E261FB;
        Wed, 18 Mar 2020 11:06:33 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8FD3F67D;
        Wed, 18 Mar 2020 11:06:32 -0700 (PDT)
Date:   Wed, 18 Mar 2020 18:06:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200318180630.GE94111@arrakis.emea.arm.com>
References: <20200316124046.103844-1-remi@remlab.net>
 <20200318175709.GD94111@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318175709.GD94111@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:57:09PM +0000, Catalin Marinas wrote:
> On Mon, Mar 16, 2020 at 02:40:44PM +0200, Rémi Denis-Courmont wrote:
> > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > 
> > This switches from custom instruction patterns to the regular large
> > memory model sequence with ADRP and LDR. In doing so, the ADD
> > instruction can be eliminated in the SDEI handler, and the code no
> > longer assumes that the trampoline vectors and the vectors address both
> > start on a page boundary.
> > 
> > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> I queued the 3 trampoline patches for 5.7. Thanks.

... and removed. I applied them on top of arm64 for-next/asm-annotations
and with defconfig I get:

  LD      .tmp_vmlinux1
arch/arm64/kernel/entry.o: in function `tramp_vectors':
arch/arm64/kernel/entry.S:838:(.entry.tramp.text+0x43c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:838: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:839:(.entry.tramp.text+0x4bc): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:839: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:840:(.entry.tramp.text+0x53c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:840: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:841:(.entry.tramp.text+0x5bc): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:841: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:843:(.entry.tramp.text+0x638): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:843: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:844:(.entry.tramp.text+0x6b8): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:844: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:845:(.entry.tramp.text+0x738): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:845: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
arch/arm64/kernel/entry.S:846:(.entry.tramp.text+0x7b8): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `__entry_tramp_data_start' defined in .rodata section in arch/arm64/kernel/entry.o
ld: arch/arm64/kernel/entry.S:846: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
make[1]: *** [Makefile:1077: vmlinux] Error 1

I haven't bisected to see which patch caused this issue.

$ gcc --version
gcc (Debian 9.2.1-30) 9.2.1 20200224

$ ld --version
GNU ld (GNU Binutils for Debian) 2.34

-- 
Catalin
