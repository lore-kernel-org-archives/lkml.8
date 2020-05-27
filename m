Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A92C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32032078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbgE0Nx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:53:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388713AbgE0Nx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:53:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B6630E;
        Wed, 27 May 2020 06:53:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17D9C3F6C4;
        Wed, 27 May 2020 06:53:24 -0700 (PDT)
Date:   Wed, 27 May 2020 14:53:22 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Message-ID: <20200527135322.GU5031@arm.com>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <159052247565.23781.7800427985507723263.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159052247565.23781.7800427985507723263.b4-ty@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:45:05PM +0100, Will Deacon wrote:
> On Tue, 26 May 2020 10:31:14 -0700, Nick Desaulniers wrote:
> > Custom toolchains that modify the default target to -mthumb cannot

It's probably too late to water this down, but it's unfortunate to have
this comment in the upstream commit history.

It's not constructive to call the native compiler configuration of
major distros for many years a "custom" toolchain.  Unmodified GCC has
had a clean configure option for this for a very long time; it's not
someone's dirty hack.  (The wisdom of armhf's choice of -mthumb might
be debated, but it is well established.)

Ignoring the triplet and passing random options to a compiler in the
hopes that it will do the right thing for an irregular usecase has never
been reliable.  Usecases don't get much more irregular than building
vdso32.

arch/arm has the proper options in its Makefiles.

This patch is a kernel bugfix, plain and simple.

> > compile the arm64 compat vdso32, as
> > arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > always.
> 
> Applied to arm64 (for-next/vdso), thanks!
> 
> [1/1] arm64: vdso32: force vdso32 to be compiled as -marm
>       https://git.kernel.org/arm64/c/20363b59ad4f

Does this need to go to stable?

Cheers
---Dave
