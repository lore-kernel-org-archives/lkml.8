Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0837C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89442075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865816;
	bh=crSIEIH4A+dogw/1bfzM+frbWB6tVAfdb0uwBlAIua8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d03VeATllKaw7LCEhFnXpuqljTnByPWKs1vpAEltKeagIMkFwtI4I9WgUoDZwMV9y
	 U/HoGzlUKDYGKQyCWpGbQpUVcC0PbszwHcflQS7KvEmGd8KgvGWqC6/l2X9hGs1wMz
	 FyUTe1pjryuBvF7sJxXkpYMyDv7weNw5xPueJJfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgFVWnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbgFVWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E37F20776;
        Mon, 22 Jun 2020 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865795;
        bh=crSIEIH4A+dogw/1bfzM+frbWB6tVAfdb0uwBlAIua8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljPKBPKEl50zFCH7vqKKF7IRSgLbxce61pNktatqFktq0R0C6mgy1Hq84Ch4/K5Zi
         bs8vvEAfKjOawDsH+E6R4zRliTN2S8X1E9AWDVqd5dnSUhPPf1DBlIAxIe2wZ2ADBC
         KghMJK62bSxgbCNzWKEPL9MLK1a4PZQYEamSd2WI=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 10/14] tools/lib/lockdep: call lockdep_init_task on init
Date:   Mon, 22 Jun 2020 18:42:54 -0400
Message-Id: <20200622224258.1208588-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
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

