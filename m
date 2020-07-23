Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D597C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A0E20888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595499041;
	bh=a1WzAHo+biXl5w0NzqYWMIoRKb3m/CzdIfGSUqtwS4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=07TADQIwee28sN6zgWC8M+c3aaS8dE3PKZePRrFy8qasVAPNL9sPiduSP6pQaVvTe
	 RjhuvFaVARvsdlfud/fRMgbkwfRO2kvGeNwg+V4oibhPMOY8dWtSg9hN6P1n9S8klK
	 pVw/CzPS72t59Wen3fNjVjGXrKnBQIyUMHE5RXYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGWKKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGWKKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:10:39 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA7F2065F;
        Thu, 23 Jul 2020 10:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595499039;
        bh=a1WzAHo+biXl5w0NzqYWMIoRKb3m/CzdIfGSUqtwS4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYQ1TlTy2848u2ByB+eOiTJCsGRtnrKiUhSRnTK2xDcxH/9SxffbLXLVxn33hsY+T
         qOKEk9rKsZJ3Kk51Hr/L5xopzCnkS7tW/EYWwNBqbeGOJ0qKU+EfdbCIO2p8Y5NfLb
         1Ex5KAiIvy3lNBbuppwt4SR7H21PUpZUWsjgBXIc=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: vdso32: Fix '--prefix=' value for newer versions of clang
Date:   Thu, 23 Jul 2020 11:10:31 +0100
Message-Id: <159549825312.3524506.8970900568207744647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723041509.400450-1-natechancellor@gmail.com>
References: <20200723041509.400450-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 21:15:10 -0700, Nathan Chancellor wrote:
> Newer versions of clang only look for $(COMPAT_GCC_TOOLCHAIN_DIR)as [1],
> rather than $(COMPAT_GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE_COMPAT)as,
> resulting in the following build error:
> 
> $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
> CROSS_COMPILE_COMPAT=arm-linux-gnueabi- LLVM=1 O=out/aarch64 distclean \
> defconfig arch/arm64/kernel/vdso32/
> ...
> /home/nathan/cbl/toolchains/llvm-binutils/bin/as: unrecognized option '-EL'
> clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
> make[3]: *** [arch/arm64/kernel/vdso32/Makefile:181: arch/arm64/kernel/vdso32/note.o] Error 1
> ...
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso32: Fix '--prefix=' value for newer versions of clang
      https://git.kernel.org/arm64/c/7b7891c7bdfd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
