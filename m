Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4292A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578675404;
	bh=MQzjT+4UNkiT5W8ykZAsZf6C5Tt67H5NykUo1q89FP8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ce/o9Zq2/y6VZsU8/cOulCyainWHN1fEyBnznRJVFIq32NttmLZ1V+efyJoa3RIRL
	 +R982X5kANRZApL1Dp+J/SNSV4d+xloOm1T+94zZ0rXEGFakQs8vtH7OzhzDW+Ad3M
	 NkrlzDCjN2UgrnSJD5ZR3d3JMqq/6YUwWBFzbU4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgAJQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgAJQ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:43 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607E420673;
        Fri, 10 Jan 2020 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675402;
        bh=MQzjT+4UNkiT5W8ykZAsZf6C5Tt67H5NykUo1q89FP8=;
        h=From:To:Cc:Subject:Date:From;
        b=X4UT9RPAMeLriDGh6EfbNvW3/fjCjnbZPO/TDvhugb9w93o3OZcNwqU/nCwD0Geeu
         Fl5bLp6WG/Uiid4ppfGpYawoLgsEFQZ7IP1cfKCpGgFsu5QHCzmTYL47iGwJPM/5Cv
         ybumkMugp77TRn9eSdBpVsgoXSIFvKiM2HhRJ/0A=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date:   Fri, 10 Jan 2020 16:56:28 +0000
Message-Id: <20200110165636.28035-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a follow-up RFC to the discussions we had on the mailing list at
the end of last year:

https://lore.kernel.org/lkml/875zimp0ay.fsf@mpe.ellerman.id.au

Unfortunately, we didn't get a "silver bullet" solution out of that
long thread, but I've tried to piece together some of the bits and
pieces we discussed and I've ended up with this series, which does at
least solve the pressing problem with the bitops for arm64.

The rough summary of the series is:

  * Drop the GCC 4.8 workarounds, so that READ_ONCE() is a
    straightforward dereference of a cast-to-volatile pointer.

  * Require that the access is either 1, 2, 4 or 8 bytes in size
    (even 32-bit architectures tend to use 8-byte accesses here).

  * Introduce __READ_ONCE() for tearing operations with no size
    restriction.

  * Drop pointer qualifiers from scalar types, so that volatile scalars
    don't generate horrible stack-spilling mess. This is pretty ugly,
    but it's also mechanical and wrapped up in a macro.

  * Convert acquire/release accessors to perform the same qualifier
    stripping.

I gave up trying to prevent READ_ONCE() on aggregates because it is
pervasive, particularly within the mm/ layer on things like pmd_t.
Thankfully, these don't tend to be volatile.

I have more patches in this area because I'm trying to move all the
read_barrier_depends() magic into arch/alpha/, but I'm holding off until
we agree on this part first.

Cheers,

Will

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>

--->8

Will Deacon (8):
  compiler/gcc: Emit build-time warning for GCC prior to version 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
  READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
  READ_ONCE: Drop pointer qualifiers when reading from scalar types
  locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
  arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release
    macros

 arch/arm64/include/asm/barrier.h |  16 ++--
 drivers/xen/time.c               |   2 +-
 include/asm-generic/barrier.h    |  16 ++--
 include/linux/compiler-gcc.h     |   4 +
 include/linux/compiler.h         | 129 +++++++++++++------------------
 include/linux/compiler_types.h   |  15 ++++
 lib/fault-inject.c               |   4 +-
 net/netfilter/core.c             |   2 +-
 net/xdp/xsk_queue.h              |   2 +-
 9 files changed, 93 insertions(+), 97 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

