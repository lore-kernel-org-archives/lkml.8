Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145BC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65842184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgEKCSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:18:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbgEKCSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:18:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD2768CF532A022CC47C;
        Mon, 11 May 2020 10:18:02 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:17:59 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kdb: Make the internal env 'KDBFLAGS' undefinable
Date:   Mon, 11 May 2020 10:16:37 +0800
Message-ID: <20200511021637.37029-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'KDBFLAGS' is an internal variable of kdb, it is combined by 'KDBDEBUG'
and state flags. But the user can define an environment variable named
'KDBFLAGS' too, so let's make it undefinable to avoid confusion.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/debug/kdb/kdb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4fc43fb17127..d3d060136821 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -423,7 +423,8 @@ int kdb_set(int argc, const char **argv)
 			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
 
 		return 0;
-	}
+	} else if (strcmp(argv[1], "KDBFLAGS") == 0)
+		return KDB_NOPERM;
 
 	/*
 	 * Tokenizer squashed the '=' sign.  argv[1] is variable
-- 
2.17.1

