Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C80CC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E86F24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fm/TVH0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANUJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:09:08 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgANUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C556C4049B;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579032536; bh=f5GlxhH1g7W0d3zEgvx81jnLwcqIiTTmh3wCeGRzGW0=;
        h=From:To:Cc:Subject:Date:From;
        b=fm/TVH0mNkG5VblJWaqvz2mdAEeXboKh6uXtqrQv8g6K4lppyWbpONWze6HfTGsuk
         D2nlY9m6Pj5TuT/CDkL/5sqZREDt6Zglbeh2zl2SeWZnT2t8hTzfTfGOBNL6qjn2ze
         l+6kT7uCoaj6sPfP0fVQF0cAeyMFvxfLBseZ3fZnwnYBiRxvXI19qO5Z2DoBJKZnwh
         OXJ0kTUQXr9X/Q6zhLzEm7kiJ+wGcLkYjxUHfkIx8UvjwO7rnNCDjoGqDi9kudoPcV
         4I1HXDCoIfP3aTmCGr+u+jl1aLHOa6jxn1p9w8TUZ6nT7hprCvrRNupN9xnlctaqnw
         IHOf0LtcpCi1A==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.25])
        by mailhost.synopsys.com (Postfix) with ESMTP id 88973A0096;
        Tue, 14 Jan 2020 20:08:51 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 0/4] Switching ARC to optimized generic strncpy_from_user
Date:   Tue, 14 Jan 2020 12:08:42 -0800
Message-Id: <20200114200846.29434-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This came up when trying to move ARC over to generic word-at-a-time
interface.

 - 1/4 is a trivial fix (and needed for ARC switch)
 - 2/4 is mucking with internals hence the RFC. I could very likely be
   overlooking some possible DoS / exploit issues and apologies in advance
   if thats the case but I felt like sharing it anyways to see what
   others think.
 - 3/4, 4/4 are ARC changes to remove the existing ARC version and
   switch to generic (needs 1/4).

Thx,
-Vineet

Vineet Gupta (4):
  asm-generic/uaccess: don't define inline functions if noinline lib/*
    in use
  lib/strncpy_from_user: Remove redundant user space pointer range check
  ARC: uaccess: remove noinline variants of __strncpy_from_user() and
    friends
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user

 arch/arc/Kconfig                      |  2 +
 arch/arc/include/asm/Kbuild           |  1 -
 arch/arc/include/asm/uaccess.h        | 87 ++-------------------------
 arch/arc/include/asm/word-at-a-time.h | 49 +++++++++++++++
 arch/arc/mm/extable.c                 | 23 -------
 include/asm-generic/uaccess.h         |  4 ++
 lib/strncpy_from_user.c               | 36 ++++-------
 lib/strnlen_user.c                    | 28 +++------
 8 files changed, 79 insertions(+), 151 deletions(-)
 create mode 100644 arch/arc/include/asm/word-at-a-time.h

-- 
2.20.1

