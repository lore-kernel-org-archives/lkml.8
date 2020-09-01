Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98502071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nNo4Vy9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgIAWZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIAWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:25:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081FC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:25:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k17so2047212qvj.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8Cpt1ljRc5OUFvhttJIkywuliHVtTrKBkn67gE9JDjs=;
        b=nNo4Vy9va2+LZTqvDKpxwiSMCYKfhf2ERgp336ctF3JBDUsOPg+Y9R4xBuOvFzpqbb
         7bsr8zYEpC6m04ZiYGlNZj9fs4bp2HfQDMr92bKf3fRoWcglT9tA5zOrFC7nL4q229xt
         8nBfw+3DA4zhaNIc5yVoAEdYZbhcU3K3wjF5Jw6WvYS25TWQYnzAPbVrQQK+8SlS7qqx
         TA2vtd3iFV9EAGTsZUUApqRrrBcVvZQ0gqexY0Qp6jEgW9nRS3WDQuxltOk+WH4em8GQ
         cVOWTfLfbcjYWyPhj1yQW4xLtr/uxt+I5NYJi58hUfOhL/mYJoS0sKmVexYEXcnpW99W
         8Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8Cpt1ljRc5OUFvhttJIkywuliHVtTrKBkn67gE9JDjs=;
        b=trhhB/Og4uBJcDsMau2iuFAWGzSulfuBo07+OchT9hoTKk77gC+bMKe3w1WCEhjXmE
         IKWfkEXRGADZ5jW57lAzOp9TuwtVtrgtHRpV1L7nozJTPJvktJiZ9+gqkQgaL/zNeEG1
         jSvfD+oBoI+A6boWFi7zVyrvKXvLrqvZpMlRYIbolMTgymM+tEgwZ5ou5GwowEQV8Jje
         MzGZkOiP9aXA5EKEQQpT44IKnfxdDByjpJZOmmHdyKmAYz4U8hCoMA5VRB7/YE0rV27k
         xlflAXMUwGMwZH3DkDBthmN22+ZXgzEJGO3DNJS/t++R8EpxActRbVGFOLx7zDsevydy
         azGw==
X-Gm-Message-State: AOAM532ZkaZwhMy2WhybDp6lcxEmMTgk7JWQ7moXCURkpYHMdPk9tcRg
        w4K2ZUw4Fb/9fJnK8oN9jLclWknTZXtCWLeUQno=
X-Google-Smtp-Source: ABdhPJw4pDP7L/8jSUUI60udN2zaLrmNYvzSnz3iTfjyKHES7GeqPrOawy43a3WEWoiGf2R3turAoULAtxPlbxsLVLY=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:e8c9:: with SMTP id
 m9mr4288274qvo.51.1598999134297; Tue, 01 Sep 2020 15:25:34 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:25:21 -0700
Message-Id: <20200901222523.1941988-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 0/2] link vdso with linker
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook is working on series that adds --orphan-section=warn to arm,
arm64, and x86.  I noticed that ppc vdso were still using cc-ldoption
for these which I removed.  It seems this results in that flag being
silently dropped.

I'm very confident with the first patch, but the second needs closer
review around the error mentioned below the fold related to the .got
section.

Nick Desaulniers (2):
  powerpc/vdso64: link vdso64 with linker
  powerpc/vdso32: link vdso64 with linker

 arch/powerpc/include/asm/vdso.h         | 17 ++---------------
 arch/powerpc/kernel/vdso32/Makefile     |  7 +++++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  3 ++-
 arch/powerpc/kernel/vdso64/Makefile     |  8 ++++++--
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  1 -
 5 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

