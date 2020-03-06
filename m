Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA7620870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCFA2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:28:03 -0500
Received: from ozlabs.org ([203.11.71.1]:38271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgCFA1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3X0KXSz9sPJ; Fri,  6 Mar 2020 11:27:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6453f9ed9d4e4b4cdf201bf34bf460c436bf50ea
In-Reply-To: <03c97f0f6b3790d164822563be80f2fd4713a955.1581932480.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Don't kmap_atomic() in pte_offset_map() on PPC32
Message-Id: <48YT3X0KXSz9sPJ@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-17 at 09:41:35 UTC, Christophe Leroy wrote:
> On PPC32, pte_offset_map() does a kmap_atomic() in order to support
> page tables allocated in high memory, just like ARM and x86/32.
> 
> But since at least 2008 and commit 8054a3428fbe ("powerpc: Remove dead
> CONFIG_HIGHPTE"), page tables are never allocated in high memory.
> 
> When the page is in low mem, kmap_atomic() just returns the page
> address but still disable preemption and pagefault. And it is
> not an inlined function, so we suffer function call for no reason.
> 
> Make pte_offset_map() the same as pte_offset_kernel() and make
> pte_unmap() void, in the same way as PPC64 which doesn't have HIGHMEM.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6453f9ed9d4e4b4cdf201bf34bf460c436bf50ea

cheers
