Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57414C433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315D6207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594859265;
	bh=c+fVTIhjyHFgghyi/7Sb5dDTsuDx3+o3PJK8lZ48bZc=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
	 References:List-ID:From;
	b=JESLe52GnTYDhCIp7dVTDPh7sQhqrvOd7XXhSLQ/e6604JgG6xjneFSUbdXHEDdVw
	 aYKyCNHChQ5NMfUhZCCav3cnqKbONr5S4TkaG32ism1z2dpMSKmr5tF/588N96ArPB
	 ZsijDb2LgBs7Uv5Pblw1mC6ZpiKbUUYOBZSnxt+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGPA1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgGPA1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:27:41 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9552076C;
        Thu, 16 Jul 2020 00:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594859260;
        bh=c+fVTIhjyHFgghyi/7Sb5dDTsuDx3+o3PJK8lZ48bZc=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
         References:From;
        b=GsXLp5SoEw62vZbMM7v8mDMwwXURBiY8wtiqUO76qxoGX81bp/YfFO+pqF/Nd3yyo
         N86Wg9M8YsL6eEefDIla58dpYT1aLihNAySJFtbqhhkr3tyh5tHePaYMoH8cFnOWA0
         /DMRm6Xot3c0VOGoRes0SoJKZ+PbcWofi9NEy5CM=
Date:   Thu, 16 Jul 2020 00:27:39 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kumar Gala <galak@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 1/1] powerpc: Fix incorrect stw{,ux,u,x} instructions in __set_pte_at
In-Reply-To: <20200708175423.28442-1-mathieu.desnoyers@efficios.com>
References: <20200708175423.28442-1-mathieu.desnoyers@efficios.com>
Message-Id: <20200716002740.7E9552076C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 9bf2b5cdc5fe ("powerpc: Fixes for CONFIG_PTE_64BIT for SMP support").

The bot has tested the following trees: v5.7.8, v5.4.51, v4.19.132, v4.14.188, v4.9.230, v4.4.230.

v5.7.8: Build OK!
v5.4.51: Build OK!
v4.19.132: Build OK!
v4.14.188: Failed to apply! Possible dependencies:
    45201c8794693 ("powerpc/nohash: Remove hash related code from nohash headers.")
    4e003747043d5 ("powerpc/64s: Replace CONFIG_PPC_STD_MMU_64 with CONFIG_PPC_BOOK3S_64")
    d5808ffaec817 ("powerpc/nohash: Use IS_ENABLED() to simplify __set_pte_at()")

v4.9.230: Failed to apply! Possible dependencies:
    45201c8794693 ("powerpc/nohash: Remove hash related code from nohash headers.")
    4546561551106 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    4e003747043d5 ("powerpc/64s: Replace CONFIG_PPC_STD_MMU_64 with CONFIG_PPC_BOOK3S_64")
    5d451a87e5ebb ("powerpc/64: Retrieve number of L1 cache sets from device-tree")
    7c5b06cadf274 ("KVM: PPC: Book3S HV: Adapt TLB invalidations to work on POWER9")
    83677f551e0a6 ("KVM: PPC: Book3S HV: Adjust host/guest context switch for POWER9")
    902e06eb86cd6 ("powerpc/32: Change the stack protector canary value per task")
    a3d96f70c1477 ("powerpc/64s: Fix system reset vs general interrupt reentrancy")
    bd067f83b0840 ("powerpc/64: Fix naming of cache block vs. cache line")
    d5808ffaec817 ("powerpc/nohash: Use IS_ENABLED() to simplify __set_pte_at()")
    e2827fe5c1566 ("powerpc/64: Clean up ppc64_caches using a struct per cache")
    e9cf1e085647b ("KVM: PPC: Book3S HV: Add new POWER9 guest-accessible SPRs")
    f4c51f841d2ac ("KVM: PPC: Book3S HV: Modify guest entry/exit paths to handle radix guests")

v4.4.230: Failed to apply! Possible dependencies:
    1ca7212932862 ("powerpc/mm: Move PTE bits from generic functions to hash64 functions.")
    26b6a3d9bb48f ("powerpc/mm: move pte headers to book3s directory")
    371352ca0e7f3 ("powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h")
    3dfcb315d81e6 ("powerpc/mm: make a separate copy for book3s")
    ab537dca2f330 ("powerpc/mm: Move hash specific pte width and other defines to book3s")
    b0412ea94bcbd ("powerpc/mm: Drop pte-common.h from BOOK3S 64")
    cbbb8683fb632 ("powerpc/mm: Delete booke bits from book3s")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
