Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87672C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3C321974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lrw5CS3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgFRJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgFRJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:32:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC72C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:31:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o140so5735452yba.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L6v3WNe9vB4gYfOBJzsidmJB3J+19cEKm9MUweYc46U=;
        b=Lrw5CS3SLvONDKoeW6LlNlz6st2JCT6q3diuLRr/xxJ7vfuPZxfICzFgK9pJKhMgQV
         Pzcu/M/pXb/St8kvLH4IP+SKI2RZRbuVehv79IifS2C3NKtlWycbBw6iB9nAG4EdVxep
         D1Ucxn1UTG4SRnbNCPiFrObnnhR8sjKm3K579epxPkB3vuUSimWegkn3RY1fo8zTPyy/
         U4SDhAlAP8ydgSbZ5ZGHH1vHTmz124P8HVOi41KwcHYi1dfA4kWn8ri1JgHdVAKuAn+I
         Jf+dogYy6Ht0l/w7HDwfVLJG1oYbcVLomsGlse+Uf2sLdZz/AH47cb9V3zxWpDtTT+D9
         mQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L6v3WNe9vB4gYfOBJzsidmJB3J+19cEKm9MUweYc46U=;
        b=Uir8HV2fBZRnsHO64bd+eMAzCnFcw6YYKcXMVEhBhB1PsIBuFEK5xbGlohbkZ6Q79g
         jTVjXmvJTjFVXSgnTo5zbrOc8XVMMTFS1p4Ym2R5p79yGtdmsgUqJqgpEZ9WcMmQNWpL
         qraotO0z23Uy7I3sTZB8DfJezyZ7B3ZAV4dv84Srgvwfe99xIXaumF2ViNcUf/1oFXDq
         lOb4HKz043Ygq7nCsW632iAns8NLXXX9Pc5MHBSk4uty5nenMk688t0BS1n4JkPYLGe9
         djKIN13npIrrpBPo/yWEIPoNaGyYJXswdEanqoPLoW07mZG2texP518NZtXSAzEMmGUD
         orxQ==
X-Gm-Message-State: AOAM5319e+EPELPmQIin3G/R25P1jF3+r2lOHW8emCAQzRUQYI34pGQJ
        cJSvjkxqr3rts5QVQ3ZdE/fNOq3ZrA==
X-Google-Smtp-Source: ABdhPJy6LDnuo+sOzAf9LZhHavkVDrLCPvyyqa0mnCoDJix+rgoqjk/DI5NTTZig88w6szDnUq5mkXK+Tg==
X-Received: by 2002:a25:84cc:: with SMTP id x12mr4787589ybm.454.1592472718011;
 Thu, 18 Jun 2020 02:31:58 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:31:15 +0200
Message-Id: <20200618093118.247375-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/3] kcsan: Re-add GCC support, and compiler flags improvements
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-add GCC as a supported compiler and clean up compiler flags.

To use KCSAN with GCC before GCC 11 is released, the following will get
a stable GCC 10 and cherry-pick the patches required for KCSAN support:

	git clone git://gcc.gnu.org/git/gcc.git && cd gcc
	git checkout -b gcc-10-for-kcsan releases/gcc-10.1.0
	git cherry-pick \
	    4089df8ef4a63126b0774c39b6638845244c20d2 \
	    ab2789ec507a94f1a75a6534bca51c7b39037ce0 \
	    06712fc68dc9843d9af7c7ac10047f49d305ad76
	./configure --prefix <your-prefix> --enable-languages=c,c++
	make -j$(nproc) && make install

Marco Elver (3):
  kcsan: Re-add GCC as a supported compiler
  kcsan: Simplify compiler flags
  kcsan: Disable branch tracing in core runtime

 Documentation/dev-tools/kcsan.rst | 3 ++-
 kernel/kcsan/Makefile             | 4 ++--
 lib/Kconfig.kcsan                 | 3 ++-
 scripts/Makefile.kcsan            | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.27.0.290.gba653c62da-goog

