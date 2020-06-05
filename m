Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D2F206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591355738;
	bh=WgImx3Bjbq4F1CvFFXofVfZoXhOUaK/+2yuYYVEWOGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qWIpiU1uKj2drDI+Nu0lPK46ltP2WaVciLRN7ZjvC9kdFcIBt6+5O5cGltvXx+0mu
	 QVG8OOAJZTpfdQ2LS7PPhshalaVTFt1mUkhwaHJl9Flkvs8FJU7rUEmZQyG3FlIPeb
	 JNzX74uA1Rtb5QWOeseEQHYHAu6nbMJawN/8BYHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFELPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgFELPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:15:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF2F206E6;
        Fri,  5 Jun 2020 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591355735;
        bh=WgImx3Bjbq4F1CvFFXofVfZoXhOUaK/+2yuYYVEWOGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bp/upE2tCLakigDXhi/n981g2AixI6Js8sGUxL90joRWo9OsO16m/hs2cL33FOnsT
         UsG+MgfLW1+3p4z6OhQiK6XZCpExus3MAVzXtN9w+w/Mt1WtFAVQa+cuUOSuGzEcIM
         OTdtiU19Uik7Me91B6vJnlNZaQ7yKrlP2JhO/OZ8=
Date:   Fri, 5 Jun 2020 12:15:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [GIT pull - RFC] locking/kcsan for v5.8
Message-ID: <20200605111531.GA19216@willie-the-truck>
References: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Tue, Jun 02, 2020 at 01:05:02PM -0000, Thomas Gleixner wrote:
> Linus,
> 
> please consider to pull the latest locking/kcsan branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-kcsan-2020-06-02
> 
> up to:  f05e1242fbb2: compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse

Just in case it's not clear, this pull request also contains the READ_ONCE
rework I've been working on for a while, which bumps the minimum GCC version
and improves code-gen on arm64 when stack protector is enabled:

> Will Deacon (19):
>       sparc32: mm: Fix argument checking in __srmmu_get_nocache()
>       sparc32: mm: Restructure sparc32 MMU page-table layout
>       sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
>       sparc32: mm: Reduce allocation size for PMD and PTE tables
>       compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
>       linux/compiler.h: Remove redundant '#else'
>       netfilter: Avoid assigning 'const' pointer to non-const pointer
>       net: tls: Avoid assigning 'const' pointer to non-const pointer
>       fault_inject: Don't rely on "return value" from WRITE_ONCE()
>       arm64: csum: Disable KASAN for do_csum()
>       READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
>       READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
>       READ_ONCE: Drop pointer qualifiers when reading from scalar types
>       locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
>       arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release macros
>       gcov: Remove old GCC 3.4 support
>       kcsan: Rework data_race() so that it can be used by READ_ONCE()
>       READ_ONCE: Use data_race() to avoid KCSAN instrumentation
>       READ_ONCE: Fix comment describing 2x32-bit atomicity

The reason it's bundled up with KCSAN is because of conflicts in linux-next
but the series is reasonably mature so it would be a shame if it missed 5.8.

On the off-chance that this lot doesn't make it (it is, after all, an RFC!),
I've stuck the READ_ONCE stuff on its own branch (see below), with some
cherry-picks of fixes that ended up in -tip. The sparc patches are all
sitting in sparc-next, so they'll come in via davem.

Obviously it would better if everything went upstream, but I'm just trying
to avoid throwing the baby out with the bathwater if KCSAN needs a little
longer to bake.

Cheers,

Will

--->8

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git rwonce/rework

for you to fetch changes up to b398ace5d2ea0b7f00d9f1ce23c647e289c206ca:

  compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse (2020-06-05 11:40:01 +0100)

----------------------------------------------------------------
Marco Elver (2):
      compiler_types.h: Optimize __unqual_scalar_typeof compilation time
      compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse

Will Deacon (14):
      compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
      netfilter: Avoid assigning 'const' pointer to non-const pointer
      net: tls: Avoid assigning 'const' pointer to non-const pointer
      fault_inject: Don't rely on "return value" from WRITE_ONCE()
      arm64: csum: Disable KASAN for do_csum()
      READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
      READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
      READ_ONCE: Drop pointer qualifiers when reading from scalar types
      locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
      arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release macros
      gcov: Remove old GCC 3.4 support
      READ_ONCE: Fix comment describing 2x32-bit atomicity
      compiler-types.h: Include naked type in __pick_integer_type() match
      compiler.h: Enforce that READ_ONCE_NOCHECK() access size is sizeof(long)

 Documentation/process/changes.rst |   2 +-
 arch/arm/crypto/Kconfig           |  12 +-
 arch/arm64/include/asm/barrier.h  |  16 +-
 arch/arm64/lib/csum.c             |  20 +-
 crypto/Kconfig                    |   1 -
 drivers/xen/time.c                |   2 +-
 include/asm-generic/barrier.h     |  16 +-
 include/linux/compiler-gcc.h      |   5 +-
 include/linux/compiler.h          | 148 +++++-----
 include/linux/compiler_types.h    |  47 ++++
 init/Kconfig                      |   1 -
 kernel/gcov/Kconfig               |  24 --
 kernel/gcov/Makefile              |   3 +-
 kernel/gcov/gcc_3_4.c             | 573 --------------------------------------
 lib/fault-inject.c                |   4 +-
 net/netfilter/core.c              |   2 +-
 net/tls/tls_main.c                |   2 +-
 scripts/gcc-plugins/Kconfig       |   2 +-
 18 files changed, 161 insertions(+), 719 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c
