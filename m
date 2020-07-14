Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3DC4345D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708A4223C6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737661;
	bh=E8GGfYTP6aEG4HFq9D6Klka2eaIy5f/oaUK+llhHQ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izzWn/PlMREdgf2fg2CrCFgTHuW7k6rB5cT/WlIyL6vKrpX/x+O8WZKN57wRAI3NC
	 cAelS/L/jmpmXDbzm8gFoL2P/jTSQ6yOJKr16gBeKUBQHH3XgQkxAHwlQnmk3KM50T
	 zfD3uDVphqknTVTo07ePqfDpl9nRca3ZRmIdfnJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgGNOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbgGNOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBE322224;
        Tue, 14 Jul 2020 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737630;
        bh=E8GGfYTP6aEG4HFq9D6Klka2eaIy5f/oaUK+llhHQ/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZN/9Xtzd86l0UPD1FsvB6Dmt6Sw17CkYSsk0A4TVG0okezCX8yo18QlguhXiQq+8k
         qdwhABXoxIgzadpwqd3SLvH60PTssrr2qpvIzA9BoZtaMtWRKOAR+KUl6wdzdMP36g
         2enXb35Bi9xXvk9rLLHThovIXvOETXQciibphHHM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.4 5/9] xtensa: update *pos in cpuinfo_op.next
Date:   Tue, 14 Jul 2020 10:40:19 -0400
Message-Id: <20200714144024.4036118-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714144024.4036118-1-sashal@kernel.org>
References: <20200714144024.4036118-1-sashal@kernel.org>
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
index 49ccbd9022f61..92f5a259e2517 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -716,7 +716,8 @@ c_start(struct seq_file *f, loff_t *pos)
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

