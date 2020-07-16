Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F6F2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGPM4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgGPMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:56 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:55:56 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPc4zFDz9sTh; Thu, 16 Jul 2020 22:55:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
References: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/signal_32: Remove !FULL_REGS() special handling in PPC64 save_general_regs()
Message-Id: <159490400779.3805857.2201061957365361885.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:48 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 12:33:35 +0000 (UTC), Christophe Leroy wrote:
> Since commit ("1bd79336a426 powerpc: Fix various
> syscall/signal/swapcontext bugs"), getting save_general_regs() called
> without FULL_REGS() is very unlikely and generates a warning.
> 
> The 32-bit version of save_general_regs() doesn't take care of it
> at all and copies all registers anyway since that commit.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/signal_32: Remove !FULL_REGS() special handling in PPC64 save_general_regs()
      https://git.kernel.org/powerpc/c/667e3c413ecf20371692fd2dc37e06dc14d0b140
[2/2] powerpc/signal_32: Simplify loop in PPC64 save_general_regs()
      https://git.kernel.org/powerpc/c/020c4831e01264f8b62af6ca9e669b7c51881a56

cheers
