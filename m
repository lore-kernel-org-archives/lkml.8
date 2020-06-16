Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88016C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D33B20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFPW5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:57:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42720 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgFPW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:57:16 -0400
Received: from ip-109-41-2-15.web.vodafone.de ([109.41.2.15] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jlKW1-0007cP-B7; Tue, 16 Jun 2020 22:57:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, ltp@lists.linux.it,
        Serge Hallyn <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2] nsproxy: restore EINVAL for non-namespace file descriptor
Date:   Wed, 17 Jun 2020 00:56:11 +0200
Message-Id: <20200616225612.4068799-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
References: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTP testsuite reported a regression where users would now see EBADF
returned instead of EINVAL when an fd was passed that referred to an open
file but the file was not a nsfd. Fix this by continuing to report EINVAL.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Link: https://lore.kernel.org/lkml/20200615085836.GR12456@shao2-debian
Fixes: 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
I plan on sending this to Linus once it has sat in for-next for a few
days.
---
 kernel/nsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b03df67621d0..cd356630a311 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	} else if (!IS_ERR(pidfd_pid(file))) {
 		err = check_setns_flags(flags);
 	} else {
-		err = -EBADF;
+		err = -EINVAL;
 	}
 	if (err)
 		goto out;

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0

