Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC323C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53C52071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDYXvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:51:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44303 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgDYXvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:51:19 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 498nqn4vzVz9sSh; Sun, 26 Apr 2020 09:51:17 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b61c38baa98056d4802ff5be5cfb979efc2d0f7a
In-Reply-To: <485caac75f195f18c11eb077b0031fdd2bb7fb9e.1587361039.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/8xx: Fix STRICT_KERNEL_RWX startup test failure
Message-Id: <498nqn4vzVz9sSh@ozlabs.org>
Date:   Sun, 26 Apr 2020 09:51:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 05:37:42 UTC, Christophe Leroy wrote:
> WRITE_RO lkdtm test works.
> 
> But when selecting CONFIG_DEBUG_RODATA_TEST, the kernel reports
> 	rodata_test: test data was not read only
> 
> This is because when rodata test runs, there are still old entries
> in TLB.
> 
> Flush TLB after setting kernel pages RO or NX.
> 
> Fixes: d5f17ee96447 ("powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b61c38baa98056d4802ff5be5cfb979efc2d0f7a

cheers
