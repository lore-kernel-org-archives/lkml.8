Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6311C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA691207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro177boz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgEQP30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEQP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so7738286qka.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szUtt2uCBtb9BFKIo6+avFuxCN1c4bm+vBn/5FwTe+c=;
        b=ro177bozlMYOqTu76KMW9NsVAYa5XSQorch1+u3k+QqmVzF1RqWo5eo9mAf7Y9Oxoi
         kN1oDBIRZa65ECDSLxXDjSYDpdZUeX8eK4qHp1RvsO9KZvsQw8O8fF4e1tB7/zMWy2fh
         ccL5U+leW9baHohU23Zx1M8ULOmKl+U/ZPu2QF7+4IrRXZPw/syR3iiisfUEnz/xrFRf
         tWx7mBSefvdIdLGVfDUoDh0Uy0ryV+kvuL4eXOK93qjkBMdKZIftuvcUWNtuq2uwyIKF
         xOq+yS/PoTz56cfgJGr3+/tC3xs9NPfHUENf6a3D1p+6tS8AIJvpaNcneUkx/F+qZHNI
         QhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szUtt2uCBtb9BFKIo6+avFuxCN1c4bm+vBn/5FwTe+c=;
        b=Qvxiyxqqyzuly/1hH1WrFMQAxGkJH0nxl3HX9+VIyFqOMENJNRoUFMKF53wMBt0gEJ
         bOKEKHop42NmPuvT9/SJ/6QtA/lJsA6QNPtpY1mEU4jhHSLX+o0f3+ZaMwaMxgsTxzRY
         LX3Zaijjlj+zKTC/rj1r6NS7oyVGwAevhKyjqh+2nsFgnD6k5VE4cIlZqQ6pErfaRaih
         mitU9sLKsWV+0swBA6rgQAFC3BoZJsd0eAU0fbsgIADVjkVhjfWACyedW2Ube5qNDLev
         MpUvnKeUlasu2Pc+rC6qwUv/S8QqhRnCGE2gFLr5bOrhPQqQwwwhHGq5oeNwX5LoHAPg
         FnaA==
X-Gm-Message-State: AOAM532y2yIN+BacYspD6cmdujoQlQkCyGhMUjvnKxJ1f7e0Meg8T3cG
        TCAdrX2oqdKP5oZ4wx4GLHj08iT7zA==
X-Google-Smtp-Source: ABdhPJzcyprfDwh5l+TH3QjXcyeMGGZNZ5zHNBXWOKHdQgUxsdanhRuX/3DnbuNrYNN/KgNJqoYpkQ==
X-Received: by 2002:a37:d85:: with SMTP id 127mr12277923qkn.205.1589729364474;
        Sun, 17 May 2020 08:29:24 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:23 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/7] x86: Clean up percpu operations
Date:   Sun, 17 May 2020 11:29:09 -0400
Message-Id: <20200517152916.3146539-1-brgerst@gmail.com>
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

Brian Gerst (7):
  x86/percpu: Introduce size abstraction macros
  x86/percpu: Clean up percpu_to_op()
  x86/percpu: Clean up percpu_from_op()
  x86/percpu: Clean up percpu_add_op()
  x86/percpu: Clean up percpu_add_return_op()
  x86/percpu: Clean up percpu_xchg_op()
  x86/percpu: Clean up percpu_cmpxchg_op()

 arch/x86/include/asm/percpu.h | 447 ++++++++++++----------------------
 1 file changed, 158 insertions(+), 289 deletions(-)

-- 
2.25.4

