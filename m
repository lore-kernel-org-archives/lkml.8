Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0B20672
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDYXvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYXvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:51:19 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9ECC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:51:18 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 498nqm63yRz9sSg; Sun, 26 Apr 2020 09:51:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: feb8e960d780e170e992a70491eec9dd68f4dbf2
In-Reply-To: <540242f7d4573f7cdf1b3bf46bb35f743b2cd68f.1587124651.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Fix CONFIG_PPC_KUAP_DEBUG on PPC32
Message-Id: <498nqm63yRz9sSg@ozlabs.org>
Date:   Sun, 26 Apr 2020 09:51:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 11:58:36 UTC, Christophe Leroy wrote:
> CONFIG_PPC_KUAP_DEBUG is not selectable because it depends on PPC_32
> which doesn't exists.
> 
> Fixing it leads to a deadlock due to a vital register getting
> clobbered in _switch().
> 
> Change dependency to PPC32 and use r0 instead of r4 in _switch()
> 
> Fixes: e2fb9f544431 ("powerpc/32: Prepare for Kernel Userspace Access Protection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/feb8e960d780e170e992a70491eec9dd68f4dbf2

cheers
