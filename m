Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ACD207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aqU1Kwc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEYFjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgEYFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:39:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304EEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:39:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49VmBR520kz9sSd;
        Mon, 25 May 2020 15:39:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590385183;
        bh=70h4YhpOdO2kfsEqmyTiggPpMIWWTu8kc/yJQERVsbI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aqU1Kwc5zrGM46XLxjK3UFd7TYdql2+K1plaCm/cATYJE7AwboQLNpD3h/TsxnOLC
         0Ak138M2olx39PxCR/L8Z0dhU2J1FFIWyU43AVurglkUOY3jqcihV9jr1O+o+XD0jh
         dbvmqs49oxDQD/8gTJajABnkPkwgkpYwf/dZXZzskVOEuszyTLbcI6JvifeP/FR8IO
         CJbPfPtrz4cyqwpDH7oR85gqKQRqW2MCZmzjBrA4VS6S8F+D6eSyLB6JIN9MH6+RXo
         Ddvl+kc6YEgN9VIlWeuh7IRUA3iLQBBoaQhIkSpwbtDWumbVirMX1Ta190i4op7ZK7
         QT7cyLThCGhQQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/45] powerpc/32s: Don't warn when mapping RO data ROX.
In-Reply-To: <6499f8eeb2a36330e5c9fc1cee9a79374875bd54.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu> <6499f8eeb2a36330e5c9fc1cee9a79374875bd54.1589866984.git.christophe.leroy@csgroup.eu>
Date:   Mon, 25 May 2020 15:40:06 +1000
Message-ID: <87eer8fu89.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Mapping RO data as ROX is not an issue since that data
> cannot be modified to introduce an exploit.

Being pedantic: it is still an issue, in that it means there's more
targets for a code-reuse attack.

But given the entire kernel text is also available for code-reuse
attacks, the RO data is unlikely to contain any useful sequences that
aren't also in the kernel text.

> PPC64 accepts to have RO data mapped ROX, as a trade off
> between kernel size and strictness of protection.
>
> On PPC32, kernel size is even more critical as amount of
> memory is usually small.

Yep, I think it's a reasonable trade off to make.

cheers

> Depending on the number of available IBATs, the last IBATs
> might overflow the end of text. Only warn if it crosses
> the end of RO data.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/book3s32/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
> index 39ba53ca5bb5..a9b2cbc74797 100644
> --- a/arch/powerpc/mm/book3s32/mmu.c
> +++ b/arch/powerpc/mm/book3s32/mmu.c
> @@ -187,6 +187,7 @@ void mmu_mark_initmem_nx(void)
>  	int i;
>  	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
>  	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
> +	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
>  	unsigned long size;
>  
>  	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
> @@ -201,9 +202,10 @@ void mmu_mark_initmem_nx(void)
>  		size = block_size(base, top);
>  		size = max(size, 128UL << 10);
>  		if ((top - base) > size) {
> -			if (strict_kernel_rwx_enabled())
> -				pr_warn("Kernel _etext not properly aligned\n");
>  			size <<= 1;
> +			if (strict_kernel_rwx_enabled() && base + size > border)
> +				pr_warn("Some RW data is getting mapped X. "
> +					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
>  		}
>  		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
>  		base += size;
> -- 
> 2.25.0
