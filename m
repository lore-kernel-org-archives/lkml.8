Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A8C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24AFA20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG0H0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:26:47 -0400
Received: from ozlabs.org ([203.11.71.1]:43153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0H0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWZs6fFyz9sTQ; Mon, 27 Jul 2020 17:26:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1593428200.git.christophe.leroy@csgroup.eu>
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 0/6] powerpc/32s: Allocate modules outside of vmalloc space for STRICT_KERNEL_RWX
Message-Id: <159583478807.602200.856546124460688008.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:45 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 11:15:19 +0000 (UTC), Christophe Leroy wrote:
> On book3s32 (hash), exec protection is set per 256Mb segments with NX bit.
> Instead of clearing NX bit on vmalloc space when CONFIG_MODULES is selected,
> allocate modules in a dedicated segment (0xb0000000-0xbfffffff by default).
> This allows to keep exec protection on vmalloc space while allowing exec
> on modules.
> 
> v2:
> - Removed the two patches that fix ptdump. Will submitted independently
> - Only changing the user/kernel boundary for PPC32 now.
> - Reordered the patches inside the series.
> 
> [...]

Applied to powerpc/next.

[1/6] powerpc/lib: Prepare code-patching for modules allocated outside vmalloc space
      https://git.kernel.org/powerpc/c/ccc8fcf72a6953fbfd6998999d622295f522b952
[2/6] powerpc: Use MODULES_VADDR if defined
      https://git.kernel.org/powerpc/c/7fbc22ce29931630da200cfc90fe5a454f54a794
[3/6] powerpc/32s: Only leave NX unset on segments used for modules
      https://git.kernel.org/powerpc/c/c496433197154144c310a17939736bc5c155914d
[4/6] powerpc/32: Set user/kernel boundary at TASK_SIZE instead of PAGE_OFFSET
      https://git.kernel.org/powerpc/c/b6be1bb7f7216b9e9f33f57abe6e3290c0e66bd4
[5/6] powerpc/32s: Kernel space starts at TASK_SIZE
      https://git.kernel.org/powerpc/c/f1a1f7a15eb0e13b84791ff2738b84e414501718
[6/6] powerpc/32s: Use dedicated segment for modules with STRICT_KERNEL_RWX
      https://git.kernel.org/powerpc/c/6ca055322da8fe25ff9ac50db6f3b7b59b6f961c

cheers
