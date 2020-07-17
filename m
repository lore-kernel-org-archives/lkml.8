Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3435AC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0839120775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594982641;
	bh=tMXpu57E8Vx7cqcnyKoKA4Db0cNZFac86QieI1k1G7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TB7sXeoYkzZDpEl9u8bVtmUfIkV4iR9JX2BC3cvJ4JQUpvjTrJYJmTVdz7wgrPga0
	 8/wiJURuJomCJrXmijPjsNoTOspCPL9OpAwte86m0HhIV3LeOxQKyylbmrpSaPCkQ2
	 zVMOpTOYZv1Y93/Q/4mJXjybT0t14lD1WpiuVxVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgGQKn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:43:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B1F20775;
        Fri, 17 Jul 2020 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594982636;
        bh=tMXpu57E8Vx7cqcnyKoKA4Db0cNZFac86QieI1k1G7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK8HTzbW5jB5n7zXDrkue0wGo8BaekBTsYKRLiz2jydjNFmCdMU4P9w01S7XptT5a
         5NPbKI40mHeFrJVBw337jP2fD9pRU5PxhdtGMfX4c2NxVgqh7TrSz8rB8OmA5zzIew
         hPhOS4WRrBv8QCh8bJUOeJ9/lWYjDpN+2z3hVC4k=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date:   Fri, 17 Jul 2020 11:43:43 +0100
Message-Id: <159497652409.524891.6561966096386113237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
References: <20200716112816.7356-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 12:28:16 +0100, Will Deacon wrote:
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
      https://git.kernel.org/arm64/c/bd024e82e4cd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
