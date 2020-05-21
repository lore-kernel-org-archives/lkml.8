Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC3820759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgEUHV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:21:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbgEUHVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:21:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BA30391107AC5928B81;
        Thu, 21 May 2020 15:21:49 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 15:21:48 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] kdb: Remove the misfeature 'KDBFLAGS'
Date:   Thu, 21 May 2020 15:21:25 +0800
Message-ID: <20200521072125.21103-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, 'KDBFLAGS' is an internal variable of kdb, it is combined
by 'KDBDEBUG' and state flags. It will be shown only when 'KDBDEBUG'
is set, and the user can define an environment variable named 'KDBFLAGS'
too. These are puzzling indeed.

After communication with Daniel, it seems that 'KDBFLAGS' is a misfeature.
So let's replace 'KDBFLAGS' with 'KDBDEBUG' to just show the value we
wrote into. After this modification, we can use `md4c1 kdb_flags` instead,
to observe the state flags.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Wei Li <liwei391@huawei.com>
---
v2 -> v3:
 - Change to replace the internal env 'KDBFLAGS' with 'KDBDEBUG'.
v1 -> v2:
 - Fix lack of braces.

 kernel/debug/kdb/kdb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4fc43fb17127..392029287083 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -418,8 +418,7 @@ int kdb_set(int argc, const char **argv)
 				    argv[2]);
 			return 0;
 		}
-		kdb_flags = (kdb_flags &
-			     ~(KDB_DEBUG_FLAG_MASK << KDB_DEBUG_FLAG_SHIFT))
+		kdb_flags = (kdb_flags & ~KDB_DEBUG(MASK))
 			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
 
 		return 0;
@@ -2081,7 +2080,8 @@ static int kdb_env(int argc, const char **argv)
 	}
 
 	if (KDB_DEBUG(MASK))
-		kdb_printf("KDBFLAGS=0x%x\n", kdb_flags);
+		kdb_printf("KDBDEBUG=0x%x\n",
+			(kdb_flags & KDB_DEBUG(MASK)) >> KDB_DEBUG_FLAG_SHIFT);
 
 	return 0;
 }
-- 
2.17.1

