Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40D820775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgFZEoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFZEoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:44:10 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2508C08C5C1;
        Thu, 25 Jun 2020 21:44:10 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPRV4sP6z9sSc; Fri, 26 Jun 2020 14:44:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Arseny Solokha <asolokha@kb.kras.ru>,
        Jason Yan <yanaijie@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200613162801.1946619-1-asolokha@kb.kras.ru>
References: <20200613162801.1946619-1-asolokha@kb.kras.ru>
Subject: Re: [PATCH] powerpc/fsl_booke/32: fix build with CONFIG_RANDOMIZE_BASE
Message-Id: <159314666217.1149515.5146980084667255752.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:44:06 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jun 2020 23:28:01 +0700, Arseny Solokha wrote:
> Building the current 5.8 kernel for a e500 machine with
> CONFIG_RANDOMIZE_BASE set yields the following failure:
> 
>   arch/powerpc/mm/nohash/kaslr_booke.c: In function 'kaslr_early_init':
>   arch/powerpc/mm/nohash/kaslr_booke.c:387:2: error: implicit declaration
> of function 'flush_icache_range'; did you mean 'flush_tlb_range'?
> [-Werror=implicit-function-declaration]
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/fsl_booke/32: Fix build with CONFIG_RANDOMIZE_BASE
      https://git.kernel.org/powerpc/c/7e4773f73dcfb92e7e33532162f722ec291e75a4

cheers
