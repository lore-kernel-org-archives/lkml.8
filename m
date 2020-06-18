Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F82C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96EA2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgFRMhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:37:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbgFRMhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:37:17 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49nhK55kyHz9sSF; Thu, 18 Jun 2020 22:37:13 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-arch@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
In-Reply-To: <20200616135617.2937252-1-mpe@ellerman.id.au>
References: <20200616135617.2937252-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/syscalls: Use the number when building SPU syscall table
Message-Id: <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
Date:   Thu, 18 Jun 2020 22:37:13 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 23:56:16 +1000, Michael Ellerman wrote:
> Currently the macro that inserts entries into the SPU syscall table
> doesn't actually use the "nr" (syscall number) parameter.
> 
> This does work, but it relies on the exact right number of syscall
> entries being emitted in order for the syscal numbers to line up with
> the array entries. If for example we had two entries with the same
> syscall number we wouldn't get an error, it would just cause all
> subsequent syscalls to be off by one in the spu_syscall_table.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/syscalls: Use the number when building SPU syscall table
      https://git.kernel.org/powerpc/c/1497eea68624f6076bf3eaf66baec3771ea04045
[2/2] powerpc/syscalls: Split SPU-ness out of ABI
      https://git.kernel.org/powerpc/c/35e32a6cb5f694fda54a5f391917e4ceefa0fece

cheers
