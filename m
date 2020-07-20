Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE2C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD5B22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260432;
	bh=0vN9ldW4dl4UP1zx716nsKtBzsTg8JvdS54xIkDdDHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6FMSRh8Q7wgeU/YebQ9c7SwSWqbJF2YgVkfFLdMIAn7N7gF41N+8g3b9mNQqgDUz
	 5V8q4YU6HgSTUhmjAy0NmNArVy0gVfzMeNTcobvAfw25nhJU84/2jdV5VwOQqV5LCd
	 pw6P4QW8eXnv9MK3ulOC9jAxbz5plgxsjqVcXVRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgGTPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbgGTPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A952064B;
        Mon, 20 Jul 2020 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260427;
        bh=0vN9ldW4dl4UP1zx716nsKtBzsTg8JvdS54xIkDdDHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM5/tzigPEOfjV2AvP4/H0JllRlkfsfAe8OMeAPKk2G+vXQwbaPiFrWt9wyDeaxdx
         t3CkbBjbpaRgPVw+QFNfmvYUm13USg9i1r6sWpaXHigMI75X6J6rHd9GoNo8kdOTJs
         yrKQ6nGKqcZgTCT6irCQO1GhFB7RfRtYSfSVvsBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Buettner <kevinb@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 067/133] copy_xstate_to_kernel: Fix typo which caused GDB regression
Date:   Mon, 20 Jul 2020 17:36:54 +0200
Message-Id: <20200720152806.970814032@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Buettner <kevinb@redhat.com>

commit 5714ee50bb4375bd586858ad800b1d9772847452 upstream.

This fixes a regression encountered while running the
gdb.base/corefile.exp test in GDB's test suite.

In my testing, the typo prevented the sw_reserved field of struct
fxregs_state from being output to the kernel XSAVES area.  Thus the
correct mask corresponding to XCR0 was not present in the core file for
GDB to interrogate, resulting in the following behavior:

   [kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
   Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
   [New LWP 232880]

   warning: Unexpected size of section `.reg-xstate/232880' in core file.

With the typo fixed, the test works again as expected.

Signed-off-by: Kevin Buettner <kevinb@redhat.com>
Fixes: 9e4636545933 ("copy_xstate_to_kernel(): don't leave parts of destination uninitialized")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/xstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1029,7 +1029,7 @@ int copy_xstate_to_kernel(void *kbuf, st
 		copy_part(offsetof(struct fxregs_state, st_space), 128,
 			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
 	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
+		copy_part(xstate_offsets[XFEATURE_SSE], 256,
 			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
 	/*
 	 * Fill xsave->i387.sw_reserved value for ptrace frame:


