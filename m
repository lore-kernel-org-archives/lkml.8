Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B856AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823352087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738155;
	bh=kcmHPfgfUkUIZ9s19Gak9QvxgsL0fT1Ndp20b1yWJ/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ajs/aPP6B5berHICz7aXal6gia9HBIfNDjBxGWC1ZYZIRhVzyUpyPcEEpgtVxy8Xa
	 dr7D1qci+D8lCQb6PKtJV7oXd4/P1vNG+sTugwXw2q9cDKtJbfot5xdPByEVhu8Ikt
	 kk2A3ifmciDlbg+vojZz+lO+GZPu0IG8HmUf9j2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgAKKWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbgAKKWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:22:32 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89EC5214D8;
        Sat, 11 Jan 2020 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738151;
        bh=kcmHPfgfUkUIZ9s19Gak9QvxgsL0fT1Ndp20b1yWJ/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTXtKwRmKN4x1HL5sdCtfhpy6tTyur6fzzO+dQtsuCnJNxWgdraGg7iWnxZ/0E3vX
         kLcEx2ztmE33jVHg4UL538cniEZfu+/GuWPpwANXn6TzV5Bc9x4h3P+DbAVfzr/FGv
         tE31JJ7t4HAYsNNp9gN6qLuQSKYi2EkZ5TbtBm6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/165] selftests: safesetid: Move link library to LDLIBS
Date:   Sat, 11 Jan 2020 10:49:17 +0100
Message-Id: <20200111094924.245126205@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit be12252212fa3dfed6e75112865095c484c0ce87 ]

Move -lcap to LDLIBS from CFLAGS because it is a library
to be linked.

Without this, safesetid failed to build with link error
as below.

----
/usr/bin/ld: /tmp/ccL8rZHT.o: in function `drop_caps':
safesetid-test.c:(.text+0xe7): undefined reference to `cap_get_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x107): undefined reference to `cap_set_flag'
/usr/bin/ld: safesetid-test.c:(.text+0x10f): undefined reference to `cap_set_proc'
/usr/bin/ld: safesetid-test.c:(.text+0x117): undefined reference to `cap_free'
/usr/bin/ld: safesetid-test.c:(.text+0x136): undefined reference to `cap_clear'
collect2: error: ld returned 1 exit status
----

Fixes: c67e8ec03f3f ("LSM: SafeSetID: add selftest")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/safesetid/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index 98da7a504737..cac42cd36a1b 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -Wall -lcap -O2
+CFLAGS = -Wall -O2
+LDLIBS = -lcap
 
 TEST_PROGS := run_tests.sh
 TEST_GEN_FILES := safesetid-test
-- 
2.20.1



