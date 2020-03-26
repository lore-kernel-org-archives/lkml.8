Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93456C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EB320714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCZMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:06:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCZMGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cb04HBz9sSV; Thu, 26 Mar 2020 23:06:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: af92bad615be75c6c0d1b1c5b48178360250a187
In-Reply-To: <4e7b56865e01569058914c991143f5961b5d4719.1583507333.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kasan: Fix kasan_remap_early_shadow_ro()
Message-Id: <48p3cb04HBz9sSV@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 15:09:40 UTC, Christophe Leroy wrote:
> At the moment kasan_remap_early_shadow_ro() does nothing, because
> k_end is 0 and k_cur < 0 is always true.
> 
> Change the test to k_cur != k_end, as done in
> kasan_init_shadow_page_tables()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: cbd18991e24f ("powerpc/mm: Fix an Oops in kasan_mmu_init()")
> Cc: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af92bad615be75c6c0d1b1c5b48178360250a187

cheers
