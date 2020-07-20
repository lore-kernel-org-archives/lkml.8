Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80553C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CF420773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvRlhxIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgGTUtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:49:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D7DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k127so22910459ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+pPzES3PiEk8bblwLpPCONxYimek8jAllUnsW6FPf6o=;
        b=HvRlhxIJOH1Eoi90pKXPeBZxtRPQmDlRcCJidDxM59G1Inl4l8GQt/GbZxa53xULLV
         x5uTAg+82iRIYu8a3pdbG0c2FyVrWNxjJnB3x361C4/BdAo8DP6SrJynoT6+s6wQJqAX
         f9Hjed8+51P97a4nw7biGwp70LmUSfGaCF0tJidSLznCc0Kg5/VcwuAT/tD6nOqKUitm
         hEZxcyIggoEm8spU3oSu3VwEjYnQSmYxlnYC5PRW8eYCBpGcR1Gkdo/nO/SiHIBNIfFq
         kp9JDnZOwZCpUs+HGMuysXk3rXcHX8vMZbp+m/YLt74TCoKJeGHBf8Cg7cqfg0Mbu9yy
         BK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+pPzES3PiEk8bblwLpPCONxYimek8jAllUnsW6FPf6o=;
        b=Dn3XewJuDcFAp4k0UY/ujd9SCXlp9TnUseLWN8cPIIik3gjjPErlzHKHbs0u4iBwxs
         GcNuXb9T8VB86BlWxwM1AMYs3ul/BfFOh5E72hdeTHXLgdtd5JHfE5VsGvHfnfFI8WSr
         Gl/IACi3pigHi+dqopO0TYIGarLot5gSfsNKJRK2X8w8pU+bKo4EHyQT3CXkxUTNiIOS
         NlwLFiIJedLg8s0RSGdHi0NismWuNSHDC0JA9cU4B1KkovWHl3oW4p9R6ddkLfP8mfBW
         QNTRttOtY76i2SoU3j3Eg6sCEI4J4DaME9su+couUTgUWnbGhgMbmSzl0AnhMwZ3yo3j
         OABQ==
X-Gm-Message-State: AOAM5326MSmampfH7ThUG6g89Lfeog7/aX4H5jq/h5R26fjInZtQDhLB
        kOPjvOFBaSF9HjLRB7EgXnb/lg36rsKq4jCoA4o=
X-Google-Smtp-Source: ABdhPJzkCHJQVkAfKym5iD2hoB4WFDSZI4iRthwQ1Y/BmnPRgucBKs1ZNq9vM9QJpFMjl33eAt8xUs8mTKowhVoxMxU=
X-Received: by 2002:a25:3b93:: with SMTP id i141mr35680756yba.28.1595278179480;
 Mon, 20 Jul 2020 13:49:39 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:14 -0700
Message-Id: <20200720204925.3654302-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 00/11] i386 Clang support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend of Brian's v2 with Acks from Peter and Linus collected, as well
as the final patch (mine) added. The commit of the final patch discusses
some of the architectural differences between GCC and Clang, and the
kernels tickling of this difference for i386, which necessitated these
patches.

Brian Gerst (10):
  x86/percpu: Introduce size abstraction macros
  x86/percpu: Clean up percpu_to_op()
  x86/percpu: Clean up percpu_from_op()
  x86/percpu: Clean up percpu_add_op()
  x86/percpu: Remove "e" constraint from XADD
  x86/percpu: Clean up percpu_add_return_op()
  x86/percpu: Clean up percpu_xchg_op()
  x86/percpu: Clean up percpu_cmpxchg_op()
  x86/percpu: Clean up percpu_stable_op()
  x86/percpu: Remove unused PER_CPU() macro

Nick Desaulniers (1):
  x86: support i386 with Clang

 arch/x86/include/asm/percpu.h  | 510 +++++++++++----------------------
 arch/x86/include/asm/uaccess.h |   4 +-
 2 files changed, 175 insertions(+), 339 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

