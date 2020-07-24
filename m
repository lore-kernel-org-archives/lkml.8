Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462AF20825
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXBun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:50:43 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60498 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbgGXBum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:50:42 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX2dQPhpfbvIDAA--.3743S3;
        Fri, 24 Jul 2020 09:50:09 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/2] lib/test_lockup.c: Fix return value of test_lockup_init()
Date:   Fri, 24 Jul 2020 09:50:07 +0800
Message-Id: <1595555407-29875-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1595555407-29875-1-git-send-email-yangtiezhu@loongson.cn>
References: <1595555407-29875-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxX2dQPhpfbvIDAA--.3743S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fJFy3Ww1xuFWkKFWDXFb_yoW8CF17pr
        Z5WFyUK348ua18XF43tFy3JFyF934UCa12qryIqw1kCrnrCwnYvr4Ut3WYvrnxur4Iv3Wa
        vaykWFW7ZFy7CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWkMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVOJ5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since filp_open() returns an error pointer, we should use IS_ERR() to
check the return value and then return PTR_ERR() if failed to get the
actual return value instead of always -EINVAL.

E.g. without this patch:

[root@localhost loongson]# ls no_such_file
ls: cannot access no_such_file: No such file or directory
[root@localhost loongson]# modprobe test_lockup file_path=no_such_file lock_sb_umount time_secs=60 state=S
modprobe: ERROR: could not insert 'test_lockup': Invalid argument
[root@localhost loongson]# dmesg | tail -1
[  126.100596] test_lockup: cannot find file_path

With this patch:

[root@localhost loongson]# ls no_such_file
ls: cannot access no_such_file: No such file or directory
[root@localhost loongson]# modprobe test_lockup file_path=no_such_file lock_sb_umount time_secs=60 state=S
modprobe: ERROR: could not insert 'test_lockup': Unknown symbol in module, or unknown parameter (see dmesg)
[root@localhost loongson]# dmesg | tail -1
[   95.134362] test_lockup: failed to open no_such_file: -2

Fixes: aecd42df6d39 ("lib/test_lockup.c: add parameters for locking generic vfs locks")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 lib/test_lockup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index bd7c7ff..e720276 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -512,8 +512,8 @@ static int __init test_lockup_init(void)
 	if (test_file_path[0]) {
 		test_file = filp_open(test_file_path, O_RDONLY, 0);
 		if (IS_ERR(test_file)) {
-			pr_err("cannot find file_path\n");
-			return -EINVAL;
+			pr_err("failed to open %s: %ld\n", test_file_path, PTR_ERR(test_file));
+			return PTR_ERR(test_file);
 		}
 		test_inode = file_inode(test_file);
 	} else if (test_lock_inode ||
-- 
2.1.0

