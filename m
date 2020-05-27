Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C520873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgE0M3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:29:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:35712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgE0M3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE142AF4C;
        Wed, 27 May 2020 12:29:13 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] powerpc/bpf: Enable bpf_probe_read{, str}() on powerpc again
Date:   Wed, 27 May 2020 14:28:44 +0200
Message-Id: <20200527122844.19524-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
to archs where they work") caused that bpf_probe_read{, str}() functions
were not longer available on architectures where the same logical address
might have different content in kernel and user memory mapping. These
architectures should use probe_read_{user,kernel}_str helpers.

For backward compatibility, the problematic functions are still available
on architectures where the user and kernel address spaces are not
overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

At the moment, these backward compatible functions are enabled only
on x86_64, arm, and arm64. Let's do it also on powerpc that has
the non overlapping address space as well.

Signed-off-by: Petr Mladek <pmladek@suse.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d13b5328ca10..b29d7cb38368 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,6 +126,7 @@ config PPC
 	select ARCH_HAS_MMIOWB			if PPC64
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
-- 
2.26.2

