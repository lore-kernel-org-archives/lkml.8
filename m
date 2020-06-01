Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B97E2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035514;
	bh=Ns5X64qYx6T9/KIhZSJGX28kOwogjGNMcAh17sqAU/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RcQv/ov3u9vFfREOfT6knLeQb5JggF/VDIgMP5ghBr5MTUMV1bus+nXHMgzaTt+89
	 UsYPn7HKUtXkz27M4HX9xJmrF56F1dJukCxZppMcyNQRRQFqOvGvX9vHWCdUQwiaY8
	 EJkfevD/TaMHKNjYQuokibPE/qlVVEtByGEmD/2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgFASSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgFASSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5562068D;
        Mon,  1 Jun 2020 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035484;
        bh=Ns5X64qYx6T9/KIhZSJGX28kOwogjGNMcAh17sqAU/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtU7uWa/HVL2NF0ZYgneleNqkP3lESa1OKyize0q11c3OTRw5vV4jtgdryi/7toyD
         E/AwfH5A9NGTxUFN8sH8NzK97xoMz+7f092OQ4VZZh+TeF9UPvO1A2sejU1xHrzNhy
         PQMcsywDqNQE8RddPQ9UMffadNvkOnGYwr+0ztu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.6 173/177] powerpc/bpf: Enable bpf_probe_read{, str}() on powerpc again
Date:   Mon,  1 Jun 2020 19:55:11 +0200
Message-Id: <20200601174102.468155104@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

commit d195b1d1d1196681ac4775e0361e9cca70f740c2 upstream.

The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
to archs where they work") caused that bpf_probe_read{, str}() functions
were not longer available on architectures where the same logical address
might have different content in kernel and user memory mapping. These
architectures should use probe_read_{user,kernel}_str helpers.

For backward compatibility, the problematic functions are still available
on architectures where the user and kernel address spaces are not
overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

At the moment, these backward compatible functions are enabled only on x86_64,
arm, and arm64. Let's do it also on powerpc that has the non overlapping
address space as well.

Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/lkml/20200527122844.19524-1-pmladek@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -125,6 +125,7 @@ config PPC
 	select ARCH_HAS_MMIOWB			if PPC64
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS


