Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231E120738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="huZjoq5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgGMMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:32:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:32:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B531z0mNJz9sQt;
        Mon, 13 Jul 2020 22:32:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594643545;
        bh=MqWMoeDNwlUAHlcs0wWO5CUaK7kc9jQIHbwysyqNKzE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=huZjoq5TXwq98uPA/wjGPFbbrESigMSKQbqC1SI/KU7B00Nn3h+zEMxwkqmlAUZL+
         CC65/DsbXm11/6KxT8nk2apPPcXW3uA7sT+WdfsSMSac1SdlqQJQf4emNH06cGQmro
         a0iHEaquMXdj6FSQCHaWaHyC0umMMAOXCfJqn1Y2vafN0UOMJCyL1aU8P9juC6TCpI
         FVUzJi1QCXPtSNISS2qaoIR3GaBo4TtzwVrg3jxn9VkfBL/55qy+wG7Rmh9HqYkj14
         vYQIAeiEqi4xeJE6EIrbMWxJ2kXganV4j2SeT9FWNGH+EVc84Ml7CyErbc9iFiWRJ3
         UTZk9VBuwglWg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/boot: add DTB to 'targets'
In-Reply-To: <20200713075629.5948-1-masahiroy@kernel.org>
References: <20200713075629.5948-1-masahiroy@kernel.org>
Date:   Mon, 13 Jul 2020 22:34:43 +1000
Message-ID: <87sgdvvbj0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> PowerPC always re-builds DTB even if nothing has been changed.
>
> As for other architectures, arch/*/boot/dts/Makefile builds DTB by
> using the dtb-y syntax.
>
> In contrast, arch/powerpc/boot/dts/(fsl/)Makefile does nothing unless
> CONFIG_OF_ALL_DTBS is defined. Instead, arch/powerpc/boot/Makefile
> builds DTB on demand. You need to add DTB to 'targets' explicitly
> so .*.cmd files are included.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I want to apply this to kbuild tree because this is needed
> to fix the build error caused by another kbuild patch:
>
> https://lkml.org/lkml/2020/7/7/134

OK.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 63d7456b9518..8792323707fd 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -366,6 +366,8 @@ initrd-y := $(patsubst zImage%, zImage.initrd%, \
>  		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))))
>  initrd-y := $(filter-out $(image-y), $(initrd-y))
>  targets	+= $(image-y) $(initrd-y)
> +targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
> +		$(patsubst $(x).%, dts/%.dtb, $(filter $(x).%, $(image-y))))
>  
>  $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>  
> -- 
> 2.25.1
