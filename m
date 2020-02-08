Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16808C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E042082E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBHMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 07:50:09 -0500
Received: from ozlabs.org ([203.11.71.1]:51285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHMuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 07:50:08 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48FBpP4qWsz9sRY; Sat,  8 Feb 2020 23:50:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d4bf905307a1c90a27714ff7a9fd29b0a2ceed98
In-Reply-To: <daeacdc0dec0416d1c587cc9f9e7191ad3068dc0.1581095957.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guenter Roeck <linux@roeck-us.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK
Message-Id: <48FBpP4qWsz9sRY@ozlabs.org>
Date:   Sat,  8 Feb 2020 23:50:05 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 17:20:57 UTC, Christophe Leroy wrote:
> When CONFIG_PROVE_LOCKING is selected together with (now default)
> CONFIG_VMAP_STACK, kernel enter deadlock during boot.
> 
> At the point of checking whether interrupts are enabled or not, the
> value of MSR saved on stack is read using the physical address of the
> stack. But at this point, when using VMAP stack the DATA MMU
> translation has already been re-enabled, leading to deadlock.
> 
> Don't use the physical address of the stack when
> CONFIG_VMAP_STACK is set.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 028474876f47 ("powerpc/32: prepare for CONFIG_VMAP_STACK")

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d4bf905307a1c90a27714ff7a9fd29b0a2ceed98

cheers
