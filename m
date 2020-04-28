Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A3C83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFFB206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="L+v+d18v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgD1BSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1BSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:18:01 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C17C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:18:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49B3fr6R2Pz9sSk;
        Tue, 28 Apr 2020 11:17:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588036677;
        bh=juVL2tzpqt8KZA0Tqf+BwLqM7PEsOkcU8g9EORqqDcQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L+v+d18vBLEOn/gVmkkziDeaEGMu+5Y+lw3dQHstKCp//wGIw9+ZfGrJ0MjRa1rCq
         NFtbtq3Yqm2X9UQnUgQgWLZ8kr0sr9QLUAaDfKUD+Gnn2njPpaLAZ4R0GNbu2gwCUj
         BvjwL/lGaqzk/K72N5fxf2KVJL1pFdSQN2tVGi53wq0Esml+JC+Lo8pE2IqcM3gAcS
         j7TusiopHiFHnmZDI0YwRGr9VF5O4LhK+grsXqM4Uugn305Zl1b2YpkQ8y27hsP5Ym
         z/4bn5tgyrVeeHEaQMABMQOr+yrnU0Sr2L248g64KbMEgT9wL3KPrccwXKIkXPAgen
         ++J3VvtQWj7CA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Discard .rela* sections if CONFIG_RELOCATABLE is undefined
In-Reply-To: <20200427211628.4244-1-hjl.tools@gmail.com>
References: <20200427211628.4244-1-hjl.tools@gmail.com>
Date:   Tue, 28 Apr 2020 11:18:13 +1000
Message-ID: <871ro8h0h6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H.J. Lu" <hjl.tools@gmail.com> writes:

> arch/powerpc/kernel/vmlinux.lds.S has
>
>         DISCARDS
>         /DISCARD/ : {
>                 *(*.EMB.apuinfo)
>                 *(.glink .iplt .plt .rela* .comment)
>                 *(.gnu.version*)
>                 *(.gnu.attributes)
>                 *(.eh_frame)
>         }
>
> Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
> change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Please insert this patch into your series prior to the patch that caused
the build break.

cheers

> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 31a0f201fb6f..4ba07734a210 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -366,9 +366,12 @@ SECTIONS
>  	DISCARDS
>  	/DISCARD/ : {
>  		*(*.EMB.apuinfo)
> -		*(.glink .iplt .plt .rela* .comment)
> +		*(.glink .iplt .plt .comment)
>  		*(.gnu.version*)
>  		*(.gnu.attributes)
>  		*(.eh_frame)
> +#ifndef CONFIG_RELOCATABLE
> +		*(.rela*)
> +#endif
>  	}
>  }
> -- 
> 2.25.4
