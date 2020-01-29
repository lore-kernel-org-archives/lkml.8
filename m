Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D43C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B558F207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgA2FSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:18:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2FR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:29 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDk52QMz9s1x; Wed, 29 Jan 2020 16:17:26 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 902137ba8e469ed07c7f120a390161937a6288fb
In-Reply-To: <eaac4b6494ecff1811220fccc895bf282aab884a.1575273217.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 1/8] powerpc/32: Add VDSO version of getcpu on non SMP
Message-Id: <486sDk52QMz9s1x@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:26 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-02 at 07:57:27 UTC, Christophe Leroy wrote:
> Commit 18ad51dd342a ("powerpc: Add VDSO version of getcpu") added
> getcpu() for PPC64 only, by making use of a user readable general
> purpose SPR.
> 
> PPC32 doesn't have any such SPR.
> 
> For non SMP, just return CPU id 0 from the VDSO directly.
> PPC32 doesn't support CONFIG_NUMA so NUMA node is always 0.
> 
> Before the patch, vdsotest reported:
> getcpu: syscall: 1572 nsec/call
> getcpu:    libc: 1787 nsec/call
> getcpu:    vdso: not tested
> 
> Now, vdsotest reports:
> getcpu: syscall: 1582 nsec/call
> getcpu:    libc: 502 nsec/call
> getcpu:    vdso: 187 nsec/call
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patches 1, 2 and 4-8, applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/902137ba8e469ed07c7f120a390161937a6288fb

cheers
