Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF596C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF286206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIAIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgIAIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:39:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECF1DEB90785927F2594;
        Tue,  1 Sep 2020 16:39:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 16:39:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] samples/seccomp: eliminate two compile warnings in user-trap.c
Date:   Tue, 1 Sep 2020 16:39:03 +0800
Message-ID: <20200901083903.2083-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200901083903.2083-1-thunder.leizhen@huawei.com>
References: <20200901083903.2083-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samples/seccomp/user-trap.c is compiled with $(userccflags), and the
latter does not contain -fno-strict-aliasing, so the warnings reported as
below. Due to add "userccflags += -fno-strict-aliasing" will impact other
files, so use __attribute__((__may_alias__)) to suppress it exactly.

My gcc version is 5.5.0 20171010.

----------
samples/seccomp/user-trap.c: In function ‘send_fd’:
samples/seccomp/user-trap.c:50:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  *((int *)CMSG_DATA(cmsg)) = fd;
  ^
samples/seccomp/user-trap.c: In function ‘recv_fd’:
samples/seccomp/user-trap.c:83:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  return *((int *)CMSG_DATA(cmsg));
  ^

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 samples/seccomp/user-trap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 20291ec6489f31e..e36696b7f41517f 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -23,6 +23,8 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
+typedef int __attribute__((__may_alias__)) __int_alias_t;
+
 static int seccomp(unsigned int op, unsigned int flags, void *args)
 {
 	errno = 0;
@@ -47,7 +49,7 @@ static int send_fd(int sock, int fd)
 	cmsg->cmsg_level = SOL_SOCKET;
 	cmsg->cmsg_type = SCM_RIGHTS;
 	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
-	*((int *)CMSG_DATA(cmsg)) = fd;
+	*(__int_alias_t *)CMSG_DATA(cmsg) = fd;
 	msg.msg_controllen = cmsg->cmsg_len;
 
 	if (sendmsg(sock, &msg, 0) < 0) {
@@ -80,7 +82,7 @@ static int recv_fd(int sock)
 
 	cmsg = CMSG_FIRSTHDR(&msg);
 
-	return *((int *)CMSG_DATA(cmsg));
+	return *(__int_alias_t *)CMSG_DATA(cmsg);
 }
 
 static int user_trap_syscall(int nr, unsigned int flags)
-- 
1.8.3


