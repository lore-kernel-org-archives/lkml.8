Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925FC22203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737630;
	bh=GzMHvU5YZPPPhdYnAemrHx5q6lnHr6D06MopjFY/qFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rtdoNJpgqhw+HsnSLm2vyGKYydLR8y+zkwdmz0ozFwgjevYXnXeLEfn8owq/sOVuK
	 HPpqyFat+Ygn5dBxxtPt2u6bwadz4M20JDREFHb1a/SJVUZidHV+0R00pye/oF1iqx
	 /J6SVE/BMAj37vuS9LzT2V9e+HvXoZPKrvDHrZIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgGNOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbgGNOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA8822519;
        Tue, 14 Jul 2020 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737617;
        bh=GzMHvU5YZPPPhdYnAemrHx5q6lnHr6D06MopjFY/qFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwPYL8DRZJZzmz2dUWrN9f7rRWJtmdbyT+mU2aiGmK0oOC7VmZjsla040xtRd+8QR
         NiCnn34ntAaaO23DQCDjuDe5qvAcoyCxuRAeeOv43ObiynvRDwqKHKE3i851s6QjAv
         jGbM0tbrZaf/P9LEZUeGGEr1O8raEb1PCtYVq5D8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.9 05/10] xtensa: update *pos in cpuinfo_op.next
Date:   Tue, 14 Jul 2020 10:40:05 -0400
Message-Id: <20200714144010.4035987-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714144010.4035987-1-sashal@kernel.org>
References: <20200714144010.4035987-1-sashal@kernel.org>
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
index b9beae798d727..8679fa3062060 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -830,7 +830,8 @@ c_start(struct seq_file *f, loff_t *pos)
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

