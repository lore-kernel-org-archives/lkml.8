Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF2620885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445956;
	bh=zBzG+XQLAb/qyuKQzJ5OOYujuxtJFnwnJn8P+8Fyby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCRC7R2HRC5aNt4lNNAk5QKSF/QmM17H6u9EnhV+H25aZdC1A9+kH0/3cnAGT3F65
	 AV5lonj6oCduYtzuBiv3R3mledDhdb5Fmpe9uZsqs4v4sGia306WQDBtAbb0VX4m7Y
	 dTWDfyFN5egkpW6MuOoMi6rr13kUYCeb/Y40o1rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgFRCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgFRBWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DA520776;
        Thu, 18 Jun 2020 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443360;
        bh=zBzG+XQLAb/qyuKQzJ5OOYujuxtJFnwnJn8P+8Fyby0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lazXY993v/5q06mZ5Wo8JO6wRbg/Rl/TnmalHVxOQytqOlKSZXC9HXYTfRbSW5E69
         qLoLdeRHQ9gY0yqhtXcFZBISk09EA0hkcWOVtRRrt1zpVwJ+phT750U13i9Fk4xIsy
         J9bI0BhRZwk3ej6FqDZZW4LVSYne6+7QCMBpAVWI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 017/172] Smack: slab-out-of-bounds in vsscanf
Date:   Wed, 17 Jun 2020 21:19:43 -0400
Message-Id: <20200618012218.607130-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 84e99e58e8d1e26f04c097f4266e431a33987f36 ]

Add barrier to soob. Return -EOVERFLOW if the buffer
is exceeded.

Suggested-by: Hillf Danton <hdanton@sina.com>
Reported-by: syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..371ae368da35 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -906,11 +906,21 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	else
 		rule += strlen(skp->smk_known) + 1;
 
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &maplevel);
 	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &catlen);
 	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
-- 
2.25.1

