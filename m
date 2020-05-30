Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4482920774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of565f9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgE3WLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3WLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD42C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a14so5977840ilk.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXcAedOSwrxhkrQYcHCK2xCwI1oS7g32dLAN0Oi8AdQ=;
        b=Of565f9XHR6akMVBVKeYCt0KqgsBPBOd8tPl9chf1LTHcHZHyMIMwVfqOsD9YiDB2g
         BF621G1rjH5z+a2waS2qHNz/smsgukpCnWV1Hto0UywsiW7DtTcKP/33Z3RxvAMlSOkg
         o2l2HMw7FLpJzpXAyApteISfXgwdHuodppWy2SBJPy6JCRUPa3toliwdpfqb0hXao+KT
         Sf+k5WuX/57tGton3e0mXfR7NPR/kgW+dlU3UQIeURwHJWXRpaTwxEAAkRy7VqIYb6SO
         Q55ETphUucl2yXZUg07oOcgCvcyQvSUmmZ82cVZC0vYTPvY7KUorwOXcenhVDKM5/5xi
         7jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXcAedOSwrxhkrQYcHCK2xCwI1oS7g32dLAN0Oi8AdQ=;
        b=UXu5DLNljyAQWYFBO97NplVPbkfI8LAlXNKMvxYFrxQ/eGQzaBEretkbvy2OQjbivE
         RL3HgHbKaE0MfLNFNpE18hz7o2SF2w9INYv1Mzsxli6rlcRkXF+apY67Cu74B7M2qnmk
         PshTAPAZ4OTjv6xEjsk/XKe2FObCORj4XRhr8oWDOdnF0OGp7ivebI2/jMmtlPXCDNad
         0efPYfmeu6bfsvr+y3K7Z3KYeW4PM2SowlPQ6qM8I4v7v6SpDp/ZNXd+XYPmY1Uj0pGy
         ER4TiF/ySoGSg3pxSboQ0Zg7xlLeQqMxqmhLbyW048lnFuTVji+aTcvQt1Wqydo+y7sx
         U1dQ==
X-Gm-Message-State: AOAM530oJ0WydR91n/5mhWyLfTQy+DNDEMVzCebi6UsfJwBbIx7YEhvf
        4cpSAL+VC7LNqHtLdPUH+Pd/yMlXWg==
X-Google-Smtp-Source: ABdhPJzHer1EUcBGv4dFXYPRPGmCCr6cE0nKk+9S/IZchZU0nvcFqXL74g5+mZFErlPYbM630v/lcA==
X-Received: by 2002:a92:4015:: with SMTP id n21mr14454647ila.137.1590876699825;
        Sat, 30 May 2020 15:11:39 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:39 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 00/10] x86: Clean up percpu operations
Date:   Sat, 30 May 2020 18:11:17 -0400
Message-Id: <20200530221127.459704-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core percpu operations already have a switch on the width of the
data type, which resulted in an extra amount of dead code being
generated with the x86 operations having another switch.  This patch set
rewrites the x86 ops to remove the switch.  Additional cleanups are to
use named assembly operands, and to cast variables to the width used in
the assembly to make Clang happy.

Changes from v1:
- Add separate patch for XADD constraint fix
- Fixed sparse truncation warning
- Add cleanup of percpu_stable_op()
- Add patch to Remove PER_CPU()

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

 arch/x86/include/asm/percpu.h | 510 ++++++++++++----------------------
 1 file changed, 172 insertions(+), 338 deletions(-)


base-commit: 229aaa8c059f2c908e0561453509f996f2b2d5c4
-- 
2.25.4

