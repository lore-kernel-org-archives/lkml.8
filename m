Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1BDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682352076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591030471;
	bh=rUyZ7vB4WhyobU1Vi9sBqW5QVcynYg9v+/DhbxAQmB4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hmxq+w9hFggf6RuzsJ43bVhqhm5Awq7L7TFt61UbEC+Ut/xWwAbuu9XVLGo6C62e3
	 deETGKhe5ibVF5tqvwIrWSuf82ZHAXvgfMCvOAMy0BgiSsx0tazG8O4/27Q5e73fUf
	 DxmKyXZfaaCKX2A/FvcwgN0ZExz2pht9K5SEqfGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgFAQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:54:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038EC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:54:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so563413wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=78E9wXUZ5m98eH9XjsmgZpCanvFWB7/7Ldy80RhVTQo=;
        b=TSeQH9PnvUl+nriaFQxvFXEBCzdwGenaR3dXXmodU2rfB7l7Xjmb6biJPeocyTETZl
         JnOp7aiMl2g7Hy2JJbSqEn7JxxVC90UufNBViVnMDokwDTb46+V2DNJs7sOvXb0UirB7
         JcNGlPyPl1R70h/ZYKcBqwbx63QBiOOxFLnIxIFcWtNlpuH+BtQCCRzgPpIwIuBGM1+4
         SnUZb9rQuT5JVwYrvJFidj80k6V2QvhDZE9zba/fEmkOY8nXp1JN3ZyjfSzLdTxPf8Wf
         nKHD47nskfbzANNICkmhUwRp3bx5d7+FXV613Z4FjZWED9UMztAbSyu5hYEyx+dSdlqS
         Zakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=78E9wXUZ5m98eH9XjsmgZpCanvFWB7/7Ldy80RhVTQo=;
        b=MO3hVUTPo5F2ixcZ4mZRbypfoBdJQqFnV+T8SqVnVg3mVuQDe2Hi28lhTNHeO3avKj
         EjmQcwHX/Hwdn1HqUJzVBHZsOJgfpRhzrG0w+qFvptPdJUBsc76WEdbUwLBsY+uhDSlx
         gpwLGIN7PVTfG9OKvLkYo5dYKePNKB97UpUhc7KG6QAgWl9UDljdO72mtss4X9pvi7YB
         E4eNJs8F2TRnxvUywIeuupKKJAZlFC6FRLhQof859i2rE24iSTyhtMwAyfsNfvLCZ9FZ
         DHlxT4xydQSe1dFjYBmE1LTYNi64JTnK4ey9yd+l0ZwuZuVIIG7ygyeisGKFsIYfCZML
         T7hg==
X-Gm-Message-State: AOAM530w0rdmj1LRBiU0j4/O6jaOH/8aK3Fln9iw0FMabPi3ALFZEsNQ
        IWT5cRS5joL0YuxJQ2oGjd8L4jMl
X-Google-Smtp-Source: ABdhPJwdi9fmf/28LkEj4VX1Lx2jbL2mXJJtqMt3T5RLaX2qJOWO4yOcRc/jhRmlCxM1x49BoXg4Gg==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr22697749wru.68.1591030468229;
        Mon, 01 Jun 2020 09:54:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y19sm264173wmi.6.2020.06.01.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:54:27 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:54:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v5.8
Message-ID: <20200601165425.GA1303742@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/fpu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-06-01

   # HEAD: 55e00fb66fd5048f4a3ee357018fd26fc527abca x86/fpu/xstate: Restore supervisor states for signal return

Most of the changes here related to 'XSAVES supervisor state' support,
which is a feature that allows kernel-only data to be automatically
saved/restored by the FPU context switching code.

CPU features that can be supported this way are Intel PT, 'PASID' and
CET features.

 Thanks,

	Ingo

------------------>
Fenghua Yu (3):
      x86/fpu/xstate: Rename validate_xstate_header() to validate_user_xstate_header()
      x86/fpu/xstate: Define new macros for supervisor and user xstates
      x86/fpu/xstate: Define new functions for clearing fpregs and xstates

Yu-cheng Yu (7):
      x86/fpu/xstate: Separate user and supervisor xfeatures mask
      x86/fpu/xstate: Introduce XSAVES supervisor states
      x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates
      x86/fpu/xstate: Update copy_kernel_to_xregs_err() for supervisor states
      x86/fpu: Introduce copy_supervisor_to_kernel()
      x86/fpu/xstate: Preserve supervisor states for the slow path in __fpu__restore_sig()
      x86/fpu/xstate: Restore supervisor states for signal return


 arch/x86/include/asm/fpu/internal.h |  10 +-
 arch/x86/include/asm/fpu/xstate.h   |  52 +++++++---
 arch/x86/kernel/fpu/core.c          |  53 ++++++----
 arch/x86/kernel/fpu/init.c          |   3 +-
 arch/x86/kernel/fpu/regset.c        |   2 +-
 arch/x86/kernel/fpu/signal.c        | 144 ++++++++++++++++++--------
 arch/x86/kernel/fpu/xstate.c        | 199 +++++++++++++++++++++++++++---------
 arch/x86/kernel/process.c           |   2 +-
 arch/x86/kernel/signal.c            |   2 +-
 9 files changed, 336 insertions(+), 131 deletions(-)
