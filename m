Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057FDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B987820656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qO/OMYnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGGAJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGGAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:09:29 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF833C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:09:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B12qT2dbbz9s1x;
        Tue,  7 Jul 2020 10:09:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1594080566; bh=vfriFgCEX80IKc2W7gQxZwAofw9bTCTuRySBYJfviU4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qO/OMYnKuE38IEhe1s+zk43bHqptD1dX1GHLx14XQi8vWYubVanp4ogu0lDyWfzGB
         YFLVBGSH/Wn+jZIBFV98PBV3i1RZV16l/EtGbC3VDdO+yr6c95ohALXx60UOxzg2K2
         nBOK13r4VYrJv09TGiOlueddmGXMGRRZDLxR79v1k3o1UNGXdg02r4Z7lho1EHNBue
         zpYM0XfVqYbbU5GMhsbA0nOz0KlpyJQm8hlZzlUi+iBpdUyoFLLP/yHMaOFCPVF2tV
         Rvl6lVnBzFKDod37nKXW9d/HG0nhsgvyXc54FVgVNqIGM9Louh/LUwZBSiILcTVvFw
         b6iSsKNFvwkhQ==
Message-ID: <824bc474550e8ddd2534d56d57e2a929d4116b9e.camel@ozlabs.org>
Subject: Re: [PATCH] powerpc/spufs: add CONFIG_COREDUMP dependency
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jul 2020 08:09:21 +0800
In-Reply-To: <20200706132302.3885935-1-arnd@arndb.de>
References: <20200706132302.3885935-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> The kernel test robot pointed out a slightly different error message
> after recent commit 5456ffdee666 ("powerpc/spufs: simplify spufs core
> dumping") to spufs for a configuration that never worked:
> 
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in
> function `.spufs_proxydma_info_dump':
> > > file.c:(.text+0x4c68): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in
> function `.spufs_dma_info_dump':
>    file.c:(.text+0x4d70): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in
> function `.spufs_wbox_info_dump':
>    file.c:(.text+0x4df4): undefined reference to `.dump_emit'
> 
> Add a Kconfig dependency to prevent this from happening again.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, thanks.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

