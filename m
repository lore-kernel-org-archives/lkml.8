Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDA8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3EC20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589841313;
	bh=bim+Wqlbpg3ow1ruxMttpLSJEZx5ODlUGcT0+LbS9x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Is3KOkUdbCGcf8ww+O4OMxMczDmZ431OhHlWU1k1aq8+/3KcxSIF9K+BhY1qTPw/L
	 7wZE9RtbkwClyqLhFcYzM8EVg7Mm3BpVj3GfTJ9Y25rz882VEU96aeh3CmixKJYjDt
	 /RWyyFW2wSs4NobN2aXoHfV9DBx9CIMmiPxm58uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgERWfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgERWfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:35:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B32B20756;
        Mon, 18 May 2020 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589841312;
        bh=bim+Wqlbpg3ow1ruxMttpLSJEZx5ODlUGcT0+LbS9x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW9TdC2c/QFLC760zBJw3wq1A6pU7sv35XuqiL3ktsDSb7AnHVhrD1n1NHujzr+6i
         1u+b5j7oBdWo0V5B4DA0cLNUUCBe6PeZ2ZXRTJRreG7KDyN1Ykcipc8Z5LRegzeBsj
         gCmzd+K/dcftxZhEl/xiq7BXIQGYUBjS+EYGZFrk=
Date:   Mon, 18 May 2020 23:35:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH V2] arm64/cpuinfo: Move HWCAP name arrays alongside their
 bit definitions
Message-ID: <20200518223506.GA5866@willie-the-truck>
References: <1588858150-26823-1-git-send-email-anshuman.khandual@arm.com>
 <20200513150405.GS21779@arm.com>
 <0999fa28-3ee7-3f02-4def-a0c6013ec6dd@arm.com>
 <20200514073613.GB4280@willie-the-truck>
 <8ddd0ca5-07c9-3a99-2ec6-4a201725ebe8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ddd0ca5-07c9-3a99-2ec6-4a201725ebe8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:58:05AM +0530, Anshuman Khandual wrote:
> On 05/14/2020 01:06 PM, Will Deacon wrote:
> > Why is it a change? We've never reported e.g. "java" on an arm64 kernel, so
> 
> We already have "java" defined in existing compat_hwcap_str[] array even
> though it might never get set in compat_elf_hwcap. AFAICS, compat_elf_hwcap
> will have the following capabilities set (at the most).
> 
> Via COMPAT_ELF_HWCAP_DEFAULT
> 
> 01.  COMPAT_HWCAP_HALF
> 02.  COMPAT_HWCAP_THUMB
> 03.  COMPAT_HWCAP_FAST_MULT
> 04.  COMPAT_HWCAP_EDSP
> 05.  COMPAT_HWCAP_TLS
> 06.  COMPAT_HWCAP_IDIV
> 07.  COMPAT_HWCAP_LPAE
> 
> Via setup_elf_hwcaps(compat_elf_hwcaps) <-- setup_cpu_features()
> 
> 8.  COMPAT_HWCAP_NEON
> 9.  COMPAT_HWCAP_VFPv4
> 10. COMPAT_HWCAP_VFP
> 11. COMPAT_HWCAP_VFPv3
> 
> Via arch_timer_set_evtstrm_feature()
> 
> 12. COMPAT_HWCAP_EVTSTRM
> 
> The code exists for "java" string to be displayed with /proc/cpuinfo but it
> may never get triggered as compat_elf_hwcap will never have JAVA capability
> unless there is a bug as you had rightly mentioned.

Fair enough, but applying this patch causes a *tonne* of warnings from
aiaiai:

+In file included from arch/arm64/include/asm/cpufeature.h:11,
+                 from arch/arm64/include/asm/ptrace.h:11,
+                 from arch/arm64/include/asm/irqflags.h:10,
+                 from include/linux/irqflags.h:16,
+                 from include/linux/spinlock.h:54,
+                 from include/linux/seqlock.h:36,
+                 from include/linux/time.h:6,
+                 from arch/arm64/include/asm/stat.h:12,
+                 from include/linux/stat.h:6,
+                 from include/linux/module.h:13,
+                 from drivers/media/rc/keymaps/rc-imon-mce.mod.c:1:
+arch/arm64/include/asm/hwcap.h:189:26: warning: ‘compat_hwcap2_str’ defined but not used [-Wunused-const-variable=]
+  189 | static const char *const compat_hwcap2_str[] = {
+      |                          ^~~~~~~~~~~~~~~~~

so I'm dropping this for now.

Will
