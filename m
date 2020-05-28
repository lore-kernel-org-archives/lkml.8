Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB996C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="A7fz2X4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgE1BDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:03:25 -0400
Received: from ozlabs.org ([203.11.71.1]:33185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgE1BDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:03:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49XTwB4G0Tz9sRK;
        Thu, 28 May 2020 11:03:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590627803;
        bh=N/Z40R+KK3M6wyiKZjsa8P/TxBi0+LFYhTsyo1gvTKc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=A7fz2X4Jn/z7PCmN6BPHq89o5QO57U4B3BrvRBG77+sHqWD1fKk76BbL/eG4omIWp
         EkSpNcKmaDKWnZVFWJN2DMAchGRaEZVkFZRlpABlU/3gCgcRubN4hLALIhPOIcWL7m
         Cz2l+2XPkYJ9savJl+QDyInt60UXqb2l08HS1RaLYpFBxRg/nXc3ZY05pvUHnaSxTo
         4tEiTd4boJEjRBkb+aU0auwr5YSIwkFJgyjfkMHcfxkmDLAEG+A8Y3AQmv3LAKI3Cz
         4Zh6IEFX3iJtZW3qs6M0S9GRdMYwL9Y/qM/fnXxZBEyVH+GA2I5DFPLToku8qmn8ID
         8qfjDdBlYmyew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc/bpf: Enable bpf_probe_read{, str}() on powerpc again
In-Reply-To: <20200527122844.19524-1-pmladek@suse.com>
References: <20200527122844.19524-1-pmladek@suse.com>
Date:   Thu, 28 May 2020 11:03:43 +1000
Message-ID: <87ftbkkh00.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:
> The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
> to archs where they work") caused that bpf_probe_read{, str}() functions
> were not longer available on architectures where the same logical address
> might have different content in kernel and user memory mapping. These
> architectures should use probe_read_{user,kernel}_str helpers.
>
> For backward compatibility, the problematic functions are still available
> on architectures where the user and kernel address spaces are not
> overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>
> At the moment, these backward compatible functions are enabled only
> on x86_64, arm, and arm64. Let's do it also on powerpc that has
> the non overlapping address space as well.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This seems like it should have a Fixes: tag and go into v5.7?

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d13b5328ca10..b29d7cb38368 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -126,6 +126,7 @@ config PPC
>  	select ARCH_HAS_MMIOWB			if PPC64
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
> -- 
> 2.26.2
