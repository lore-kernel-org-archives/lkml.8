Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8558C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9971D21D93
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TOLeaidP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGNIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:50:00 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D494C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:50:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B5Z2s1KYZz9sDX;
        Tue, 14 Jul 2020 18:49:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594716597;
        bh=ujJhlUqzTFfO2DXEvnQ2grI2UssFZKA1JTxfOqu1uWc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TOLeaidPoqQK8PFMDuqbXNoGd9u1ebrlY6iDeNE9VGAT/z82VWUGzceAt5IT9V4sr
         GnMPph+ECKLlXRXqU1vVoQqBAzpYvrVjFjyxzw1BC3VbwF7m21Z0WkI4kdB+/W+nIy
         Aj1x3ro8qhm/MlLJ58AO7qSm0HfcG4cCxGHFYyi6cRz6oSBY0M0pX4W7wliMz+huMZ
         uZQk4O88QL8L+aqIrs5UlRJkjKsvUcK5pfahL8ilPH3x79q3UDpmCG+TcmOBeZ9bEh
         K9Xucu5dhffHTaXNFUQ0jSZz2zEMDtPxDGXLobe24gWRsLof0RNhXEre/lIhbzrlbQ
         XFCBG7EhElFKQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: Build regressions/improvements in v5.8-rc5
In-Reply-To: <CAMuHMdUG9-P_gqCssGQxheTkQKw0PD495eCO-o8xZdbzEsnrrA@mail.gmail.com>
References: <20200713095031.1991-1-geert@linux-m68k.org> <CAMuHMdUG9-P_gqCssGQxheTkQKw0PD495eCO-o8xZdbzEsnrrA@mail.gmail.com>
Date:   Tue, 14 Jul 2020 18:49:53 +1000
Message-ID: <87d04yv5u6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Mon, Jul 13, 2020 at 11:51 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v5.8-rc5[1] to v5.8-rc4[3], the summaries are:
>>   - build errors: +3/-0
>
>   + /kisskb/src/include/linux/compiler-gcc.h: error: #error Sorry,
> your compiler is too old - please upgrade it.:  => 15:3
>   + /kisskb/src/include/linux/compiler.h: error: implicit declaration
> of function '_Generic' [-Werror=implicit-function-declaration]:  =>
> 309:2
>   + /kisskb/src/include/linux/compiler_types.h: error: expected
> expression before 'char':  => 265:5
>
> arcompact/axs101_defconfig, which uses a pre-v4.9 gcc:
>
>     Compiler: arcompact (arc-buildroot-linux-uclibc-gcc (Buildroot
> 2015.08.1) 4.8.4 / GNU ld (GNU Binutils) 2.23.2)
>
> While at it, you may also want to upgrade
>
>     Compiler: arcv2 (arc-linux-gcc.br_real (Buildroot
> 2016.11-git-00613-ge98b4dd) 6.2.1 20160824 / GNU ld (GNU Binutils)
> 2.27.51.20160928)
>
> as it has a buggy definition of size_t, and causes bogus warnings like:
>
>>   + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 205:23
>>   + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 67:23
>>   + /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 2 has type 'ssize_t {aka int}' [-Wformat=]:  => 5:18
>>   + /kisskb/src/kernel/dma/pool.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 249:16

Thanks.

It seems the kernel.org 10.1.0 toolchain can build both arcv2 and
arcompact, so I've added an arc-gcc10 and moved both defconfigs to that
toolchain. Hopefully that will work.

cheers
