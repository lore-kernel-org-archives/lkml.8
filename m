Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92244C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C08206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586274;
	bh=crSIEIH4A+dogw/1bfzM+frbWB6tVAfdb0uwBlAIua8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6W/66qv68PLKOZ/QCXZLQ0VsrwOXWLH4pm2J+KebFFrhGSeyM+xLnbq1T0A6uctn
	 kBYRBd8mXJovT8r6/w36tMcXKgiXwbS6rKzRQ8oDLa0yLiXESgVgJNwTVHkegaUQAo
	 oQaG+1sugWUYJj3r9mQjJqcFE3KZLpfMNcXnNkeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHEALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgHEAKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDBE22CBB;
        Wed,  5 Aug 2020 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586254;
        bh=crSIEIH4A+dogw/1bfzM+frbWB6tVAfdb0uwBlAIua8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICR5xjslbkUl7sDtULDdiwylOmTNKsz1C+8hKoNZnv/RXDNBXesI/C/1eLOKqgqtl
         j4zkp5w+Yv1GGusrcGQavw05wA/pEGBBw3yYVhP6a+KFAI5rjE83S7PUta0V35a7Cc
         cqvmkqavd93rXY32R7NPnPEKqBD4nrPWYbQv9NY0=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 10/14] tools/lib/lockdep: call lockdep_init_task on init
Date:   Tue,  4 Aug 2020 20:10:39 -0400
Message-Id: <20200805001043.3331907-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have to explicitly call lockdep_init_task() when starting up.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/preload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 8f1adbe887b2f..578fdeda9422c 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -9,6 +9,8 @@
 #include "include/liblockdep/mutex.h"
 #include "../../include/linux/rbtree.h"
 
+extern struct task_struct *__curr(void);
+
 /**
  * struct lock_lookup - liblockdep's view of a single unique lock
  * @orig: pointer to the original pthread lock, used for lookups
@@ -421,6 +423,8 @@ __attribute__((constructor)) static void init_preload(void)
 	if (__init_state == done)
 		return;
 
+	lockdep_init_task(__curr());
+
 #ifndef __GLIBC__
 	__init_state = prepare;
 
-- 
2.25.1

