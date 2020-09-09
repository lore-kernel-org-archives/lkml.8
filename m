Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C576C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03302087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgIIQbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgIIQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A466C06179F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVv64yJz9sVZ; Wed,  9 Sep 2020 23:27:35 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     hch@infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
References: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/4] powerpc: Remove flush_instruction_cache for book3s/32
Message-Id: <159965716831.808686.749950598970188021.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 05:56:24 +0000 (UTC), Christophe Leroy wrote:
> The only callers of flush_instruction_cache() are:
> 
> arch/powerpc/kernel/swsusp_booke.S:	bl flush_instruction_cache
> arch/powerpc/mm/nohash/40x.c:	flush_instruction_cache();
> arch/powerpc/mm/nohash/44x.c:	flush_instruction_cache();
> arch/powerpc/mm/nohash/fsl_booke.c:	flush_instruction_cache();
> arch/powerpc/platforms/44x/machine_check.c:			flush_instruction_cache();
> arch/powerpc/platforms/44x/machine_check.c:		flush_instruction_cache();
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Remove flush_instruction_cache for book3s/32
      https://git.kernel.org/powerpc/c/e426ab39f41045a4c163031272b2f48d944b69c0
[2/4] powerpc: Move flush_instruction_cache() prototype in asm/cacheflush.h
      https://git.kernel.org/powerpc/c/f663f3312051402d32952c44d156a20c0b854753
[3/4] powerpc: Rewrite 4xx flush_cache_instruction() in C
      https://git.kernel.org/powerpc/c/de39b19452e784de5f90ae899851ab29a29bb42c
[4/4] powerpc: Rewrite FSL_BOOKE flush_cache_instruction() in C
      https://git.kernel.org/powerpc/c/704dfe931df951895dea98bd1d9cacbb601b6451

cheers
