Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EFE206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgEMMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgEMMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:43:46 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE243C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:43:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49MZ9B5R9Kz9sSf; Wed, 13 May 2020 22:43:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu>
References: <7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH fixes] powerpc/vdso32: Fallback on getres syscall when clock is unknown
Message-Id: <158937375618.3526905.2066468534333015968.b4-ty@ellerman.id.au>
Date:   Wed, 13 May 2020 22:43:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 09:42:14 +0000 (UTC), Christophe Leroy wrote:
> There are other clocks than the standard ones, for instance
> per process clocks. Therefore, being above the last standard clock
> doesn't mean it is a bad clock. So, fallback to syscall instead
> of returning -EINVAL inconditionaly.

Applied to powerpc/fixes.

[1/1] powerpc/vdso32: Fallback on getres syscall when clock is unknown
      https://git.kernel.org/powerpc/c/e963b7a28b2bf2416304e1a15df967fcf662aff5

cheers
