Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503E7207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928161;
	bh=J0DXJSQCt/AEQ4kWcc4CEH9PFV6o+FDOPj9pZhVlWp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LAH2g2L10BrJTWm213n/xDnJknongumTdnO0mXNsJLN7fIk3gV4hwc9GQzpPuYc20
	 t3IHhnqjSPKXKfwfFPocHnn0w2MwSWxl5QaPDASBPq54yG2m4JuEtH8HnoNUzv40I+
	 +7D2qY2BppywUHI3JHBpHLwJUUyHZBsmXjw9HC0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgHTMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgHTJmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2E620724;
        Thu, 20 Aug 2020 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916571;
        bh=J0DXJSQCt/AEQ4kWcc4CEH9PFV6o+FDOPj9pZhVlWp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbS7m+eGPtPek3Kei9DBW8jwgPBmXEf/suW3DYZr6A8EpWc0VB4WV2Oa1JGhSH0iR
         OnuEvRS3TeEz/pvyJzk7G1PawiGUZWsFfx8WPYkOnaxdlr07lo3aqH3ZmE4dErZCkL
         N4MIH7csFpVeIEwRjG1OiU7UbqqtynyGdFxV/8Fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 175/204] lib/test_lockup.c: fix return value of test_lockup_init()
Date:   Thu, 20 Aug 2020 11:21:12 +0200
Message-Id: <20200820091614.947103996@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 3adf3bae0d612357da516d39e1584f1547eb6e86 ]

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Kees Cook <keescook@chromium.org>
Link: http://lkml.kernel.org/r/1595555407-29875-2-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_lockup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index ea09ca335b214..69ef1c17edf64 100644
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
2.25.1



