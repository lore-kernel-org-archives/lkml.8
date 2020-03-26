Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB45C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DAE2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgCZMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:07:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgCZMHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:07:06 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3d34sgtz9sRY; Thu, 26 Mar 2020 23:07:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: af6cf95c4d003fccd6c2ecc99a598fb854b537e7
In-Reply-To: <20200323222729.15365-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/maple: Fix declaration made after definition
Message-Id: <48p3d34sgtz9sRY@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:07:02 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 22:27:29 UTC, Nathan Chancellor wrote:
> When building ppc64 defconfig, Clang errors (trimmed for brevity):
> 
> arch/powerpc/platforms/maple/setup.c:365:1: error: attribute declaration
> must precede definition [-Werror,-Wignored-attributes]
> machine_device_initcall(maple, maple_cpc925_edac_setup);
> ^
> 
> machine_device_initcall expands to __define_machine_initcall, which in
> turn has the macro machine_is used in it, which declares mach_##name
> with an __attribute__((weak)). define_machine actually defines
> mach_##name, which in this file happens before the declaration, hence
> the warning.
> 
> To fix this, move define_machine after machine_device_initcall so that
> the declaration occurs before the definition, which matches how
> machine_device_initcall and define_machine work throughout arch/powerpc.
> 
> While we're here, remove some spaces before tabs.
> 
> Fixes: 8f101a051ef0 ("edac: cpc925 MC platform device setup")
> Link: https://godbolt.org/z/kDoYSA
> Link: https://github.com/ClangBuiltLinux/linux/issues/662
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af6cf95c4d003fccd6c2ecc99a598fb854b537e7

cheers
