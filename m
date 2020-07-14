Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982CBC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7569822795
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737596;
	bh=rGyKxKZX6b3Ow+n3+T9s6BHBuaad/6NgYACL9wTGXrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmAo2o30YcJdxry1wxm0y0+9jjN1Y5grdPpgofjthr1BltEsdHzG2lqjvWXNkvens
	 b8i/3nNkdgqkfvLU1u+xfJkkexVOi+jQuXW01zqNo9uZMf28B8Xxeiw1/6wYN3RR0G
	 2M34z5ZJrLZhdn/OKJ5NHSKzX/4OJlVVg9YUSyPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgGNOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgGNOjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:39:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C812E2251F;
        Tue, 14 Jul 2020 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737586;
        bh=rGyKxKZX6b3Ow+n3+T9s6BHBuaad/6NgYACL9wTGXrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UB8fb8l732wZShrMjBgAew7qRQ3g5+549iXqfzFqrF1UBb5zhM8ihI59G/SATx9q1
         RkhmR7EOCMO1ZtQ1bqJZGVgr4yA6EYwd+UlIKhZuAeZtCfoJSalDFGOVRnpQZS0L4K
         WFF/zkl/sCwjofuk8RZpL4LYYCiiKj6pgmXdgXao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.19 07/13] xtensa: update *pos in cpuinfo_op.next
Date:   Tue, 14 Jul 2020 10:39:31 -0400
Message-Id: <20200714143937.4035685-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143937.4035685-1-sashal@kernel.org>
References: <20200714143937.4035685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 0d5ab144429e8bd80889b856a44d56ab4a5cd59b ]

Increment *pos in the cpuinfo_op.next to fix the following warning
triggered by cat /proc/cpuinfo:

  seq_file: buggy .next function c_next did not update position index

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 15580e4fc766a..6a0167ac803c6 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -720,7 +720,8 @@ c_start(struct seq_file *f, loff_t *pos)
 static void *
 c_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	return NULL;
+	++*pos;
+	return c_start(f, pos);
 }
 
 static void
-- 
2.25.1

