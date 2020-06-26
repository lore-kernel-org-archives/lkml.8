Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47778C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACDF20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFZEqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:46:01 -0400
Received: from ozlabs.org ([203.11.71.1]:41671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgFZEp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:45:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTc04WXz9sTC; Fri, 26 Jun 2020 14:45:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ca8c9f8249f523b1fab873e67b81b11989d46553.1592207216.git.christophe.leroy@csgroup.eu>
References: <ca8c9f8249f523b1fab873e67b81b11989d46553.1592207216.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k
Message-Id: <159314672762.1150869.11958650760523739309.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:55 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 07:48:25 +0000 (UTC), Christophe Leroy wrote:
> FIX_EARLY_DEBUG_BASE reserves a 128k area for debuging.
> 
> When page size is 256k, the calculation results in a 0 number of
> pages, leading to the following failure:
> 
>   CC      arch/powerpc/kernel/asm-offsets.s
> In file included from ./arch/powerpc/include/asm/nohash/32/pgtable.h:77:0,
>                  from ./arch/powerpc/include/asm/nohash/pgtable.h:8,
>                  from ./arch/powerpc/include/asm/pgtable.h:20,
>                  from ./include/linux/pgtable.h:6,
>                  from ./arch/powerpc/include/asm/kup.h:42,
>                  from ./arch/powerpc/include/asm/uaccess.h:9,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/crypto.h:21,
>                  from ./include/crypto/hash.h:11,
>                  from ./include/linux/uio.h:10,
>                  from ./include/linux/socket.h:8,
>                  from ./include/linux/compat.h:15,
>                  from arch/powerpc/kernel/asm-offsets.c:14:
> ./arch/powerpc/include/asm/fixmap.h:75:2: error: overflow in enumeration values
>   __end_of_permanent_fixed_addresses,
>   ^
> make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k
      https://git.kernel.org/powerpc/c/03fd42d458fb9cb69e712600bd69ff77ff3a45a8

cheers
