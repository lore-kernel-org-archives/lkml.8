Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42A620786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgH0HrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:59 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E07C06121A;
        Thu, 27 Aug 2020 00:46:58 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BcZYr2ZqWz9sTK; Thu, 27 Aug 2020 17:46:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e06de4d3-a36f-2745-9775-467e125436cc@infradead.org>
References: <e06de4d3-a36f-2745-9775-467e125436cc@infradead.org>
Subject: Re: [PATCH] Documentation/powerpc: fix malformed table in syscall64-abi
Message-Id: <159851436088.52163.10131581013009684108.b4-ty@ellerman.id.au>
Date:   Thu, 27 Aug 2020 17:46:55 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Aug 2020 17:31:16 -0700, Randy Dunlap wrote:
> Fix malformed table warning in powerpc/syscall64-abi.rst by making
> two tables and moving the headings.
> 
> Documentation/powerpc/syscall64-abi.rst:53: WARNING: Malformed table.
> Text in column margin in table line 2.
> 
> =========== ============= ========================================
> --- For the sc instruction, differences with the ELF ABI ---
> r0          Volatile      (System call number.)
> r3          Volatile      (Parameter 1, and return value.)
> r4-r8       Volatile      (Parameters 2-6.)
> cr0         Volatile      (cr0.SO is the return error condition.)
> cr1, cr5-7  Nonvolatile
> lr          Nonvolatile
> 
> [...]

Applied to powerpc/fixes.

[1/1] Documentation/powerpc: fix malformed table in syscall64-abi
      https://git.kernel.org/powerpc/c/aa661d7fab436d8a782618b3138da1a84ca28a31

cheers
