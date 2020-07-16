Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B7C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF87B2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGPM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgGPM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:10 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:10 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPv5kPyz9sVP; Thu, 16 Jul 2020 22:56:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Geoff Levand <geoff@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20200624035920.835571-1-natechancellor@gmail.com>
References: <20200624035920.835571-1-natechancellor@gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
Message-Id: <159490400429.3805857.14182608515747263467.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:59:20 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> arch/powerpc/boot/main.c:107:18: warning: array comparison always
> evaluates to a constant [-Wtautological-compare]
>         if (_initrd_end > _initrd_start) {
>                         ^
> arch/powerpc/boot/main.c:155:20: warning: array comparison always
> evaluates to a constant [-Wtautological-compare]
>         if (_esm_blob_end <= _esm_blob_start)
>                           ^
> 2 warnings generated.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Use address-of operator on section symbols
      https://git.kernel.org/powerpc/c/df4232d96e724d09e54a623362f9f610727f059f

cheers
